import 'package:flutter/foundation.dart';

enum ReaderTheme { paper, dark, eyeCare }

extension ReaderThemeWire on ReaderTheme {
  String get wireName => switch (this) {
    ReaderTheme.paper => 'paper',
    ReaderTheme.dark => 'dark',
    ReaderTheme.eyeCare => 'eye_care',
  };

  static ReaderTheme fromWire(String? value) => switch (value) {
    'dark' => ReaderTheme.dark,
    'eye_care' => ReaderTheme.eyeCare,
    _ => ReaderTheme.paper,
  };
}

@immutable
class Paper {
  const Paper({required this.year, required this.code, this.title});

  final int year;
  final String code;
  final String? title;
}

@immutable
class PassageSummary {
  const PassageSummary({
    required this.key,
    required this.year,
    required this.part,
    required this.textNo,
    required this.titleZh,
    required this.titleEn,
    required this.wordCount,
    required this.partBType,
    required this.displayOrder,
  });

  final String key;
  final int year;
  final String part;
  final int? textNo;
  final String? titleZh;
  final String? titleEn;
  final int wordCount;
  final String? partBType;
  final int displayOrder;

  String get label {
    if (part == 'A' && textNo != null) return 'Part A · Text $textNo';
    return 'Part $part';
  }

  String get displayTitle => titleZh ?? titleEn ?? '$year $label';
}

@immutable
class Passage {
  const Passage({
    required this.key,
    required this.year,
    required this.part,
    required this.textNo,
    required this.titleZh,
    required this.titleEn,
    required this.sourceNote,
    required this.wordCount,
    required this.partBType,
    required this.displayOrder,
  });

  final String key;
  final int year;
  final String part;
  final int? textNo;
  final String? titleZh;
  final String? titleEn;
  final String? sourceNote;
  final int wordCount;
  final String? partBType;
  final int displayOrder;

  String get label {
    if (part == 'A' && textNo != null) return 'Part A · Text $textNo';
    return 'Part $part';
  }

  String get displayTitle => titleZh ?? titleEn ?? '$year $label';
}

@immutable
class Paragraph {
  const Paragraph({
    required this.key,
    required this.ordinal,
    required this.label,
    required this.headingEn,
    required this.headingZh,
    required this.speaker,
    required this.textEn,
    required this.textZh,
    required this.translationSource,
    required this.translationStatus,
  });

  final String key;
  final int ordinal;
  final String? label;
  final String? headingEn;
  final String? headingZh;
  final String? speaker;
  final String textEn;
  final String? textZh;
  final String? translationSource;
  final String translationStatus;

  bool get hasTranslation => textZh != null && textZh!.isNotEmpty;
  bool get isMachine => translationStatus == 'machine';
}

@immutable
class Sentence {
  const Sentence({
    required this.key,
    required this.ordinal,
    required this.textEn,
    required this.textZh,
    required this.examNo,
  });

  final String key;
  final int ordinal;
  final String textEn;
  final String? textZh;
  final int? examNo;
}

@immutable
class Gap {
  const Gap({
    required this.gapNo,
    required this.afterParagraphOrdinal,
    required this.afterSentenceOrdinal,
  });

  final int gapNo;
  final int afterParagraphOrdinal;
  final int? afterSentenceOrdinal;
}

@immutable
class PartBOption {
  const PartBOption({
    required this.optionKey,
    required this.ordinal,
    required this.textEn,
    required this.textZh,
  });

  final String optionKey;
  final int ordinal;
  final String textEn;
  final String? textZh;
}

@immutable
class PassageContent {
  const PassageContent({
    required this.passage,
    required this.paragraphs,
    required this.sentencesByParagraph,
    required this.gaps,
    required this.options,
  });

  final Passage passage;
  final List<Paragraph> paragraphs;
  final Map<String, List<Sentence>> sentencesByParagraph;
  final List<Gap> gaps;
  final List<PartBOption> options;

  List<Sentence> sentencesFor(String paragraphKey) =>
      sentencesByParagraph[paragraphKey] ?? const [];
}

@immutable
class Bookmark {
  const Bookmark({
    required this.passageKey,
    required this.paragraphKey,
    required this.createdAt,
  });

  final String passageKey;
  final String paragraphKey;
  final int createdAt;
}

@immutable
class ReadingProgress {
  const ReadingProgress({
    required this.passageKey,
    required this.lastParagraphKey,
    required this.lastSentenceKey,
    required this.isRead,
    required this.updatedAt,
  });

  final String passageKey;
  final String? lastParagraphKey;
  final String? lastSentenceKey;
  final bool isRead;
  final int updatedAt;

  ReadingProgress copyWith({
    String? lastParagraphKey,
    String? lastSentenceKey,
    bool? isRead,
    int? updatedAt,
  }) => ReadingProgress(
    passageKey: passageKey,
    lastParagraphKey: lastParagraphKey ?? this.lastParagraphKey,
    lastSentenceKey: lastSentenceKey ?? this.lastSentenceKey,
    isRead: isRead ?? this.isRead,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}

@immutable
class ReaderSettings {
  const ReaderSettings({
    required this.fontSize,
    required this.lineHeight,
    required this.theme,
    required this.showTranslations,
    required this.librarySort,
  });

  static const defaults = ReaderSettings(
    fontSize: 18,
    lineHeight: 1.7,
    theme: ReaderTheme.paper,
    showTranslations: false,
    librarySort: 'year_asc',
  );

  final double fontSize;
  final double lineHeight;
  final ReaderTheme theme;
  final bool showTranslations;
  final String librarySort;

  ReaderSettings copyWith({
    double? fontSize,
    double? lineHeight,
    ReaderTheme? theme,
    bool? showTranslations,
    String? librarySort,
  }) => ReaderSettings(
    fontSize: fontSize ?? this.fontSize,
    lineHeight: lineHeight ?? this.lineHeight,
    theme: theme ?? this.theme,
    showTranslations: showTranslations ?? this.showTranslations,
    librarySort: librarySort ?? this.librarySort,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReaderSettings &&
          other.fontSize == fontSize &&
          other.lineHeight == lineHeight &&
          other.theme == theme &&
          other.showTranslations == showTranslations &&
          other.librarySort == librarySort;

  @override
  int get hashCode => Object.hash(
        fontSize,
        lineHeight,
        theme,
        showTranslations,
        librarySort,
      );

  Map<String, String> toMap() => {
    'font_size': fontSize.toString(),
    'line_height': lineHeight.toString(),
    'theme': theme.wireName,
    'show_translations': showTranslations ? '1' : '0',
    'library_sort': librarySort,
  };

  factory ReaderSettings.fromMap(Map<String, String> map) => ReaderSettings(
    fontSize: double.tryParse(map['font_size'] ?? '') ?? defaults.fontSize,
    lineHeight:
        double.tryParse(map['line_height'] ?? '') ?? defaults.lineHeight,
    theme: ReaderThemeWire.fromWire(map['theme']),
    showTranslations: map['show_translations'] == '1',
    librarySort: map['library_sort'] ?? defaults.librarySort,
  );
}
