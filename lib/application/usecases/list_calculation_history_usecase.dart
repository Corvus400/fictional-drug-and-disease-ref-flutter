import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';

const _calculationHistoryLimit = 50;

/// Lists calculation history rows.
final class ListCalculationHistoryUsecase {
  /// Creates the use case.
  const ListCalculationHistoryUsecase({
    required CalculationHistoryRepository calculationHistoryRepository,
  }) : _calculationHistoryRepository = calculationHistoryRepository;

  final CalculationHistoryRepository _calculationHistoryRepository;

  /// Executes the use case.
  Future<ListCalculationHistoryResult> execute(CalcType calcType) async {
    final result = await _calculationHistoryRepository.findByCalcType(
      calcType.storageKey,
      limit: _calculationHistoryLimit,
    );
    return switch (result) {
      Ok<List<CalculationHistoryEntry>>(:final value) when value.isEmpty =>
        const ListCalculationHistoryEmpty(),
      Ok<List<CalculationHistoryEntry>>(:final value) =>
        ListCalculationHistorySuccess(value),
      Err<List<CalculationHistoryEntry>>(:final error) =>
        ListCalculationHistoryFailure(error),
    };
  }
}

/// List calculation history result.
sealed class ListCalculationHistoryResult {
  const ListCalculationHistoryResult();
}

/// Successful list result.
final class ListCalculationHistorySuccess extends ListCalculationHistoryResult {
  /// Creates a success result.
  const ListCalculationHistorySuccess(this.entries);

  /// History entries.
  final List<CalculationHistoryEntry> entries;
}

/// Empty list result.
final class ListCalculationHistoryEmpty extends ListCalculationHistoryResult {
  /// Creates an empty result.
  const ListCalculationHistoryEmpty();
}

/// Failed list result.
final class ListCalculationHistoryFailure extends ListCalculationHistoryResult {
  /// Creates a failure result.
  const ListCalculationHistoryFailure(this.error);

  /// Application exception.
  final AppException error;
}
