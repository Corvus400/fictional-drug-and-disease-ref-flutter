import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';

/// Deletes one calculation history row.
final class DeleteCalculationHistoryUsecase {
  /// Creates the use case.
  const DeleteCalculationHistoryUsecase({
    required CalculationHistoryRepository calculationHistoryRepository,
  }) : _calculationHistoryRepository = calculationHistoryRepository;

  final CalculationHistoryRepository _calculationHistoryRepository;

  /// Executes the use case.
  Future<DeleteCalculationHistoryResult> execute(String id) async {
    final result = await _calculationHistoryRepository.deleteById(id);
    return switch (result) {
      Ok<void>() => const DeleteCalculationHistorySuccess(),
      Err<void>(:final error) => DeleteCalculationHistoryFailure(error),
    };
  }
}

/// Delete calculation history result.
sealed class DeleteCalculationHistoryResult {
  const DeleteCalculationHistoryResult();
}

/// Successful deletion.
final class DeleteCalculationHistorySuccess
    extends DeleteCalculationHistoryResult {
  /// Creates a success result.
  const DeleteCalculationHistorySuccess();
}

/// Failed deletion.
final class DeleteCalculationHistoryFailure
    extends DeleteCalculationHistoryResult {
  /// Creates a failure result.
  const DeleteCalculationHistoryFailure(this.error);

  /// Application exception.
  final AppException error;
}
