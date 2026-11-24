# readingbook-pipeline

把源 markdown 转成可校验的 `content.sqlite`。

## 命令

```bash
cd pipeline
uv sync --locked
uv run readingbook-build
uv run readingbook-validate
uv run readingbook-inspect
uv run pytest
```

- `readingbook-build` 默认读取 `config/manifest.sample.yaml`，从 `config/sample-source.md` 生成合成示例内容库，并复制到 `../app/assets/content.sqlite`。
- `readingbook-validate` 检查 schema、`user_version`、段落/句子序、英文拼接与译文状态。
- `readingbook-inspect` 打印篇目、段落与句子计数。
- 使用本地真实资料时，显式传入 `--manifest config/manifest.yaml`。真实内容库不要提交到公开仓库。

## 结构

- `src/readingbook_pipeline/sources/huangpishu.py`：精编版适配器。
- `src/readingbook_pipeline/segment.py`：切句与词数。
- `src/readingbook_pipeline/build_sqlite.py`：SQLite 构建与校验。
- `config/content-schema.sql`：内容库 schema 构建输入。

## 示例内容

`config/sample-source.md` 的正文与译文均为本项目原创。构建后的内容库写入 `meta.sample=true`，`scripts/check_sample_content.py` 在 CI 与发布流程中据此拒绝真实内容库。
