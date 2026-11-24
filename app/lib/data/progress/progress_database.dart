import 'package:drift/drift.dart';

part 'progress_database.g.dart';

@DataClassName('BookmarkRow')
class BookmarkTable extends Table {
  @override
  String get tableName => 'bookmark';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get passageKey => text()();
  TextColumn get paragraphKey => text()();
  IntColumn get createdAt => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {paragraphKey},
  ];
}

@DataClassName('ReadingProgressRow')
class ReadingProgressTable extends Table {
  @override
  String get tableName => 'reading_progress';

  TextColumn get passageKey => text()();
  TextColumn get lastParagraphKey => text().nullable()();
  TextColumn get lastSentenceKey => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {passageKey};
}

@DataClassName('SettingsRow')
class SettingsTable extends Table {
  @override
  String get tableName => 'settings';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [BookmarkTable, ReadingProgressTable, SettingsTable])
class ProgressDatabase extends _$ProgressDatabase {
  ProgressDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
