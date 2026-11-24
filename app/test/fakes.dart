import 'dart:async';

import 'package:readingbook/domain/models.dart';
import 'package:readingbook/domain/repositories.dart';

class FakeContentRepository implements ContentRepository {
  FakeContentRepository(this.content);

  final PassageContent content;

  @override
  Future<List<Paper>> listPapers() async => [
    Paper(year: content.passage.year, code: 'english1'),
  ];

  @override
  Future<List<PassageSummary>> listPassages() async => [
    PassageSummary(
      key: content.passage.key,
      year: content.passage.year,
      part: content.passage.part,
      textNo: content.passage.textNo,
      titleZh: content.passage.titleZh,
      titleEn: content.passage.titleEn,
      wordCount: content.passage.wordCount,
      partBType: content.passage.partBType,
      displayOrder: content.passage.displayOrder,
    ),
  ];

  @override
  Future<PassageContent> loadPassage(String passageKey) async => content;

  @override
  Future<String> readContentVersion() async => 'test';
}

class FakeProgressRepository implements ProgressRepository {
  final List<ReadingProgress> progress = [];
  final List<Bookmark> bookmarks = [];
  ReaderSettings settings = ReaderSettings.defaults;

  final StreamController<List<ReadingProgress>> _progressController =
      StreamController<List<ReadingProgress>>.broadcast();
  final StreamController<List<Bookmark>> _bookmarkController =
      StreamController<List<Bookmark>>.broadcast();
  final StreamController<ReaderSettings> _settingsController =
      StreamController<ReaderSettings>.broadcast();

  @override
  Stream<ReadingProgress?> watchProgress(String passageKey) async* {
    yield _progressFor(passageKey);
    yield* _progressController.stream.map((_) => _progressFor(passageKey));
  }

  @override
  Stream<List<ReadingProgress>> watchAllProgress() async* {
    yield List.unmodifiable(progress);
    yield* _progressController.stream;
  }

  @override
  Stream<List<Bookmark>> watchBookmarks() async* {
    yield List.unmodifiable(bookmarks);
    yield* _bookmarkController.stream;
  }

  @override
  Stream<ReaderSettings> watchSettings() async* {
    yield settings;
    yield* _settingsController.stream;
  }

  @override
  Future<void> saveProgress(ReadingProgress value) async {
    progress.removeWhere((item) => item.passageKey == value.passageKey);
    progress.add(value);
    _progressController.add(List.unmodifiable(progress));
  }

  @override
  Future<void> setRead(String passageKey, bool isRead) async {
    final existing = _progressFor(passageKey);
    await saveProgress(
      existing?.copyWith(isRead: isRead) ??
          ReadingProgress(
            passageKey: passageKey,
            lastParagraphKey: null,
            lastSentenceKey: null,
            isRead: isRead,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
          ),
    );
  }

  @override
  Future<void> addBookmark(String passageKey, String paragraphKey) async {
    if (bookmarks.any((bookmark) => bookmark.paragraphKey == paragraphKey)) {
      return;
    }
    bookmarks.add(
      Bookmark(
        passageKey: passageKey,
        paragraphKey: paragraphKey,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
    _bookmarkController.add(List.unmodifiable(bookmarks));
  }

  @override
  Future<void> removeBookmark(String paragraphKey) async {
    bookmarks.removeWhere((bookmark) => bookmark.paragraphKey == paragraphKey);
    _bookmarkController.add(List.unmodifiable(bookmarks));
  }

  @override
  Future<void> saveSettings(ReaderSettings value) async {
    settings = value;
    _settingsController.add(value);
  }

  ReadingProgress? _progressFor(String passageKey) {
    for (final item in progress) {
      if (item.passageKey == passageKey) return item;
    }
    return null;
  }

  Future<void> dispose() async {
    await _progressController.close();
    await _bookmarkController.close();
    await _settingsController.close();
  }
}
