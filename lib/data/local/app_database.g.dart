// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BookmarksTableTable extends BookmarksTable
    with TableInfo<$BookmarksTableTable, BookmarksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotMeta = const VerificationMeta(
    'snapshot',
  );
  @override
  late final GeneratedColumn<String> snapshot = GeneratedColumn<String>(
    'snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, int> bookmarkedAt =
      GeneratedColumn<int>(
        'bookmarked_at',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DateTime>($BookmarksTableTable.$converterbookmarkedAt);
  @override
  List<GeneratedColumn> get $columns => [id, snapshot, bookmarkedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookmarksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('snapshot')) {
      context.handle(
        _snapshotMeta,
        snapshot.isAcceptableOrUnknown(data['snapshot']!, _snapshotMeta),
      );
    } else if (isInserting) {
      context.missing(_snapshotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookmarksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      snapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot'],
      )!,
      bookmarkedAt: $BookmarksTableTable.$converterbookmarkedAt.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}bookmarked_at'],
        )!,
      ),
    );
  }

  @override
  $BookmarksTableTable createAlias(String alias) {
    return $BookmarksTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, int> $converterbookmarkedAt =
      const DateTimeMillisConverter();
}

class BookmarksTableData extends DataClass
    implements Insertable<BookmarksTableData> {
  /// Bookmark target id.
  final String id;

  /// Serialized summary snapshot JSON.
  final String snapshot;

  /// Bookmark timestamp as Unix epoch milliseconds.
  final DateTime bookmarkedAt;
  const BookmarksTableData({
    required this.id,
    required this.snapshot,
    required this.bookmarkedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['snapshot'] = Variable<String>(snapshot);
    {
      map['bookmarked_at'] = Variable<int>(
        $BookmarksTableTable.$converterbookmarkedAt.toSql(bookmarkedAt),
      );
    }
    return map;
  }

  BookmarksTableCompanion toCompanion(bool nullToAbsent) {
    return BookmarksTableCompanion(
      id: Value(id),
      snapshot: Value(snapshot),
      bookmarkedAt: Value(bookmarkedAt),
    );
  }

  factory BookmarksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarksTableData(
      id: serializer.fromJson<String>(json['id']),
      snapshot: serializer.fromJson<String>(json['snapshot']),
      bookmarkedAt: serializer.fromJson<DateTime>(json['bookmarkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'snapshot': serializer.toJson<String>(snapshot),
      'bookmarkedAt': serializer.toJson<DateTime>(bookmarkedAt),
    };
  }

  BookmarksTableData copyWith({
    String? id,
    String? snapshot,
    DateTime? bookmarkedAt,
  }) => BookmarksTableData(
    id: id ?? this.id,
    snapshot: snapshot ?? this.snapshot,
    bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
  );
  BookmarksTableData copyWithCompanion(BookmarksTableCompanion data) {
    return BookmarksTableData(
      id: data.id.present ? data.id.value : this.id,
      snapshot: data.snapshot.present ? data.snapshot.value : this.snapshot,
      bookmarkedAt: data.bookmarkedAt.present
          ? data.bookmarkedAt.value
          : this.bookmarkedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksTableData(')
          ..write('id: $id, ')
          ..write('snapshot: $snapshot, ')
          ..write('bookmarkedAt: $bookmarkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, snapshot, bookmarkedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarksTableData &&
          other.id == this.id &&
          other.snapshot == this.snapshot &&
          other.bookmarkedAt == this.bookmarkedAt);
}

class BookmarksTableCompanion extends UpdateCompanion<BookmarksTableData> {
  final Value<String> id;
  final Value<String> snapshot;
  final Value<DateTime> bookmarkedAt;
  final Value<int> rowid;
  const BookmarksTableCompanion({
    this.id = const Value.absent(),
    this.snapshot = const Value.absent(),
    this.bookmarkedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksTableCompanion.insert({
    required String id,
    required String snapshot,
    required DateTime bookmarkedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       snapshot = Value(snapshot),
       bookmarkedAt = Value(bookmarkedAt);
  static Insertable<BookmarksTableData> custom({
    Expression<String>? id,
    Expression<String>? snapshot,
    Expression<int>? bookmarkedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (snapshot != null) 'snapshot': snapshot,
      if (bookmarkedAt != null) 'bookmarked_at': bookmarkedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? snapshot,
    Value<DateTime>? bookmarkedAt,
    Value<int>? rowid,
  }) {
    return BookmarksTableCompanion(
      id: id ?? this.id,
      snapshot: snapshot ?? this.snapshot,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (snapshot.present) {
      map['snapshot'] = Variable<String>(snapshot.value);
    }
    if (bookmarkedAt.present) {
      map['bookmarked_at'] = Variable<int>(
        $BookmarksTableTable.$converterbookmarkedAt.toSql(bookmarkedAt.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksTableCompanion(')
          ..write('id: $id, ')
          ..write('snapshot: $snapshot, ')
          ..write('bookmarkedAt: $bookmarkedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrowsingHistoriesTableTable extends BrowsingHistoriesTable
    with TableInfo<$BrowsingHistoriesTableTable, BrowsingHistoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrowsingHistoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, int> viewedAt =
      GeneratedColumn<int>(
        'viewed_at',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DateTime>(
        $BrowsingHistoriesTableTable.$converterviewedAt,
      );
  @override
  List<GeneratedColumn> get $columns => [id, viewedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'browsing_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrowsingHistoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BrowsingHistoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrowsingHistoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      viewedAt: $BrowsingHistoriesTableTable.$converterviewedAt.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}viewed_at'],
        )!,
      ),
    );
  }

  @override
  $BrowsingHistoriesTableTable createAlias(String alias) {
    return $BrowsingHistoriesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, int> $converterviewedAt =
      const DateTimeMillisConverter();
}

class BrowsingHistoriesTableData extends DataClass
    implements Insertable<BrowsingHistoriesTableData> {
  /// Viewed target id.
  final String id;

  /// Viewed timestamp as Unix epoch milliseconds.
  final DateTime viewedAt;
  const BrowsingHistoriesTableData({required this.id, required this.viewedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['viewed_at'] = Variable<int>(
        $BrowsingHistoriesTableTable.$converterviewedAt.toSql(viewedAt),
      );
    }
    return map;
  }

  BrowsingHistoriesTableCompanion toCompanion(bool nullToAbsent) {
    return BrowsingHistoriesTableCompanion(
      id: Value(id),
      viewedAt: Value(viewedAt),
    );
  }

  factory BrowsingHistoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrowsingHistoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      viewedAt: serializer.fromJson<DateTime>(json['viewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'viewedAt': serializer.toJson<DateTime>(viewedAt),
    };
  }

  BrowsingHistoriesTableData copyWith({String? id, DateTime? viewedAt}) =>
      BrowsingHistoriesTableData(
        id: id ?? this.id,
        viewedAt: viewedAt ?? this.viewedAt,
      );
  BrowsingHistoriesTableData copyWithCompanion(
    BrowsingHistoriesTableCompanion data,
  ) {
    return BrowsingHistoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrowsingHistoriesTableData(')
          ..write('id: $id, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, viewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrowsingHistoriesTableData &&
          other.id == this.id &&
          other.viewedAt == this.viewedAt);
}

class BrowsingHistoriesTableCompanion
    extends UpdateCompanion<BrowsingHistoriesTableData> {
  final Value<String> id;
  final Value<DateTime> viewedAt;
  final Value<int> rowid;
  const BrowsingHistoriesTableCompanion({
    this.id = const Value.absent(),
    this.viewedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrowsingHistoriesTableCompanion.insert({
    required String id,
    required DateTime viewedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       viewedAt = Value(viewedAt);
  static Insertable<BrowsingHistoriesTableData> custom({
    Expression<String>? id,
    Expression<int>? viewedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (viewedAt != null) 'viewed_at': viewedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrowsingHistoriesTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? viewedAt,
    Value<int>? rowid,
  }) {
    return BrowsingHistoriesTableCompanion(
      id: id ?? this.id,
      viewedAt: viewedAt ?? this.viewedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<int>(
        $BrowsingHistoriesTableTable.$converterviewedAt.toSql(viewedAt.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrowsingHistoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('viewedAt: $viewedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoriesTableTable extends SearchHistoriesTable
    with TableInfo<$SearchHistoriesTableTable, SearchHistoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (target IN (\'drug\', \'disease\'))',
  );
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, int> searchedAt =
      GeneratedColumn<int>(
        'searched_at',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DateTime>(
        $SearchHistoriesTableTable.$convertersearchedAt,
      );
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    target,
    query,
    searchedAt,
    totalCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('query')) {
      context.handle(
        _queryMeta,
        query.isAcceptableOrUnknown(data['query']!, _queryMeta),
      );
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target'],
      )!,
      query: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query'],
      )!,
      searchedAt: $SearchHistoriesTableTable.$convertersearchedAt.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}searched_at'],
        )!,
      ),
      totalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_count'],
      )!,
    );
  }

  @override
  $SearchHistoriesTableTable createAlias(String alias) {
    return $SearchHistoriesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, int> $convertersearchedAt =
      const DateTimeMillisConverter();
}

class SearchHistoriesTableData extends DataClass
    implements Insertable<SearchHistoriesTableData> {
  /// Search history id.
  final String id;

  /// Search target.
  final String target;

  /// Serialized query JSON.
  final String query;

  /// Search timestamp as Unix epoch milliseconds.
  final DateTime searchedAt;

  /// Total result count.
  final int totalCount;
  const SearchHistoriesTableData({
    required this.id,
    required this.target,
    required this.query,
    required this.searchedAt,
    required this.totalCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['target'] = Variable<String>(target);
    map['query'] = Variable<String>(query);
    {
      map['searched_at'] = Variable<int>(
        $SearchHistoriesTableTable.$convertersearchedAt.toSql(searchedAt),
      );
    }
    map['total_count'] = Variable<int>(totalCount);
    return map;
  }

  SearchHistoriesTableCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoriesTableCompanion(
      id: Value(id),
      target: Value(target),
      query: Value(query),
      searchedAt: Value(searchedAt),
      totalCount: Value(totalCount),
    );
  }

  factory SearchHistoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      target: serializer.fromJson<String>(json['target']),
      query: serializer.fromJson<String>(json['query']),
      searchedAt: serializer.fromJson<DateTime>(json['searchedAt']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'target': serializer.toJson<String>(target),
      'query': serializer.toJson<String>(query),
      'searchedAt': serializer.toJson<DateTime>(searchedAt),
      'totalCount': serializer.toJson<int>(totalCount),
    };
  }

  SearchHistoriesTableData copyWith({
    String? id,
    String? target,
    String? query,
    DateTime? searchedAt,
    int? totalCount,
  }) => SearchHistoriesTableData(
    id: id ?? this.id,
    target: target ?? this.target,
    query: query ?? this.query,
    searchedAt: searchedAt ?? this.searchedAt,
    totalCount: totalCount ?? this.totalCount,
  );
  SearchHistoriesTableData copyWithCompanion(
    SearchHistoriesTableCompanion data,
  ) {
    return SearchHistoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      target: data.target.present ? data.target.value : this.target,
      query: data.query.present ? data.query.value : this.query,
      searchedAt: data.searchedAt.present
          ? data.searchedAt.value
          : this.searchedAt,
      totalCount: data.totalCount.present
          ? data.totalCount.value
          : this.totalCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoriesTableData(')
          ..write('id: $id, ')
          ..write('target: $target, ')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt, ')
          ..write('totalCount: $totalCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, target, query, searchedAt, totalCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistoriesTableData &&
          other.id == this.id &&
          other.target == this.target &&
          other.query == this.query &&
          other.searchedAt == this.searchedAt &&
          other.totalCount == this.totalCount);
}

class SearchHistoriesTableCompanion
    extends UpdateCompanion<SearchHistoriesTableData> {
  final Value<String> id;
  final Value<String> target;
  final Value<String> query;
  final Value<DateTime> searchedAt;
  final Value<int> totalCount;
  final Value<int> rowid;
  const SearchHistoriesTableCompanion({
    this.id = const Value.absent(),
    this.target = const Value.absent(),
    this.query = const Value.absent(),
    this.searchedAt = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchHistoriesTableCompanion.insert({
    required String id,
    required String target,
    required String query,
    required DateTime searchedAt,
    required int totalCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       target = Value(target),
       query = Value(query),
       searchedAt = Value(searchedAt),
       totalCount = Value(totalCount);
  static Insertable<SearchHistoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? target,
    Expression<String>? query,
    Expression<int>? searchedAt,
    Expression<int>? totalCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (target != null) 'target': target,
      if (query != null) 'query': query,
      if (searchedAt != null) 'searched_at': searchedAt,
      if (totalCount != null) 'total_count': totalCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchHistoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? target,
    Value<String>? query,
    Value<DateTime>? searchedAt,
    Value<int>? totalCount,
    Value<int>? rowid,
  }) {
    return SearchHistoriesTableCompanion(
      id: id ?? this.id,
      target: target ?? this.target,
      query: query ?? this.query,
      searchedAt: searchedAt ?? this.searchedAt,
      totalCount: totalCount ?? this.totalCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (searchedAt.present) {
      map['searched_at'] = Variable<int>(
        $SearchHistoriesTableTable.$convertersearchedAt.toSql(searchedAt.value),
      );
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('target: $target, ')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt, ')
          ..write('totalCount: $totalCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalculationHistoriesTableTable extends CalculationHistoriesTable
    with
        TableInfo<
          $CalculationHistoriesTableTable,
          CalculationHistoriesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalculationHistoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calcTypeMeta = const VerificationMeta(
    'calcType',
  );
  @override
  late final GeneratedColumn<String> calcType = GeneratedColumn<String>(
    'calc_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (calc_type IN (\'bmi\', \'egfr\', \'crcl\'))',
  );
  static const VerificationMeta _inputsMeta = const VerificationMeta('inputs');
  @override
  late final GeneratedColumn<String> inputs = GeneratedColumn<String>(
    'inputs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, int> calculatedAt =
      GeneratedColumn<int>(
        'calculated_at',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DateTime>(
        $CalculationHistoriesTableTable.$convertercalculatedAt,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    calcType,
    inputs,
    result,
    calculatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calculation_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalculationHistoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('calc_type')) {
      context.handle(
        _calcTypeMeta,
        calcType.isAcceptableOrUnknown(data['calc_type']!, _calcTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_calcTypeMeta);
    }
    if (data.containsKey('inputs')) {
      context.handle(
        _inputsMeta,
        inputs.isAcceptableOrUnknown(data['inputs']!, _inputsMeta),
      );
    } else if (isInserting) {
      context.missing(_inputsMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalculationHistoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalculationHistoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      calcType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calc_type'],
      )!,
      inputs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inputs'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      calculatedAt: $CalculationHistoriesTableTable.$convertercalculatedAt
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}calculated_at'],
            )!,
          ),
    );
  }

  @override
  $CalculationHistoriesTableTable createAlias(String alias) {
    return $CalculationHistoriesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, int> $convertercalculatedAt =
      const DateTimeMillisConverter();
}

class CalculationHistoriesTableData extends DataClass
    implements Insertable<CalculationHistoriesTableData> {
  /// Calculation history id.
  final String id;

  /// Calculation type.
  final String calcType;

  /// Serialized inputs JSON.
  final String inputs;

  /// Serialized result JSON.
  final String result;

  /// Calculation timestamp as Unix epoch milliseconds.
  final DateTime calculatedAt;
  const CalculationHistoriesTableData({
    required this.id,
    required this.calcType,
    required this.inputs,
    required this.result,
    required this.calculatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['calc_type'] = Variable<String>(calcType);
    map['inputs'] = Variable<String>(inputs);
    map['result'] = Variable<String>(result);
    {
      map['calculated_at'] = Variable<int>(
        $CalculationHistoriesTableTable.$convertercalculatedAt.toSql(
          calculatedAt,
        ),
      );
    }
    return map;
  }

  CalculationHistoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CalculationHistoriesTableCompanion(
      id: Value(id),
      calcType: Value(calcType),
      inputs: Value(inputs),
      result: Value(result),
      calculatedAt: Value(calculatedAt),
    );
  }

  factory CalculationHistoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalculationHistoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      calcType: serializer.fromJson<String>(json['calcType']),
      inputs: serializer.fromJson<String>(json['inputs']),
      result: serializer.fromJson<String>(json['result']),
      calculatedAt: serializer.fromJson<DateTime>(json['calculatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'calcType': serializer.toJson<String>(calcType),
      'inputs': serializer.toJson<String>(inputs),
      'result': serializer.toJson<String>(result),
      'calculatedAt': serializer.toJson<DateTime>(calculatedAt),
    };
  }

  CalculationHistoriesTableData copyWith({
    String? id,
    String? calcType,
    String? inputs,
    String? result,
    DateTime? calculatedAt,
  }) => CalculationHistoriesTableData(
    id: id ?? this.id,
    calcType: calcType ?? this.calcType,
    inputs: inputs ?? this.inputs,
    result: result ?? this.result,
    calculatedAt: calculatedAt ?? this.calculatedAt,
  );
  CalculationHistoriesTableData copyWithCompanion(
    CalculationHistoriesTableCompanion data,
  ) {
    return CalculationHistoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      calcType: data.calcType.present ? data.calcType.value : this.calcType,
      inputs: data.inputs.present ? data.inputs.value : this.inputs,
      result: data.result.present ? data.result.value : this.result,
      calculatedAt: data.calculatedAt.present
          ? data.calculatedAt.value
          : this.calculatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalculationHistoriesTableData(')
          ..write('id: $id, ')
          ..write('calcType: $calcType, ')
          ..write('inputs: $inputs, ')
          ..write('result: $result, ')
          ..write('calculatedAt: $calculatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, calcType, inputs, result, calculatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalculationHistoriesTableData &&
          other.id == this.id &&
          other.calcType == this.calcType &&
          other.inputs == this.inputs &&
          other.result == this.result &&
          other.calculatedAt == this.calculatedAt);
}

class CalculationHistoriesTableCompanion
    extends UpdateCompanion<CalculationHistoriesTableData> {
  final Value<String> id;
  final Value<String> calcType;
  final Value<String> inputs;
  final Value<String> result;
  final Value<DateTime> calculatedAt;
  final Value<int> rowid;
  const CalculationHistoriesTableCompanion({
    this.id = const Value.absent(),
    this.calcType = const Value.absent(),
    this.inputs = const Value.absent(),
    this.result = const Value.absent(),
    this.calculatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalculationHistoriesTableCompanion.insert({
    required String id,
    required String calcType,
    required String inputs,
    required String result,
    required DateTime calculatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       calcType = Value(calcType),
       inputs = Value(inputs),
       result = Value(result),
       calculatedAt = Value(calculatedAt);
  static Insertable<CalculationHistoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? calcType,
    Expression<String>? inputs,
    Expression<String>? result,
    Expression<int>? calculatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (calcType != null) 'calc_type': calcType,
      if (inputs != null) 'inputs': inputs,
      if (result != null) 'result': result,
      if (calculatedAt != null) 'calculated_at': calculatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalculationHistoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? calcType,
    Value<String>? inputs,
    Value<String>? result,
    Value<DateTime>? calculatedAt,
    Value<int>? rowid,
  }) {
    return CalculationHistoriesTableCompanion(
      id: id ?? this.id,
      calcType: calcType ?? this.calcType,
      inputs: inputs ?? this.inputs,
      result: result ?? this.result,
      calculatedAt: calculatedAt ?? this.calculatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (calcType.present) {
      map['calc_type'] = Variable<String>(calcType.value);
    }
    if (inputs.present) {
      map['inputs'] = Variable<String>(inputs.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (calculatedAt.present) {
      map['calculated_at'] = Variable<int>(
        $CalculationHistoriesTableTable.$convertercalculatedAt.toSql(
          calculatedAt.value,
        ),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalculationHistoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('calcType: $calcType, ')
          ..write('inputs: $inputs, ')
          ..write('result: $result, ')
          ..write('calculatedAt: $calculatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BookmarksTableTable bookmarksTable = $BookmarksTableTable(this);
  late final $BrowsingHistoriesTableTable browsingHistoriesTable =
      $BrowsingHistoriesTableTable(this);
  late final $SearchHistoriesTableTable searchHistoriesTable =
      $SearchHistoriesTableTable(this);
  late final $CalculationHistoriesTableTable calculationHistoriesTable =
      $CalculationHistoriesTableTable(this);
  late final Index idxBookmarksIdPrefix = Index(
    'idx_bookmarks_id_prefix',
    'CREATE INDEX idx_bookmarks_id_prefix ON bookmarks (substr(id, 1, 5))',
  );
  late final Index idxBookmarksDate = Index(
    'idx_bookmarks_date',
    'CREATE INDEX idx_bookmarks_date ON bookmarks (bookmarked_at DESC)',
  );
  late final Index idxBrowsingDate = Index(
    'idx_browsing_date',
    'CREATE INDEX idx_browsing_date ON browsing_history (viewed_at DESC)',
  );
  late final Index idxBrowsingIdPrefixDate = Index(
    'idx_browsing_id_prefix_date',
    'CREATE INDEX idx_browsing_id_prefix_date ON browsing_history (substr(id, 1, 5), viewed_at DESC)',
  );
  late final Index idxSearchTargetDate = Index(
    'idx_search_target_date',
    'CREATE INDEX idx_search_target_date ON search_history (target, searched_at DESC)',
  );
  late final Index idxCalcTypeDate = Index(
    'idx_calc_type_date',
    'CREATE INDEX idx_calc_type_date ON calculation_history (calc_type, calculated_at DESC)',
  );
  late final BookmarksDao bookmarksDao = BookmarksDao(this as AppDatabase);
  late final BrowsingHistoriesDao browsingHistoriesDao = BrowsingHistoriesDao(
    this as AppDatabase,
  );
  late final SearchHistoriesDao searchHistoriesDao = SearchHistoriesDao(
    this as AppDatabase,
  );
  late final CalculationHistoriesDao calculationHistoriesDao =
      CalculationHistoriesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bookmarksTable,
    browsingHistoriesTable,
    searchHistoriesTable,
    calculationHistoriesTable,
    idxBookmarksIdPrefix,
    idxBookmarksDate,
    idxBrowsingDate,
    idxBrowsingIdPrefixDate,
    idxSearchTargetDate,
    idxCalcTypeDate,
  ];
}

typedef $$BookmarksTableTableCreateCompanionBuilder =
    BookmarksTableCompanion Function({
      required String id,
      required String snapshot,
      required DateTime bookmarkedAt,
      Value<int> rowid,
    });
typedef $$BookmarksTableTableUpdateCompanionBuilder =
    BookmarksTableCompanion Function({
      Value<String> id,
      Value<String> snapshot,
      Value<DateTime> bookmarkedAt,
      Value<int> rowid,
    });

class $$BookmarksTableTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTableTable> {
  $$BookmarksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshot => $composableBuilder(
    column: $table.snapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, int> get bookmarkedAt =>
      $composableBuilder(
        column: $table.bookmarkedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$BookmarksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTableTable> {
  $$BookmarksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshot => $composableBuilder(
    column: $table.snapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookmarkedAt => $composableBuilder(
    column: $table.bookmarkedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTableTable> {
  $$BookmarksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get snapshot =>
      $composableBuilder(column: $table.snapshot, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, int> get bookmarkedAt =>
      $composableBuilder(
        column: $table.bookmarkedAt,
        builder: (column) => column,
      );
}

class $$BookmarksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTableTable,
          BookmarksTableData,
          $$BookmarksTableTableFilterComposer,
          $$BookmarksTableTableOrderingComposer,
          $$BookmarksTableTableAnnotationComposer,
          $$BookmarksTableTableCreateCompanionBuilder,
          $$BookmarksTableTableUpdateCompanionBuilder,
          (
            BookmarksTableData,
            BaseReferences<
              _$AppDatabase,
              $BookmarksTableTable,
              BookmarksTableData
            >,
          ),
          BookmarksTableData,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableTableManager(
    _$AppDatabase db,
    $BookmarksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> snapshot = const Value.absent(),
                Value<DateTime> bookmarkedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksTableCompanion(
                id: id,
                snapshot: snapshot,
                bookmarkedAt: bookmarkedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String snapshot,
                required DateTime bookmarkedAt,
                Value<int> rowid = const Value.absent(),
              }) => BookmarksTableCompanion.insert(
                id: id,
                snapshot: snapshot,
                bookmarkedAt: bookmarkedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTableTable,
      BookmarksTableData,
      $$BookmarksTableTableFilterComposer,
      $$BookmarksTableTableOrderingComposer,
      $$BookmarksTableTableAnnotationComposer,
      $$BookmarksTableTableCreateCompanionBuilder,
      $$BookmarksTableTableUpdateCompanionBuilder,
      (
        BookmarksTableData,
        BaseReferences<_$AppDatabase, $BookmarksTableTable, BookmarksTableData>,
      ),
      BookmarksTableData,
      PrefetchHooks Function()
    >;
typedef $$BrowsingHistoriesTableTableCreateCompanionBuilder =
    BrowsingHistoriesTableCompanion Function({
      required String id,
      required DateTime viewedAt,
      Value<int> rowid,
    });
typedef $$BrowsingHistoriesTableTableUpdateCompanionBuilder =
    BrowsingHistoriesTableCompanion Function({
      Value<String> id,
      Value<DateTime> viewedAt,
      Value<int> rowid,
    });

class $$BrowsingHistoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $BrowsingHistoriesTableTable> {
  $$BrowsingHistoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, int> get viewedAt =>
      $composableBuilder(
        column: $table.viewedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$BrowsingHistoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BrowsingHistoriesTableTable> {
  $$BrowsingHistoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrowsingHistoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrowsingHistoriesTableTable> {
  $$BrowsingHistoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, int> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);
}

class $$BrowsingHistoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrowsingHistoriesTableTable,
          BrowsingHistoriesTableData,
          $$BrowsingHistoriesTableTableFilterComposer,
          $$BrowsingHistoriesTableTableOrderingComposer,
          $$BrowsingHistoriesTableTableAnnotationComposer,
          $$BrowsingHistoriesTableTableCreateCompanionBuilder,
          $$BrowsingHistoriesTableTableUpdateCompanionBuilder,
          (
            BrowsingHistoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $BrowsingHistoriesTableTable,
              BrowsingHistoriesTableData
            >,
          ),
          BrowsingHistoriesTableData,
          PrefetchHooks Function()
        > {
  $$BrowsingHistoriesTableTableTableManager(
    _$AppDatabase db,
    $BrowsingHistoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrowsingHistoriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BrowsingHistoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BrowsingHistoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> viewedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrowsingHistoriesTableCompanion(
                id: id,
                viewedAt: viewedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime viewedAt,
                Value<int> rowid = const Value.absent(),
              }) => BrowsingHistoriesTableCompanion.insert(
                id: id,
                viewedAt: viewedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BrowsingHistoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrowsingHistoriesTableTable,
      BrowsingHistoriesTableData,
      $$BrowsingHistoriesTableTableFilterComposer,
      $$BrowsingHistoriesTableTableOrderingComposer,
      $$BrowsingHistoriesTableTableAnnotationComposer,
      $$BrowsingHistoriesTableTableCreateCompanionBuilder,
      $$BrowsingHistoriesTableTableUpdateCompanionBuilder,
      (
        BrowsingHistoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $BrowsingHistoriesTableTable,
          BrowsingHistoriesTableData
        >,
      ),
      BrowsingHistoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$SearchHistoriesTableTableCreateCompanionBuilder =
    SearchHistoriesTableCompanion Function({
      required String id,
      required String target,
      required String query,
      required DateTime searchedAt,
      required int totalCount,
      Value<int> rowid,
    });
typedef $$SearchHistoriesTableTableUpdateCompanionBuilder =
    SearchHistoriesTableCompanion Function({
      Value<String> id,
      Value<String> target,
      Value<String> query,
      Value<DateTime> searchedAt,
      Value<int> totalCount,
      Value<int> rowid,
    });

class $$SearchHistoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistoriesTableTable> {
  $$SearchHistoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, int> get searchedAt =>
      $composableBuilder(
        column: $table.searchedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchHistoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistoriesTableTable> {
  $$SearchHistoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get searchedAt => $composableBuilder(
    column: $table.searchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchHistoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistoriesTableTable> {
  $$SearchHistoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, int> get searchedAt =>
      $composableBuilder(
        column: $table.searchedAt,
        builder: (column) => column,
      );

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );
}

class $$SearchHistoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchHistoriesTableTable,
          SearchHistoriesTableData,
          $$SearchHistoriesTableTableFilterComposer,
          $$SearchHistoriesTableTableOrderingComposer,
          $$SearchHistoriesTableTableAnnotationComposer,
          $$SearchHistoriesTableTableCreateCompanionBuilder,
          $$SearchHistoriesTableTableUpdateCompanionBuilder,
          (
            SearchHistoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $SearchHistoriesTableTable,
              SearchHistoriesTableData
            >,
          ),
          SearchHistoriesTableData,
          PrefetchHooks Function()
        > {
  $$SearchHistoriesTableTableTableManager(
    _$AppDatabase db,
    $SearchHistoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SearchHistoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> target = const Value.absent(),
                Value<String> query = const Value.absent(),
                Value<DateTime> searchedAt = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchHistoriesTableCompanion(
                id: id,
                target: target,
                query: query,
                searchedAt: searchedAt,
                totalCount: totalCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String target,
                required String query,
                required DateTime searchedAt,
                required int totalCount,
                Value<int> rowid = const Value.absent(),
              }) => SearchHistoriesTableCompanion.insert(
                id: id,
                target: target,
                query: query,
                searchedAt: searchedAt,
                totalCount: totalCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchHistoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchHistoriesTableTable,
      SearchHistoriesTableData,
      $$SearchHistoriesTableTableFilterComposer,
      $$SearchHistoriesTableTableOrderingComposer,
      $$SearchHistoriesTableTableAnnotationComposer,
      $$SearchHistoriesTableTableCreateCompanionBuilder,
      $$SearchHistoriesTableTableUpdateCompanionBuilder,
      (
        SearchHistoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $SearchHistoriesTableTable,
          SearchHistoriesTableData
        >,
      ),
      SearchHistoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$CalculationHistoriesTableTableCreateCompanionBuilder =
    CalculationHistoriesTableCompanion Function({
      required String id,
      required String calcType,
      required String inputs,
      required String result,
      required DateTime calculatedAt,
      Value<int> rowid,
    });
typedef $$CalculationHistoriesTableTableUpdateCompanionBuilder =
    CalculationHistoriesTableCompanion Function({
      Value<String> id,
      Value<String> calcType,
      Value<String> inputs,
      Value<String> result,
      Value<DateTime> calculatedAt,
      Value<int> rowid,
    });

class $$CalculationHistoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CalculationHistoriesTableTable> {
  $$CalculationHistoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calcType => $composableBuilder(
    column: $table.calcType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputs => $composableBuilder(
    column: $table.inputs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, int> get calculatedAt =>
      $composableBuilder(
        column: $table.calculatedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$CalculationHistoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CalculationHistoriesTableTable> {
  $$CalculationHistoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calcType => $composableBuilder(
    column: $table.calcType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputs => $composableBuilder(
    column: $table.inputs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalculationHistoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalculationHistoriesTableTable> {
  $$CalculationHistoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get calcType =>
      $composableBuilder(column: $table.calcType, builder: (column) => column);

  GeneratedColumn<String> get inputs =>
      $composableBuilder(column: $table.inputs, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, int> get calculatedAt =>
      $composableBuilder(
        column: $table.calculatedAt,
        builder: (column) => column,
      );
}

class $$CalculationHistoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalculationHistoriesTableTable,
          CalculationHistoriesTableData,
          $$CalculationHistoriesTableTableFilterComposer,
          $$CalculationHistoriesTableTableOrderingComposer,
          $$CalculationHistoriesTableTableAnnotationComposer,
          $$CalculationHistoriesTableTableCreateCompanionBuilder,
          $$CalculationHistoriesTableTableUpdateCompanionBuilder,
          (
            CalculationHistoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $CalculationHistoriesTableTable,
              CalculationHistoriesTableData
            >,
          ),
          CalculationHistoriesTableData,
          PrefetchHooks Function()
        > {
  $$CalculationHistoriesTableTableTableManager(
    _$AppDatabase db,
    $CalculationHistoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalculationHistoriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CalculationHistoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CalculationHistoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> calcType = const Value.absent(),
                Value<String> inputs = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<DateTime> calculatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalculationHistoriesTableCompanion(
                id: id,
                calcType: calcType,
                inputs: inputs,
                result: result,
                calculatedAt: calculatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String calcType,
                required String inputs,
                required String result,
                required DateTime calculatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CalculationHistoriesTableCompanion.insert(
                id: id,
                calcType: calcType,
                inputs: inputs,
                result: result,
                calculatedAt: calculatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalculationHistoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalculationHistoriesTableTable,
      CalculationHistoriesTableData,
      $$CalculationHistoriesTableTableFilterComposer,
      $$CalculationHistoriesTableTableOrderingComposer,
      $$CalculationHistoriesTableTableAnnotationComposer,
      $$CalculationHistoriesTableTableCreateCompanionBuilder,
      $$CalculationHistoriesTableTableUpdateCompanionBuilder,
      (
        CalculationHistoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $CalculationHistoriesTableTable,
          CalculationHistoriesTableData
        >,
      ),
      CalculationHistoriesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BookmarksTableTableTableManager get bookmarksTable =>
      $$BookmarksTableTableTableManager(_db, _db.bookmarksTable);
  $$BrowsingHistoriesTableTableTableManager get browsingHistoriesTable =>
      $$BrowsingHistoriesTableTableTableManager(
        _db,
        _db.browsingHistoriesTable,
      );
  $$SearchHistoriesTableTableTableManager get searchHistoriesTable =>
      $$SearchHistoriesTableTableTableManager(_db, _db.searchHistoriesTable);
  $$CalculationHistoriesTableTableTableManager get calculationHistoriesTable =>
      $$CalculationHistoriesTableTableTableManager(
        _db,
        _db.calculationHistoriesTable,
      );
}

mixin _$BookmarksDaoMixin on DatabaseAccessor<AppDatabase> {
  $BookmarksTableTable get bookmarksTable => attachedDatabase.bookmarksTable;
  BookmarksDaoManager get managers => BookmarksDaoManager(this);
}

class BookmarksDaoManager {
  final _$BookmarksDaoMixin _db;
  BookmarksDaoManager(this._db);
  $$BookmarksTableTableTableManager get bookmarksTable =>
      $$BookmarksTableTableTableManager(
        _db.attachedDatabase,
        _db.bookmarksTable,
      );
}

mixin _$BrowsingHistoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $BrowsingHistoriesTableTable get browsingHistoriesTable =>
      attachedDatabase.browsingHistoriesTable;
  BrowsingHistoriesDaoManager get managers => BrowsingHistoriesDaoManager(this);
}

class BrowsingHistoriesDaoManager {
  final _$BrowsingHistoriesDaoMixin _db;
  BrowsingHistoriesDaoManager(this._db);
  $$BrowsingHistoriesTableTableTableManager get browsingHistoriesTable =>
      $$BrowsingHistoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.browsingHistoriesTable,
      );
}

mixin _$SearchHistoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SearchHistoriesTableTable get searchHistoriesTable =>
      attachedDatabase.searchHistoriesTable;
  SearchHistoriesDaoManager get managers => SearchHistoriesDaoManager(this);
}

class SearchHistoriesDaoManager {
  final _$SearchHistoriesDaoMixin _db;
  SearchHistoriesDaoManager(this._db);
  $$SearchHistoriesTableTableTableManager get searchHistoriesTable =>
      $$SearchHistoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.searchHistoriesTable,
      );
}

mixin _$CalculationHistoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $CalculationHistoriesTableTable get calculationHistoriesTable =>
      attachedDatabase.calculationHistoriesTable;
  CalculationHistoriesDaoManager get managers =>
      CalculationHistoriesDaoManager(this);
}

class CalculationHistoriesDaoManager {
  final _$CalculationHistoriesDaoMixin _db;
  CalculationHistoriesDaoManager(this._db);
  $$CalculationHistoriesTableTableTableManager get calculationHistoriesTable =>
      $$CalculationHistoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.calculationHistoriesTable,
      );
}
