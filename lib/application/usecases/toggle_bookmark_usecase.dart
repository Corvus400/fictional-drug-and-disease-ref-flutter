import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';

/// Use case for toggling detail bookmark state.
final class ToggleBookmarkUsecase {
  /// Creates a toggle-bookmark use case.
  const ToggleBookmarkUsecase({
    required BookmarkRepository bookmarkRepository,
    required DrugBookmarkSnapshotCodec drugCodec,
    required DiseaseBookmarkSnapshotCodec diseaseCodec,
  }) : _bookmarkRepository = bookmarkRepository,
       _drugCodec = drugCodec,
       _diseaseCodec = diseaseCodec;

  final BookmarkRepository _bookmarkRepository;
  final DrugBookmarkSnapshotCodec _drugCodec;
  final DiseaseBookmarkSnapshotCodec _diseaseCodec;

  /// Toggles a drug bookmark.
  Future<Result<void>> toggleDrug({
    required Drug drug,
    required bool currentlyBookmarked,
  }) {
    if (!currentlyBookmarked) {
      final snapshot = _drugCodec.fromDrug(drug);
      return _bookmarkRepository.insert(
        id: drug.id,
        snapshotJson: _drugCodec.encode(snapshot),
        bookmarkedAt: DateTime.now(),
      );
    }
    return _bookmarkRepository.deleteById(drug.id);
  }

  /// Toggles a disease bookmark.
  Future<Result<void>> toggleDisease({
    required Disease disease,
    required bool currentlyBookmarked,
  }) {
    if (!currentlyBookmarked) {
      final snapshot = _diseaseCodec.fromDisease(disease);
      return _bookmarkRepository.insert(
        id: disease.id,
        snapshotJson: _diseaseCodec.encode(snapshot),
        bookmarkedAt: DateTime.now(),
      );
    }
    return _bookmarkRepository.deleteById(disease.id);
  }
}
