import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';

/// Deletes one search history row.
final class DeleteSearchHistoryUsecase {
  /// Creates the use case.
  const DeleteSearchHistoryUsecase({
    required SearchHistoryRepository searchHistoryRepository,
  }) : _searchHistoryRepository = searchHistoryRepository;

  final SearchHistoryRepository _searchHistoryRepository;

  /// Executes the use case.
  Future<Result<void>> execute(String id) {
    return _searchHistoryRepository.deleteById(id);
  }
}
