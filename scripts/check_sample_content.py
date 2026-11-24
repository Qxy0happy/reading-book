#!/usr/bin/env python3
"""Refuse to publish a content database that is not the synthetic sample."""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

REAL_MARKERS = ("古罗马钉子", "近 2 000 年前罗马人")


def main() -> int:
    path = Path(sys.argv[1] if len(sys.argv) > 1 else "app/assets/content.sqlite")
    if not path.exists():
        print(f"missing content database: {path}", file=sys.stderr)
        return 1

    connection = sqlite3.connect(path)
    try:
        row = connection.execute(
            "SELECT value FROM meta WHERE key = 'sample'"
        ).fetchone()
        if row is None or row[0] != "true":
            print(
                "refusing to publish: content database is not marked sample=true",
                file=sys.stderr,
            )
            return 1

        titles = [
            title or ""
            for (title,) in connection.execute("SELECT title_zh FROM passage")
        ]
        if any(marker in title for title in titles for marker in REAL_MARKERS):
            print(
                "refusing to publish: real exam content detected in passage titles",
                file=sys.stderr,
            )
            return 1
    finally:
        connection.close()

    print(f"sample content check passed: {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
