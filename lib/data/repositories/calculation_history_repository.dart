import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';

/// Repository for persisted calculation history.
final class CalculationHistoryRepository {
  /// Creates a calculation history repository.
  const CalculationHistoryRepository(this._dao);

  final CalculationHistoriesDao _dao;

  /// Inserts a calculation history row.
  Future<Result<void>> insert({
    required String id,
    required String calcType,
    required String inputsJson,
    required String resultJson,
    required DateTime calculatedAt,
  }) async {
    try {
      await _dao.insertCalculation(
        CalculationHistoriesTableCompanion.insert(
          id: id,
          calcType: calcType,
          inputs: inputsJson,
          result: resultJson,
          calculatedAt: calculatedAt,
        ),
      );
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Finds rows for a calculation type ordered by newest first.
  Future<Result<List<CalculationHistoryEntry>>> findByCalcType(
    String calcType, {
    int? limit,
  }) async {
    try {
      final rows = await _dao.findByCalcType(calcType, limit: limit);
      return Result.ok(rows.map(_toDomain).toList(growable: false));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes a row by id.
  Future<Result<void>> deleteById(String id) async {
    try {
      await _dao.deleteById(id);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes the oldest row for a calculation type.
  Future<Result<void>> deleteOldestByCalcType(String calcType) async {
    try {
      await _dao.deleteOldestByCalcType(calcType);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}

CalculationHistoryEntry _toDomain(CalculationHistoriesTableData row) {
  return CalculationHistoryEntry(
    id: row.id,
    calcType: row.calcType,
    inputsJson: row.inputs,
    resultJson: row.result,
    calculatedAt: row.calculatedAt,
  );
}
