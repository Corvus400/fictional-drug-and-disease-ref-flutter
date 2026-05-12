import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';

/// Observes persisted browsing history rows.
final class ObserveBrowsingHistoryUsecase {
  /// Creates the use case.
  const ObserveBrowsingHistoryUsecase({
    required BrowsingHistoryRepository repository,
  }) : _repository = repository;

  final BrowsingHistoryRepository _repository;

  /// Executes the use case.
  Stream<List<BrowsingHistoryEntry>> execute() {
    return _repository.watchAll();
  }
}
