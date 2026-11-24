-- 内容库 content.sqlite schema v1（构建输入）
-- 权威定义：.scratch/reading-book/spec/content-schema.sql
-- 只包含内容库表；进度库由 Flutter drift 管理。

PRAGMA foreign_keys = ON;

CREATE TABLE meta (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL
) WITHOUT ROWID;

CREATE TABLE paper (
  id    INTEGER PRIMARY KEY,
  year  INTEGER NOT NULL,
  code  TEXT NOT NULL,          -- 'english1'
  title TEXT,
  UNIQUE (year, code)
);

CREATE TABLE passage (
  id            INTEGER PRIMARY KEY,
  key           TEXT NOT NULL UNIQUE,  -- '2024-A-T1' / '2024-B' / '2024-C'
  paper_id      INTEGER NOT NULL REFERENCES paper(id) ON DELETE CASCADE,
  part          TEXT NOT NULL CHECK (part IN ('A','B','C')),
  text_no       INTEGER,               -- Part A: 1..4；Part B/C: NULL
  title_zh      TEXT,
  title_en      TEXT,
  source_note   TEXT,                  -- 来源说明，可空
  word_count    INTEGER NOT NULL CHECK (word_count >= 0),
  part_b_type   TEXT CHECK (part_b_type IN
                    ('gap_fill','ordering','heading_match','opinion_match','translation')),
  display_order INTEGER NOT NULL,
  CHECK ((part = 'A' AND text_no BETWEEN 1 AND 4)
      OR (part IN ('B','C') AND text_no IS NULL)),
  CHECK ((part = 'B' AND part_b_type IS NOT NULL)
      OR (part <> 'B' AND part_b_type IS NULL))
);

CREATE UNIQUE INDEX ux_passage_part_a
  ON passage(paper_id, text_no) WHERE part = 'A';
CREATE UNIQUE INDEX ux_passage_part_bc
  ON passage(paper_id, part) WHERE part IN ('B','C');
CREATE INDEX idx_passage_display ON passage(display_order);

CREATE TABLE paragraph (
  id                 INTEGER PRIMARY KEY,
  key                TEXT NOT NULL UNIQUE,  -- '{passage.key}-P03'
  passage_id         INTEGER NOT NULL REFERENCES passage(id) ON DELETE CASCADE,
  ordinal            INTEGER NOT NULL CHECK (ordinal >= 1),
  label              TEXT,                  -- 排序: 'A'..'H'；观点匹配: '41'..'45'
  heading_en         TEXT,                  -- 标题匹配: 匹配到的小标题
  heading_zh         TEXT,
  speaker            TEXT,                  -- 观点匹配: 人名
  text_en            TEXT NOT NULL,         -- 阅读页快照（句级拼接）
  text_zh            TEXT,                  -- 阅读页快照（主译文）
  translation_source TEXT CHECK (translation_source IN
                        ('jingjiang','huangpishu','mixed','llm')),
  translation_status TEXT NOT NULL DEFAULT 'source'
                        CHECK (translation_status IN ('source','machine','missing')),
  UNIQUE (passage_id, ordinal),
  CHECK ((translation_status = 'missing' AND text_zh IS NULL)
      OR (translation_status IN ('source','machine') AND text_zh IS NOT NULL))
);

CREATE INDEX idx_paragraph_passage ON paragraph(passage_id, ordinal);

CREATE TABLE sentence (
  id                 INTEGER PRIMARY KEY,
  key                TEXT NOT NULL UNIQUE,  -- '{paragraph.key}-S01'
  paragraph_id       INTEGER NOT NULL REFERENCES paragraph(id) ON DELETE CASCADE,
  ordinal            INTEGER NOT NULL CHECK (ordinal >= 1),
  text_en            TEXT NOT NULL,
  text_zh            TEXT,
  translation_source TEXT CHECK (translation_source IN
                        ('jingjiang','huangpishu','mixed','llm')),
  translation_status TEXT NOT NULL DEFAULT 'source'
                        CHECK (translation_status IN ('source','machine','missing')),
  exam_no            INTEGER,               -- Part C: 46..50；2004 Part B: 61..65
  confidence         REAL CHECK (confidence IS NULL OR (confidence >= 0 AND confidence <= 1)),
  UNIQUE (paragraph_id, ordinal),
  CHECK (exam_no IS NULL OR exam_no BETWEEN 46 AND 65),
  CHECK ((translation_status = 'missing' AND text_zh IS NULL)
      OR (translation_status IN ('source','machine') AND text_zh IS NOT NULL))
);

CREATE INDEX idx_sentence_paragraph ON sentence(paragraph_id, ordinal);
CREATE INDEX idx_sentence_exam
  ON sentence(paragraph_id, exam_no) WHERE exam_no IS NOT NULL;

-- 7选5 的空格。空格位于“第 N 段之后”：
--   after_sentence_ordinal IS NULL  -> 整段之后（段间空格）
--   after_sentence_ordinal = K     -> 该段第 K 句之后（段内空格）
--   after_paragraph_ordinal = 0    -> 第一段之前
-- 不存正确选项；正确答案不进入内容库。
CREATE TABLE gap (
  id                      INTEGER PRIMARY KEY,
  passage_id              INTEGER NOT NULL REFERENCES passage(id) ON DELETE CASCADE,
  gap_no                  INTEGER NOT NULL CHECK (gap_no BETWEEN 41 AND 45),
  after_paragraph_ordinal INTEGER NOT NULL CHECK (after_paragraph_ordinal >= 0),
  after_sentence_ordinal  INTEGER CHECK (after_sentence_ordinal IS NULL
                                         OR after_sentence_ordinal >= 1),
  UNIQUE (passage_id, gap_no),
  CHECK (after_paragraph_ordinal > 0 OR after_sentence_ordinal IS NULL)
);

CREATE INDEX idx_gap_passage
  ON gap(passage_id, after_paragraph_ordinal, after_sentence_ordinal);

-- 仅 7选5 使用。选项按 A–G/H 排列；不存正确项。
CREATE TABLE part_b_option (
  id          INTEGER PRIMARY KEY,
  passage_id  INTEGER NOT NULL REFERENCES passage(id) ON DELETE CASCADE,
  option_key  TEXT NOT NULL,               -- 'A'..'G' / 'A'..'H'
  ordinal     INTEGER NOT NULL CHECK (ordinal >= 1),
  text_en     TEXT NOT NULL,
  text_zh     TEXT,
  UNIQUE (passage_id, option_key)
);

CREATE INDEX idx_option_passage ON part_b_option(passage_id, ordinal);

-- 内容版本。建议在 meta 中写入：
--   schema_version, content_version, generated_at, source_audit
-- 应用启动时比较 content_version；变化时替换内容库文件，

PRAGMA user_version = 1;
