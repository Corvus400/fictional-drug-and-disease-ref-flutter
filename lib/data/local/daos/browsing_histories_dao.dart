part of '../app_database.dart';

/// DAO for browsing history rows.
@DriftAccessor(tables: [BrowsingHistoriesTable])
class BrowsingHistoriesDao extends DatabaseAccessor<AppDatabase>
    with _$BrowsingHistoriesDaoMixin {
  /// Creates a browsing histories DAO.
  BrowsingHistoriesDao(super.attachedDatabase);

  /// Inserts or updates a browsing history row.
  Future<void> upsert(BrowsingHistoriesTableCompanion companion) async {
    await into(browsingHistoriesTable).insertOnConflictUpdate(companion);
  }

  /// Finds browsing history rows ordered by newest first.
  Future<List<BrowsingHistoriesTableData>> findAll({
    String? idPrefix,
    int? limit,
  }) {
    final query = select(browsingHistoriesTable)
      ..orderBy([
        (table) => OrderingTerm.desc(table.viewedAt),
      ]);
    if (idPrefix != null) {
      query.where((table) => table.id.like('$idPrefix%'));
    }
    if (limit != null) {
      query.limit(limit);
    }
    return query.get();
  }

  /// Deletes a row by id.
  Future<void> deleteById(String id) async {
    await (delete(
      browsingHistoriesTable,
    )..where((table) => table.id.equals(id))).go();
  }

  /// Deletes all rows.
  Future<void> deleteAll() async {
    await delete(browsingHistoriesTable).go();
  }

  /// Deletes the oldest row.
  Future<void> deleteOldest() async {
    final oldest =
        await (select(browsingHistoriesTable)
              ..orderBy([(table) => OrderingTerm.asc(table.viewedAt)])
              ..limit(1))
            .getSingleOrNull();
    if (oldest != null) {
      await deleteById(oldest.id);
    }
  }

  /// Watches all rows ordered by newest first.
  Stream<List<BrowsingHistoriesTableData>> watchAll() {
    return (select(
      browsingHistoriesTable,
    )..orderBy([(table) => OrderingTerm.desc(table.viewedAt)])).watch();
  }
}
