from __future__ import annotations

from pathlib import Path

import pytest

from readingbook_pipeline.sources.jingjiang import parse_jingjiang_part_a

FIXTURE = Path(__file__).parent / "fixtures" / "jingjiang_text_sample.md"


def test_jingjiang_merges_split_lines_and_dedupes() -> None:
    passages = parse_jingjiang_part_a(FIXTURE, 2024, expected_texts=1)
    assert len(passages) == 1
    passage = passages[0]
    assert passage.key == "2024-A-T1"
    assert len(passage.paragraphs) == 2

    first, second = passage.paragraphs
    assert [sentence.text_en for sentence in first.sentences] == [
        "First English sentence.",
        "A sentence that is split across lines and ends here.",
        "Duplicate sentence.",
    ]
    assert first.sentences[1].text_zh == "一个被拆成两行的句子。"
    assert second.sentences[0].text_zh == "第二段译文。"
    assert all(sentence.text_zh for sentence in first.sentences)
    assert "word" not in first.text_en
    assert "主" not in first.text_en
    joined = " ".join(paragraph.text_en for paragraph in passage.paragraphs)
    assert "Part B" not in joined


def test_real_part_a_corpus_if_available() -> None:
    base = Path(__file__).parents[3] / "00.Past Papers [Translation]" / "outputs"
    if not base.exists():
        pytest.skip("real jingjiang sources are not available")

    total = 0
    for year in range(2004, 2024):
        source = base / f"{year}年逐词逐句精讲册" / "markdown.md"
        if not source.exists():
            pytest.skip(f"missing source: {source}")
        passages = parse_jingjiang_part_a(source, year)
        assert len(passages) == 4
        for passage in passages:
            assert passage.paragraphs
            for paragraph in passage.paragraphs:
                assert paragraph.sentences
                for sentence in paragraph.sentences:
                    assert sentence.text_zh
                    assert "$^{*}$" not in sentence.text_en
                    assert "★" not in sentence.text_en
            total += 1
    assert total == 80
