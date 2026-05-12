import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';

/// Deletes one browsing history row.
final class DeleteBrowsingHistoryUsecase {
  /// Creates the use case.
  const DeleteBrowsingHistoryUsecase({
    required BrowsingHistoryRepository repository,
  }) : _repository = repository;

  final BrowsingHistoryRepository _repository;

  /// Executes the use case.
  Future<Result<void>> execute(String id) {
    return _repository.deleteById(id);
  }
}
