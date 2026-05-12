part of '../app_database.dart';

/// DAO for bookmark rows.
@DriftAccessor(tables: [BookmarksTable])
class BookmarksDao extends DatabaseAccessor<AppDatabase>
    with _$BookmarksDaoMixin {
  /// Creates a bookmarks DAO.
  BookmarksDao(super.attachedDatabase);

  /// Inserts a bookmark row.
  Future<void> insertBookmark(BookmarksTableCompanion companion) async {
    await into(bookmarksTable).insert(companion);
  }

  /// Finds a bookmark row by id.
  Future<BookmarksTableData?> findById(String id) {
    return (select(
      bookmarksTable,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  /// Updates the stored snapshot JSON for an existing bookmark.
  Future<void> updateSnapshot(String id, String snapshotJson) async {
    await (update(bookmarksTable)..where((table) => table.id.equals(id))).write(
      BookmarksTableCompanion(snapshot: Value(snapshotJson)),
    );
  }

  /// Deletes a bookmark by id.
  Future<void> deleteById(String id) async {
    await (delete(bookmarksTable)..where((table) => table.id.equals(id))).go();
  }

  /// Finds bookmark rows ordered by newest first.
  Future<List<BookmarksTableData>> findAll({String? idPrefix}) {
    final query = select(bookmarksTable)
      ..orderBy([
        (table) => OrderingTerm.desc(table.bookmarkedAt),
      ]);
    if (idPrefix != null) {
      query.where((table) => table.id.like('$idPrefix%'));
    }
    return query.get();
  }

  /// Watches all bookmark rows ordered by newest first.
  Stream<List<BookmarksTableData>> watchAll() {
    return (select(
      bookmarksTable,
    )..orderBy([(table) => OrderingTerm.desc(table.bookmarkedAt)])).watch();
  }

  /// Returns whether a bookmark row exists.
  Future<bool> existsById(String id) async {
    final row = await findById(id);
    return row != null;
  }

  /// Watches whether a bookmark row exists.
  Stream<bool> watchExists(String id) {
    return (select(bookmarksTable)..where((table) => table.id.equals(id)))
        .watch()
        .map((rows) => rows.isNotEmpty);
  }
}
