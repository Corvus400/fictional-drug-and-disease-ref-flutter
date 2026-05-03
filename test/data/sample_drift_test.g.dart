// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_drift_test.dart';

// ignore_for_file: type=lint
class $SampleTableTable extends SampleTable
    with TableInfo<$SampleTableTable, SampleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SampleTableTable(this.attachedDatabase, [this._alias]);
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
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sample_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SampleTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SampleTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SampleTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SampleTableTable createAlias(String alias) {
    return $SampleTableTable(attachedDatabase, alias);
  }
}

class SampleTableData extends DataClass implements Insertable<SampleTableData> {
  final int id;
  final String value;
  const SampleTableData({required this.id, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  SampleTableCompanion toCompanion(bool nullToAbsent) {
    return SampleTableCompanion(id: Value(id), value: Value(value));
  }

  factory SampleTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SampleTableData(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  SampleTableData copyWith({int? id, String? value}) =>
      SampleTableData(id: id ?? this.id, value: value ?? this.value);
  SampleTableData copyWithCompanion(SampleTableCompanion data) {
    return SampleTableData(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SampleTableData(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SampleTableData &&
          other.id == this.id &&
          other.value == this.value);
}

class SampleTableCompanion extends UpdateCompanion<SampleTableData> {
  final Value<int> id;
  final Value<String> value;
  const SampleTableCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  SampleTableCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<SampleTableData> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  SampleTableCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return SampleTableCompanion(id: id ?? this.id, value: value ?? this.value);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SampleTableCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$SampleDb extends GeneratedDatabase {
  _$SampleDb(QueryExecutor e) : super(e);
  $SampleDbManager get managers => $SampleDbManager(this);
  late final $SampleTableTable sampleTable = $SampleTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sampleTable];
}

typedef $$SampleTableTableCreateCompanionBuilder =
    SampleTableCompanion Function({Value<int> id, required String value});
typedef $$SampleTableTableUpdateCompanionBuilder =
    SampleTableCompanion Function({Value<int> id, Value<String> value});

class $$SampleTableTableFilterComposer
    extends Composer<_$SampleDb, $SampleTableTable> {
  $$SampleTableTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SampleTableTableOrderingComposer
    extends Composer<_$SampleDb, $SampleTableTable> {
  $$SampleTableTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SampleTableTableAnnotationComposer
    extends Composer<_$SampleDb, $SampleTableTable> {
  $$SampleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SampleTableTableTableManager
    extends
        RootTableManager<
          _$SampleDb,
          $SampleTableTable,
          SampleTableData,
          $$SampleTableTableFilterComposer,
          $$SampleTableTableOrderingComposer,
          $$SampleTableTableAnnotationComposer,
          $$SampleTableTableCreateCompanionBuilder,
          $$SampleTableTableUpdateCompanionBuilder,
          (
            SampleTableData,
            BaseReferences<_$SampleDb, $SampleTableTable, SampleTableData>,
          ),
          SampleTableData,
          PrefetchHooks Function()
        > {
  $$SampleTableTableTableManager(_$SampleDb db, $SampleTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SampleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SampleTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SampleTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> value = const Value.absent(),
              }) => SampleTableCompanion(id: id, value: value),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String value}) =>
                  SampleTableCompanion.insert(id: id, value: value),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SampleTableTableProcessedTableManager =
    ProcessedTableManager<
      _$SampleDb,
      $SampleTableTable,
      SampleTableData,
      $$SampleTableTableFilterComposer,
      $$SampleTableTableOrderingComposer,
      $$SampleTableTableAnnotationComposer,
      $$SampleTableTableCreateCompanionBuilder,
      $$SampleTableTableUpdateCompanionBuilder,
      (
        SampleTableData,
        BaseReferences<_$SampleDb, $SampleTableTable, SampleTableData>,
      ),
      SampleTableData,
      PrefetchHooks Function()
    >;

class $SampleDbManager {
  final _$SampleDb _db;
  $SampleDbManager(this._db);
  $$SampleTableTableTableManager get sampleTable =>
      $$SampleTableTableTableManager(_db, _db.sampleTable);
}
