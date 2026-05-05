import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';

/// Clears all search history rows for a target.
final class ClearSearchHistoryUsecase {
  /// Creates the use case.
  const ClearSearchHistoryUsecase({
    required SearchHistoryRepository searchHistoryRepository,
  }) : _searchHistoryRepository = searchHistoryRepository;

  final SearchHistoryRepository _searchHistoryRepository;

  /// Executes the use case.
  Future<Result<void>> execute(String target) {
    return _searchHistoryRepository.clearByTarget(target);
  }
}
