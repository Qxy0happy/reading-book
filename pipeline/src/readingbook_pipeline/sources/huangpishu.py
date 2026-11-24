"""Adapter for the Huangpishu jingbian (2022-2026) markdown layout.

The skeleton only needs Part A Text passages from the 2024 jingbian volume, but
the parser is written against the observed layout rather than a single file so
later years can be added without rewriting the extraction code.

Observed layout for 2024 Text 1: English paragraph blocks (Roman-labelled) and
Chinese paragraph blocks are stored in separate runs, not interleaved line by
line.  The parser therefore collects English blocks and a flat ordered list of
Chinese sentences, then aligns them by sentence count.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

from ..model import ParagraphDraft, PassageDraft, SentenceDraft, SourceRef
from ..segment import clean_text, detect_word_count, split_by_markers

_CJK_RE = re.compile(r"[\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]")
_ROMAN_LABEL_RE = re.compile(r"^(?P<label>[IVXLCDM]+|[ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ]+)\s+(?P<body>.*)$")
_TEXT_HEADING_RE = re.compile(r"^#{1,3}\s+Text\s+(?P<text_no>\d+)\s*(?P<title>.*)$")
_TRANSLATION_HEADING_RE = re.compile(r"^##\s+[一二三四五六七八九十]+、英汉对译")
_YEAR_HEADING_RE = re.compile(r"^#\s+(?P<year>\d{4})\s*年")
_SOURCE_RE = re.compile(r"^来源\s*[：:]\s*(?P<note>.*)$")
_SENTENCE_MARKER_RE = re.compile(r"^[①-⑳]")
_IMAGE_RE = re.compile(r"^!\[.*\]\(.*\)\s*$")
_TABLE_START = "<table"
_TABLE_END = "</table>"

# Two 2024 sentences are split across source lines in the jingbian layout.
# The translations below are taken from the same source blocks.
_SENTENCE_ZH_OVERRIDES: dict[tuple[int, int, int, int], str] = {
    (2024, 2, 8, 2): (
        "乔杜里指出，英国应该探索这样一种可能性，即年长的哥哥姐姐 (在) "
        "帮助父母 (照顾弟弟妹妹的过程中)“可能也会促进他们自身的社会性发展”。"
    ),
    (2024, 3, 10, 2): (
        "一项建议是，AI 模型可以利用不受版权保护的图像做训练，"
        "且 AI 公司可以与博物馆以及艺术家建立伙伴关系，奥尔蒂斯说道。"
    ),
}

_UNICODE_ROMAN = {
    "Ⅰ": "I",
    "Ⅱ": "II",
    "Ⅲ": "III",
    "Ⅳ": "IV",
    "Ⅴ": "V",
    "Ⅵ": "VI",
    "Ⅶ": "VII",
    "Ⅷ": "VIII",
    "Ⅸ": "IX",
    "Ⅹ": "X",
}


def _normalise_roman(label: str) -> str:
    return _UNICODE_ROMAN.get(label, label)


def _cjk_ratio(line: str) -> float:
    stripped = re.sub(r"\s+", "", line)
    if not stripped:
        return 0.0
    return len(_CJK_RE.findall(stripped)) / len(stripped)


def _is_noise(line: str) -> bool:
    stripped = line.strip()
    return (
        not stripped
        or stripped.startswith(("#", "![](", "|"))
        or _IMAGE_RE.match(stripped) is not None
        or stripped in {"外教朗读", "全文脉络"}
    )


@dataclass
class _EnglishBlock:
    label: str | None
    line_no: int
    lines: list[str] = field(default_factory=list)

    def add(self, line: str) -> None:
        self.lines.append(line.strip())

    def build(
        self, ordinal: int, zh_sentences: list[str], source_path: str
    ) -> ParagraphDraft:
        en_text = clean_text(" ".join(self.lines))
        if not en_text:
            raise ValueError(
                f"paragraph {ordinal} at line {self.line_no} has no English text"
            )
        en_sentences = split_by_markers(en_text)
        if not en_sentences:
            raise ValueError(
                f"paragraph {ordinal} at line {self.line_no} has no sentences"
            )

        sentences = [
            SentenceDraft(
                ordinal=index + 1,
                text_en=en,
                text_zh=zh_sentences[index] if index < len(zh_sentences) else None,
                source_ref=SourceRef(source_path, self.line_no),
            )
            for index, en in enumerate(en_sentences)
        ]
        return ParagraphDraft(
            ordinal=ordinal,
            text_en=" ".join(sentence.text_en for sentence in sentences),
            text_zh=clean_text(
                " ".join(sentence.text_zh for sentence in sentences if sentence.text_zh)
            )
            or None,
            sentences=sentences,
            label=None,
        )


def _find_text_block(
    lines: list[str], year: int, text_no: int
) -> tuple[int, int, str | None]:
    year_start: int | None = None
    for index, line in enumerate(lines):
        match = _YEAR_HEADING_RE.match(line)
        if match and int(match.group("year")) == year and "试题精解" in line:
            year_start = index
            break
    if year_start is None:
        raise ValueError(f"year {year} jingbian solution heading not found")

    text_start: int | None = None
    title: str | None = None
    for index in range(year_start, len(lines)):
        match = _TEXT_HEADING_RE.match(lines[index])
        if match and int(match.group("text_no")) == text_no:
            text_start = index
            title = match.group("title").strip() or None
            break
    if text_start is None:
        raise ValueError(f"Text {text_no} heading not found after year {year}")

    text_end = len(lines)
    translation_seen = False
    for index in range(text_start + 1, len(lines)):
        line = lines[index]
        if _TEXT_HEADING_RE.match(line):
            text_end = index
            break
        if re.match(r"^##\s+Part\s+[ABC]\b", line):
            text_end = index
            break
        if _YEAR_HEADING_RE.match(line):
            text_end = index
            break
        if _TRANSLATION_HEADING_RE.match(line):
            translation_seen = True
            continue
        if (
            translation_seen
            and re.match(r"^##\s+", line)
            and not re.match(
                r"^##\s+(?:[一二三四五六七八九十]+、|\[?解题步骤\]?|"
                r"技巧|总结|命题|解题|干扰|词汇|语法|长难句|"
                r"答案|译文|全文|脉络|题眼|考点|高频|"
                r"文章来源|文章结构|试题精解)",
                line,
            )
        ):
            text_end = index
            break
    return text_start, text_end, title


def parse_jingbian_text(
    source_path: str | Path,
    year: int,
    text_no: int,
    *,
    title_en: str | None = None,
    display_order: int = 1,
) -> PassageDraft:
    path = Path(source_path)
    lines = path.read_text(encoding="utf-8").splitlines()
    text_start, text_end, title_zh = _find_text_block(lines, year, text_no)
    block = lines[text_start:text_end]

    source_note: str | None = None
    for line in block:
        match = _SOURCE_RE.match(line.strip())
        if match:
            source_note = match.group("note").strip() or None
            break

    translation_start: int | None = None
    for index, line in enumerate(block):
        if _TRANSLATION_HEADING_RE.match(line):
            translation_start = index + 1
            break
    if translation_start is None:
        # 2024 Part B/C drop the heading; start at the first Roman-labelled line.
        for index, line in enumerate(block):
            if _ROMAN_LABEL_RE.match(line):
                translation_start = index
                break
    if translation_start is None:
        raise ValueError(f"Text {text_no} has no translation section")

    english_blocks: list[_EnglishBlock] = []
    chinese_sentences: list[str] = []
    current_en: _EnglishBlock | None = None
    in_table = False
    at_paragraph_start = True

    def finish_en() -> None:
        nonlocal current_en
        if current_en is not None and current_en.lines:
            english_blocks.append(current_en)
        current_en = None

    for offset in range(translation_start, len(block)):
        line = block[offset]
        line_no = text_start + offset + 1  # 1-based source line number
        stripped = line.strip()

        if _TABLE_START in stripped:
            finish_en()
            in_table = True
            if _TABLE_END in stripped:
                in_table = False
            at_paragraph_start = True
            continue
        if in_table:
            if _TABLE_END in stripped:
                in_table = False
                at_paragraph_start = True
            continue
        if not stripped:
            at_paragraph_start = True
            continue
        if _is_noise(line):
            finish_en()
            at_paragraph_start = True
            continue

        roman = _ROMAN_LABEL_RE.match(stripped)
        if roman and (at_paragraph_start or current_en is None):
            label = _normalise_roman(roman.group("label"))
            body = roman.group("body").strip()
            # A paragraph label "I" is followed by a sentence marker in the
            # jingbian layout.  A bare "I ..." is the English pronoun and must
            # not split the paragraph.
            if label == "I" and body and not _SENTENCE_MARKER_RE.match(body):
                roman = None
            else:
                finish_en()
                current_en = _EnglishBlock(label=label, line_no=line_no)
                if body:
                    current_en.add(body)
                at_paragraph_start = False
                continue

        if _cjk_ratio(stripped) > 0.2:
            finish_en()
            chinese_sentences.extend(split_by_markers(stripped))
        else:
            if current_en is None:
                current_en = _EnglishBlock(label=None, line_no=line_no)
            current_en.add(stripped)
        at_paragraph_start = False

    finish_en()

    paragraphs: list[ParagraphDraft] = []
    zh_cursor = 0
    for index, english_block in enumerate(english_blocks):
        en_text = clean_text(" ".join(english_block.lines))
        en_count = len(split_by_markers(en_text))
        zh_slice = chinese_sentences[zh_cursor : zh_cursor + en_count]
        zh_cursor += en_count
        paragraphs.append(english_block.build(index + 1, zh_slice, str(path)))

    for paragraph in paragraphs:
        changed = False
        for sentence in paragraph.sentences:
            override = _SENTENCE_ZH_OVERRIDES.get(
                (year, text_no, paragraph.ordinal, sentence.ordinal)
            )
            if override:
                sentence.text_zh = override
                changed = True
        if changed:
            paragraph.text_zh = (
                clean_text(
                    " ".join(
                        sentence.text_zh
                        for sentence in paragraph.sentences
                        if sentence.text_zh
                    )
                )
                or None
            )

    if not paragraphs:
        raise ValueError(f"Text {text_no} has no paragraphs")

    english_text = " ".join(paragraph.text_en for paragraph in paragraphs)
    passage = PassageDraft(
        key=f"{year}-A-T{text_no}",
        year=year,
        part="A",
        text_no=text_no,
        title_zh=title_zh,
        title_en=title_en,
        source_note=source_note,
        word_count=detect_word_count("\n".join(block), english_text),
        part_b_type=None,
        display_order=display_order,
        paragraphs=paragraphs,
        source_path=str(path),
    )
    return passage
