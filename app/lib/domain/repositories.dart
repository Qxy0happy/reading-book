import 'models.dart';

abstract interface class ContentRepository {
  Future<List<Paper>> listPapers();

  Future<List<PassageSummary>> listPassages();

  Future<PassageContent> loadPassage(String passageKey);

  Future<String> readContentVersion();
}

abstract interface class ProgressRepository {
  Stream<ReadingProgress?> watchProgress(String passageKey);

  Stream<List<ReadingProgress>> watchAllProgress();

  Stream<List<Bookmark>> watchBookmarks();

  Stream<ReaderSettings> watchSettings();

  Future<void> saveProgress(ReadingProgress progress);

  Future<void> setRead(String passageKey, bool isRead);

  Future<void> addBookmark(String passageKey, String paragraphKey);

  Future<void> removeBookmark(String paragraphKey);

  Future<void> saveSettings(ReaderSettings settings);
}
