import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';

/// Deletes one bookmark row.
final class DeleteBookmarkUsecase {
  /// Creates the use case.
  const DeleteBookmarkUsecase({
    required BookmarkRepository repository,
  }) : _repository = repository;

  final BookmarkRepository _repository;

  /// Executes the use case.
  Future<Result<void>> execute(String id) {
    return _repository.deleteById(id);
  }
}
