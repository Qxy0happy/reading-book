import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readingbook/data/progress/progress_database.dart';
import 'package:readingbook/data/progress/progress_repository_impl.dart';
import 'package:readingbook/domain/models.dart';

void main() {
  test('进度库读写、书签与设置持久化', () async {
    final db = ProgressDatabase(NativeDatabase.memory());
    final repository = DriftProgressRepository(db);
    try {
      await repository.ensureDefaults();
      final initial = await repository.watchSettings().first;
      expect(initial.fontSize, ReaderSettings.defaults.fontSize);
      expect(initial.theme, ReaderTheme.paper);

      await repository.saveProgress(
        const ReadingProgress(
          passageKey: '2024-A-T1',
          lastParagraphKey: '2024-A-T1-P03',
          lastSentenceKey: null,
          isRead: false,
          updatedAt: 1,
        ),
      );
      final progress = await repository.watchProgress('2024-A-T1').first;
      expect(progress?.lastParagraphKey, '2024-A-T1-P03');

      await repository.addBookmark('2024-A-T1', '2024-A-T1-P03');
      await repository.addBookmark('2024-A-T1', '2024-A-T1-P03');
      expect(await repository.watchBookmarks().first, hasLength(1));

      await repository.removeBookmark('2024-A-T1-P03');
      expect(await repository.watchBookmarks().first, isEmpty);

      await repository.saveSettings(
        ReaderSettings.defaults.copyWith(fontSize: 21, showTranslations: true),
      );
      final updated = await repository.watchSettings().first;
      expect(updated.fontSize, 21);
      expect(updated.showTranslations, isTrue);
    } finally {
      await db.close();
    }
  });
}
