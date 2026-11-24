"""Intermediate content model shared by source adapters and the SQLite builder."""

from __future__ import annotations

from dataclasses import dataclass, field


@dataclass(frozen=True)
class SourceRef:
    path: str
    line: int


@dataclass
class SentenceDraft:
    ordinal: int
    text_en: str
    text_zh: str | None
    source_ref: SourceRef | None = None


@dataclass
class ParagraphDraft:
    ordinal: int
    text_en: str
    text_zh: str | None
    sentences: list[SentenceDraft] = field(default_factory=list)
    label: str | None = None
    heading_en: str | None = None
    heading_zh: str | None = None
    speaker: str | None = None


@dataclass
class PassageDraft:
    key: str
    year: int
    part: str
    text_no: int | None
    title_zh: str | None
    title_en: str | None
    source_note: str | None
    word_count: int
    part_b_type: str | None
    display_order: int
    paragraphs: list[ParagraphDraft]
    source_path: str


@dataclass
class PaperDraft:
    year: int
    code: str
    title: str | None
    passages: list[PassageDraft]
