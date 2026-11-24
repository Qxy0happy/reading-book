from __future__ import annotations

from pathlib import Path

import pytest

from readingbook_pipeline.sources.huangpishu import parse_jingbian_text

FIXTURE = Path(__file__).parent / "fixtures" / "jingbian_text_sample.md"


def test_parse_separate_english_and_chinese_runs() -> None:
    passage = parse_jingbian_text(
        FIXTURE, year=2024, text_no=1, title_en="A Test Article"
    )

    assert passage.key == "2024-A-T1"
    assert passage.title_zh == "测试文章"
    assert passage.title_en == "A Test Article"
    assert passage.source_note is not None
    assert "A Test Article" in passage.source_note
    assert passage.word_count == 80
    assert len(passage.paragraphs) == 3

    first, second, third = passage.paragraphs
    assert [len(paragraph.sentences) for paragraph in passage.paragraphs] == [2, 3, 1]
    assert first.text_en.startswith("First English sentence.")
    assert first.text_zh == "第一句译文。 第二句译文。"
    assert second.text_zh == "第三句译文。 第四句译文。 第五句译文。"
    assert third.text_en == "Sixth English sentence."
    assert third.text_zh == "第六句译文。"

    for paragraph in passage.paragraphs:
        assert paragraph.text_en == " ".join(
            sentence.text_en for sentence in paragraph.sentences
        )
        assert all(sentence.text_zh for sentence in paragraph.sentences)


def test_parser_skips_pipe_tables() -> None:
    passage = parse_jingbian_text(FIXTURE, year=2024, text_no=1)

    joined_en = " ".join(paragraph.text_en for paragraph in passage.paragraphs)
    joined_zh = " ".join(paragraph.text_zh or "" for paragraph in passage.paragraphs)

    assert "Test question" not in joined_en
    assert "Option A" not in joined_en
    assert "测试题目" not in joined_zh
    assert "选项 A" not in joined_zh


def test_parser_stops_at_next_text() -> None:
    passage = parse_jingbian_text(FIXTURE, year=2024, text_no=1)

    assert all(
        "下一篇文章" not in (paragraph.text_zh or "")
        for paragraph in passage.paragraphs
    )
    assert all(
        "不应被解析" not in paragraph.text_en for paragraph in passage.paragraphs
    )


def test_real_2024_text1_if_available() -> None:
    source = (
        Path(__file__).parents[3]
        / "00.黄皮书"
        / "outputs"
        / "历年考研英语真题解析及复习思路(精编版)  (2022-2026)"
        / "markdown.md"
    )
    if not source.exists():
        pytest.skip("real 2024 source is not available")

    passage = parse_jingbian_text(source, year=2024, text_no=1)

    assert passage.key == "2024-A-T1"
    assert len(passage.paragraphs) == 7
    assert sum(len(paragraph.sentences) for paragraph in passage.paragraphs) == 19
    assert all(paragraph.text_zh for paragraph in passage.paragraphs)
    assert all(
        sentence.text_zh
        for paragraph in passage.paragraphs
        for sentence in paragraph.sentences
    )
    assert passage.word_count == 424
