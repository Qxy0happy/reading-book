"""Manifest loading and content.sqlite construction."""

from __future__ import annotations

import hashlib
import os
import sqlite3
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import yaml

from .model import PaperDraft, PassageDraft
from .sources.huangpishu import parse_jingbian_text
from .sources.jingjiang import parse_jingjiang_part_a

REPO_ROOT = Path(__file__).resolve().parents[3]
SCHEMA_PATH = Path(__file__).resolve().parents[2] / "config" / "content-schema.sql"
SUPPORTED_SCHEMA_VERSION = "1"


@dataclass(frozen=True)
class BuildResult:
    out_path: Path
    sha256: str
    paper_count: int
    passage_count: int
    paragraph_count: int
    sentence_count: int
    issues: list[str]


def _resolve(path: str | Path) -> Path:
    candidate = Path(path)
    if candidate.is_absolute():
        return candidate
    cwd_candidate = (Path.cwd() / candidate).resolve()
    if cwd_candidate.exists():
        return cwd_candidate
    return (REPO_ROOT / candidate).resolve()


def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def load_manifest(manifest_path: str | Path) -> tuple[dict[str, Any], list[PaperDraft]]:
    path = _resolve(manifest_path)
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise TypeError(f"manifest {path} must be a mapping")

    papers: list[PaperDraft] = []
    for paper_entry in data.get("papers", []):
        year = int(paper_entry["year"])
        code = str(paper_entry.get("code", "english1"))
        title = paper_entry.get("title")
        passages: list[PassageDraft] = []
        display_order = 0
        parts = paper_entry.get("parts", {})
        for part in ("A", "B", "C"):
            part_entry = parts.get(part)
            if not part_entry:
                continue
            if part_entry.get("texts"):
                source = part_entry.get("source", "jingbian")
                source_path = _resolve(part_entry["source_path"])
                text_nos = [int(value) for value in part_entry["texts"]]
                if source == "jingjiang":
                    parsed = parse_jingjiang_part_a(source_path, year)
                    for passage in parsed:
                        if passage.text_no not in text_nos:
                            continue
                        display_order += 1
                        passage.display_order = display_order
                        passages.append(passage)
                elif source == "jingbian":
                    for text_no in text_nos:
                        display_order += 1
                        passages.append(
                            parse_jingbian_text(
                                source_path,
                                year,
                                text_no,
                                title_en=None,
                                display_order=display_order,
                            )
                        )
                else:
                    raise ValueError(
                        f"unsupported source {source!r} for {year} Part {part}"
                    )
                continue
            for passage_entry in part_entry.get("passages", []):
                display_order += 1
                source = passage_entry.get("source", "jingbian")
                if source != "jingbian":
                    raise ValueError(
                        f"unsupported source {source!r} for {year} Part {part}"
                    )
                source_path = _resolve(passage_entry["source_path"])
                text_no = int(passage_entry["text_no"]) if part == "A" else None
                if part == "A" and text_no is None:
                    raise ValueError(f"{year} Part A entry is missing text_no")
                passage = parse_jingbian_text(
                    source_path,
                    year,
                    text_no if text_no is not None else 1,
                    title_en=passage_entry.get("title_en"),
                    display_order=display_order,
                )
                if part != "A":
                    raise ValueError("skeleton builder currently supports Part A only")
                passages.append(passage)
        papers.append(PaperDraft(year=year, code=code, title=title, passages=passages))
    if not papers:
        raise ValueError(f"manifest {path} has no papers")
    return data, papers


def _normalise(text_value: str | None) -> str:
    return " ".join((text_value or "").split())


def _insert_paper(conn: sqlite3.Connection, paper: PaperDraft) -> int:
    cursor = conn.execute(
        "INSERT INTO paper (year, code, title) VALUES (?, ?, ?)",
        (paper.year, paper.code, paper.title),
    )
    return int(cursor.lastrowid)


def _insert_passage(
    conn: sqlite3.Connection, paper_id: int, passage: PassageDraft
) -> int:
    cursor = conn.execute(
        """
        INSERT INTO passage (
          key, paper_id, part, text_no, title_zh, title_en, source_note,
          word_count, part_b_type, display_order
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """,
        (
            passage.key,
            paper_id,
            passage.part,
            passage.text_no,
            passage.title_zh,
            passage.title_en,
            passage.source_note,
            passage.word_count,
            passage.part_b_type,
            passage.display_order,
        ),
    )
    return int(cursor.lastrowid)


def _insert_paragraph(
    conn: sqlite3.Connection, passage_id: int, passage: PassageDraft
) -> tuple[int, int]:
    paragraph_count = 0
    sentence_count = 0
    for paragraph in passage.paragraphs:
        paragraph_key = f"{passage.key}-P{paragraph.ordinal:02d}"
        translation_status = "source" if paragraph.text_zh else "missing"
        cursor = conn.execute(
            """
            INSERT INTO paragraph (
              key, passage_id, ordinal, label, heading_en, heading_zh, speaker,
              text_en, text_zh, translation_source, translation_status
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                paragraph_key,
                passage_id,
                paragraph.ordinal,
                paragraph.label,
                paragraph.heading_en,
                paragraph.heading_zh,
                paragraph.speaker,
                paragraph.text_en,
                paragraph.text_zh,
                "huangpishu",
                translation_status,
            ),
        )
        paragraph_id = int(cursor.lastrowid)
        paragraph_count += 1
        for sentence in paragraph.sentences:
            sentence_count += 1
            conn.execute(
                """
                INSERT INTO sentence (
                  key, paragraph_id, ordinal, text_en, text_zh,
                  translation_source, translation_status, exam_no, confidence
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    f"{paragraph_key}-S{sentence.ordinal:02d}",
                    paragraph_id,
                    sentence.ordinal,
                    sentence.text_en,
                    sentence.text_zh,
                    "huangpishu",
                    "source" if sentence.text_zh else "missing",
                    None,
                    None,
                ),
            )
    return paragraph_count, sentence_count


def build_content_db(
    manifest_path: str | Path,
    out_path: str | Path,
    *,
    app_assets_path: str | Path | None = None,
) -> BuildResult:
    manifest_file = _resolve(manifest_path)
    manifest, papers = load_manifest(manifest_file)
    out = _resolve(out_path)
    out.parent.mkdir(parents=True, exist_ok=True)
    temp_path = out.with_name(out.name + ".tmp")
    if temp_path.exists():
        temp_path.unlink()

    schema = SCHEMA_PATH.read_text(encoding="utf-8")
    conn = sqlite3.connect(temp_path)
    try:
        conn.executescript(schema)
        conn.execute("PRAGMA foreign_keys = ON")
        source_path_set: set[Path] = set()
        for paper in manifest["papers"]:
            for part in paper.get("parts", {}).values():
                if part.get("source_path"):
                    source_path_set.add(_resolve(part["source_path"]))
                for entry in part.get("passages", []):
                    source_path_set.add(_resolve(entry["source_path"]))
        source_paths = sorted(source_path_set)
        audit_basis = (
            manifest_file.read_bytes()
            + b"\0"
            + b"\0".join(path.read_bytes() for path in source_paths)
        )
        source_audit = hashlib.sha256(audit_basis).hexdigest()
        meta_rows = {
            "schema_version": SUPPORTED_SCHEMA_VERSION,
            "content_version": str(manifest["content_version"]),
            "generated_at": str(manifest["generated_at"]),
            "source_audit": source_audit,
        }
        if manifest.get("sample") is True:
            meta_rows["sample"] = "true"
        conn.executemany(
            "INSERT INTO meta (key, value) VALUES (?, ?)", meta_rows.items()
        )

        passage_count = paragraph_count = sentence_count = 0
        for paper in papers:
            paper_id = _insert_paper(conn, paper)
            for passage in paper.passages:
                passage_id = _insert_passage(conn, paper_id, passage)
                paragraphs, sentences = _insert_paragraph(conn, passage_id, passage)
                paragraph_count += paragraphs
                sentence_count += sentences
                passage_count += 1

        conn.execute("PRAGMA user_version = 1")
        conn.commit()
        integrity = conn.execute("PRAGMA integrity_check").fetchone()
        if not integrity or integrity[0] != "ok":
            raise ValueError(f"content database integrity_check failed: {integrity!r}")
    finally:
        conn.close()

    os.replace(temp_path, out)
    if app_assets_path is not None:
        asset_path = _resolve(app_assets_path)
        asset_path.parent.mkdir(parents=True, exist_ok=True)
        asset_path.write_bytes(out.read_bytes())

    issues = validate_content_db(out)
    return BuildResult(
        out_path=out,
        sha256=_sha256(out),
        paper_count=len(papers),
        passage_count=passage_count,
        paragraph_count=paragraph_count,
        sentence_count=sentence_count,
        issues=issues,
    )


def validate_content_db(db_path: str | Path) -> list[str]:
    """Validate the content contract invariants that the skeleton can produce."""
    path = _resolve(db_path)
    issues: list[str] = []
    conn = sqlite3.connect(path)
    conn.row_factory = sqlite3.Row
    try:
        integrity = conn.execute("PRAGMA integrity_check").fetchone()[0]
        if integrity != "ok":
            issues.append(f"integrity_check: {integrity}")
        user_version = conn.execute("PRAGMA user_version").fetchone()[0]
        if user_version != 1:
            issues.append(f"user_version: expected 1, got {user_version}")
        meta = {
            row["key"]: row["value"]
            for row in conn.execute("SELECT key, value FROM meta")
        }
        if meta.get("schema_version") != SUPPORTED_SCHEMA_VERSION:
            issues.append(
                f"meta.schema_version: expected {SUPPORTED_SCHEMA_VERSION}, got {meta.get('schema_version')!r}"
            )
        if not meta.get("content_version"):
            issues.append("meta.content_version is missing")

        passages = conn.execute(
            "SELECT * FROM passage ORDER BY display_order"
        ).fetchall()
        if not passages:
            issues.append("no passages")
        for passage in passages:
            paragraphs = conn.execute(
                "SELECT * FROM paragraph WHERE passage_id = ? ORDER BY ordinal",
                (passage["id"],),
            ).fetchall()
            if not paragraphs:
                issues.append(f"{passage['key']}: no paragraphs")
            for expected, paragraph in enumerate(paragraphs, start=1):
                if paragraph["ordinal"] != expected:
                    issues.append(
                        f"{paragraph['key']}: ordinal {paragraph['ordinal']} != {expected}"
                    )
                sentences = conn.execute(
                    "SELECT * FROM sentence WHERE paragraph_id = ? ORDER BY ordinal",
                    (paragraph["id"],),
                ).fetchall()
                if not sentences:
                    issues.append(f"{paragraph['key']}: no sentences")
                for expected_sentence, sentence in enumerate(sentences, start=1):
                    if sentence["ordinal"] != expected_sentence:
                        issues.append(
                            f"{sentence['key']}: ordinal {sentence['ordinal']} != {expected_sentence}"
                        )
                    if sentence["exam_no"] is not None:
                        issues.append(
                            f"{sentence['key']}: exam_no is not supported by the skeleton"
                        )
                joined = " ".join(sentence["text_en"] for sentence in sentences)
                if _normalise(joined) != _normalise(paragraph["text_en"]):
                    issues.append(
                        f"{paragraph['key']}: text_en does not match sentence concatenation"
                    )
                if (
                    paragraph["translation_status"] == "missing"
                    and paragraph["text_zh"] is not None
                ):
                    issues.append(
                        f"{paragraph['key']}: missing translation has text_zh"
                    )
                if (
                    paragraph["translation_status"] in {"source", "machine"}
                    and not paragraph["text_zh"]
                ):
                    issues.append(
                        f"{paragraph['key']}: translated paragraph has no text_zh"
                    )
            if passage["part"] == "B" and passage["part_b_type"] is None:
                issues.append(f"{passage['key']}: Part B without part_b_type")
            if passage["part"] != "B" and passage["part_b_type"] is not None:
                issues.append(f"{passage['key']}: non-Part B with part_b_type")
    finally:
        conn.close()
    return issues


__all__ = [
    "BuildResult",
    "build_content_db",
    "load_manifest",
    "validate_content_db",
]
