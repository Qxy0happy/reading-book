import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:readingbook/bootstrap.dart';
import 'package:readingbook/domain/models.dart';
import 'package:readingbook/reader/reader_screen.dart';
import 'package:readingbook/settings/settings_controller.dart';
import 'package:readingbook/shared/theme.dart';

import 'fakes.dart';

PassageContent _sampleContent() {
  const paragraphs = [
    Paragraph(
      key: '2024-A-T1-P01',
      ordinal: 1,
      label: null,
      headingEn: null,
      headingZh: null,
      speaker: null,
      textEn: 'First English paragraph.',
      textZh: '第一段译文。',
      translationSource: 'huangpishu',
      translationStatus: 'source',
    ),
    Paragraph(
      key: '2024-A-T1-P02',
      ordinal: 2,
      label: null,
      headingEn: null,
      headingZh: null,
      speaker: null,
      textEn: 'Second English paragraph.',
      textZh: '第二段译文。',
      translationSource: 'huangpishu',
      translationStatus: 'source',
    ),
  ];
  return PassageContent(
    passage: const Passage(
      key: '2024-A-T1',
      year: 2024,
      part: 'A',
      textNo: 1,
      titleZh: '测试文章',
      titleEn: 'A Test Article',
      sourceNote: 'Test source',
      wordCount: 10,
      partBType: null,
      displayOrder: 1,
    ),
    paragraphs: paragraphs,
    sentencesByParagraph: const {
      '2024-A-T1-P01': [
        Sentence(
          key: '2024-A-T1-P01-S01',
          ordinal: 1,
          textEn: 'First English paragraph.',
          textZh: '第一段译文。',
          examNo: null,
        ),
      ],
      '2024-A-T1-P02': [
        Sentence(
          key: '2024-A-T1-P02-S01',
          ordinal: 1,
          textEn: 'Second English paragraph.',
          textZh: '第二段译文。',
          examNo: null,
        ),
      ],
    },
    gaps: const [],
    options: const [],
  );
}

void main() {
  testWidgets('点按段落展开并收起中文译文', (tester) async {
    final contentRepository = FakeContentRepository(_sampleContent());
    final progressRepository = FakeProgressRepository();
    final settingsController = SettingsController(progressRepository);
    await settingsController.load();
    addTearDown(settingsController.dispose);
    addTearDown(progressRepository.dispose);

    final dependencies = AppDependencies(
      contentRepository: contentRepository,
      progressRepository: progressRepository,
      settingsController: settingsController,
      contentVersion: 'test',
      dispose: () async {},
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.build(ReaderTheme.paper),
        home: ReaderScreen(dependencies: dependencies, passageKey: '2024-A-T1'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('First English paragraph.'), findsOneWidget);
    expect(find.text('第一段译文。'), findsNothing);

    await tester.tap(find.text('First English paragraph.'));
    await tester.pumpAndSettle();

    expect(find.text('第一段译文。'), findsOneWidget);
    expect(find.text('第二段译文。'), findsNothing);

    await tester.tap(find.text('First English paragraph.'));
    await tester.pumpAndSettle();

    expect(find.text('第一段译文。'), findsNothing);
  });

  testWidgets('全部显示与全部隐藏作用于所有段落', (tester) async {
    final contentRepository = FakeContentRepository(_sampleContent());
    final progressRepository = FakeProgressRepository();
    final settingsController = SettingsController(progressRepository);
    await settingsController.load();
    addTearDown(settingsController.dispose);
    addTearDown(progressRepository.dispose);

    final dependencies = AppDependencies(
      contentRepository: contentRepository,
      progressRepository: progressRepository,
      settingsController: settingsController,
      contentVersion: 'test',
      dispose: () async {},
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.build(ReaderTheme.paper),
        home: ReaderScreen(dependencies: dependencies, passageKey: '2024-A-T1'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('显示译文'));
    await tester.pumpAndSettle();

    expect(find.text('第一段译文。'), findsOneWidget);
    expect(find.text('第二段译文。'), findsOneWidget);

    await tester.tap(find.text('隐藏译文'));
    await tester.pumpAndSettle();

    expect(find.text('第一段译文。'), findsNothing);
    expect(find.text('第二段译文。'), findsNothing);
  });
}
