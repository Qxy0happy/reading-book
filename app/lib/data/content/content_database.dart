import 'package:drift/drift.dart';

part 'content_database.g.dart';

@DataClassName('ContentMetaRow')
class Meta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DataClassName('ContentPaperRow')
class Paper extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get year => integer()();
  TextColumn get code => text()();
  TextColumn get title => text().nullable()();
}

@DataClassName('ContentPassageRow')
class Passage extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  IntColumn get paperId => integer().references(Paper, #id)();
  TextColumn get part => text()();
  IntColumn get textNo => integer().nullable()();
  TextColumn get titleZh => text().nullable()();
  TextColumn get titleEn => text().nullable()();
  TextColumn get sourceNote => text().nullable()();
  IntColumn get wordCount => integer()();
  TextColumn get partBType => text().nullable()();
  IntColumn get displayOrder => integer()();
}

@DataClassName('ContentParagraphRow')
class Paragraph extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  IntColumn get passageId => integer().references(Passage, #id)();
  IntColumn get ordinal => integer()();
  TextColumn get label => text().nullable()();
  TextColumn get headingEn => text().nullable()();
  TextColumn get headingZh => text().nullable()();
  TextColumn get speaker => text().nullable()();
  TextColumn get textEn => text()();
  TextColumn get textZh => text().nullable()();
  TextColumn get translationSource => text().nullable()();
  TextColumn get translationStatus => text()();
}

@DataClassName('ContentSentenceRow')
class Sentence extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  IntColumn get paragraphId => integer().references(Paragraph, #id)();
  IntColumn get ordinal => integer()();
  TextColumn get textEn => text()();
  TextColumn get textZh => text().nullable()();
  TextColumn get translationSource => text().nullable()();
  TextColumn get translationStatus => text()();
  IntColumn get examNo => integer().nullable()();
  RealColumn get confidence => real().nullable()();
}

@DataClassName('ContentGapRow')
class Gap extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get passageId => integer().references(Passage, #id)();
  IntColumn get gapNo => integer()();
  IntColumn get afterParagraphOrdinal => integer()();
  IntColumn get afterSentenceOrdinal => integer().nullable()();
}

@DataClassName('ContentPartBOptionRow')
class PartBOption extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get passageId => integer().references(Passage, #id)();
  TextColumn get optionKey => text()();
  IntColumn get ordinal => integer()();
  TextColumn get textEn => text()();
  TextColumn get textZh => text().nullable()();
}

@DriftDatabase(
  tables: [Meta, Paper, Passage, Paragraph, Sentence, Gap, PartBOption],
)
class ContentDatabase extends _$ContentDatabase {
  ContentDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
