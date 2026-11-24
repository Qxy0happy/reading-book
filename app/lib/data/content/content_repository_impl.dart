import 'package:drift/drift.dart';

import '../../domain/models.dart';
import '../../domain/repositories.dart';
import 'content_database.dart' as content_db;

class DriftContentRepository implements ContentRepository {
  DriftContentRepository(this._db);

  final content_db.ContentDatabase _db;

  @override
  Future<List<Paper>> listPapers() async {
    final rows = await (_db.select(
      _db.paper,
    )..orderBy([(table) => OrderingTerm.asc(table.year)])).get();
    return rows
        .map((row) => Paper(year: row.year, code: row.code, title: row.title))
        .toList(growable: false);
  }

  @override
  Future<List<PassageSummary>> listPassages() async {
    final query =
        _db.select(_db.passage).join([
          innerJoin(_db.paper, _db.paper.id.equalsExp(_db.passage.paperId)),
        ])..orderBy([
          OrderingTerm.asc(_db.paper.year),
          OrderingTerm.asc(_db.passage.displayOrder),
        ]);
    final rows = await query.get();
    return rows
        .map((row) {
          final passage = row.readTable(_db.passage);
          final paper = row.readTable(_db.paper);
          return PassageSummary(
            key: passage.key,
            year: paper.year,
            part: passage.part,
            textNo: passage.textNo,
            titleZh: passage.titleZh,
            titleEn: passage.titleEn,
            wordCount: passage.wordCount,
            partBType: passage.partBType,
            displayOrder: passage.displayOrder,
          );
        })
        .toList(growable: false);
  }

  @override
  Future<PassageContent> loadPassage(String passageKey) async {
    final passageRow = await (_db.select(
      _db.passage,
    )..where((table) => table.key.equals(passageKey))).getSingleOrNull();
    if (passageRow == null) {
      throw StateError('passage not found: $passageKey');
    }
    final paperRow = await (_db.select(
      _db.paper,
    )..where((table) => table.id.equals(passageRow.paperId))).getSingle();

    final paragraphRows =
        await (_db.select(_db.paragraph)
              ..where((table) => table.passageId.equals(passageRow.id))
              ..orderBy([(table) => OrderingTerm.asc(table.ordinal)]))
            .get();

    final paragraphKeyById = {
      for (final paragraph in paragraphRows) paragraph.id: paragraph.key,
    };
    final sentenceRows = paragraphRows.isEmpty
        ? <content_db.ContentSentenceRow>[]
        : await (_db.select(_db.sentence)
                ..where(
                  (table) =>
                      table.paragraphId.isIn(paragraphRows.map((p) => p.id)),
                )
                ..orderBy([
                  (table) => OrderingTerm.asc(table.paragraphId),
                  (table) => OrderingTerm.asc(table.ordinal),
                ]))
              .get();

    final sentencesByParagraph = <String, List<Sentence>>{};
    for (final row in sentenceRows) {
      final paragraphKey = paragraphKeyById[row.paragraphId];
      if (paragraphKey == null) continue;
      sentencesByParagraph
          .putIfAbsent(paragraphKey, () => [])
          .add(
            Sentence(
              key: row.key,
              ordinal: row.ordinal,
              textEn: row.textEn,
              textZh: row.textZh,
              examNo: row.examNo,
            ),
          );
    }

    final gapRows = await (_db.select(
      _db.gap,
    )..where((table) => table.passageId.equals(passageRow.id))).get();
    final optionRows =
        await (_db.select(_db.partBOption)
              ..where((table) => table.passageId.equals(passageRow.id))
              ..orderBy([(table) => OrderingTerm.asc(table.ordinal)]))
            .get();

    return PassageContent(
      passage: Passage(
        key: passageRow.key,
        year: paperRow.year,
        part: passageRow.part,
        textNo: passageRow.textNo,
        titleZh: passageRow.titleZh,
        titleEn: passageRow.titleEn,
        sourceNote: passageRow.sourceNote,
        wordCount: passageRow.wordCount,
        partBType: passageRow.partBType,
        displayOrder: passageRow.displayOrder,
      ),
      paragraphs: paragraphRows
          .map(
            (row) => Paragraph(
              key: row.key,
              ordinal: row.ordinal,
              label: row.label,
              headingEn: row.headingEn,
              headingZh: row.headingZh,
              speaker: row.speaker,
              textEn: row.textEn,
              textZh: row.textZh,
              translationSource: row.translationSource,
              translationStatus: row.translationStatus,
            ),
          )
          .toList(growable: false),
      sentencesByParagraph: sentencesByParagraph,
      gaps: gapRows
          .map(
            (row) => Gap(
              gapNo: row.gapNo,
              afterParagraphOrdinal: row.afterParagraphOrdinal,
              afterSentenceOrdinal: row.afterSentenceOrdinal,
            ),
          )
          .toList(growable: false),
      options: optionRows
          .map(
            (row) => PartBOption(
              optionKey: row.optionKey,
              ordinal: row.ordinal,
              textEn: row.textEn,
              textZh: row.textZh,
            ),
          )
          .toList(growable: false),
    );
  }

  Future<void> close() => _db.close();

  @override
  Future<String> readContentVersion() async {
    final row = await (_db.select(
      _db.meta,
    )..where((table) => table.key.equals('content_version'))).getSingleOrNull();
    return row?.value ?? '';
  }
}
