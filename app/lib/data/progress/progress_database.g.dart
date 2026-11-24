// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_database.dart';

// ignore_for_file: type=lint
class $BookmarkTableTable extends BookmarkTable
    with TableInfo<$BookmarkTableTable, BookmarkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarkTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _passageKeyMeta = const VerificationMeta(
    'passageKey',
  );
  @override
  late final GeneratedColumn<String> passageKey = GeneratedColumn<String>(
    'passage_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paragraphKeyMeta = const VerificationMeta(
    'paragraphKey',
  );
  @override
  late final GeneratedColumn<String> paragraphKey = GeneratedColumn<String>(
    'paragraph_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    passageKey,
    paragraphKey,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmark';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookmarkRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('passage_key')) {
      context.handle(
        _passageKeyMeta,
        passageKey.isAcceptableOrUnknown(data['passage_key']!, _passageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_passageKeyMeta);
    }
    if (data.containsKey('paragraph_key')) {
      context.handle(
        _paragraphKeyMeta,
        paragraphKey.isAcceptableOrUnknown(
          data['paragraph_key']!,
          _paragraphKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paragraphKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {paragraphKey},
  ];
  @override
  BookmarkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarkRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      passageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passage_key'],
      )!,
      paragraphKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paragraph_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarkTableTable createAlias(String alias) {
    return $BookmarkTableTable(attachedDatabase, alias);
  }
}

class BookmarkRow extends DataClass implements Insertable<BookmarkRow> {
  final int id;
  final String passageKey;
  final String paragraphKey;
  final int createdAt;
  const BookmarkRow({
    required this.id,
    required this.passageKey,
    required this.paragraphKey,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['passage_key'] = Variable<String>(passageKey);
    map['paragraph_key'] = Variable<String>(paragraphKey);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  BookmarkTableCompanion toCompanion(bool nullToAbsent) {
    return BookmarkTableCompanion(
      id: Value(id),
      passageKey: Value(passageKey),
      paragraphKey: Value(paragraphKey),
      createdAt: Value(createdAt),
    );
  }

  factory BookmarkRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarkRow(
      id: serializer.fromJson<int>(json['id']),
      passageKey: serializer.fromJson<String>(json['passageKey']),
      paragraphKey: serializer.fromJson<String>(json['paragraphKey']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'passageKey': serializer.toJson<String>(passageKey),
      'paragraphKey': serializer.toJson<String>(paragraphKey),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  BookmarkRow copyWith({
    int? id,
    String? passageKey,
    String? paragraphKey,
    int? createdAt,
  }) => BookmarkRow(
    id: id ?? this.id,
    passageKey: passageKey ?? this.passageKey,
    paragraphKey: paragraphKey ?? this.paragraphKey,
    createdAt: createdAt ?? this.createdAt,
  );
  BookmarkRow copyWithCompanion(BookmarkTableCompanion data) {
    return BookmarkRow(
      id: data.id.present ? data.id.value : this.id,
      passageKey: data.passageKey.present
          ? data.passageKey.value
          : this.passageKey,
      paragraphKey: data.paragraphKey.present
          ? data.paragraphKey.value
          : this.paragraphKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkRow(')
          ..write('id: $id, ')
          ..write('passageKey: $passageKey, ')
          ..write('paragraphKey: $paragraphKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, passageKey, paragraphKey, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarkRow &&
          other.id == this.id &&
          other.passageKey == this.passageKey &&
          other.paragraphKey == this.paragraphKey &&
          other.createdAt == this.createdAt);
}

class BookmarkTableCompanion extends UpdateCompanion<BookmarkRow> {
  final Value<int> id;
  final Value<String> passageKey;
  final Value<String> paragraphKey;
  final Value<int> createdAt;
  const BookmarkTableCompanion({
    this.id = const Value.absent(),
    this.passageKey = const Value.absent(),
    this.paragraphKey = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarkTableCompanion.insert({
    this.id = const Value.absent(),
    required String passageKey,
    required String paragraphKey,
    required int createdAt,
  }) : passageKey = Value(passageKey),
       paragraphKey = Value(paragraphKey),
       createdAt = Value(createdAt);
  static Insertable<BookmarkRow> custom({
    Expression<int>? id,
    Expression<String>? passageKey,
    Expression<String>? paragraphKey,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (passageKey != null) 'passage_key': passageKey,
      if (paragraphKey != null) 'paragraph_key': paragraphKey,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarkTableCompanion copyWith({
    Value<int>? id,
    Value<String>? passageKey,
    Value<String>? paragraphKey,
    Value<int>? createdAt,
  }) {
    return BookmarkTableCompanion(
      id: id ?? this.id,
      passageKey: passageKey ?? this.passageKey,
      paragraphKey: paragraphKey ?? this.paragraphKey,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (passageKey.present) {
      map['passage_key'] = Variable<String>(passageKey.value);
    }
    if (paragraphKey.present) {
      map['paragraph_key'] = Variable<String>(paragraphKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkTableCompanion(')
          ..write('id: $id, ')
          ..write('passageKey: $passageKey, ')
          ..write('paragraphKey: $paragraphKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressTableTable extends ReadingProgressTable
    with TableInfo<$ReadingProgressTableTable, ReadingProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _passageKeyMeta = const VerificationMeta(
    'passageKey',
  );
  @override
  late final GeneratedColumn<String> passageKey = GeneratedColumn<String>(
    'passage_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastParagraphKeyMeta = const VerificationMeta(
    'lastParagraphKey',
  );
  @override
  late final GeneratedColumn<String> lastParagraphKey = GeneratedColumn<String>(
    'last_paragraph_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSentenceKeyMeta = const VerificationMeta(
    'lastSentenceKey',
  );
  @override
  late final GeneratedColumn<String> lastSentenceKey = GeneratedColumn<String>(
    'last_sentence_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    passageKey,
    lastParagraphKey,
    lastSentenceKey,
    isRead,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('passage_key')) {
      context.handle(
        _passageKeyMeta,
        passageKey.isAcceptableOrUnknown(data['passage_key']!, _passageKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_passageKeyMeta);
    }
    if (data.containsKey('last_paragraph_key')) {
      context.handle(
        _lastParagraphKeyMeta,
        lastParagraphKey.isAcceptableOrUnknown(
          data['last_paragraph_key']!,
          _lastParagraphKeyMeta,
        ),
      );
    }
    if (data.containsKey('last_sentence_key')) {
      context.handle(
        _lastSentenceKeyMeta,
        lastSentenceKey.isAcceptableOrUnknown(
          data['last_sentence_key']!,
          _lastSentenceKeyMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {passageKey};
  @override
  ReadingProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressRow(
      passageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passage_key'],
      )!,
      lastParagraphKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_paragraph_key'],
      ),
      lastSentenceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_sentence_key'],
      ),
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReadingProgressTableTable createAlias(String alias) {
    return $ReadingProgressTableTable(attachedDatabase, alias);
  }
}

class ReadingProgressRow extends DataClass
    implements Insertable<ReadingProgressRow> {
  final String passageKey;
  final String? lastParagraphKey;
  final String? lastSentenceKey;
  final bool isRead;
  final int updatedAt;
  const ReadingProgressRow({
    required this.passageKey,
    this.lastParagraphKey,
    this.lastSentenceKey,
    required this.isRead,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['passage_key'] = Variable<String>(passageKey);
    if (!nullToAbsent || lastParagraphKey != null) {
      map['last_paragraph_key'] = Variable<String>(lastParagraphKey);
    }
    if (!nullToAbsent || lastSentenceKey != null) {
      map['last_sentence_key'] = Variable<String>(lastSentenceKey);
    }
    map['is_read'] = Variable<bool>(isRead);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  ReadingProgressTableCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressTableCompanion(
      passageKey: Value(passageKey),
      lastParagraphKey: lastParagraphKey == null && nullToAbsent
          ? const Value.absent()
          : Value(lastParagraphKey),
      lastSentenceKey: lastSentenceKey == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSentenceKey),
      isRead: Value(isRead),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReadingProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressRow(
      passageKey: serializer.fromJson<String>(json['passageKey']),
      lastParagraphKey: serializer.fromJson<String?>(json['lastParagraphKey']),
      lastSentenceKey: serializer.fromJson<String?>(json['lastSentenceKey']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'passageKey': serializer.toJson<String>(passageKey),
      'lastParagraphKey': serializer.toJson<String?>(lastParagraphKey),
      'lastSentenceKey': serializer.toJson<String?>(lastSentenceKey),
      'isRead': serializer.toJson<bool>(isRead),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  ReadingProgressRow copyWith({
    String? passageKey,
    Value<String?> lastParagraphKey = const Value.absent(),
    Value<String?> lastSentenceKey = const Value.absent(),
    bool? isRead,
    int? updatedAt,
  }) => ReadingProgressRow(
    passageKey: passageKey ?? this.passageKey,
    lastParagraphKey: lastParagraphKey.present
        ? lastParagraphKey.value
        : this.lastParagraphKey,
    lastSentenceKey: lastSentenceKey.present
        ? lastSentenceKey.value
        : this.lastSentenceKey,
    isRead: isRead ?? this.isRead,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReadingProgressRow copyWithCompanion(ReadingProgressTableCompanion data) {
    return ReadingProgressRow(
      passageKey: data.passageKey.present
          ? data.passageKey.value
          : this.passageKey,
      lastParagraphKey: data.lastParagraphKey.present
          ? data.lastParagraphKey.value
          : this.lastParagraphKey,
      lastSentenceKey: data.lastSentenceKey.present
          ? data.lastSentenceKey.value
          : this.lastSentenceKey,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressRow(')
          ..write('passageKey: $passageKey, ')
          ..write('lastParagraphKey: $lastParagraphKey, ')
          ..write('lastSentenceKey: $lastSentenceKey, ')
          ..write('isRead: $isRead, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    passageKey,
    lastParagraphKey,
    lastSentenceKey,
    isRead,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressRow &&
          other.passageKey == this.passageKey &&
          other.lastParagraphKey == this.lastParagraphKey &&
          other.lastSentenceKey == this.lastSentenceKey &&
          other.isRead == this.isRead &&
          other.updatedAt == this.updatedAt);
}

class ReadingProgressTableCompanion
    extends UpdateCompanion<ReadingProgressRow> {
  final Value<String> passageKey;
  final Value<String?> lastParagraphKey;
  final Value<String?> lastSentenceKey;
  final Value<bool> isRead;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const ReadingProgressTableCompanion({
    this.passageKey = const Value.absent(),
    this.lastParagraphKey = const Value.absent(),
    this.lastSentenceKey = const Value.absent(),
    this.isRead = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingProgressTableCompanion.insert({
    required String passageKey,
    this.lastParagraphKey = const Value.absent(),
    this.lastSentenceKey = const Value.absent(),
    this.isRead = const Value.absent(),
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : passageKey = Value(passageKey),
       updatedAt = Value(updatedAt);
  static Insertable<ReadingProgressRow> custom({
    Expression<String>? passageKey,
    Expression<String>? lastParagraphKey,
    Expression<String>? lastSentenceKey,
    Expression<bool>? isRead,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (passageKey != null) 'passage_key': passageKey,
      if (lastParagraphKey != null) 'last_paragraph_key': lastParagraphKey,
      if (lastSentenceKey != null) 'last_sentence_key': lastSentenceKey,
      if (isRead != null) 'is_read': isRead,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingProgressTableCompanion copyWith({
    Value<String>? passageKey,
    Value<String?>? lastParagraphKey,
    Value<String?>? lastSentenceKey,
    Value<bool>? isRead,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return ReadingProgressTableCompanion(
      passageKey: passageKey ?? this.passageKey,
      lastParagraphKey: lastParagraphKey ?? this.lastParagraphKey,
      lastSentenceKey: lastSentenceKey ?? this.lastSentenceKey,
      isRead: isRead ?? this.isRead,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (passageKey.present) {
      map['passage_key'] = Variable<String>(passageKey.value);
    }
    if (lastParagraphKey.present) {
      map['last_paragraph_key'] = Variable<String>(lastParagraphKey.value);
    }
    if (lastSentenceKey.present) {
      map['last_sentence_key'] = Variable<String>(lastSentenceKey.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressTableCompanion(')
          ..write('passageKey: $passageKey, ')
          ..write('lastParagraphKey: $lastParagraphKey, ')
          ..write('lastSentenceKey: $lastSentenceKey, ')
          ..write('isRead: $isRead, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
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
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
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
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final String key;
  final String value;
  const SettingsRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(key: Value(key), value: Value(value));
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
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

  SettingsRow copyWith({String? key, String? value}) =>
      SettingsRow(key: key ?? this.key, value: value ?? this.value);
  SettingsRow copyWithCompanion(SettingsTableCompanion data) {
    return SettingsRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
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
      (other is SettingsRow &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingsRow> custom({
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

  SettingsTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsTableCompanion(
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
    return (StringBuffer('SettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProgressDatabase extends GeneratedDatabase {
  _$ProgressDatabase(QueryExecutor e) : super(e);
  $ProgressDatabaseManager get managers => $ProgressDatabaseManager(this);
  late final $BookmarkTableTable bookmarkTable = $BookmarkTableTable(this);
  late final $ReadingProgressTableTable readingProgressTable =
      $ReadingProgressTableTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bookmarkTable,
    readingProgressTable,
    settingsTable,
  ];
}

typedef $$BookmarkTableTableCreateCompanionBuilder =
    BookmarkTableCompanion Function({
      Value<int> id,
      required String passageKey,
      required String paragraphKey,
      required int createdAt,
    });
typedef $$BookmarkTableTableUpdateCompanionBuilder =
    BookmarkTableCompanion Function({
      Value<int> id,
      Value<String> passageKey,
      Value<String> paragraphKey,
      Value<int> createdAt,
    });

class $$BookmarkTableTableFilterComposer
    extends Composer<_$ProgressDatabase, $BookmarkTableTable> {
  $$BookmarkTableTableFilterComposer({
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

  ColumnFilters<String> get passageKey => $composableBuilder(
    column: $table.passageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paragraphKey => $composableBuilder(
    column: $table.paragraphKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarkTableTableOrderingComposer
    extends Composer<_$ProgressDatabase, $BookmarkTableTable> {
  $$BookmarkTableTableOrderingComposer({
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

  ColumnOrderings<String> get passageKey => $composableBuilder(
    column: $table.passageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paragraphKey => $composableBuilder(
    column: $table.paragraphKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarkTableTableAnnotationComposer
    extends Composer<_$ProgressDatabase, $BookmarkTableTable> {
  $$BookmarkTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get passageKey => $composableBuilder(
    column: $table.passageKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paragraphKey => $composableBuilder(
    column: $table.paragraphKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarkTableTableTableManager
    extends
        RootTableManager<
          _$ProgressDatabase,
          $BookmarkTableTable,
          BookmarkRow,
          $$BookmarkTableTableFilterComposer,
          $$BookmarkTableTableOrderingComposer,
          $$BookmarkTableTableAnnotationComposer,
          $$BookmarkTableTableCreateCompanionBuilder,
          $$BookmarkTableTableUpdateCompanionBuilder,
          (
            BookmarkRow,
            BaseReferences<
              _$ProgressDatabase,
              $BookmarkTableTable,
              BookmarkRow
            >,
          ),
          BookmarkRow,
          PrefetchHooks Function()
        > {
  $$BookmarkTableTableTableManager(
    _$ProgressDatabase db,
    $BookmarkTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarkTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarkTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarkTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> passageKey = const Value.absent(),
                Value<String> paragraphKey = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => BookmarkTableCompanion(
                id: id,
                passageKey: passageKey,
                paragraphKey: paragraphKey,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String passageKey,
                required String paragraphKey,
                required int createdAt,
              }) => BookmarkTableCompanion.insert(
                id: id,
                passageKey: passageKey,
                paragraphKey: paragraphKey,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BookmarkTableTable, BookmarkRow>(table),
                  BaseReferences<
                    _$ProgressDatabase,
                    $BookmarkTableTable,
                    BookmarkRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarkTableTableProcessedTableManager =
    ProcessedTableManager<
      _$ProgressDatabase,
      $BookmarkTableTable,
      BookmarkRow,
      $$BookmarkTableTableFilterComposer,
      $$BookmarkTableTableOrderingComposer,
      $$BookmarkTableTableAnnotationComposer,
      $$BookmarkTableTableCreateCompanionBuilder,
      $$BookmarkTableTableUpdateCompanionBuilder,
      (
        BookmarkRow,
        BaseReferences<_$ProgressDatabase, $BookmarkTableTable, BookmarkRow>,
      ),
      BookmarkRow,
      PrefetchHooks Function()
    >;
typedef $$ReadingProgressTableTableCreateCompanionBuilder =
    ReadingProgressTableCompanion Function({
      required String passageKey,
      Value<String?> lastParagraphKey,
      Value<String?> lastSentenceKey,
      Value<bool> isRead,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$ReadingProgressTableTableUpdateCompanionBuilder =
    ReadingProgressTableCompanion Function({
      Value<String> passageKey,
      Value<String?> lastParagraphKey,
      Value<String?> lastSentenceKey,
      Value<bool> isRead,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$ReadingProgressTableTableFilterComposer
    extends Composer<_$ProgressDatabase, $ReadingProgressTableTable> {
  $$ReadingProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get passageKey => $composableBuilder(
    column: $table.passageKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastParagraphKey => $composableBuilder(
    column: $table.lastParagraphKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSentenceKey => $composableBuilder(
    column: $table.lastSentenceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingProgressTableTableOrderingComposer
    extends Composer<_$ProgressDatabase, $ReadingProgressTableTable> {
  $$ReadingProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get passageKey => $composableBuilder(
    column: $table.passageKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastParagraphKey => $composableBuilder(
    column: $table.lastParagraphKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSentenceKey => $composableBuilder(
    column: $table.lastSentenceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingProgressTableTableAnnotationComposer
    extends Composer<_$ProgressDatabase, $ReadingProgressTableTable> {
  $$ReadingProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get passageKey => $composableBuilder(
    column: $table.passageKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastParagraphKey => $composableBuilder(
    column: $table.lastParagraphKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSentenceKey => $composableBuilder(
    column: $table.lastSentenceKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ReadingProgressTableTableTableManager
    extends
        RootTableManager<
          _$ProgressDatabase,
          $ReadingProgressTableTable,
          ReadingProgressRow,
          $$ReadingProgressTableTableFilterComposer,
          $$ReadingProgressTableTableOrderingComposer,
          $$ReadingProgressTableTableAnnotationComposer,
          $$ReadingProgressTableTableCreateCompanionBuilder,
          $$ReadingProgressTableTableUpdateCompanionBuilder,
          (
            ReadingProgressRow,
            BaseReferences<
              _$ProgressDatabase,
              $ReadingProgressTableTable,
              ReadingProgressRow
            >,
          ),
          ReadingProgressRow,
          PrefetchHooks Function()
        > {
  $$ReadingProgressTableTableTableManager(
    _$ProgressDatabase db,
    $ReadingProgressTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingProgressTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingProgressTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReadingProgressTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> passageKey = const Value.absent(),
                Value<String?> lastParagraphKey = const Value.absent(),
                Value<String?> lastSentenceKey = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingProgressTableCompanion(
                passageKey: passageKey,
                lastParagraphKey: lastParagraphKey,
                lastSentenceKey: lastSentenceKey,
                isRead: isRead,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String passageKey,
                Value<String?> lastParagraphKey = const Value.absent(),
                Value<String?> lastSentenceKey = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ReadingProgressTableCompanion.insert(
                passageKey: passageKey,
                lastParagraphKey: lastParagraphKey,
                lastSentenceKey: lastSentenceKey,
                isRead: isRead,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReadingProgressTableTable, ReadingProgressRow>(
                    table,
                  ),
                  BaseReferences<
                    _$ProgressDatabase,
                    $ReadingProgressTableTable,
                    ReadingProgressRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingProgressTableTableProcessedTableManager =
    ProcessedTableManager<
      _$ProgressDatabase,
      $ReadingProgressTableTable,
      ReadingProgressRow,
      $$ReadingProgressTableTableFilterComposer,
      $$ReadingProgressTableTableOrderingComposer,
      $$ReadingProgressTableTableAnnotationComposer,
      $$ReadingProgressTableTableCreateCompanionBuilder,
      $$ReadingProgressTableTableUpdateCompanionBuilder,
      (
        ReadingProgressRow,
        BaseReferences<
          _$ProgressDatabase,
          $ReadingProgressTableTable,
          ReadingProgressRow
        >,
      ),
      ReadingProgressRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$ProgressDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
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

class $$SettingsTableTableOrderingComposer
    extends Composer<_$ProgressDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
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

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$ProgressDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
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

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$ProgressDatabase,
          $SettingsTableTable,
          SettingsRow,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<
              _$ProgressDatabase,
              $SettingsTableTable,
              SettingsRow
            >,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(
    _$ProgressDatabase db,
    $SettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsTableCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTableTable, SettingsRow>(table),
                  BaseReferences<
                    _$ProgressDatabase,
                    $SettingsTableTable,
                    SettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$ProgressDatabase,
      $SettingsTableTable,
      SettingsRow,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$ProgressDatabase, $SettingsTableTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;

class $ProgressDatabaseManager {
  final _$ProgressDatabase _db;
  $ProgressDatabaseManager(this._db);
  $$BookmarkTableTableTableManager get bookmarkTable =>
      $$BookmarkTableTableTableManager(_db, _db.bookmarkTable);
  $$ReadingProgressTableTableTableManager get readingProgressTable =>
      $$ReadingProgressTableTableTableManager(_db, _db.readingProgressTable);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
}
