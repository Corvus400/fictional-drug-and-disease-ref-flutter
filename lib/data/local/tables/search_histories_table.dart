part of '../app_database.dart';

/// Persisted search history rows.
@TableIndex.sql(
  'CREATE INDEX idx_search_target_date '
  'ON search_history(target, searched_at DESC)',
)
class SearchHistoriesTable extends Table {
  @override
  String get tableName => 'search_history';

  /// Search history id.
  TextColumn get id => text()();

  /// Search target.
  TextColumn get target => text().customConstraint(
    "NOT NULL CHECK (target IN ('drug', 'disease'))",
  )();

  /// Serialized query JSON.
  TextColumn get query => text()();

  /// Search timestamp as Unix epoch milliseconds.
  IntColumn get searchedAt => integer().map(const DateTimeMillisConverter())();

  /// Total result count.
  IntColumn get totalCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
