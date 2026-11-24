"""Command line entry points for the content pipeline."""

from __future__ import annotations

import argparse
import json
import sqlite3
import sys
from pathlib import Path

from .build_sqlite import REPO_ROOT, build_content_db, validate_content_db


def _default_manifest() -> Path:
    return REPO_ROOT / "pipeline" / "config" / "manifest.sample.yaml"


def _default_out() -> Path:
    return REPO_ROOT / "content" / "content.sqlite"


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="readingbook")
    subparsers = parser.add_subparsers(dest="command", required=True)

    build = subparsers.add_parser(
        "build", help="build content.sqlite from the manifest"
    )
    build.add_argument("--manifest", type=Path, default=_default_manifest())
    build.add_argument("--out", type=Path, default=_default_out())
    build.add_argument("--app-assets", type=Path, default=None, help="optional app asset copy target")
    build.add_argument(
        "--strict", action="store_true", help="fail on any validation issue"
    )

    validate = subparsers.add_parser(
        "validate", help="validate an existing content.sqlite"
    )
    validate.add_argument("--db", type=Path, default=_default_out())
    validate.add_argument("--strict", action="store_true")

    inspect = subparsers.add_parser("inspect", help="print a short content inventory")
    inspect.add_argument("--db", type=Path, default=_default_out())
    return parser


def _run_build(args: argparse.Namespace) -> int:
    result = build_content_db(args.manifest, args.out, app_assets_path=args.app_assets)
    print(
        json.dumps(
            {
                "out": str(result.out_path),
                "sha256": result.sha256,
                "papers": result.paper_count,
                "passages": result.passage_count,
                "paragraphs": result.paragraph_count,
                "sentences": result.sentence_count,
                "issues": result.issues,
            },
            ensure_ascii=False,
            indent=2,
        )
    )
    if result.issues:
        return 1 if args.strict else 0
    return 0


def _run_validate(args: argparse.Namespace) -> int:
    issues = validate_content_db(args.db)
    if issues:
        for issue in issues:
            print(f"ERROR {issue}")
        return 1
    print(f"OK {args.db}")
    return 0


def _run_inspect(args: argparse.Namespace) -> int:
    conn = sqlite3.connect(args.db)
    conn.row_factory = sqlite3.Row
    try:
        meta = {
            row["key"]: row["value"]
            for row in conn.execute("SELECT key, value FROM meta")
        }
        print(f"content_version: {meta.get('content_version')}")
        print(f"schema_version: {meta.get('schema_version')}")
        for passage in conn.execute("SELECT * FROM passage ORDER BY display_order"):
            paragraphs = conn.execute(
                "SELECT COUNT(*) FROM paragraph WHERE passage_id = ?", (passage["id"],)
            ).fetchone()[0]
            sentences = conn.execute(
                "SELECT COUNT(*) FROM sentence s JOIN paragraph p ON p.id = s.paragraph_id WHERE p.passage_id = ?",
                (passage["id"],),
            ).fetchone()[0]
            print(
                f"{passage['key']}  part={passage['part']}  words={passage['word_count']}  "
                f"paragraphs={paragraphs}  sentences={sentences}  title={passage['title_zh'] or passage['title_en']}"
            )
    finally:
        conn.close()
    return 0


def main(argv: list[str] | None = None) -> None:
    argv = list(sys.argv[1:] if argv is None else argv)
    program = Path(sys.argv[0]).name
    default_command = {
        "readingbook-build": "build",
        "readingbook-validate": "validate",
        "readingbook-inspect": "inspect",
    }.get(program)
    if default_command and (
        not argv or argv[0] not in {"build", "validate", "inspect"}
    ):
        argv.insert(0, default_command)

    parser = _build_parser()
    args = parser.parse_args(argv)
    if args.command == "build":
        raise SystemExit(_run_build(args))
    if args.command == "validate":
        raise SystemExit(_run_validate(args))
    if args.command == "inspect":
        raise SystemExit(_run_inspect(args))
    parser.error(f"unknown command {args.command!r}")
