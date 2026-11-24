import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:readingbook/bootstrap.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('第二次 bootstrap 复用已复制的内容库', () async {
    final directory = await Directory.systemTemp.createTemp(
      'readingbook_bootstrap_',
    );
    try {
      final first = await bootstrap(supportDirectory: directory);
      await first.dispose();
      final target = File('${directory.path}/content.sqlite');
      final before = await target.lastModified();
      await Future<void>.delayed(const Duration(milliseconds: 20));

      final second = await bootstrap(supportDirectory: directory);
      await second.dispose();

      expect(await target.lastModified(), before);
      expect(
        File('${directory.path}/content.sqlite.tmp').existsSync(),
        isFalse,
      );
    } finally {
      await directory.delete(recursive: true);
    }
  });

  test('bootstrap 复制内容库并打开两个数据库', () async {
    final directory = await Directory.systemTemp.createTemp(
      'readingbook_bootstrap_',
    );
    try {
      final dependencies = await bootstrap(supportDirectory: directory);

      expect(File('${directory.path}/content.sqlite').existsSync(), isTrue);
      expect(File('${directory.path}/progress.sqlite').existsSync(), isTrue);
      expect(dependencies.contentVersion, isNotEmpty);

      final content = await dependencies.contentRepository.loadPassage(
        '2024-A-T1',
      );
      expect(content.paragraphs, isNotEmpty);
      expect(content.paragraphs.first.textZh, isNotNull);

      await dependencies.dispose();
    } finally {
      await directory.delete(recursive: true);
    }
  });
}
