part of '../app_database.dart';

/// DAO for calculation history rows.
@DriftAccessor(tables: [CalculationHistoriesTable])
class CalculationHistoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CalculationHistoriesDaoMixin {
  /// Creates a calculation histories DAO.
  CalculationHistoriesDao(super.attachedDatabase);

  /// Inserts a calculation history row.
  Future<void> insertCalculation(
    CalculationHistoriesTableCompanion companion,
  ) async {
    await into(calculationHistoriesTable).insert(companion);
  }

  /// Finds rows for a calculation type ordered by newest first.
  Future<List<CalculationHistoriesTableData>> findByCalcType(
    String calcType, {
    int? limit,
  }) {
    final query = select(calculationHistoriesTable)
      ..where((table) => table.calcType.equals(calcType))
      ..orderBy([(table) => OrderingTerm.desc(table.calculatedAt)]);
    if (limit != null) {
      query.limit(limit);
    }
    return query.get();
  }

  /// Deletes a row by id.
  Future<void> deleteById(String id) async {
    await (delete(
      calculationHistoriesTable,
    )..where((table) => table.id.equals(id))).go();
  }

  /// Deletes the oldest row for a calculation type.
  Future<void> deleteOldestByCalcType(String calcType) async {
    final oldest =
        await (select(calculationHistoriesTable)
              ..where((table) => table.calcType.equals(calcType))
              ..orderBy([(table) => OrderingTerm.asc(table.calculatedAt)])
              ..limit(1))
            .getSingleOrNull();
    if (oldest != null) {
      await deleteById(oldest.id);
    }
  }
}
