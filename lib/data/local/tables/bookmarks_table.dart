part of '../app_database.dart';

/// Persisted bookmark snapshots.
@TableIndex.sql(
  'CREATE INDEX idx_bookmarks_id_prefix ON bookmarks(substr(id, 1, 5))',
)
@TableIndex.sql(
  'CREATE INDEX idx_bookmarks_date ON bookmarks(bookmarked_at DESC)',
)
class BookmarksTable extends Table {
  @override
  String get tableName => 'bookmarks';

  /// Bookmark target id.
  TextColumn get id => text()();

  /// Serialized summary snapshot JSON.
  TextColumn get snapshot => text()();

  /// Bookmark timestamp as Unix epoch milliseconds.
  IntColumn get bookmarkedAt =>
      integer().map(const DateTimeMillisConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
