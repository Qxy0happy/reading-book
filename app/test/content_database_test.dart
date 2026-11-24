import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readingbook/data/content/content_database.dart';
import 'package:readingbook/data/content/content_repository_impl.dart';

void main() {
  test('真实内容库可通过 drift 只读加载', () async {
    final tempDir = await Directory.systemTemp.createTemp(
      'readingbook_content_',
    );
    final file = File('${tempDir.path}/content.sqlite');
    await File('assets/content.sqlite').copy(file.path);

    final db = ContentDatabase(
      NativeDatabase(
        file,
        setup: (database) => database.execute('PRAGMA query_only = ON'),
      ),
    );
    final repository = DriftContentRepository(db);
    try {
      final version = await repository.readContentVersion();
      expect(version, isNotEmpty);

      final content = await repository.loadPassage('2024-A-T1');
      expect(content.passage.year, greaterThanOrEqualTo(2000));
      expect(content.passage.part, 'A');
      expect(content.passage.textNo, 1);
      expect(content.passage.wordCount, greaterThan(0));
      expect(content.paragraphs, isNotEmpty);
      expect(
        content.sentencesByParagraph.values.expand((sentences) => sentences),
        isNotEmpty,
      );
      for (final paragraph in content.paragraphs) {
        expect(paragraph.textEn, isNotEmpty);
        expect(paragraph.textZh, isNotNull);
        expect(paragraph.textZh, isNotEmpty);
        expect(content.sentencesFor(paragraph.key), isNotEmpty);
      }
    } finally {
      await db.close();
      await tempDir.delete(recursive: true);
    }
  });
}
