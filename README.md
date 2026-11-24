# 考研英语阅读本

[![CI](https://github.com/Qxy0happy/reading-book/actions/workflows/ci.yml/badge.svg)](https://github.com/Qxy0happy/reading-book/actions/workflows/ci.yml)
[![Release](https://github.com/Qxy0happy/reading-book/actions/workflows/release.yml/badge.svg)](https://github.com/Qxy0happy/reading-book/actions/workflows/release.yml)

把考研英语一历年真题的阅读文章与资料译文整理成可离线阅读的 Flutter 应用（Android + Linux）。

当前仓库是走通骨架：内容流水线已实现 2024 年 Part A Text 1 的抽取与 SQLite 构建；Flutter 应用已具备目录、阅读页逐段展开译文、全部显示/隐藏、书签、继续阅读与设置。完整 2004–2025 语料与 Part B/C 仍在实施中。

## 示例内容与版权

- 仓库**只提交合成示例**：`pipeline/config/sample-source.md` 是原创英文与中文，生成的 `app/assets/content.sqlite` 标记为 `sample=true`。
- **真实真题正文与资料译文不进入仓库**。`pipeline/config/manifest.yaml` 只保存本地资料路径，供已购买资料的用户自行构建。
- `scripts/check_sample_content.py` 在 CI 与发布流程中拒绝非示例内容库，避免误传真实内容。
- 真题与资料译文的使用请遵守原始资料的版权与许可。

## 目录

```
app/         Flutter 应用（Android + Linux）
pipeline/    Python + uv 内容流水线
content/     本地生成的内容库（不提交）
scripts/     CI 与内容守卫脚本
.github/     CI 与 Release workflow
```

## 构建示例内容

```bash
cd pipeline
uv sync --locked
uv run readingbook-build          # 默认读取 config/manifest.sample.yaml
uv run readingbook-validate
uv run readingbook-inspect
uv run pytest
```

`readingbook-build` 生成 `content/content.sqlite` 并复制到 `app/assets/content.sqlite`。默认路径就是仓库中的合成示例。

## 运行应用

```bash
cd app
flutter pub get
flutter analyze
flutter test
flutter build linux --release
./build/linux/x64/release/bundle/readingbook
```

Android：

```bash
cd app
flutter build apk --release --split-per-abi
```

Android 构建需要 JDK 21。Gradle 默认使用 `JAVA_HOME`；也可以在本机 `~/.gradle/gradle.properties` 中设置：

```properties
org.gradle.java.home=/path/to/jdk-21
```

可选 release 签名：在 `app/android/key.properties` 中配置 `storeFile`、`storePassword`、`keyAlias`、`keyPassword`，并把 keystore 放到 `app/android/app/` 下。未配置时使用 debug 签名，适合本地试用。

## 使用本地真实内容

如果你拥有对应的资料，可在本地用 `pipeline/config/manifest.yaml` 构建真实内容：

```bash
cd pipeline
uv run readingbook-build \
  --manifest config/manifest.yaml \
  --out ../content/content.sqlite \
  --app-assets ../app/assets/content.sqlite
```

请勿把生成的真实内容库提交到公开仓库；CI 的 `check_sample_content.py` 会拒绝它。

## 发布

推送 `v*` tag 会触发 `.github/workflows/release.yml`，构建并发布：

- `reading-book-android-arm64-v8a.apk`
- `reading-book-linux-amd64-<version>.tar.gz`
- `SHA256SUMS`

也可以在 Actions 页面手动触发 Release workflow 并填写 tag。Linux 产物解压后运行 `bundle/readingbook`。发布产物使用仓库中的合成示例内容。

## 技术栈

- Flutter 3.50.1 / Dart 3.14
- drift + sqlite3 + path_provider
- Python 3.14 + uv + PyYAML
- Source Serif 4 + Noto Serif SC（SIL Open Font License 1.1）

## 许可证

代码与示例内容采用 [MIT License](LICENSE)。字体采用 SIL Open Font License 1.1，许可证文本见 `app/assets/fonts/*-OFL.txt`。
