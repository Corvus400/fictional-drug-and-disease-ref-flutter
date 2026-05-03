import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';

/// Use case for observing bookmark state.
final class ObserveBookmarkStateUsecase {
  /// Creates an observe-bookmark-state use case.
  const ObserveBookmarkStateUsecase({
    required BookmarkRepository bookmarkRepository,
  }) : _bookmarkRepository = bookmarkRepository;

  final BookmarkRepository _bookmarkRepository;

  /// Watches whether a target is bookmarked.
  Stream<bool> execute(String id) {
    return _bookmarkRepository.watchExists(id);
  }
}
