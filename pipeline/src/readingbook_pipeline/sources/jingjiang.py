"""Adapter for the 逐词逐句精讲册 (2004-2023) Part A layout.

Each sentence is stored as one line: English sentence followed by its Chinese
translation.  Circled sentence numbers are hints only and are not used as
ordinals.  Part A has four texts per year; some years lose the ``##`` prefix on
``Part A``/``Text N``/``第一段`` headings, and some lose a ``Text N`` heading
entirely, so boundaries are also detected by a repeated ``第一段``.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

from ..model import ParagraphDraft, PassageDraft, SentenceDraft, SourceRef
from ..segment import clean_text, count_words

_HEADING_PREFIX = r"(?:#{1,3}\s*)?"
_CJK_RE = re.compile(r"[\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]")
_MARKER_RE = re.compile(r"^[①-⑳]\s*")
_READING_RE = re.compile(r"Reading\s+Comprehension", re.IGNORECASE)
_PART_A_RE = re.compile(rf"^{_HEADING_PREFIX}Part\s+A\s*$", re.IGNORECASE)
_PART_BC_RE = re.compile(rf"^{_HEADING_PREFIX}Part\s+[BC]\b", re.IGNORECASE)
_SECTION_RE = re.compile(rf"^{_HEADING_PREFIX}Section\b", re.IGNORECASE)
_TEXT_RE = re.compile(
    rf"^{_HEADING_PREFIX}Text\s+(?P<no>\d+)\s*(?P<title>.*)$", re.IGNORECASE
)
_PARAGRAPH_RE = re.compile(
    rf"^{_HEADING_PREFIX}第(?P<num>[一二三四五六七八九十百]+)段\s*$"
)
_NOISE_RE = re.compile(
    rf"^{_HEADING_PREFIX}(词汇注释|句子主干|一级修饰|二级修饰|三级修饰|"
    rf"要点注释|句子讲解|Tips|全文脉络|外教朗读)\b",
    re.IGNORECASE,
)
_NOISE_LINE_RE = re.compile(
    r"^(词汇注释|句子主干|一级修饰|二级修饰|三级修饰|要点注释|句子讲解|"
    r"Tips|全文脉络|外教朗读)\b",
    re.IGNORECASE,
)
_IMAGE_RE = re.compile(r"^!\[.*\]\(.*\)\s*$")
_TABLE_RE = re.compile(r"^(?:<table|</table>|\|)")
_GRAMMAR_HINTS = ("(主", "主 + 谓", "主+谓", "谓语", "宾语", "定语", "状语", "修饰")
_VOCAB_MARKER_RE = re.compile(r"\$\^\{\*\}\$|\\\*|\u2605|\u2606")
_VOCAB_POS_RE = re.compile(
    r"\[[^\]]{1,40}\]\s*(?:n|v|vt|vi|a|ad|adv|adj|prep|conj|pron|num)\.",
    re.IGNORECASE,
)
_GRAMMAR_ZH_RE = re.compile(
    r"(主语|谓语|宾语|定语|状语|从句|语法|句子主干|结构作|修饰|指代|"
    r"省略句|补充完整|本句|该句)"
)


@dataclass
class _Sentence:
    en: str
    zh: str | None
    line_no: int


@dataclass
class _Paragraph:
    ordinal: int
    line_no: int
    sentences: list[_Sentence] = field(default_factory=list)

    def add(
        self, en: str | None, zh: str | None, line_no: int, had_marker: bool
    ) -> None:
        if not en and zh:
            if self.sentences and self.sentences[-1].zh is None:
                self.sentences[-1].zh = zh
            return
        if not en:
            return
        if re.fullmatch(r"p\d+", en.strip(), re.IGNORECASE):
            return

        if self.sentences:
            previous = self.sentences[-1]
            # A sentence can be split across physical lines.  The first line
            # ends without Chinese; the next unnumbered line starts with the
            # rest of the English sentence and then the Chinese translation.
            if not had_marker and previous.zh is None and zh is not None:
                previous.en = f"{previous.en} {en}".strip()
                previous.zh = zh
                return
            if not had_marker and previous.zh is None and zh is None:
                previous.en = f"{previous.en} {en}".strip()
                return

        self.sentences.append(_Sentence(en=en, zh=zh, line_no=line_no))

    def build(self, source_path: str) -> ParagraphDraft:
        sentences: list[SentenceDraft] = []
        for sentence in self.sentences:
            en = clean_text(sentence.en)
            if not en:
                continue
            zh = clean_text(sentence.zh) if sentence.zh else None
            sentences.append(
                SentenceDraft(
                    ordinal=len(sentences) + 1,
                    text_en=en,
                    text_zh=zh,
                    source_ref=SourceRef(source_path, sentence.line_no),
                )
            )
        if not sentences:
            raise ValueError(f"paragraph at line {self.line_no} has no sentences")
        return ParagraphDraft(
            ordinal=self.ordinal,
            text_en=" ".join(sentence.text_en for sentence in sentences),
            text_zh=clean_text(
                " ".join(sentence.text_zh for sentence in sentences if sentence.text_zh)
            )
            or None,
            sentences=sentences,
        )


@dataclass
class _Text:
    text_no: int
    title: str | None
    line_no: int
    paragraphs: list[_Paragraph] = field(default_factory=list)

    def build(self, year: int, source_path: str) -> PassageDraft:
        if not self.paragraphs:
            raise ValueError(
                f"Text {self.text_no} at line {self.line_no} has no paragraphs"
            )
        paragraphs: list[ParagraphDraft] = []
        seen_sentences: set[str] = set()
        seen_paragraphs: set[str] = set()
        for paragraph in self.paragraphs:
            draft = paragraph.build(source_path)
            kept = []
            for sentence in draft.sentences:
                normalized_sentence = " ".join(sentence.text_en.lower().split())
                if normalized_sentence in seen_sentences:
                    continue
                seen_sentences.add(normalized_sentence)
                sentence.ordinal = len(kept) + 1
                kept.append(sentence)
            if not kept:
                continue
            draft.sentences = kept
            draft.text_en = " ".join(sentence.text_en for sentence in kept)
            draft.text_zh = (
                clean_text(
                    " ".join(sentence.text_zh for sentence in kept if sentence.text_zh)
                )
                or None
            )
            normalized_paragraph = " ".join(draft.text_en.lower().split())
            if normalized_paragraph in seen_paragraphs:
                continue
            seen_paragraphs.add(normalized_paragraph)
            draft.ordinal = len(paragraphs) + 1
            paragraphs.append(draft)
        if not paragraphs:
            raise ValueError(f"Text {self.text_no} at line {self.line_no} is empty")
        english_text = " ".join(paragraph.text_en for paragraph in paragraphs)
        return PassageDraft(
            key=f"{year}-A-T{self.text_no}",
            year=year,
            part="A",
            text_no=self.text_no,
            title_zh=self.title,
            title_en=None,
            source_note=None,
            word_count=count_words(english_text),
            part_b_type=None,
            display_order=self.text_no,
            paragraphs=paragraphs,
            source_path=source_path,
        )


def _first_cjk_index(text: str) -> int:
    match = _CJK_RE.search(text)
    return match.start() if match else -1


def _split_bilingual(line: str) -> tuple[str | None, str | None, bool]:
    stripped = line.strip()
    had_marker = bool(_MARKER_RE.match(stripped))
    stripped = _MARKER_RE.sub("", stripped, count=1).strip()
    index = _first_cjk_index(stripped)
    if index < 0:
        return clean_text(stripped) or None, None, had_marker
    en = clean_text(stripped[:index])
    zh = _MARKER_RE.sub("", stripped[index:].strip(), count=1)
    zh = clean_text(zh)
    return en or None, zh or None, had_marker


def _looks_like_sentence(line: str) -> bool:
    index = _first_cjk_index(line)
    if index < 0:
        return False
    en = line[:index].strip()
    if len(en) < 40:
        return False
    if not re.search(r"[.!?][\"'”’)]?\s*$", en):
        return False
    if any(marker in en for marker in ("$^{*}$", "★", "☆", "\\*", " [", "(亦作")):
        return False
    return not any(hint in en for hint in _GRAMMAR_HINTS)


def _is_vocabulary_line(line: str) -> bool:
    return bool(_VOCAB_MARKER_RE.search(line) or _VOCAB_POS_RE.search(line))


def _is_noise_line(line: str) -> bool:
    return (
        not line
        or bool(_NOISE_LINE_RE.match(line))
        or bool(_IMAGE_RE.match(line))
        or bool(_TABLE_RE.match(line))
        or line.startswith(("```", "<details>", "</details>"))
    )


def _find_part_a_start(lines: list[str]) -> int:
    reading_index: int | None = None
    for index, line in enumerate(lines):
        if _READING_RE.search(line):
            reading_index = index
            break
    search_from = reading_index if reading_index is not None else 0

    part_a_matches: list[int] = []
    for index in range(search_from, len(lines)):
        stripped = lines[index].strip()
        if _PART_BC_RE.match(stripped):
            break
        if _PART_A_RE.match(stripped):
            part_a_matches.append(index)
    if part_a_matches:
        return part_a_matches[-1] + 1

    for index in range(search_from, len(lines)):
        stripped = lines[index].strip()
        if _TEXT_RE.match(stripped) or _PARAGRAPH_RE.match(stripped):
            return index
    return search_from + 1


def parse_jingjiang_part_a(
    source_path: str | Path,
    year: int,
    *,
    expected_texts: int = 4,
) -> list[PassageDraft]:
    path = Path(source_path)
    lines = path.read_text(encoding="utf-8").splitlines()
    start = _find_part_a_start(lines)

    texts: list[_Text] = []
    current_text: _Text | None = None
    current_paragraph: _Paragraph | None = None
    in_noise = False
    in_details = False
    next_text_no = 1

    def finish_paragraph() -> None:
        nonlocal current_paragraph
        if (
            current_paragraph is not None
            and current_paragraph.sentences
            and current_text is not None
        ):
            current_text.paragraphs.append(current_paragraph)
        current_paragraph = None

    def finish_text() -> None:
        nonlocal current_text
        finish_paragraph()
        if current_text is not None and current_text.paragraphs:
            texts.append(current_text)
        current_text = None

    def start_text(text_no: int, title: str | None, line_no: int) -> None:
        nonlocal current_text, next_text_no
        finish_text()
        current_text = _Text(text_no=text_no, title=title, line_no=line_no)
        next_text_no = max(next_text_no, text_no + 1)

    def start_paragraph(line_no: int) -> None:
        nonlocal current_paragraph
        finish_paragraph()
        if current_text is None:
            start_text(next_text_no, None, line_no)
        current_paragraph = _Paragraph(
            ordinal=len(current_text.paragraphs) + 1,
            line_no=line_no,
        )

    for offset in range(start, len(lines)):
        line = lines[offset].strip()
        line_no = offset + 1
        if not line:
            continue

        if in_details:
            if "</details>" in line:
                in_details = False
            continue
        if "<details>" in line:
            in_details = True
            continue

        if _PART_BC_RE.match(line) or _SECTION_RE.match(line):
            break

        text_match = _TEXT_RE.match(line)
        if text_match:
            text_no = int(text_match.group("no"))
            if 1 <= text_no <= expected_texts:
                start_text(
                    text_no,
                    text_match.group("title").strip() or None,
                    line_no,
                )
                in_noise = False
                continue

        paragraph_match = _PARAGRAPH_RE.match(line)
        if paragraph_match:
            is_first = paragraph_match.group("num") == "一"
            if current_text is None or (is_first and current_text.paragraphs):
                start_text(next_text_no, None, line_no)
            start_paragraph(line_no)
            in_noise = False
            continue

        if _NOISE_RE.match(line):
            in_noise = True
            continue

        if line.startswith("#"):
            in_noise = True
            continue

        if _is_noise_line(line):
            continue

        if _is_vocabulary_line(line):
            continue

        if in_noise and not (_MARKER_RE.match(line) or _looks_like_sentence(line)):
            continue

        if line.startswith("【"):
            continue

        en, zh, had_marker = _split_bilingual(line)
        if not en:
            if current_paragraph is not None and zh:
                current_paragraph.add(None, zh, line_no, False)
            continue
        if zh is not None and len(en) < 15 and _GRAMMAR_ZH_RE.search(zh):
            continue
        if current_paragraph is None:
            if current_text is None:
                start_text(next_text_no, None, line_no)
            start_paragraph(line_no)
        if in_noise:
            in_noise = False
        current_paragraph.add(en, zh, line_no, had_marker)

    finish_text()

    if len(texts) < expected_texts:
        found = ", ".join(str(text.text_no) for text in texts) or "none"
        raise ValueError(
            f"{year} Part A: expected {expected_texts} texts, found {len(texts)} ({found})"
        )
    return [text.build(year, str(path)) for text in texts[:expected_texts]]


def summarize(source_path: str | Path, year: int) -> str:
    passages = parse_jingjiang_part_a(source_path, year)
    lines = [
        f"{passage.key}: {len(passage.paragraphs)} paragraphs, "
        f"{sum(len(p.sentences) for p in passage.paragraphs)} sentences, "
        f"{passage.word_count} words"
        for passage in passages
    ]
    return "\n".join(lines)
