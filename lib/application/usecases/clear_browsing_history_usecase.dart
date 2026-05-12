import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';

/// Deletes all browsing history rows.
final class ClearBrowsingHistoryUsecase {
  /// Creates the use case.
  const ClearBrowsingHistoryUsecase({
    required BrowsingHistoryRepository repository,
  }) : _repository = repository;

  final BrowsingHistoryRepository _repository;

  /// Executes the use case.
  Future<Result<void>> execute() {
    return _repository.deleteAll();
  }
}
