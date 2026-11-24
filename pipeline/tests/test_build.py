from __future__ import annotations

import sqlite3
from pathlib import Path

import yaml

from readingbook_pipeline.build_sqlite import build_content_db, validate_content_db

FIXTURE = Path(__file__).parent / "fixtures" / "jingbian_text_sample.md"


def _manifest(tmp_path: Path) -> Path:
    manifest = {
        "schema": 1,
        "content_version": "2026-11-24.1",
        "generated_at": "2026-11-24T00:00:00Z",
        "papers": [
            {
                "year": 2024,
                "code": "english1",
                "title": "Test Paper",
                "parts": {
                    "A": {
                        "passages": [
                            {
                                "text_no": 1,
                                "source": "jingbian",
                                "source_path": str(FIXTURE),
                                "title_en": "A Test Article",
                            }
                        ]
                    }
                },
            }
        ],
    }
    path = tmp_path / "manifest.yaml"
    path.write_text(yaml.safe_dump(manifest, allow_unicode=True), encoding="utf-8")
    return path


def test_build_content_db_from_fixture(tmp_path: Path) -> None:
    out = tmp_path / "content.sqlite"
    result = build_content_db(_manifest(tmp_path), out)

    assert result.passage_count == 1
    assert result.paragraph_count == 3
    assert result.sentence_count == 6
    assert result.issues == []
    assert out.exists()

    conn = sqlite3.connect(out)
    try:
        assert conn.execute("PRAGMA user_version").fetchone()[0] == 1
        meta = dict(conn.execute("SELECT key, value FROM meta"))
        assert meta["schema_version"] == "1"
        assert meta["content_version"] == "2026-11-24.1"
        assert meta["source_audit"]
        assert conn.execute("PRAGMA integrity_check").fetchone()[0] == "ok"

        passage = conn.execute("SELECT * FROM passage").fetchone()
        assert passage is not None
        assert passage[1] == "2024-A-T1"
        assert passage[8] == 80

        paragraphs = conn.execute(
            "SELECT key, text_en, text_zh, translation_status FROM paragraph ORDER BY ordinal"
        ).fetchall()
        assert len(paragraphs) == 3
        assert paragraphs[0][3] == "source"
        assert paragraphs[0][2] is not None

        sentences = conn.execute("SELECT COUNT(*) FROM sentence").fetchone()[0]
        assert sentences == 6
    finally:
        conn.close()


def test_validate_reports_no_issues(tmp_path: Path) -> None:
    out = tmp_path / "content.sqlite"
    build_content_db(_manifest(tmp_path), out)

    assert validate_content_db(out) == []
