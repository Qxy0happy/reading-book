import 'package:drift/drift.dart';

import '../../domain/models.dart';
import '../../domain/repositories.dart';
import 'progress_database.dart';

class DriftProgressRepository implements ProgressRepository {
  DriftProgressRepository(this._db);

  final ProgressDatabase _db;

  @override
  Stream<ReadingProgress?> watchProgress(String passageKey) {
    return (_db.select(_db.readingProgressTable)
          ..where((table) => table.passageKey.equals(passageKey)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _mapProgress(row));
  }

  @override
  Stream<List<ReadingProgress>> watchAllProgress() {
    return _db
        .select(_db.readingProgressTable)
        .watch()
        .map((rows) => rows.map(_mapProgress).toList(growable: false));
  }

  @override
  Stream<List<Bookmark>> watchBookmarks() {
    return _db
        .select(_db.bookmarkTable)
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => Bookmark(
                  passageKey: row.passageKey,
                  paragraphKey: row.paragraphKey,
                  createdAt: row.createdAt,
                ),
              )
              .toList(growable: false),
        );
  }

  @override
  Stream<ReaderSettings> watchSettings() {
    return _db
        .select(_db.settingsTable)
        .watch()
        .map(
          (rows) => ReaderSettings.fromMap({
            for (final row in rows) row.key: row.value,
          }),
        );
  }

  @override
  Future<void> saveProgress(ReadingProgress progress) async {
    await _db
        .into(_db.readingProgressTable)
        .insertOnConflictUpdate(
          ReadingProgressTableCompanion.insert(
            passageKey: progress.passageKey,
            lastParagraphKey: Value(progress.lastParagraphKey),
            lastSentenceKey: Value(progress.lastSentenceKey),
            isRead: Value(progress.isRead),
            updatedAt: progress.updatedAt,
          ),
        );
  }

  @override
  Future<void> setRead(String passageKey, bool isRead) async {
    final existing = await (_db.select(
      _db.readingProgressTable,
    )..where((table) => table.passageKey.equals(passageKey))).getSingleOrNull();
    final now = DateTime.now().millisecondsSinceEpoch;
    if (existing == null) {
      await _db
          .into(_db.readingProgressTable)
          .insert(
            ReadingProgressTableCompanion.insert(
              passageKey: passageKey,
              isRead: Value(isRead),
              updatedAt: now,
            ),
          );
    } else {
      await (_db.update(
        _db.readingProgressTable,
      )..where((table) => table.passageKey.equals(passageKey))).write(
        ReadingProgressTableCompanion(
          isRead: Value(isRead),
          updatedAt: Value(now),
        ),
      );
    }
  }

  @override
  Future<void> addBookmark(String passageKey, String paragraphKey) async {
    await _db
        .into(_db.bookmarkTable)
        .insert(
          BookmarkTableCompanion.insert(
            passageKey: passageKey,
            paragraphKey: paragraphKey,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  @override
  Future<void> removeBookmark(String paragraphKey) async {
    await (_db.delete(
      _db.bookmarkTable,
    )..where((table) => table.paragraphKey.equals(paragraphKey))).go();
  }

  @override
  Future<void> saveSettings(ReaderSettings settings) async {
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.settingsTable,
        settings
            .toMap()
            .entries
            .map(
              (entry) => SettingsTableCompanion.insert(
                key: entry.key,
                value: entry.value,
              ),
            )
            .toList(growable: false),
      );
    });
  }

  Future<void> ensureDefaults() async {
    final rows = await _db.select(_db.settingsTable).get();
    final existing = rows.map((row) => row.key).toSet();
    final defaults = ReaderSettings.defaults.toMap();
    final missing = defaults.entries
        .where((entry) => !existing.contains(entry.key))
        .map(
          (entry) =>
              SettingsTableCompanion.insert(key: entry.key, value: entry.value),
        )
        .toList(growable: false);
    if (missing.isNotEmpty) {
      await _db.batch((batch) => batch.insertAll(_db.settingsTable, missing));
    }
  }

  Future<void> close() => _db.close();

  ReadingProgress _mapProgress(ReadingProgressRow row) => ReadingProgress(
    passageKey: row.passageKey,
    lastParagraphKey: row.lastParagraphKey,
    lastSentenceKey: row.lastSentenceKey,
    isRead: row.isRead,
    updatedAt: row.updatedAt,
  );
}
