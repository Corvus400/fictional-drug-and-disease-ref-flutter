part of '../app_database.dart';

/// Persisted browsing history rows.
@TableIndex.sql(
  'CREATE INDEX idx_browsing_date ON browsing_history(viewed_at DESC)',
)
@TableIndex.sql(
  'CREATE INDEX idx_browsing_id_prefix_date '
  'ON browsing_history(substr(id, 1, 5), viewed_at DESC)',
)
class BrowsingHistoriesTable extends Table {
  @override
  String get tableName => 'browsing_history';

  /// Viewed target id.
  TextColumn get id => text()();

  /// Viewed timestamp as Unix epoch milliseconds.
  IntColumn get viewedAt => integer().map(const DateTimeMillisConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
