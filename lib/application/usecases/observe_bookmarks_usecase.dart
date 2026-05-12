import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';

/// Observes persisted bookmark rows.
final class ObserveBookmarksUsecase {
  /// Creates the use case.
  const ObserveBookmarksUsecase({
    required BookmarkRepository repository,
  }) : _repository = repository;

  final BookmarkRepository _repository;

  /// Executes the use case.
  Stream<List<BookmarkEntry>> execute() {
    return _repository.watchAll();
  }
}
