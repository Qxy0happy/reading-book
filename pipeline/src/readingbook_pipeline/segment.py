"""Sentence and paragraph segmentation helpers."""

from __future__ import annotations

import html
import re

MARKER_RE = re.compile(r"[①-⑳]")
MARKER_SPLIT_RE = re.compile(r"(?=[①-⑳])")
PUNCT_SPLIT_RE = re.compile(r"(?<=[.!?。！？])\s+")
WORD_RE = re.compile(r"[A-Za-z0-9][A-Za-z0-9'’\-]*")
WORDS_MARKER_RE = re.compile(r"\[(\d+)\s*words\]", re.IGNORECASE)


def clean_text(text: str) -> str:
    text = html.unescape(text)
    text = text.replace("\u00a0", " ").replace("\u3000", " ")
    text = WORDS_MARKER_RE.sub("", text)
    text = re.sub(r"\s+", " ", text)
    return text.strip()


def split_by_markers(text: str) -> list[str]:
    """Split a paragraph on circled sentence numbers, preserving sentence text."""
    text = clean_text(text)
    if not text:
        return []
    if MARKER_RE.search(text):
        parts = [part.strip() for part in MARKER_SPLIT_RE.split(text)]
        parts = [
            MARKER_RE.sub("", part, count=1).strip() for part in parts if part.strip()
        ]
        return [part for part in parts if part]
    return [part.strip() for part in PUNCT_SPLIT_RE.split(text) if part.strip()]


def sentence_pairs(en_text: str, zh_text: str | None) -> list[tuple[str, str | None]]:
    """Pair English and Chinese sentences in order; missing Chinese stays None."""
    en_sentences = split_by_markers(en_text)
    zh_sentences = split_by_markers(zh_text) if zh_text else []
    pairs: list[tuple[str, str | None]] = []
    for index, en_sentence in enumerate(en_sentences):
        zh_sentence = zh_sentences[index] if index < len(zh_sentences) else None
        pairs.append((en_sentence, zh_sentence))
    return pairs


def count_words(text: str) -> int:
    return len(WORD_RE.findall(clean_text(text)))


def detect_word_count(block: str, english_text: str) -> int:
    match = WORDS_MARKER_RE.search(block)
    if match:
        return int(match.group(1))
    return count_words(english_text)
