// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_database.dart';

// ignore_for_file: type=lint
class $MetaTable extends Meta with TableInfo<$MetaTable, ContentMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  ContentMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $MetaTable createAlias(String alias) {
    return $MetaTable(attachedDatabase, alias);
  }
}

class ContentMetaRow extends DataClass implements Insertable<ContentMetaRow> {
  final String key;
  final String value;
  const ContentMetaRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  MetaCompanion toCompanion(bool nullToAbsent) {
    return MetaCompanion(key: Value(key), value: Value(value));
  }

  factory ContentMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  ContentMetaRow copyWith({String? key, String? value}) =>
      ContentMetaRow(key: key ?? this.key, value: value ?? this.value);
  ContentMetaRow copyWithCompanion(MetaCompanion data) {
    return ContentMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentMetaRow &&
          other.key == this.key &&
          other.value == this.value);
}

class MetaCompanion extends UpdateCompanion<ContentMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const MetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<ContentMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return MetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaperTable extends Paper with TableInfo<$PaperTable, ContentPaperRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaperTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, year, code, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paper';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentPaperRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentPaperRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentPaperRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
    );
  }

  @override
  $PaperTable createAlias(String alias) {
    return $PaperTable(attachedDatabase, alias);
  }
}

class ContentPaperRow extends DataClass implements Insertable<ContentPaperRow> {
  final int id;
  final int year;
  final String code;
  final String? title;
  const ContentPaperRow({
    required this.id,
    required this.year,
    required this.code,
    this.title,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year'] = Variable<int>(year);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    return map;
  }

  PaperCompanion toCompanion(bool nullToAbsent) {
    return PaperCompanion(
      id: Value(id),
      year: Value(year),
      code: Value(code),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
    );
  }

  factory ContentPaperRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentPaperRow(
      id: serializer.fromJson<int>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String?>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'year': serializer.toJson<int>(year),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String?>(title),
    };
  }

  ContentPaperRow copyWith({
    int? id,
    int? year,
    String? code,
    Value<String?> title = const Value.absent(),
  }) => ContentPaperRow(
    id: id ?? this.id,
    year: year ?? this.year,
    code: code ?? this.code,
    title: title.present ? title.value : this.title,
  );
  ContentPaperRow copyWithCompanion(PaperCompanion data) {
    return ContentPaperRow(
      id: data.id.present ? data.id.value : this.id,
      year: data.year.present ? data.year.value : this.year,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentPaperRow(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('code: $code, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, year, code, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentPaperRow &&
          other.id == this.id &&
          other.year == this.year &&
          other.code == this.code &&
          other.title == this.title);
}

class PaperCompanion extends UpdateCompanion<ContentPaperRow> {
  final Value<int> id;
  final Value<int> year;
  final Value<String> code;
  final Value<String?> title;
  const PaperCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
  });
  PaperCompanion.insert({
    this.id = const Value.absent(),
    required int year,
    required String code,
    this.title = const Value.absent(),
  }) : year = Value(year),
       code = Value(code);
  static Insertable<ContentPaperRow> custom({
    Expression<int>? id,
    Expression<int>? year,
    Expression<String>? code,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
    });
  }

  PaperCompanion copyWith({
    Value<int>? id,
    Value<int>? year,
    Value<String>? code,
    Value<String?>? title,
  }) {
    return PaperCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      code: code ?? this.code,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaperCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('code: $code, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $PassageTable extends Passage
    with TableInfo<$PassageTable, ContentPassageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PassageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _paperIdMeta = const VerificationMeta(
    'paperId',
  );
  @override
  late final GeneratedColumn<int> paperId = GeneratedColumn<int>(
    'paper_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES paper (id)',
    ),
  );
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<String> part = GeneratedColumn<String>(
    'part',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textNoMeta = const VerificationMeta('textNo');
  @override
  late final GeneratedColumn<int> textNo = GeneratedColumn<int>(
    'text_no',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleZhMeta = const VerificationMeta(
    'titleZh',
  );
  @override
  late final GeneratedColumn<String> titleZh = GeneratedColumn<String>(
    'title_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceNoteMeta = const VerificationMeta(
    'sourceNote',
  );
  @override
  late final GeneratedColumn<String> sourceNote = GeneratedColumn<String>(
    'source_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
    'word_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partBTypeMeta = const VerificationMeta(
    'partBType',
  );
  @override
  late final GeneratedColumn<String> partBType = GeneratedColumn<String>(
    'part_b_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    paperId,
    part,
    textNo,
    titleZh,
    titleEn,
    sourceNote,
    wordCount,
    partBType,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'passage';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentPassageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('paper_id')) {
      context.handle(
        _paperIdMeta,
        paperId.isAcceptableOrUnknown(data['paper_id']!, _paperIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paperIdMeta);
    }
    if (data.containsKey('part')) {
      context.handle(
        _partMeta,
        part.isAcceptableOrUnknown(data['part']!, _partMeta),
      );
    } else if (isInserting) {
      context.missing(_partMeta);
    }
    if (data.containsKey('text_no')) {
      context.handle(
        _textNoMeta,
        textNo.isAcceptableOrUnknown(data['text_no']!, _textNoMeta),
      );
    }
    if (data.containsKey('title_zh')) {
      context.handle(
        _titleZhMeta,
        titleZh.isAcceptableOrUnknown(data['title_zh']!, _titleZhMeta),
      );
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    }
    if (data.containsKey('source_note')) {
      context.handle(
        _sourceNoteMeta,
        sourceNote.isAcceptableOrUnknown(data['source_note']!, _sourceNoteMeta),
      );
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    } else if (isInserting) {
      context.missing(_wordCountMeta);
    }
    if (data.containsKey('part_b_type')) {
      context.handle(
        _partBTypeMeta,
        partBType.isAcceptableOrUnknown(data['part_b_type']!, _partBTypeMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentPassageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentPassageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      paperId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paper_id'],
      )!,
      part: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part'],
      )!,
      textNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}text_no'],
      ),
      titleZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_zh'],
      ),
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      ),
      sourceNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_note'],
      ),
      wordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_count'],
      )!,
      partBType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_b_type'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $PassageTable createAlias(String alias) {
    return $PassageTable(attachedDatabase, alias);
  }
}

class ContentPassageRow extends DataClass
    implements Insertable<ContentPassageRow> {
  final int id;
  final String key;
  final int paperId;
  final String part;
  final int? textNo;
  final String? titleZh;
  final String? titleEn;
  final String? sourceNote;
  final int wordCount;
  final String? partBType;
  final int displayOrder;
  const ContentPassageRow({
    required this.id,
    required this.key,
    required this.paperId,
    required this.part,
    this.textNo,
    this.titleZh,
    this.titleEn,
    this.sourceNote,
    required this.wordCount,
    this.partBType,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['paper_id'] = Variable<int>(paperId);
    map['part'] = Variable<String>(part);
    if (!nullToAbsent || textNo != null) {
      map['text_no'] = Variable<int>(textNo);
    }
    if (!nullToAbsent || titleZh != null) {
      map['title_zh'] = Variable<String>(titleZh);
    }
    if (!nullToAbsent || titleEn != null) {
      map['title_en'] = Variable<String>(titleEn);
    }
    if (!nullToAbsent || sourceNote != null) {
      map['source_note'] = Variable<String>(sourceNote);
    }
    map['word_count'] = Variable<int>(wordCount);
    if (!nullToAbsent || partBType != null) {
      map['part_b_type'] = Variable<String>(partBType);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  PassageCompanion toCompanion(bool nullToAbsent) {
    return PassageCompanion(
      id: Value(id),
      key: Value(key),
      paperId: Value(paperId),
      part: Value(part),
      textNo: textNo == null && nullToAbsent
          ? const Value.absent()
          : Value(textNo),
      titleZh: titleZh == null && nullToAbsent
          ? const Value.absent()
          : Value(titleZh),
      titleEn: titleEn == null && nullToAbsent
          ? const Value.absent()
          : Value(titleEn),
      sourceNote: sourceNote == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceNote),
      wordCount: Value(wordCount),
      partBType: partBType == null && nullToAbsent
          ? const Value.absent()
          : Value(partBType),
      displayOrder: Value(displayOrder),
    );
  }

  factory ContentPassageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentPassageRow(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      paperId: serializer.fromJson<int>(json['paperId']),
      part: serializer.fromJson<String>(json['part']),
      textNo: serializer.fromJson<int?>(json['textNo']),
      titleZh: serializer.fromJson<String?>(json['titleZh']),
      titleEn: serializer.fromJson<String?>(json['titleEn']),
      sourceNote: serializer.fromJson<String?>(json['sourceNote']),
      wordCount: serializer.fromJson<int>(json['wordCount']),
      partBType: serializer.fromJson<String?>(json['partBType']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'paperId': serializer.toJson<int>(paperId),
      'part': serializer.toJson<String>(part),
      'textNo': serializer.toJson<int?>(textNo),
      'titleZh': serializer.toJson<String?>(titleZh),
      'titleEn': serializer.toJson<String?>(titleEn),
      'sourceNote': serializer.toJson<String?>(sourceNote),
      'wordCount': serializer.toJson<int>(wordCount),
      'partBType': serializer.toJson<String?>(partBType),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  ContentPassageRow copyWith({
    int? id,
    String? key,
    int? paperId,
    String? part,
    Value<int?> textNo = const Value.absent(),
    Value<String?> titleZh = const Value.absent(),
    Value<String?> titleEn = const Value.absent(),
    Value<String?> sourceNote = const Value.absent(),
    int? wordCount,
    Value<String?> partBType = const Value.absent(),
    int? displayOrder,
  }) => ContentPassageRow(
    id: id ?? this.id,
    key: key ?? this.key,
    paperId: paperId ?? this.paperId,
    part: part ?? this.part,
    textNo: textNo.present ? textNo.value : this.textNo,
    titleZh: titleZh.present ? titleZh.value : this.titleZh,
    titleEn: titleEn.present ? titleEn.value : this.titleEn,
    sourceNote: sourceNote.present ? sourceNote.value : this.sourceNote,
    wordCount: wordCount ?? this.wordCount,
    partBType: partBType.present ? partBType.value : this.partBType,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  ContentPassageRow copyWithCompanion(PassageCompanion data) {
    return ContentPassageRow(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      paperId: data.paperId.present ? data.paperId.value : this.paperId,
      part: data.part.present ? data.part.value : this.part,
      textNo: data.textNo.present ? data.textNo.value : this.textNo,
      titleZh: data.titleZh.present ? data.titleZh.value : this.titleZh,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      sourceNote: data.sourceNote.present
          ? data.sourceNote.value
          : this.sourceNote,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      partBType: data.partBType.present ? data.partBType.value : this.partBType,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentPassageRow(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('paperId: $paperId, ')
          ..write('part: $part, ')
          ..write('textNo: $textNo, ')
          ..write('titleZh: $titleZh, ')
          ..write('titleEn: $titleEn, ')
          ..write('sourceNote: $sourceNote, ')
          ..write('wordCount: $wordCount, ')
          ..write('partBType: $partBType, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    paperId,
    part,
    textNo,
    titleZh,
    titleEn,
    sourceNote,
    wordCount,
    partBType,
    displayOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentPassageRow &&
          other.id == this.id &&
          other.key == this.key &&
          other.paperId == this.paperId &&
          other.part == this.part &&
          other.textNo == this.textNo &&
          other.titleZh == this.titleZh &&
          other.titleEn == this.titleEn &&
          other.sourceNote == this.sourceNote &&
          other.wordCount == this.wordCount &&
          other.partBType == this.partBType &&
          other.displayOrder == this.displayOrder);
}

class PassageCompanion extends UpdateCompanion<ContentPassageRow> {
  final Value<int> id;
  final Value<String> key;
  final Value<int> paperId;
  final Value<String> part;
  final Value<int?> textNo;
  final Value<String?> titleZh;
  final Value<String?> titleEn;
  final Value<String?> sourceNote;
  final Value<int> wordCount;
  final Value<String?> partBType;
  final Value<int> displayOrder;
  const PassageCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.paperId = const Value.absent(),
    this.part = const Value.absent(),
    this.textNo = const Value.absent(),
    this.titleZh = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.sourceNote = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.partBType = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  PassageCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required int paperId,
    required String part,
    this.textNo = const Value.absent(),
    this.titleZh = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.sourceNote = const Value.absent(),
    required int wordCount,
    this.partBType = const Value.absent(),
    required int displayOrder,
  }) : key = Value(key),
       paperId = Value(paperId),
       part = Value(part),
       wordCount = Value(wordCount),
       displayOrder = Value(displayOrder);
  static Insertable<ContentPassageRow> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<int>? paperId,
    Expression<String>? part,
    Expression<int>? textNo,
    Expression<String>? titleZh,
    Expression<String>? titleEn,
    Expression<String>? sourceNote,
    Expression<int>? wordCount,
    Expression<String>? partBType,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (paperId != null) 'paper_id': paperId,
      if (part != null) 'part': part,
      if (textNo != null) 'text_no': textNo,
      if (titleZh != null) 'title_zh': titleZh,
      if (titleEn != null) 'title_en': titleEn,
      if (sourceNote != null) 'source_note': sourceNote,
      if (wordCount != null) 'word_count': wordCount,
      if (partBType != null) 'part_b_type': partBType,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  PassageCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<int>? paperId,
    Value<String>? part,
    Value<int?>? textNo,
    Value<String?>? titleZh,
    Value<String?>? titleEn,
    Value<String?>? sourceNote,
    Value<int>? wordCount,
    Value<String?>? partBType,
    Value<int>? displayOrder,
  }) {
    return PassageCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      paperId: paperId ?? this.paperId,
      part: part ?? this.part,
      textNo: textNo ?? this.textNo,
      titleZh: titleZh ?? this.titleZh,
      titleEn: titleEn ?? this.titleEn,
      sourceNote: sourceNote ?? this.sourceNote,
      wordCount: wordCount ?? this.wordCount,
      partBType: partBType ?? this.partBType,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (paperId.present) {
      map['paper_id'] = Variable<int>(paperId.value);
    }
    if (part.present) {
      map['part'] = Variable<String>(part.value);
    }
    if (textNo.present) {
      map['text_no'] = Variable<int>(textNo.value);
    }
    if (titleZh.present) {
      map['title_zh'] = Variable<String>(titleZh.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (sourceNote.present) {
      map['source_note'] = Variable<String>(sourceNote.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    if (partBType.present) {
      map['part_b_type'] = Variable<String>(partBType.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PassageCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('paperId: $paperId, ')
          ..write('part: $part, ')
          ..write('textNo: $textNo, ')
          ..write('titleZh: $titleZh, ')
          ..write('titleEn: $titleEn, ')
          ..write('sourceNote: $sourceNote, ')
          ..write('wordCount: $wordCount, ')
          ..write('partBType: $partBType, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $ParagraphTable extends Paragraph
    with TableInfo<$ParagraphTable, ContentParagraphRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParagraphTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passageIdMeta = const VerificationMeta(
    'passageId',
  );
  @override
  late final GeneratedColumn<int> passageId = GeneratedColumn<int>(
    'passage_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES passage (id)',
    ),
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headingEnMeta = const VerificationMeta(
    'headingEn',
  );
  @override
  late final GeneratedColumn<String> headingEn = GeneratedColumn<String>(
    'heading_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headingZhMeta = const VerificationMeta(
    'headingZh',
  );
  @override
  late final GeneratedColumn<String> headingZh = GeneratedColumn<String>(
    'heading_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speakerMeta = const VerificationMeta(
    'speaker',
  );
  @override
  late final GeneratedColumn<String> speaker = GeneratedColumn<String>(
    'speaker',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _textEnMeta = const VerificationMeta('textEn');
  @override
  late final GeneratedColumn<String> textEn = GeneratedColumn<String>(
    'text_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textZhMeta = const VerificationMeta('textZh');
  @override
  late final GeneratedColumn<String> textZh = GeneratedColumn<String>(
    'text_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _translationSourceMeta = const VerificationMeta(
    'translationSource',
  );
  @override
  late final GeneratedColumn<String> translationSource =
      GeneratedColumn<String>(
        'translation_source',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _translationStatusMeta = const VerificationMeta(
    'translationStatus',
  );
  @override
  late final GeneratedColumn<String> translationStatus =
      GeneratedColumn<String>(
        'translation_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    passageId,
    ordinal,
    label,
    headingEn,
    headingZh,
    speaker,
    textEn,
    textZh,
    translationSource,
    translationStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paragraph';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentParagraphRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('passage_id')) {
      context.handle(
        _passageIdMeta,
        passageId.isAcceptableOrUnknown(data['passage_id']!, _passageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_passageIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('heading_en')) {
      context.handle(
        _headingEnMeta,
        headingEn.isAcceptableOrUnknown(data['heading_en']!, _headingEnMeta),
      );
    }
    if (data.containsKey('heading_zh')) {
      context.handle(
        _headingZhMeta,
        headingZh.isAcceptableOrUnknown(data['heading_zh']!, _headingZhMeta),
      );
    }
    if (data.containsKey('speaker')) {
      context.handle(
        _speakerMeta,
        speaker.isAcceptableOrUnknown(data['speaker']!, _speakerMeta),
      );
    }
    if (data.containsKey('text_en')) {
      context.handle(
        _textEnMeta,
        textEn.isAcceptableOrUnknown(data['text_en']!, _textEnMeta),
      );
    } else if (isInserting) {
      context.missing(_textEnMeta);
    }
    if (data.containsKey('text_zh')) {
      context.handle(
        _textZhMeta,
        textZh.isAcceptableOrUnknown(data['text_zh']!, _textZhMeta),
      );
    }
    if (data.containsKey('translation_source')) {
      context.handle(
        _translationSourceMeta,
        translationSource.isAcceptableOrUnknown(
          data['translation_source']!,
          _translationSourceMeta,
        ),
      );
    }
    if (data.containsKey('translation_status')) {
      context.handle(
        _translationStatusMeta,
        translationStatus.isAcceptableOrUnknown(
          data['translation_status']!,
          _translationStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentParagraphRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentParagraphRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      passageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}passage_id'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      headingEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}heading_en'],
      ),
      headingZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}heading_zh'],
      ),
      speaker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}speaker'],
      ),
      textEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_en'],
      )!,
      textZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_zh'],
      ),
      translationSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_source'],
      ),
      translationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_status'],
      )!,
    );
  }

  @override
  $ParagraphTable createAlias(String alias) {
    return $ParagraphTable(attachedDatabase, alias);
  }
}

class ContentParagraphRow extends DataClass
    implements Insertable<ContentParagraphRow> {
  final int id;
  final String key;
  final int passageId;
  final int ordinal;
  final String? label;
  final String? headingEn;
  final String? headingZh;
  final String? speaker;
  final String textEn;
  final String? textZh;
  final String? translationSource;
  final String translationStatus;
  const ContentParagraphRow({
    required this.id,
    required this.key,
    required this.passageId,
    required this.ordinal,
    this.label,
    this.headingEn,
    this.headingZh,
    this.speaker,
    required this.textEn,
    this.textZh,
    this.translationSource,
    required this.translationStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['passage_id'] = Variable<int>(passageId);
    map['ordinal'] = Variable<int>(ordinal);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || headingEn != null) {
      map['heading_en'] = Variable<String>(headingEn);
    }
    if (!nullToAbsent || headingZh != null) {
      map['heading_zh'] = Variable<String>(headingZh);
    }
    if (!nullToAbsent || speaker != null) {
      map['speaker'] = Variable<String>(speaker);
    }
    map['text_en'] = Variable<String>(textEn);
    if (!nullToAbsent || textZh != null) {
      map['text_zh'] = Variable<String>(textZh);
    }
    if (!nullToAbsent || translationSource != null) {
      map['translation_source'] = Variable<String>(translationSource);
    }
    map['translation_status'] = Variable<String>(translationStatus);
    return map;
  }

  ParagraphCompanion toCompanion(bool nullToAbsent) {
    return ParagraphCompanion(
      id: Value(id),
      key: Value(key),
      passageId: Value(passageId),
      ordinal: Value(ordinal),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      headingEn: headingEn == null && nullToAbsent
          ? const Value.absent()
          : Value(headingEn),
      headingZh: headingZh == null && nullToAbsent
          ? const Value.absent()
          : Value(headingZh),
      speaker: speaker == null && nullToAbsent
          ? const Value.absent()
          : Value(speaker),
      textEn: Value(textEn),
      textZh: textZh == null && nullToAbsent
          ? const Value.absent()
          : Value(textZh),
      translationSource: translationSource == null && nullToAbsent
          ? const Value.absent()
          : Value(translationSource),
      translationStatus: Value(translationStatus),
    );
  }

  factory ContentParagraphRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentParagraphRow(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      passageId: serializer.fromJson<int>(json['passageId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      label: serializer.fromJson<String?>(json['label']),
      headingEn: serializer.fromJson<String?>(json['headingEn']),
      headingZh: serializer.fromJson<String?>(json['headingZh']),
      speaker: serializer.fromJson<String?>(json['speaker']),
      textEn: serializer.fromJson<String>(json['textEn']),
      textZh: serializer.fromJson<String?>(json['textZh']),
      translationSource: serializer.fromJson<String?>(
        json['translationSource'],
      ),
      translationStatus: serializer.fromJson<String>(json['translationStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'passageId': serializer.toJson<int>(passageId),
      'ordinal': serializer.toJson<int>(ordinal),
      'label': serializer.toJson<String?>(label),
      'headingEn': serializer.toJson<String?>(headingEn),
      'headingZh': serializer.toJson<String?>(headingZh),
      'speaker': serializer.toJson<String?>(speaker),
      'textEn': serializer.toJson<String>(textEn),
      'textZh': serializer.toJson<String?>(textZh),
      'translationSource': serializer.toJson<String?>(translationSource),
      'translationStatus': serializer.toJson<String>(translationStatus),
    };
  }

  ContentParagraphRow copyWith({
    int? id,
    String? key,
    int? passageId,
    int? ordinal,
    Value<String?> label = const Value.absent(),
    Value<String?> headingEn = const Value.absent(),
    Value<String?> headingZh = const Value.absent(),
    Value<String?> speaker = const Value.absent(),
    String? textEn,
    Value<String?> textZh = const Value.absent(),
    Value<String?> translationSource = const Value.absent(),
    String? translationStatus,
  }) => ContentParagraphRow(
    id: id ?? this.id,
    key: key ?? this.key,
    passageId: passageId ?? this.passageId,
    ordinal: ordinal ?? this.ordinal,
    label: label.present ? label.value : this.label,
    headingEn: headingEn.present ? headingEn.value : this.headingEn,
    headingZh: headingZh.present ? headingZh.value : this.headingZh,
    speaker: speaker.present ? speaker.value : this.speaker,
    textEn: textEn ?? this.textEn,
    textZh: textZh.present ? textZh.value : this.textZh,
    translationSource: translationSource.present
        ? translationSource.value
        : this.translationSource,
    translationStatus: translationStatus ?? this.translationStatus,
  );
  ContentParagraphRow copyWithCompanion(ParagraphCompanion data) {
    return ContentParagraphRow(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      passageId: data.passageId.present ? data.passageId.value : this.passageId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      label: data.label.present ? data.label.value : this.label,
      headingEn: data.headingEn.present ? data.headingEn.value : this.headingEn,
      headingZh: data.headingZh.present ? data.headingZh.value : this.headingZh,
      speaker: data.speaker.present ? data.speaker.value : this.speaker,
      textEn: data.textEn.present ? data.textEn.value : this.textEn,
      textZh: data.textZh.present ? data.textZh.value : this.textZh,
      translationSource: data.translationSource.present
          ? data.translationSource.value
          : this.translationSource,
      translationStatus: data.translationStatus.present
          ? data.translationStatus.value
          : this.translationStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentParagraphRow(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('passageId: $passageId, ')
          ..write('ordinal: $ordinal, ')
          ..write('label: $label, ')
          ..write('headingEn: $headingEn, ')
          ..write('headingZh: $headingZh, ')
          ..write('speaker: $speaker, ')
          ..write('textEn: $textEn, ')
          ..write('textZh: $textZh, ')
          ..write('translationSource: $translationSource, ')
          ..write('translationStatus: $translationStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    passageId,
    ordinal,
    label,
    headingEn,
    headingZh,
    speaker,
    textEn,
    textZh,
    translationSource,
    translationStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentParagraphRow &&
          other.id == this.id &&
          other.key == this.key &&
          other.passageId == this.passageId &&
          other.ordinal == this.ordinal &&
          other.label == this.label &&
          other.headingEn == this.headingEn &&
          other.headingZh == this.headingZh &&
          other.speaker == this.speaker &&
          other.textEn == this.textEn &&
          other.textZh == this.textZh &&
          other.translationSource == this.translationSource &&
          other.translationStatus == this.translationStatus);
}

class ParagraphCompanion extends UpdateCompanion<ContentParagraphRow> {
  final Value<int> id;
  final Value<String> key;
  final Value<int> passageId;
  final Value<int> ordinal;
  final Value<String?> label;
  final Value<String?> headingEn;
  final Value<String?> headingZh;
  final Value<String?> speaker;
  final Value<String> textEn;
  final Value<String?> textZh;
  final Value<String?> translationSource;
  final Value<String> translationStatus;
  const ParagraphCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.passageId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.label = const Value.absent(),
    this.headingEn = const Value.absent(),
    this.headingZh = const Value.absent(),
    this.speaker = const Value.absent(),
    this.textEn = const Value.absent(),
    this.textZh = const Value.absent(),
    this.translationSource = const Value.absent(),
    this.translationStatus = const Value.absent(),
  });
  ParagraphCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required int passageId,
    required int ordinal,
    this.label = const Value.absent(),
    this.headingEn = const Value.absent(),
    this.headingZh = const Value.absent(),
    this.speaker = const Value.absent(),
    required String textEn,
    this.textZh = const Value.absent(),
    this.translationSource = const Value.absent(),
    required String translationStatus,
  }) : key = Value(key),
       passageId = Value(passageId),
       ordinal = Value(ordinal),
       textEn = Value(textEn),
       translationStatus = Value(translationStatus);
  static Insertable<ContentParagraphRow> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<int>? passageId,
    Expression<int>? ordinal,
    Expression<String>? label,
    Expression<String>? headingEn,
    Expression<String>? headingZh,
    Expression<String>? speaker,
    Expression<String>? textEn,
    Expression<String>? textZh,
    Expression<String>? translationSource,
    Expression<String>? translationStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (passageId != null) 'passage_id': passageId,
      if (ordinal != null) 'ordinal': ordinal,
      if (label != null) 'label': label,
      if (headingEn != null) 'heading_en': headingEn,
      if (headingZh != null) 'heading_zh': headingZh,
      if (speaker != null) 'speaker': speaker,
      if (textEn != null) 'text_en': textEn,
      if (textZh != null) 'text_zh': textZh,
      if (translationSource != null) 'translation_source': translationSource,
      if (translationStatus != null) 'translation_status': translationStatus,
    });
  }

  ParagraphCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<int>? passageId,
    Value<int>? ordinal,
    Value<String?>? label,
    Value<String?>? headingEn,
    Value<String?>? headingZh,
    Value<String?>? speaker,
    Value<String>? textEn,
    Value<String?>? textZh,
    Value<String?>? translationSource,
    Value<String>? translationStatus,
  }) {
    return ParagraphCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      passageId: passageId ?? this.passageId,
      ordinal: ordinal ?? this.ordinal,
      label: label ?? this.label,
      headingEn: headingEn ?? this.headingEn,
      headingZh: headingZh ?? this.headingZh,
      speaker: speaker ?? this.speaker,
      textEn: textEn ?? this.textEn,
      textZh: textZh ?? this.textZh,
      translationSource: translationSource ?? this.translationSource,
      translationStatus: translationStatus ?? this.translationStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (passageId.present) {
      map['passage_id'] = Variable<int>(passageId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (headingEn.present) {
      map['heading_en'] = Variable<String>(headingEn.value);
    }
    if (headingZh.present) {
      map['heading_zh'] = Variable<String>(headingZh.value);
    }
    if (speaker.present) {
      map['speaker'] = Variable<String>(speaker.value);
    }
    if (textEn.present) {
      map['text_en'] = Variable<String>(textEn.value);
    }
    if (textZh.present) {
      map['text_zh'] = Variable<String>(textZh.value);
    }
    if (translationSource.present) {
      map['translation_source'] = Variable<String>(translationSource.value);
    }
    if (translationStatus.present) {
      map['translation_status'] = Variable<String>(translationStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParagraphCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('passageId: $passageId, ')
          ..write('ordinal: $ordinal, ')
          ..write('label: $label, ')
          ..write('headingEn: $headingEn, ')
          ..write('headingZh: $headingZh, ')
          ..write('speaker: $speaker, ')
          ..write('textEn: $textEn, ')
          ..write('textZh: $textZh, ')
          ..write('translationSource: $translationSource, ')
          ..write('translationStatus: $translationStatus')
          ..write(')'))
        .toString();
  }
}

class $SentenceTable extends Sentence
    with TableInfo<$SentenceTable, ContentSentenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SentenceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _paragraphIdMeta = const VerificationMeta(
    'paragraphId',
  );
  @override
  late final GeneratedColumn<int> paragraphId = GeneratedColumn<int>(
    'paragraph_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES paragraph (id)',
    ),
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textEnMeta = const VerificationMeta('textEn');
  @override
  late final GeneratedColumn<String> textEn = GeneratedColumn<String>(
    'text_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textZhMeta = const VerificationMeta('textZh');
  @override
  late final GeneratedColumn<String> textZh = GeneratedColumn<String>(
    'text_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _translationSourceMeta = const VerificationMeta(
    'translationSource',
  );
  @override
  late final GeneratedColumn<String> translationSource =
      GeneratedColumn<String>(
        'translation_source',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _translationStatusMeta = const VerificationMeta(
    'translationStatus',
  );
  @override
  late final GeneratedColumn<String> translationStatus =
      GeneratedColumn<String>(
        'translation_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _examNoMeta = const VerificationMeta('examNo');
  @override
  late final GeneratedColumn<int> examNo = GeneratedColumn<int>(
    'exam_no',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    paragraphId,
    ordinal,
    textEn,
    textZh,
    translationSource,
    translationStatus,
    examNo,
    confidence,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sentence';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentSentenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('paragraph_id')) {
      context.handle(
        _paragraphIdMeta,
        paragraphId.isAcceptableOrUnknown(
          data['paragraph_id']!,
          _paragraphIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paragraphIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('text_en')) {
      context.handle(
        _textEnMeta,
        textEn.isAcceptableOrUnknown(data['text_en']!, _textEnMeta),
      );
    } else if (isInserting) {
      context.missing(_textEnMeta);
    }
    if (data.containsKey('text_zh')) {
      context.handle(
        _textZhMeta,
        textZh.isAcceptableOrUnknown(data['text_zh']!, _textZhMeta),
      );
    }
    if (data.containsKey('translation_source')) {
      context.handle(
        _translationSourceMeta,
        translationSource.isAcceptableOrUnknown(
          data['translation_source']!,
          _translationSourceMeta,
        ),
      );
    }
    if (data.containsKey('translation_status')) {
      context.handle(
        _translationStatusMeta,
        translationStatus.isAcceptableOrUnknown(
          data['translation_status']!,
          _translationStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationStatusMeta);
    }
    if (data.containsKey('exam_no')) {
      context.handle(
        _examNoMeta,
        examNo.isAcceptableOrUnknown(data['exam_no']!, _examNoMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentSentenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentSentenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      paragraphId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paragraph_id'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      textEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_en'],
      )!,
      textZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_zh'],
      ),
      translationSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_source'],
      ),
      translationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_status'],
      )!,
      examNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exam_no'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
    );
  }

  @override
  $SentenceTable createAlias(String alias) {
    return $SentenceTable(attachedDatabase, alias);
  }
}

class ContentSentenceRow extends DataClass
    implements Insertable<ContentSentenceRow> {
  final int id;
  final String key;
  final int paragraphId;
  final int ordinal;
  final String textEn;
  final String? textZh;
  final String? translationSource;
  final String translationStatus;
  final int? examNo;
  final double? confidence;
  const ContentSentenceRow({
    required this.id,
    required this.key,
    required this.paragraphId,
    required this.ordinal,
    required this.textEn,
    this.textZh,
    this.translationSource,
    required this.translationStatus,
    this.examNo,
    this.confidence,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['paragraph_id'] = Variable<int>(paragraphId);
    map['ordinal'] = Variable<int>(ordinal);
    map['text_en'] = Variable<String>(textEn);
    if (!nullToAbsent || textZh != null) {
      map['text_zh'] = Variable<String>(textZh);
    }
    if (!nullToAbsent || translationSource != null) {
      map['translation_source'] = Variable<String>(translationSource);
    }
    map['translation_status'] = Variable<String>(translationStatus);
    if (!nullToAbsent || examNo != null) {
      map['exam_no'] = Variable<int>(examNo);
    }
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    return map;
  }

  SentenceCompanion toCompanion(bool nullToAbsent) {
    return SentenceCompanion(
      id: Value(id),
      key: Value(key),
      paragraphId: Value(paragraphId),
      ordinal: Value(ordinal),
      textEn: Value(textEn),
      textZh: textZh == null && nullToAbsent
          ? const Value.absent()
          : Value(textZh),
      translationSource: translationSource == null && nullToAbsent
          ? const Value.absent()
          : Value(translationSource),
      translationStatus: Value(translationStatus),
      examNo: examNo == null && nullToAbsent
          ? const Value.absent()
          : Value(examNo),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
    );
  }

  factory ContentSentenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentSentenceRow(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      paragraphId: serializer.fromJson<int>(json['paragraphId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      textEn: serializer.fromJson<String>(json['textEn']),
      textZh: serializer.fromJson<String?>(json['textZh']),
      translationSource: serializer.fromJson<String?>(
        json['translationSource'],
      ),
      translationStatus: serializer.fromJson<String>(json['translationStatus']),
      examNo: serializer.fromJson<int?>(json['examNo']),
      confidence: serializer.fromJson<double?>(json['confidence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'paragraphId': serializer.toJson<int>(paragraphId),
      'ordinal': serializer.toJson<int>(ordinal),
      'textEn': serializer.toJson<String>(textEn),
      'textZh': serializer.toJson<String?>(textZh),
      'translationSource': serializer.toJson<String?>(translationSource),
      'translationStatus': serializer.toJson<String>(translationStatus),
      'examNo': serializer.toJson<int?>(examNo),
      'confidence': serializer.toJson<double?>(confidence),
    };
  }

  ContentSentenceRow copyWith({
    int? id,
    String? key,
    int? paragraphId,
    int? ordinal,
    String? textEn,
    Value<String?> textZh = const Value.absent(),
    Value<String?> translationSource = const Value.absent(),
    String? translationStatus,
    Value<int?> examNo = const Value.absent(),
    Value<double?> confidence = const Value.absent(),
  }) => ContentSentenceRow(
    id: id ?? this.id,
    key: key ?? this.key,
    paragraphId: paragraphId ?? this.paragraphId,
    ordinal: ordinal ?? this.ordinal,
    textEn: textEn ?? this.textEn,
    textZh: textZh.present ? textZh.value : this.textZh,
    translationSource: translationSource.present
        ? translationSource.value
        : this.translationSource,
    translationStatus: translationStatus ?? this.translationStatus,
    examNo: examNo.present ? examNo.value : this.examNo,
    confidence: confidence.present ? confidence.value : this.confidence,
  );
  ContentSentenceRow copyWithCompanion(SentenceCompanion data) {
    return ContentSentenceRow(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      paragraphId: data.paragraphId.present
          ? data.paragraphId.value
          : this.paragraphId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      textEn: data.textEn.present ? data.textEn.value : this.textEn,
      textZh: data.textZh.present ? data.textZh.value : this.textZh,
      translationSource: data.translationSource.present
          ? data.translationSource.value
          : this.translationSource,
      translationStatus: data.translationStatus.present
          ? data.translationStatus.value
          : this.translationStatus,
      examNo: data.examNo.present ? data.examNo.value : this.examNo,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentSentenceRow(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('paragraphId: $paragraphId, ')
          ..write('ordinal: $ordinal, ')
          ..write('textEn: $textEn, ')
          ..write('textZh: $textZh, ')
          ..write('translationSource: $translationSource, ')
          ..write('translationStatus: $translationStatus, ')
          ..write('examNo: $examNo, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    paragraphId,
    ordinal,
    textEn,
    textZh,
    translationSource,
    translationStatus,
    examNo,
    confidence,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentSentenceRow &&
          other.id == this.id &&
          other.key == this.key &&
          other.paragraphId == this.paragraphId &&
          other.ordinal == this.ordinal &&
          other.textEn == this.textEn &&
          other.textZh == this.textZh &&
          other.translationSource == this.translationSource &&
          other.translationStatus == this.translationStatus &&
          other.examNo == this.examNo &&
          other.confidence == this.confidence);
}

class SentenceCompanion extends UpdateCompanion<ContentSentenceRow> {
  final Value<int> id;
  final Value<String> key;
  final Value<int> paragraphId;
  final Value<int> ordinal;
  final Value<String> textEn;
  final Value<String?> textZh;
  final Value<String?> translationSource;
  final Value<String> translationStatus;
  final Value<int?> examNo;
  final Value<double?> confidence;
  const SentenceCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.paragraphId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.textEn = const Value.absent(),
    this.textZh = const Value.absent(),
    this.translationSource = const Value.absent(),
    this.translationStatus = const Value.absent(),
    this.examNo = const Value.absent(),
    this.confidence = const Value.absent(),
  });
  SentenceCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required int paragraphId,
    required int ordinal,
    required String textEn,
    this.textZh = const Value.absent(),
    this.translationSource = const Value.absent(),
    required String translationStatus,
    this.examNo = const Value.absent(),
    this.confidence = const Value.absent(),
  }) : key = Value(key),
       paragraphId = Value(paragraphId),
       ordinal = Value(ordinal),
       textEn = Value(textEn),
       translationStatus = Value(translationStatus);
  static Insertable<ContentSentenceRow> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<int>? paragraphId,
    Expression<int>? ordinal,
    Expression<String>? textEn,
    Expression<String>? textZh,
    Expression<String>? translationSource,
    Expression<String>? translationStatus,
    Expression<int>? examNo,
    Expression<double>? confidence,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (paragraphId != null) 'paragraph_id': paragraphId,
      if (ordinal != null) 'ordinal': ordinal,
      if (textEn != null) 'text_en': textEn,
      if (textZh != null) 'text_zh': textZh,
      if (translationSource != null) 'translation_source': translationSource,
      if (translationStatus != null) 'translation_status': translationStatus,
      if (examNo != null) 'exam_no': examNo,
      if (confidence != null) 'confidence': confidence,
    });
  }

  SentenceCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<int>? paragraphId,
    Value<int>? ordinal,
    Value<String>? textEn,
    Value<String?>? textZh,
    Value<String?>? translationSource,
    Value<String>? translationStatus,
    Value<int?>? examNo,
    Value<double?>? confidence,
  }) {
    return SentenceCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      paragraphId: paragraphId ?? this.paragraphId,
      ordinal: ordinal ?? this.ordinal,
      textEn: textEn ?? this.textEn,
      textZh: textZh ?? this.textZh,
      translationSource: translationSource ?? this.translationSource,
      translationStatus: translationStatus ?? this.translationStatus,
      examNo: examNo ?? this.examNo,
      confidence: confidence ?? this.confidence,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (paragraphId.present) {
      map['paragraph_id'] = Variable<int>(paragraphId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (textEn.present) {
      map['text_en'] = Variable<String>(textEn.value);
    }
    if (textZh.present) {
      map['text_zh'] = Variable<String>(textZh.value);
    }
    if (translationSource.present) {
      map['translation_source'] = Variable<String>(translationSource.value);
    }
    if (translationStatus.present) {
      map['translation_status'] = Variable<String>(translationStatus.value);
    }
    if (examNo.present) {
      map['exam_no'] = Variable<int>(examNo.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SentenceCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('paragraphId: $paragraphId, ')
          ..write('ordinal: $ordinal, ')
          ..write('textEn: $textEn, ')
          ..write('textZh: $textZh, ')
          ..write('translationSource: $translationSource, ')
          ..write('translationStatus: $translationStatus, ')
          ..write('examNo: $examNo, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }
}

class $GapTable extends Gap with TableInfo<$GapTable, ContentGapRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GapTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _passageIdMeta = const VerificationMeta(
    'passageId',
  );
  @override
  late final GeneratedColumn<int> passageId = GeneratedColumn<int>(
    'passage_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES passage (id)',
    ),
  );
  static const VerificationMeta _gapNoMeta = const VerificationMeta('gapNo');
  @override
  late final GeneratedColumn<int> gapNo = GeneratedColumn<int>(
    'gap_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _afterParagraphOrdinalMeta =
      const VerificationMeta('afterParagraphOrdinal');
  @override
  late final GeneratedColumn<int> afterParagraphOrdinal = GeneratedColumn<int>(
    'after_paragraph_ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _afterSentenceOrdinalMeta =
      const VerificationMeta('afterSentenceOrdinal');
  @override
  late final GeneratedColumn<int> afterSentenceOrdinal = GeneratedColumn<int>(
    'after_sentence_ordinal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    passageId,
    gapNo,
    afterParagraphOrdinal,
    afterSentenceOrdinal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gap';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentGapRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('passage_id')) {
      context.handle(
        _passageIdMeta,
        passageId.isAcceptableOrUnknown(data['passage_id']!, _passageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_passageIdMeta);
    }
    if (data.containsKey('gap_no')) {
      context.handle(
        _gapNoMeta,
        gapNo.isAcceptableOrUnknown(data['gap_no']!, _gapNoMeta),
      );
    } else if (isInserting) {
      context.missing(_gapNoMeta);
    }
    if (data.containsKey('after_paragraph_ordinal')) {
      context.handle(
        _afterParagraphOrdinalMeta,
        afterParagraphOrdinal.isAcceptableOrUnknown(
          data['after_paragraph_ordinal']!,
          _afterParagraphOrdinalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_afterParagraphOrdinalMeta);
    }
    if (data.containsKey('after_sentence_ordinal')) {
      context.handle(
        _afterSentenceOrdinalMeta,
        afterSentenceOrdinal.isAcceptableOrUnknown(
          data['after_sentence_ordinal']!,
          _afterSentenceOrdinalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentGapRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentGapRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      passageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}passage_id'],
      )!,
      gapNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gap_no'],
      )!,
      afterParagraphOrdinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}after_paragraph_ordinal'],
      )!,
      afterSentenceOrdinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}after_sentence_ordinal'],
      ),
    );
  }

  @override
  $GapTable createAlias(String alias) {
    return $GapTable(attachedDatabase, alias);
  }
}

class ContentGapRow extends DataClass implements Insertable<ContentGapRow> {
  final int id;
  final int passageId;
  final int gapNo;
  final int afterParagraphOrdinal;
  final int? afterSentenceOrdinal;
  const ContentGapRow({
    required this.id,
    required this.passageId,
    required this.gapNo,
    required this.afterParagraphOrdinal,
    this.afterSentenceOrdinal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['passage_id'] = Variable<int>(passageId);
    map['gap_no'] = Variable<int>(gapNo);
    map['after_paragraph_ordinal'] = Variable<int>(afterParagraphOrdinal);
    if (!nullToAbsent || afterSentenceOrdinal != null) {
      map['after_sentence_ordinal'] = Variable<int>(afterSentenceOrdinal);
    }
    return map;
  }

  GapCompanion toCompanion(bool nullToAbsent) {
    return GapCompanion(
      id: Value(id),
      passageId: Value(passageId),
      gapNo: Value(gapNo),
      afterParagraphOrdinal: Value(afterParagraphOrdinal),
      afterSentenceOrdinal: afterSentenceOrdinal == null && nullToAbsent
          ? const Value.absent()
          : Value(afterSentenceOrdinal),
    );
  }

  factory ContentGapRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentGapRow(
      id: serializer.fromJson<int>(json['id']),
      passageId: serializer.fromJson<int>(json['passageId']),
      gapNo: serializer.fromJson<int>(json['gapNo']),
      afterParagraphOrdinal: serializer.fromJson<int>(
        json['afterParagraphOrdinal'],
      ),
      afterSentenceOrdinal: serializer.fromJson<int?>(
        json['afterSentenceOrdinal'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'passageId': serializer.toJson<int>(passageId),
      'gapNo': serializer.toJson<int>(gapNo),
      'afterParagraphOrdinal': serializer.toJson<int>(afterParagraphOrdinal),
      'afterSentenceOrdinal': serializer.toJson<int?>(afterSentenceOrdinal),
    };
  }

  ContentGapRow copyWith({
    int? id,
    int? passageId,
    int? gapNo,
    int? afterParagraphOrdinal,
    Value<int?> afterSentenceOrdinal = const Value.absent(),
  }) => ContentGapRow(
    id: id ?? this.id,
    passageId: passageId ?? this.passageId,
    gapNo: gapNo ?? this.gapNo,
    afterParagraphOrdinal: afterParagraphOrdinal ?? this.afterParagraphOrdinal,
    afterSentenceOrdinal: afterSentenceOrdinal.present
        ? afterSentenceOrdinal.value
        : this.afterSentenceOrdinal,
  );
  ContentGapRow copyWithCompanion(GapCompanion data) {
    return ContentGapRow(
      id: data.id.present ? data.id.value : this.id,
      passageId: data.passageId.present ? data.passageId.value : this.passageId,
      gapNo: data.gapNo.present ? data.gapNo.value : this.gapNo,
      afterParagraphOrdinal: data.afterParagraphOrdinal.present
          ? data.afterParagraphOrdinal.value
          : this.afterParagraphOrdinal,
      afterSentenceOrdinal: data.afterSentenceOrdinal.present
          ? data.afterSentenceOrdinal.value
          : this.afterSentenceOrdinal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentGapRow(')
          ..write('id: $id, ')
          ..write('passageId: $passageId, ')
          ..write('gapNo: $gapNo, ')
          ..write('afterParagraphOrdinal: $afterParagraphOrdinal, ')
          ..write('afterSentenceOrdinal: $afterSentenceOrdinal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    passageId,
    gapNo,
    afterParagraphOrdinal,
    afterSentenceOrdinal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentGapRow &&
          other.id == this.id &&
          other.passageId == this.passageId &&
          other.gapNo == this.gapNo &&
          other.afterParagraphOrdinal == this.afterParagraphOrdinal &&
          other.afterSentenceOrdinal == this.afterSentenceOrdinal);
}

class GapCompanion extends UpdateCompanion<ContentGapRow> {
  final Value<int> id;
  final Value<int> passageId;
  final Value<int> gapNo;
  final Value<int> afterParagraphOrdinal;
  final Value<int?> afterSentenceOrdinal;
  const GapCompanion({
    this.id = const Value.absent(),
    this.passageId = const Value.absent(),
    this.gapNo = const Value.absent(),
    this.afterParagraphOrdinal = const Value.absent(),
    this.afterSentenceOrdinal = const Value.absent(),
  });
  GapCompanion.insert({
    this.id = const Value.absent(),
    required int passageId,
    required int gapNo,
    required int afterParagraphOrdinal,
    this.afterSentenceOrdinal = const Value.absent(),
  }) : passageId = Value(passageId),
       gapNo = Value(gapNo),
       afterParagraphOrdinal = Value(afterParagraphOrdinal);
  static Insertable<ContentGapRow> custom({
    Expression<int>? id,
    Expression<int>? passageId,
    Expression<int>? gapNo,
    Expression<int>? afterParagraphOrdinal,
    Expression<int>? afterSentenceOrdinal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (passageId != null) 'passage_id': passageId,
      if (gapNo != null) 'gap_no': gapNo,
      if (afterParagraphOrdinal != null)
        'after_paragraph_ordinal': afterParagraphOrdinal,
      if (afterSentenceOrdinal != null)
        'after_sentence_ordinal': afterSentenceOrdinal,
    });
  }

  GapCompanion copyWith({
    Value<int>? id,
    Value<int>? passageId,
    Value<int>? gapNo,
    Value<int>? afterParagraphOrdinal,
    Value<int?>? afterSentenceOrdinal,
  }) {
    return GapCompanion(
      id: id ?? this.id,
      passageId: passageId ?? this.passageId,
      gapNo: gapNo ?? this.gapNo,
      afterParagraphOrdinal:
          afterParagraphOrdinal ?? this.afterParagraphOrdinal,
      afterSentenceOrdinal: afterSentenceOrdinal ?? this.afterSentenceOrdinal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (passageId.present) {
      map['passage_id'] = Variable<int>(passageId.value);
    }
    if (gapNo.present) {
      map['gap_no'] = Variable<int>(gapNo.value);
    }
    if (afterParagraphOrdinal.present) {
      map['after_paragraph_ordinal'] = Variable<int>(
        afterParagraphOrdinal.value,
      );
    }
    if (afterSentenceOrdinal.present) {
      map['after_sentence_ordinal'] = Variable<int>(afterSentenceOrdinal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GapCompanion(')
          ..write('id: $id, ')
          ..write('passageId: $passageId, ')
          ..write('gapNo: $gapNo, ')
          ..write('afterParagraphOrdinal: $afterParagraphOrdinal, ')
          ..write('afterSentenceOrdinal: $afterSentenceOrdinal')
          ..write(')'))
        .toString();
  }
}

class $PartBOptionTable extends PartBOption
    with TableInfo<$PartBOptionTable, ContentPartBOptionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartBOptionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _passageIdMeta = const VerificationMeta(
    'passageId',
  );
  @override
  late final GeneratedColumn<int> passageId = GeneratedColumn<int>(
    'passage_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES passage (id)',
    ),
  );
  static const VerificationMeta _optionKeyMeta = const VerificationMeta(
    'optionKey',
  );
  @override
  late final GeneratedColumn<String> optionKey = GeneratedColumn<String>(
    'option_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textEnMeta = const VerificationMeta('textEn');
  @override
  late final GeneratedColumn<String> textEn = GeneratedColumn<String>(
    'text_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textZhMeta = const VerificationMeta('textZh');
  @override
  late final GeneratedColumn<String> textZh = GeneratedColumn<String>(
    'text_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    passageId,
    optionKey,
    ordinal,
    textEn,
    textZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part_b_option';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentPartBOptionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('passage_id')) {
      context.handle(
        _passageIdMeta,
        passageId.isAcceptableOrUnknown(data['passage_id']!, _passageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_passageIdMeta);
    }
    if (data.containsKey('option_key')) {
      context.handle(
        _optionKeyMeta,
        optionKey.isAcceptableOrUnknown(data['option_key']!, _optionKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_optionKeyMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('text_en')) {
      context.handle(
        _textEnMeta,
        textEn.isAcceptableOrUnknown(data['text_en']!, _textEnMeta),
      );
    } else if (isInserting) {
      context.missing(_textEnMeta);
    }
    if (data.containsKey('text_zh')) {
      context.handle(
        _textZhMeta,
        textZh.isAcceptableOrUnknown(data['text_zh']!, _textZhMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentPartBOptionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentPartBOptionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      passageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}passage_id'],
      )!,
      optionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_key'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      textEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_en'],
      )!,
      textZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_zh'],
      ),
    );
  }

  @override
  $PartBOptionTable createAlias(String alias) {
    return $PartBOptionTable(attachedDatabase, alias);
  }
}

class ContentPartBOptionRow extends DataClass
    implements Insertable<ContentPartBOptionRow> {
  final int id;
  final int passageId;
  final String optionKey;
  final int ordinal;
  final String textEn;
  final String? textZh;
  const ContentPartBOptionRow({
    required this.id,
    required this.passageId,
    required this.optionKey,
    required this.ordinal,
    required this.textEn,
    this.textZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['passage_id'] = Variable<int>(passageId);
    map['option_key'] = Variable<String>(optionKey);
    map['ordinal'] = Variable<int>(ordinal);
    map['text_en'] = Variable<String>(textEn);
    if (!nullToAbsent || textZh != null) {
      map['text_zh'] = Variable<String>(textZh);
    }
    return map;
  }

  PartBOptionCompanion toCompanion(bool nullToAbsent) {
    return PartBOptionCompanion(
      id: Value(id),
      passageId: Value(passageId),
      optionKey: Value(optionKey),
      ordinal: Value(ordinal),
      textEn: Value(textEn),
      textZh: textZh == null && nullToAbsent
          ? const Value.absent()
          : Value(textZh),
    );
  }

  factory ContentPartBOptionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentPartBOptionRow(
      id: serializer.fromJson<int>(json['id']),
      passageId: serializer.fromJson<int>(json['passageId']),
      optionKey: serializer.fromJson<String>(json['optionKey']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      textEn: serializer.fromJson<String>(json['textEn']),
      textZh: serializer.fromJson<String?>(json['textZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'passageId': serializer.toJson<int>(passageId),
      'optionKey': serializer.toJson<String>(optionKey),
      'ordinal': serializer.toJson<int>(ordinal),
      'textEn': serializer.toJson<String>(textEn),
      'textZh': serializer.toJson<String?>(textZh),
    };
  }

  ContentPartBOptionRow copyWith({
    int? id,
    int? passageId,
    String? optionKey,
    int? ordinal,
    String? textEn,
    Value<String?> textZh = const Value.absent(),
  }) => ContentPartBOptionRow(
    id: id ?? this.id,
    passageId: passageId ?? this.passageId,
    optionKey: optionKey ?? this.optionKey,
    ordinal: ordinal ?? this.ordinal,
    textEn: textEn ?? this.textEn,
    textZh: textZh.present ? textZh.value : this.textZh,
  );
  ContentPartBOptionRow copyWithCompanion(PartBOptionCompanion data) {
    return ContentPartBOptionRow(
      id: data.id.present ? data.id.value : this.id,
      passageId: data.passageId.present ? data.passageId.value : this.passageId,
      optionKey: data.optionKey.present ? data.optionKey.value : this.optionKey,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      textEn: data.textEn.present ? data.textEn.value : this.textEn,
      textZh: data.textZh.present ? data.textZh.value : this.textZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentPartBOptionRow(')
          ..write('id: $id, ')
          ..write('passageId: $passageId, ')
          ..write('optionKey: $optionKey, ')
          ..write('ordinal: $ordinal, ')
          ..write('textEn: $textEn, ')
          ..write('textZh: $textZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, passageId, optionKey, ordinal, textEn, textZh);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentPartBOptionRow &&
          other.id == this.id &&
          other.passageId == this.passageId &&
          other.optionKey == this.optionKey &&
          other.ordinal == this.ordinal &&
          other.textEn == this.textEn &&
          other.textZh == this.textZh);
}

class PartBOptionCompanion extends UpdateCompanion<ContentPartBOptionRow> {
  final Value<int> id;
  final Value<int> passageId;
  final Value<String> optionKey;
  final Value<int> ordinal;
  final Value<String> textEn;
  final Value<String?> textZh;
  const PartBOptionCompanion({
    this.id = const Value.absent(),
    this.passageId = const Value.absent(),
    this.optionKey = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.textEn = const Value.absent(),
    this.textZh = const Value.absent(),
  });
  PartBOptionCompanion.insert({
    this.id = const Value.absent(),
    required int passageId,
    required String optionKey,
    required int ordinal,
    required String textEn,
    this.textZh = const Value.absent(),
  }) : passageId = Value(passageId),
       optionKey = Value(optionKey),
       ordinal = Value(ordinal),
       textEn = Value(textEn);
  static Insertable<ContentPartBOptionRow> custom({
    Expression<int>? id,
    Expression<int>? passageId,
    Expression<String>? optionKey,
    Expression<int>? ordinal,
    Expression<String>? textEn,
    Expression<String>? textZh,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (passageId != null) 'passage_id': passageId,
      if (optionKey != null) 'option_key': optionKey,
      if (ordinal != null) 'ordinal': ordinal,
      if (textEn != null) 'text_en': textEn,
      if (textZh != null) 'text_zh': textZh,
    });
  }

  PartBOptionCompanion copyWith({
    Value<int>? id,
    Value<int>? passageId,
    Value<String>? optionKey,
    Value<int>? ordinal,
    Value<String>? textEn,
    Value<String?>? textZh,
  }) {
    return PartBOptionCompanion(
      id: id ?? this.id,
      passageId: passageId ?? this.passageId,
      optionKey: optionKey ?? this.optionKey,
      ordinal: ordinal ?? this.ordinal,
      textEn: textEn ?? this.textEn,
      textZh: textZh ?? this.textZh,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (passageId.present) {
      map['passage_id'] = Variable<int>(passageId.value);
    }
    if (optionKey.present) {
      map['option_key'] = Variable<String>(optionKey.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (textEn.present) {
      map['text_en'] = Variable<String>(textEn.value);
    }
    if (textZh.present) {
      map['text_zh'] = Variable<String>(textZh.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartBOptionCompanion(')
          ..write('id: $id, ')
          ..write('passageId: $passageId, ')
          ..write('optionKey: $optionKey, ')
          ..write('ordinal: $ordinal, ')
          ..write('textEn: $textEn, ')
          ..write('textZh: $textZh')
          ..write(')'))
        .toString();
  }
}

abstract class _$ContentDatabase extends GeneratedDatabase {
  _$ContentDatabase(QueryExecutor e) : super(e);
  $ContentDatabaseManager get managers => $ContentDatabaseManager(this);
  late final $MetaTable meta = $MetaTable(this);
  late final $PaperTable paper = $PaperTable(this);
  late final $PassageTable passage = $PassageTable(this);
  late final $ParagraphTable paragraph = $ParagraphTable(this);
  late final $SentenceTable sentence = $SentenceTable(this);
  late final $GapTable gap = $GapTable(this);
  late final $PartBOptionTable partBOption = $PartBOptionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    meta,
    paper,
    passage,
    paragraph,
    sentence,
    gap,
    partBOption,
  ];
}

typedef $$MetaTableCreateCompanionBuilder = MetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$MetaTableUpdateCompanionBuilder = MetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$MetaTableFilterComposer
    extends Composer<_$ContentDatabase, $MetaTable> {
  $$MetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaTableOrderingComposer
    extends Composer<_$ContentDatabase, $MetaTable> {
  $$MetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaTableAnnotationComposer
    extends Composer<_$ContentDatabase, $MetaTable> {
  $$MetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$MetaTableTableManager
    extends
        RootTableManager<
          _$ContentDatabase,
          $MetaTable,
          ContentMetaRow,
          $$MetaTableFilterComposer,
          $$MetaTableOrderingComposer,
          $$MetaTableAnnotationComposer,
          $$MetaTableCreateCompanionBuilder,
          $$MetaTableUpdateCompanionBuilder,
          (
            ContentMetaRow,
            BaseReferences<_$ContentDatabase, $MetaTable, ContentMetaRow>,
          ),
          ContentMetaRow,
          PrefetchHooks Function()
        > {
  $$MetaTableTableManager(_$ContentDatabase db, $MetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => MetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => MetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetaTable, ContentMetaRow>(table),
                  BaseReferences<_$ContentDatabase, $MetaTable, ContentMetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentDatabase,
      $MetaTable,
      ContentMetaRow,
      $$MetaTableFilterComposer,
      $$MetaTableOrderingComposer,
      $$MetaTableAnnotationComposer,
      $$MetaTableCreateCompanionBuilder,
      $$MetaTableUpdateCompanionBuilder,
      (
        ContentMetaRow,
        BaseReferences<_$ContentDatabase, $MetaTable, ContentMetaRow>,
      ),
      ContentMetaRow,
      PrefetchHooks Function()
    >;
typedef $$PaperTableCreateCompanionBuilder = PaperCompanion Function({
  Value<int> id,
  required int year,
  required String code,
  Value<String?> title,
});
typedef $$PaperTableUpdateCompanionBuilder = PaperCompanion Function({
  Value<int> id,
  Value<int> year,
  Value<String> code,
  Value<String?> title,
});

final class $$PaperTableReferences
    extends BaseReferences<_$ContentDatabase, $PaperTable, ContentPaperRow> {
  $$PaperTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PassageTable, List<ContentPassageRow>>
  _passageRefsTable(_$ContentDatabase db) => MultiTypedResultKey.fromTable(
    db.passage,
    aliasName: 'paper__id__passage__paper_id',
  );

  $$PassageTableProcessedTableManager get passageRefs {
    final manager = $$PassageTableTableManager(
      $_db,
      $_db.passage,
    ).filter((f) => f.paperId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_passageRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaperTableFilterComposer
    extends Composer<_$ContentDatabase, $PaperTable> {
  $$PaperTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> passageRefs(
    Expression<bool> Function($$PassageTableFilterComposer f) f,
  ) {
    final $$PassageTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.paperId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableFilterComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaperTableOrderingComposer
    extends Composer<_$ContentDatabase, $PaperTable> {
  $$PaperTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaperTableAnnotationComposer
    extends Composer<_$ContentDatabase, $PaperTable> {
  $$PaperTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  Expression<T> passageRefs<T extends Object>(
    Expression<T> Function($$PassageTableAnnotationComposer a) f,
  ) {
    final $$PassageTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.paperId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableAnnotationComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaperTableTableManager
    extends
        RootTableManager<
          _$ContentDatabase,
          $PaperTable,
          ContentPaperRow,
          $$PaperTableFilterComposer,
          $$PaperTableOrderingComposer,
          $$PaperTableAnnotationComposer,
          $$PaperTableCreateCompanionBuilder,
          $$PaperTableUpdateCompanionBuilder,
          (ContentPaperRow, $$PaperTableReferences),
          ContentPaperRow,
          PrefetchHooks Function({bool passageRefs})
        > {
  $$PaperTableTableManager(_$ContentDatabase db, $PaperTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaperTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaperTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaperTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String?> title = const Value.absent(),
          }) => PaperCompanion(id: id, year: year, code: code, title: title),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int year,
                required String code,
                Value<String?> title = const Value.absent(),
              }) => PaperCompanion.insert(
                id: id,
                year: year,
                code: code,
                title: title,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaperTable, ContentPaperRow>(table),
                  $$PaperTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({passageRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (passageRefs) db.passage],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (passageRefs)
                    await $_getPrefetchedDataByColumns<
                      ContentPaperRow,
                      $PaperTable,
                      ContentPassageRow,
                      $PassageTable
                    >(
                      currentTable: table,
                      referencedTable: $$PaperTableReferences._passageRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$PaperTableReferences(db, table, p0).passageRefs,
                      currentColumn: 'id',
                      referencedColumn: 'paper_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PaperTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentDatabase,
      $PaperTable,
      ContentPaperRow,
      $$PaperTableFilterComposer,
      $$PaperTableOrderingComposer,
      $$PaperTableAnnotationComposer,
      $$PaperTableCreateCompanionBuilder,
      $$PaperTableUpdateCompanionBuilder,
      (ContentPaperRow, $$PaperTableReferences),
      ContentPaperRow,
      PrefetchHooks Function({bool passageRefs})
    >;
typedef $$PassageTableCreateCompanionBuilder = PassageCompanion Function({
  Value<int> id,
  required String key,
  required int paperId,
  required String part,
  Value<int?> textNo,
  Value<String?> titleZh,
  Value<String?> titleEn,
  Value<String?> sourceNote,
  required int wordCount,
  Value<String?> partBType,
  required int displayOrder,
});
typedef $$PassageTableUpdateCompanionBuilder = PassageCompanion Function({
  Value<int> id,
  Value<String> key,
  Value<int> paperId,
  Value<String> part,
  Value<int?> textNo,
  Value<String?> titleZh,
  Value<String?> titleEn,
  Value<String?> sourceNote,
  Value<int> wordCount,
  Value<String?> partBType,
  Value<int> displayOrder,
});

final class $$PassageTableReferences
    extends
        BaseReferences<_$ContentDatabase, $PassageTable, ContentPassageRow> {
  $$PassageTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PaperTable _paperIdTable(_$ContentDatabase db) =>
      db.paper.createAlias('passage__paper_id__paper__id');

  $$PaperTableProcessedTableManager get paperId {
    final $_column = $_itemColumn<int>('paper_id')!;

    final manager = $$PaperTableTableManager(
      $_db,
      $_db.paper,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paperIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ParagraphTable, List<ContentParagraphRow>>
  _paragraphRefsTable(_$ContentDatabase db) => MultiTypedResultKey.fromTable(
    db.paragraph,
    aliasName: 'passage__id__paragraph__passage_id',
  );

  $$ParagraphTableProcessedTableManager get paragraphRefs {
    final manager = $$ParagraphTableTableManager(
      $_db,
      $_db.paragraph,
    ).filter((f) => f.passageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paragraphRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GapTable, List<ContentGapRow>> _gapRefsTable(
    _$ContentDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.gap,
    aliasName: 'passage__id__gap__passage_id',
  );

  $$GapTableProcessedTableManager get gapRefs {
    final manager = $$GapTableTableManager(
      $_db,
      $_db.gap,
    ).filter((f) => f.passageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gapRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartBOptionTable, List<ContentPartBOptionRow>>
  _partBOptionRefsTable(_$ContentDatabase db) => MultiTypedResultKey.fromTable(
    db.partBOption,
    aliasName: 'passage__id__part_b_option__passage_id',
  );

  $$PartBOptionTableProcessedTableManager get partBOptionRefs {
    final manager = $$PartBOptionTableTableManager(
      $_db,
      $_db.partBOption,
    ).filter((f) => f.passageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partBOptionRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PassageTableFilterComposer
    extends Composer<_$ContentDatabase, $PassageTable> {
  $$PassageTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get part => $composableBuilder(
    column: $table.part,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get textNo => $composableBuilder(
    column: $table.textNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleZh => $composableBuilder(
    column: $table.titleZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partBType => $composableBuilder(
    column: $table.partBType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$PaperTableFilterComposer get paperId {
    final $$PaperTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paperId,
      referencedTable: $db.paper,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaperTableFilterComposer(
            $db: $db,
            $table: $db.paper,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paragraphRefs(
    Expression<bool> Function($$ParagraphTableFilterComposer f) f,
  ) {
    final $$ParagraphTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paragraph,
      getReferencedColumn: (t) => t.passageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphTableFilterComposer(
            $db: $db,
            $table: $db.paragraph,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gapRefs(
    Expression<bool> Function($$GapTableFilterComposer f) f,
  ) {
    final $$GapTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gap,
      getReferencedColumn: (t) => t.passageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GapTableFilterComposer(
            $db: $db,
            $table: $db.gap,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> partBOptionRefs(
    Expression<bool> Function($$PartBOptionTableFilterComposer f) f,
  ) {
    final $$PartBOptionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partBOption,
      getReferencedColumn: (t) => t.passageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartBOptionTableFilterComposer(
            $db: $db,
            $table: $db.partBOption,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PassageTableOrderingComposer
    extends Composer<_$ContentDatabase, $PassageTable> {
  $$PassageTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get part => $composableBuilder(
    column: $table.part,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get textNo => $composableBuilder(
    column: $table.textNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleZh => $composableBuilder(
    column: $table.titleZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partBType => $composableBuilder(
    column: $table.partBType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaperTableOrderingComposer get paperId {
    final $$PaperTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paperId,
      referencedTable: $db.paper,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaperTableOrderingComposer(
            $db: $db,
            $table: $db.paper,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PassageTableAnnotationComposer
    extends Composer<_$ContentDatabase, $PassageTable> {
  $$PassageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get part =>
      $composableBuilder(column: $table.part, builder: (column) => column);

  GeneratedColumn<int> get textNo =>
      $composableBuilder(column: $table.textNo, builder: (column) => column);

  GeneratedColumn<String> get titleZh =>
      $composableBuilder(column: $table.titleZh, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<String> get partBType =>
      $composableBuilder(column: $table.partBType, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$PaperTableAnnotationComposer get paperId {
    final $$PaperTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paperId,
      referencedTable: $db.paper,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaperTableAnnotationComposer(
            $db: $db,
            $table: $db.paper,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paragraphRefs<T extends Object>(
    Expression<T> Function($$ParagraphTableAnnotationComposer a) f,
  ) {
    final $$ParagraphTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paragraph,
      getReferencedColumn: (t) => t.passageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphTableAnnotationComposer(
            $db: $db,
            $table: $db.paragraph,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gapRefs<T extends Object>(
    Expression<T> Function($$GapTableAnnotationComposer a) f,
  ) {
    final $$GapTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gap,
      getReferencedColumn: (t) => t.passageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GapTableAnnotationComposer(
            $db: $db,
            $table: $db.gap,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> partBOptionRefs<T extends Object>(
    Expression<T> Function($$PartBOptionTableAnnotationComposer a) f,
  ) {
    final $$PartBOptionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partBOption,
      getReferencedColumn: (t) => t.passageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartBOptionTableAnnotationComposer(
            $db: $db,
            $table: $db.partBOption,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PassageTableTableManager
    extends
        RootTableManager<
          _$ContentDatabase,
          $PassageTable,
          ContentPassageRow,
          $$PassageTableFilterComposer,
          $$PassageTableOrderingComposer,
          $$PassageTableAnnotationComposer,
          $$PassageTableCreateCompanionBuilder,
          $$PassageTableUpdateCompanionBuilder,
          (ContentPassageRow, $$PassageTableReferences),
          ContentPassageRow,
          PrefetchHooks Function({
            bool paperId,
            bool paragraphRefs,
            bool gapRefs,
            bool partBOptionRefs,
          })
        > {
  $$PassageTableTableManager(_$ContentDatabase db, $PassageTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PassageTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PassageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PassageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<int> paperId = const Value.absent(),
                Value<String> part = const Value.absent(),
                Value<int?> textNo = const Value.absent(),
                Value<String?> titleZh = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                Value<String?> sourceNote = const Value.absent(),
                Value<int> wordCount = const Value.absent(),
                Value<String?> partBType = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => PassageCompanion(
                id: id,
                key: key,
                paperId: paperId,
                part: part,
                textNo: textNo,
                titleZh: titleZh,
                titleEn: titleEn,
                sourceNote: sourceNote,
                wordCount: wordCount,
                partBType: partBType,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required int paperId,
                required String part,
                Value<int?> textNo = const Value.absent(),
                Value<String?> titleZh = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                Value<String?> sourceNote = const Value.absent(),
                required int wordCount,
                Value<String?> partBType = const Value.absent(),
                required int displayOrder,
              }) => PassageCompanion.insert(
                id: id,
                key: key,
                paperId: paperId,
                part: part,
                textNo: textNo,
                titleZh: titleZh,
                titleEn: titleEn,
                sourceNote: sourceNote,
                wordCount: wordCount,
                partBType: partBType,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PassageTable, ContentPassageRow>(table),
                  $$PassageTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                paperId = false,
                paragraphRefs = false,
                gapRefs = false,
                partBOptionRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (paragraphRefs) db.paragraph,
                    if (gapRefs) db.gap,
                    if (partBOptionRefs) db.partBOption,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (paperId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.paperId,
                            referencedTable: $$PassageTableReferences
                                ._paperIdTable(db),
                            referencedColumn: $$PassageTableReferences
                                ._paperIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paragraphRefs)
                        await $_getPrefetchedDataByColumns<
                          ContentPassageRow,
                          $PassageTable,
                          ContentParagraphRow,
                          $ParagraphTable
                        >(
                          currentTable: table,
                          referencedTable: $$PassageTableReferences
                              ._paragraphRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PassageTableReferences(
                                db,
                                table,
                                p0,
                              ).paragraphRefs,
                          currentColumn: 'id',
                          referencedColumn: 'passage_id',
                          typedResults: items,
                        ),
                      if (gapRefs)
                        await $_getPrefetchedDataByColumns<
                          ContentPassageRow,
                          $PassageTable,
                          ContentGapRow,
                          $GapTable
                        >(
                          currentTable: table,
                          referencedTable: $$PassageTableReferences
                              ._gapRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PassageTableReferences(db, table, p0).gapRefs,
                          currentColumn: 'id',
                          referencedColumn: 'passage_id',
                          typedResults: items,
                        ),
                      if (partBOptionRefs)
                        await $_getPrefetchedDataByColumns<
                          ContentPassageRow,
                          $PassageTable,
                          ContentPartBOptionRow,
                          $PartBOptionTable
                        >(
                          currentTable: table,
                          referencedTable: $$PassageTableReferences
                              ._partBOptionRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PassageTableReferences(
                                db,
                                table,
                                p0,
                              ).partBOptionRefs,
                          currentColumn: 'id',
                          referencedColumn: 'passage_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PassageTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentDatabase,
      $PassageTable,
      ContentPassageRow,
      $$PassageTableFilterComposer,
      $$PassageTableOrderingComposer,
      $$PassageTableAnnotationComposer,
      $$PassageTableCreateCompanionBuilder,
      $$PassageTableUpdateCompanionBuilder,
      (ContentPassageRow, $$PassageTableReferences),
      ContentPassageRow,
      PrefetchHooks Function({
        bool paperId,
        bool paragraphRefs,
        bool gapRefs,
        bool partBOptionRefs,
      })
    >;
typedef $$ParagraphTableCreateCompanionBuilder = ParagraphCompanion Function({
  Value<int> id,
  required String key,
  required int passageId,
  required int ordinal,
  Value<String?> label,
  Value<String?> headingEn,
  Value<String?> headingZh,
  Value<String?> speaker,
  required String textEn,
  Value<String?> textZh,
  Value<String?> translationSource,
  required String translationStatus,
});
typedef $$ParagraphTableUpdateCompanionBuilder = ParagraphCompanion Function({
  Value<int> id,
  Value<String> key,
  Value<int> passageId,
  Value<int> ordinal,
  Value<String?> label,
  Value<String?> headingEn,
  Value<String?> headingZh,
  Value<String?> speaker,
  Value<String> textEn,
  Value<String?> textZh,
  Value<String?> translationSource,
  Value<String> translationStatus,
});

final class $$ParagraphTableReferences
    extends
        BaseReferences<
          _$ContentDatabase,
          $ParagraphTable,
          ContentParagraphRow
        > {
  $$ParagraphTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PassageTable _passageIdTable(_$ContentDatabase db) =>
      db.passage.createAlias('paragraph__passage_id__passage__id');

  $$PassageTableProcessedTableManager get passageId {
    final $_column = $_itemColumn<int>('passage_id')!;

    final manager = $$PassageTableTableManager(
      $_db,
      $_db.passage,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_passageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SentenceTable, List<ContentSentenceRow>>
  _sentenceRefsTable(_$ContentDatabase db) => MultiTypedResultKey.fromTable(
    db.sentence,
    aliasName: 'paragraph__id__sentence__paragraph_id',
  );

  $$SentenceTableProcessedTableManager get sentenceRefs {
    final manager = $$SentenceTableTableManager(
      $_db,
      $_db.sentence,
    ).filter((f) => f.paragraphId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sentenceRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ParagraphTableFilterComposer
    extends Composer<_$ContentDatabase, $ParagraphTable> {
  $$ParagraphTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get headingEn => $composableBuilder(
    column: $table.headingEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get headingZh => $composableBuilder(
    column: $table.headingZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speaker => $composableBuilder(
    column: $table.speaker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationSource => $composableBuilder(
    column: $table.translationSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationStatus => $composableBuilder(
    column: $table.translationStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$PassageTableFilterComposer get passageId {
    final $$PassageTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableFilterComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sentenceRefs(
    Expression<bool> Function($$SentenceTableFilterComposer f) f,
  ) {
    final $$SentenceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentence,
      getReferencedColumn: (t) => t.paragraphId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceTableFilterComposer(
            $db: $db,
            $table: $db.sentence,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParagraphTableOrderingComposer
    extends Composer<_$ContentDatabase, $ParagraphTable> {
  $$ParagraphTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get headingEn => $composableBuilder(
    column: $table.headingEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get headingZh => $composableBuilder(
    column: $table.headingZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speaker => $composableBuilder(
    column: $table.speaker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationSource => $composableBuilder(
    column: $table.translationSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationStatus => $composableBuilder(
    column: $table.translationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$PassageTableOrderingComposer get passageId {
    final $$PassageTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableOrderingComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParagraphTableAnnotationComposer
    extends Composer<_$ContentDatabase, $ParagraphTable> {
  $$ParagraphTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get headingEn =>
      $composableBuilder(column: $table.headingEn, builder: (column) => column);

  GeneratedColumn<String> get headingZh =>
      $composableBuilder(column: $table.headingZh, builder: (column) => column);

  GeneratedColumn<String> get speaker =>
      $composableBuilder(column: $table.speaker, builder: (column) => column);

  GeneratedColumn<String> get textEn =>
      $composableBuilder(column: $table.textEn, builder: (column) => column);

  GeneratedColumn<String> get textZh =>
      $composableBuilder(column: $table.textZh, builder: (column) => column);

  GeneratedColumn<String> get translationSource => $composableBuilder(
    column: $table.translationSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationStatus => $composableBuilder(
    column: $table.translationStatus,
    builder: (column) => column,
  );

  $$PassageTableAnnotationComposer get passageId {
    final $$PassageTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableAnnotationComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sentenceRefs<T extends Object>(
    Expression<T> Function($$SentenceTableAnnotationComposer a) f,
  ) {
    final $$SentenceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentence,
      getReferencedColumn: (t) => t.paragraphId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceTableAnnotationComposer(
            $db: $db,
            $table: $db.sentence,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParagraphTableTableManager
    extends
        RootTableManager<
          _$ContentDatabase,
          $ParagraphTable,
          ContentParagraphRow,
          $$ParagraphTableFilterComposer,
          $$ParagraphTableOrderingComposer,
          $$ParagraphTableAnnotationComposer,
          $$ParagraphTableCreateCompanionBuilder,
          $$ParagraphTableUpdateCompanionBuilder,
          (ContentParagraphRow, $$ParagraphTableReferences),
          ContentParagraphRow,
          PrefetchHooks Function({bool passageId, bool sentenceRefs})
        > {
  $$ParagraphTableTableManager(_$ContentDatabase db, $ParagraphTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParagraphTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParagraphTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParagraphTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<int> passageId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> headingEn = const Value.absent(),
                Value<String?> headingZh = const Value.absent(),
                Value<String?> speaker = const Value.absent(),
                Value<String> textEn = const Value.absent(),
                Value<String?> textZh = const Value.absent(),
                Value<String?> translationSource = const Value.absent(),
                Value<String> translationStatus = const Value.absent(),
              }) => ParagraphCompanion(
                id: id,
                key: key,
                passageId: passageId,
                ordinal: ordinal,
                label: label,
                headingEn: headingEn,
                headingZh: headingZh,
                speaker: speaker,
                textEn: textEn,
                textZh: textZh,
                translationSource: translationSource,
                translationStatus: translationStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required int passageId,
                required int ordinal,
                Value<String?> label = const Value.absent(),
                Value<String?> headingEn = const Value.absent(),
                Value<String?> headingZh = const Value.absent(),
                Value<String?> speaker = const Value.absent(),
                required String textEn,
                Value<String?> textZh = const Value.absent(),
                Value<String?> translationSource = const Value.absent(),
                required String translationStatus,
              }) => ParagraphCompanion.insert(
                id: id,
                key: key,
                passageId: passageId,
                ordinal: ordinal,
                label: label,
                headingEn: headingEn,
                headingZh: headingZh,
                speaker: speaker,
                textEn: textEn,
                textZh: textZh,
                translationSource: translationSource,
                translationStatus: translationStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ParagraphTable, ContentParagraphRow>(table),
                  $$ParagraphTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({passageId = false, sentenceRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sentenceRefs) db.sentence],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (passageId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.passageId,
                        referencedTable: $$ParagraphTableReferences
                            ._passageIdTable(db),
                        referencedColumn: $$ParagraphTableReferences
                            ._passageIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sentenceRefs)
                    await $_getPrefetchedDataByColumns<
                      ContentParagraphRow,
                      $ParagraphTable,
                      ContentSentenceRow,
                      $SentenceTable
                    >(
                      currentTable: table,
                      referencedTable: $$ParagraphTableReferences
                          ._sentenceRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ParagraphTableReferences(
                            db,
                            table,
                            p0,
                          ).sentenceRefs,
                      currentColumn: 'id',
                      referencedColumn: 'paragraph_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ParagraphTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentDatabase,
      $ParagraphTable,
      ContentParagraphRow,
      $$ParagraphTableFilterComposer,
      $$ParagraphTableOrderingComposer,
      $$ParagraphTableAnnotationComposer,
      $$ParagraphTableCreateCompanionBuilder,
      $$ParagraphTableUpdateCompanionBuilder,
      (ContentParagraphRow, $$ParagraphTableReferences),
      ContentParagraphRow,
      PrefetchHooks Function({bool passageId, bool sentenceRefs})
    >;
typedef $$SentenceTableCreateCompanionBuilder = SentenceCompanion Function({
  Value<int> id,
  required String key,
  required int paragraphId,
  required int ordinal,
  required String textEn,
  Value<String?> textZh,
  Value<String?> translationSource,
  required String translationStatus,
  Value<int?> examNo,
  Value<double?> confidence,
});
typedef $$SentenceTableUpdateCompanionBuilder = SentenceCompanion Function({
  Value<int> id,
  Value<String> key,
  Value<int> paragraphId,
  Value<int> ordinal,
  Value<String> textEn,
  Value<String?> textZh,
  Value<String?> translationSource,
  Value<String> translationStatus,
  Value<int?> examNo,
  Value<double?> confidence,
});

final class $$SentenceTableReferences
    extends
        BaseReferences<_$ContentDatabase, $SentenceTable, ContentSentenceRow> {
  $$SentenceTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ParagraphTable _paragraphIdTable(_$ContentDatabase db) =>
      db.paragraph.createAlias('sentence__paragraph_id__paragraph__id');

  $$ParagraphTableProcessedTableManager get paragraphId {
    final $_column = $_itemColumn<int>('paragraph_id')!;

    final manager = $$ParagraphTableTableManager(
      $_db,
      $_db.paragraph,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paragraphIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SentenceTableFilterComposer
    extends Composer<_$ContentDatabase, $SentenceTable> {
  $$SentenceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationSource => $composableBuilder(
    column: $table.translationSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationStatus => $composableBuilder(
    column: $table.translationStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get examNo => $composableBuilder(
    column: $table.examNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  $$ParagraphTableFilterComposer get paragraphId {
    final $$ParagraphTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paragraphId,
      referencedTable: $db.paragraph,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphTableFilterComposer(
            $db: $db,
            $table: $db.paragraph,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceTableOrderingComposer
    extends Composer<_$ContentDatabase, $SentenceTable> {
  $$SentenceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationSource => $composableBuilder(
    column: $table.translationSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationStatus => $composableBuilder(
    column: $table.translationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get examNo => $composableBuilder(
    column: $table.examNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParagraphTableOrderingComposer get paragraphId {
    final $$ParagraphTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paragraphId,
      referencedTable: $db.paragraph,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphTableOrderingComposer(
            $db: $db,
            $table: $db.paragraph,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceTableAnnotationComposer
    extends Composer<_$ContentDatabase, $SentenceTable> {
  $$SentenceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get textEn =>
      $composableBuilder(column: $table.textEn, builder: (column) => column);

  GeneratedColumn<String> get textZh =>
      $composableBuilder(column: $table.textZh, builder: (column) => column);

  GeneratedColumn<String> get translationSource => $composableBuilder(
    column: $table.translationSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationStatus => $composableBuilder(
    column: $table.translationStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get examNo =>
      $composableBuilder(column: $table.examNo, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  $$ParagraphTableAnnotationComposer get paragraphId {
    final $$ParagraphTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paragraphId,
      referencedTable: $db.paragraph,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphTableAnnotationComposer(
            $db: $db,
            $table: $db.paragraph,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceTableTableManager
    extends
        RootTableManager<
          _$ContentDatabase,
          $SentenceTable,
          ContentSentenceRow,
          $$SentenceTableFilterComposer,
          $$SentenceTableOrderingComposer,
          $$SentenceTableAnnotationComposer,
          $$SentenceTableCreateCompanionBuilder,
          $$SentenceTableUpdateCompanionBuilder,
          (ContentSentenceRow, $$SentenceTableReferences),
          ContentSentenceRow,
          PrefetchHooks Function({bool paragraphId})
        > {
  $$SentenceTableTableManager(_$ContentDatabase db, $SentenceTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SentenceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SentenceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SentenceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<int> paragraphId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String> textEn = const Value.absent(),
                Value<String?> textZh = const Value.absent(),
                Value<String?> translationSource = const Value.absent(),
                Value<String> translationStatus = const Value.absent(),
                Value<int?> examNo = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
              }) => SentenceCompanion(
                id: id,
                key: key,
                paragraphId: paragraphId,
                ordinal: ordinal,
                textEn: textEn,
                textZh: textZh,
                translationSource: translationSource,
                translationStatus: translationStatus,
                examNo: examNo,
                confidence: confidence,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required int paragraphId,
                required int ordinal,
                required String textEn,
                Value<String?> textZh = const Value.absent(),
                Value<String?> translationSource = const Value.absent(),
                required String translationStatus,
                Value<int?> examNo = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
              }) => SentenceCompanion.insert(
                id: id,
                key: key,
                paragraphId: paragraphId,
                ordinal: ordinal,
                textEn: textEn,
                textZh: textZh,
                translationSource: translationSource,
                translationStatus: translationStatus,
                examNo: examNo,
                confidence: confidence,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SentenceTable, ContentSentenceRow>(table),
                  $$SentenceTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paragraphId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (paragraphId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.paragraphId,
                        referencedTable: $$SentenceTableReferences
                            ._paragraphIdTable(db),
                        referencedColumn: $$SentenceTableReferences
                            ._paragraphIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SentenceTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentDatabase,
      $SentenceTable,
      ContentSentenceRow,
      $$SentenceTableFilterComposer,
      $$SentenceTableOrderingComposer,
      $$SentenceTableAnnotationComposer,
      $$SentenceTableCreateCompanionBuilder,
      $$SentenceTableUpdateCompanionBuilder,
      (ContentSentenceRow, $$SentenceTableReferences),
      ContentSentenceRow,
      PrefetchHooks Function({bool paragraphId})
    >;
typedef $$GapTableCreateCompanionBuilder = GapCompanion Function({
  Value<int> id,
  required int passageId,
  required int gapNo,
  required int afterParagraphOrdinal,
  Value<int?> afterSentenceOrdinal,
});
typedef $$GapTableUpdateCompanionBuilder = GapCompanion Function({
  Value<int> id,
  Value<int> passageId,
  Value<int> gapNo,
  Value<int> afterParagraphOrdinal,
  Value<int?> afterSentenceOrdinal,
});

final class $$GapTableReferences
    extends BaseReferences<_$ContentDatabase, $GapTable, ContentGapRow> {
  $$GapTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PassageTable _passageIdTable(_$ContentDatabase db) =>
      db.passage.createAlias('gap__passage_id__passage__id');

  $$PassageTableProcessedTableManager get passageId {
    final $_column = $_itemColumn<int>('passage_id')!;

    final manager = $$PassageTableTableManager(
      $_db,
      $_db.passage,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_passageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GapTableFilterComposer extends Composer<_$ContentDatabase, $GapTable> {
  $$GapTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gapNo => $composableBuilder(
    column: $table.gapNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get afterParagraphOrdinal => $composableBuilder(
    column: $table.afterParagraphOrdinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get afterSentenceOrdinal => $composableBuilder(
    column: $table.afterSentenceOrdinal,
    builder: (column) => ColumnFilters(column),
  );

  $$PassageTableFilterComposer get passageId {
    final $$PassageTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableFilterComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GapTableOrderingComposer
    extends Composer<_$ContentDatabase, $GapTable> {
  $$GapTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gapNo => $composableBuilder(
    column: $table.gapNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get afterParagraphOrdinal => $composableBuilder(
    column: $table.afterParagraphOrdinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get afterSentenceOrdinal => $composableBuilder(
    column: $table.afterSentenceOrdinal,
    builder: (column) => ColumnOrderings(column),
  );

  $$PassageTableOrderingComposer get passageId {
    final $$PassageTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableOrderingComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GapTableAnnotationComposer
    extends Composer<_$ContentDatabase, $GapTable> {
  $$GapTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get gapNo =>
      $composableBuilder(column: $table.gapNo, builder: (column) => column);

  GeneratedColumn<int> get afterParagraphOrdinal => $composableBuilder(
    column: $table.afterParagraphOrdinal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get afterSentenceOrdinal => $composableBuilder(
    column: $table.afterSentenceOrdinal,
    builder: (column) => column,
  );

  $$PassageTableAnnotationComposer get passageId {
    final $$PassageTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableAnnotationComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GapTableTableManager
    extends
        RootTableManager<
          _$ContentDatabase,
          $GapTable,
          ContentGapRow,
          $$GapTableFilterComposer,
          $$GapTableOrderingComposer,
          $$GapTableAnnotationComposer,
          $$GapTableCreateCompanionBuilder,
          $$GapTableUpdateCompanionBuilder,
          (ContentGapRow, $$GapTableReferences),
          ContentGapRow,
          PrefetchHooks Function({bool passageId})
        > {
  $$GapTableTableManager(_$ContentDatabase db, $GapTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GapTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GapTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GapTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> passageId = const Value.absent(),
                Value<int> gapNo = const Value.absent(),
                Value<int> afterParagraphOrdinal = const Value.absent(),
                Value<int?> afterSentenceOrdinal = const Value.absent(),
              }) => GapCompanion(
                id: id,
                passageId: passageId,
                gapNo: gapNo,
                afterParagraphOrdinal: afterParagraphOrdinal,
                afterSentenceOrdinal: afterSentenceOrdinal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int passageId,
                required int gapNo,
                required int afterParagraphOrdinal,
                Value<int?> afterSentenceOrdinal = const Value.absent(),
              }) => GapCompanion.insert(
                id: id,
                passageId: passageId,
                gapNo: gapNo,
                afterParagraphOrdinal: afterParagraphOrdinal,
                afterSentenceOrdinal: afterSentenceOrdinal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GapTable, ContentGapRow>(table),
                  $$GapTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({passageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (passageId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.passageId,
                        referencedTable: $$GapTableReferences._passageIdTable(
                          db,
                        ),
                        referencedColumn: $$GapTableReferences
                            ._passageIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GapTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentDatabase,
      $GapTable,
      ContentGapRow,
      $$GapTableFilterComposer,
      $$GapTableOrderingComposer,
      $$GapTableAnnotationComposer,
      $$GapTableCreateCompanionBuilder,
      $$GapTableUpdateCompanionBuilder,
      (ContentGapRow, $$GapTableReferences),
      ContentGapRow,
      PrefetchHooks Function({bool passageId})
    >;
typedef $$PartBOptionTableCreateCompanionBuilder =
    PartBOptionCompanion Function({
      Value<int> id,
      required int passageId,
      required String optionKey,
      required int ordinal,
      required String textEn,
      Value<String?> textZh,
    });
typedef $$PartBOptionTableUpdateCompanionBuilder =
    PartBOptionCompanion Function({
      Value<int> id,
      Value<int> passageId,
      Value<String> optionKey,
      Value<int> ordinal,
      Value<String> textEn,
      Value<String?> textZh,
    });

final class $$PartBOptionTableReferences
    extends
        BaseReferences<
          _$ContentDatabase,
          $PartBOptionTable,
          ContentPartBOptionRow
        > {
  $$PartBOptionTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PassageTable _passageIdTable(_$ContentDatabase db) =>
      db.passage.createAlias('part_b_option__passage_id__passage__id');

  $$PassageTableProcessedTableManager get passageId {
    final $_column = $_itemColumn<int>('passage_id')!;

    final manager = $$PassageTableTableManager(
      $_db,
      $_db.passage,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_passageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PartBOptionTableFilterComposer
    extends Composer<_$ContentDatabase, $PartBOptionTable> {
  $$PartBOptionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionKey => $composableBuilder(
    column: $table.optionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnFilters(column),
  );

  $$PassageTableFilterComposer get passageId {
    final $$PassageTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableFilterComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartBOptionTableOrderingComposer
    extends Composer<_$ContentDatabase, $PartBOptionTable> {
  $$PartBOptionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionKey => $composableBuilder(
    column: $table.optionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnOrderings(column),
  );

  $$PassageTableOrderingComposer get passageId {
    final $$PassageTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableOrderingComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartBOptionTableAnnotationComposer
    extends Composer<_$ContentDatabase, $PartBOptionTable> {
  $$PartBOptionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get optionKey =>
      $composableBuilder(column: $table.optionKey, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get textEn =>
      $composableBuilder(column: $table.textEn, builder: (column) => column);

  GeneratedColumn<String> get textZh =>
      $composableBuilder(column: $table.textZh, builder: (column) => column);

  $$PassageTableAnnotationComposer get passageId {
    final $$PassageTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passageId,
      referencedTable: $db.passage,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageTableAnnotationComposer(
            $db: $db,
            $table: $db.passage,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartBOptionTableTableManager
    extends
        RootTableManager<
          _$ContentDatabase,
          $PartBOptionTable,
          ContentPartBOptionRow,
          $$PartBOptionTableFilterComposer,
          $$PartBOptionTableOrderingComposer,
          $$PartBOptionTableAnnotationComposer,
          $$PartBOptionTableCreateCompanionBuilder,
          $$PartBOptionTableUpdateCompanionBuilder,
          (ContentPartBOptionRow, $$PartBOptionTableReferences),
          ContentPartBOptionRow,
          PrefetchHooks Function({bool passageId})
        > {
  $$PartBOptionTableTableManager(_$ContentDatabase db, $PartBOptionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartBOptionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartBOptionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartBOptionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> passageId = const Value.absent(),
                Value<String> optionKey = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String> textEn = const Value.absent(),
                Value<String?> textZh = const Value.absent(),
              }) => PartBOptionCompanion(
                id: id,
                passageId: passageId,
                optionKey: optionKey,
                ordinal: ordinal,
                textEn: textEn,
                textZh: textZh,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int passageId,
                required String optionKey,
                required int ordinal,
                required String textEn,
                Value<String?> textZh = const Value.absent(),
              }) => PartBOptionCompanion.insert(
                id: id,
                passageId: passageId,
                optionKey: optionKey,
                ordinal: ordinal,
                textEn: textEn,
                textZh: textZh,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PartBOptionTable, ContentPartBOptionRow>(table),
                  $$PartBOptionTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({passageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (passageId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.passageId,
                        referencedTable: $$PartBOptionTableReferences
                            ._passageIdTable(db),
                        referencedColumn: $$PartBOptionTableReferences
                            ._passageIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PartBOptionTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentDatabase,
      $PartBOptionTable,
      ContentPartBOptionRow,
      $$PartBOptionTableFilterComposer,
      $$PartBOptionTableOrderingComposer,
      $$PartBOptionTableAnnotationComposer,
      $$PartBOptionTableCreateCompanionBuilder,
      $$PartBOptionTableUpdateCompanionBuilder,
      (ContentPartBOptionRow, $$PartBOptionTableReferences),
      ContentPartBOptionRow,
      PrefetchHooks Function({bool passageId})
    >;

class $ContentDatabaseManager {
  final _$ContentDatabase _db;
  $ContentDatabaseManager(this._db);
  $$MetaTableTableManager get meta => $$MetaTableTableManager(_db, _db.meta);
  $$PaperTableTableManager get paper =>
      $$PaperTableTableManager(_db, _db.paper);
  $$PassageTableTableManager get passage =>
      $$PassageTableTableManager(_db, _db.passage);
  $$ParagraphTableTableManager get paragraph =>
      $$ParagraphTableTableManager(_db, _db.paragraph);
  $$SentenceTableTableManager get sentence =>
      $$SentenceTableTableManager(_db, _db.sentence);
  $$GapTableTableManager get gap => $$GapTableTableManager(_db, _db.gap);
  $$PartBOptionTableTableManager get partBOption =>
      $$PartBOptionTableTableManager(_db, _db.partBOption);
}
