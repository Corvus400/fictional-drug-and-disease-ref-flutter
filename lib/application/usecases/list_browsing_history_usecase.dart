import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';

/// Lists persisted browsing history rows.
final class ListBrowsingHistoryUsecase {
  /// Creates the use case.
  const ListBrowsingHistoryUsecase({
    required BrowsingHistoryRepository repository,
  }) : _repository = repository;

  final BrowsingHistoryRepository _repository;

  /// Executes the use case.
  Future<Result<List<BrowsingHistoryEntry>>> execute({
    String? idPrefix,
    int? limit,
  }) {
    return _repository.findAll(idPrefix: idPrefix, limit: limit);
  }
}
