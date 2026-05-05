part of '../app_database.dart';

/// DAO for search history rows.
@DriftAccessor(tables: [SearchHistoriesTable])
class SearchHistoriesDao extends DatabaseAccessor<AppDatabase>
    with _$SearchHistoriesDaoMixin {
  /// Creates a search histories DAO.
  SearchHistoriesDao(super.attachedDatabase);

  /// Inserts a row after deleting an existing row with the same target/query.
  Future<void> insertWithDedup(SearchHistoriesTableCompanion companion) async {
    await transaction(() async {
      await (delete(searchHistoriesTable)..where(
            (table) =>
                table.target.equals(companion.target.value) &
                table.query.equals(companion.query.value),
          ))
          .go();
      await into(searchHistoriesTable).insert(companion);
    });
  }

  /// Finds rows for a target ordered by newest first.
  Future<List<SearchHistoriesTableData>> findByTarget(
    String target, {
    int? limit,
  }) {
    final query = select(searchHistoriesTable)
      ..where((table) => table.target.equals(target))
      ..orderBy([(table) => OrderingTerm.desc(table.searchedAt)]);
    if (limit != null) {
      query.limit(limit);
    }
    return query.get();
  }

  /// Deletes a row by id.
  Future<void> deleteById(String id) async {
    await (delete(
      searchHistoriesTable,
    )..where((table) => table.id.equals(id))).go();
  }

  /// Deletes all rows for a target.
  Future<void> clearByTarget(String target) async {
    await (delete(
      searchHistoriesTable,
    )..where((table) => table.target.equals(target))).go();
  }
}
