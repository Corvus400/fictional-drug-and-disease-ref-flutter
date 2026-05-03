import 'package:fictional_drug_and_disease_ref/application/bookmarks/detail_fallback_policy.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';

/// Result of loading a disease detail surface.
sealed class DiseaseDetailLoadResult {
  const DiseaseDetailLoadResult();
}

/// Successfully loaded disease detail.
final class DiseaseDetailLoaded extends DiseaseDetailLoadResult {
  /// Creates a loaded result.
  const DiseaseDetailLoaded(this.disease, {required this.isBookmarked});

  /// Loaded disease.
  final Disease disease;

  /// Current bookmark state.
  final bool isBookmarked;
}

/// Offline fallback loaded from a bookmark snapshot.
final class DiseaseDetailOfflineFallback extends DiseaseDetailLoadResult {
  /// Creates an offline fallback result.
  const DiseaseDetailOfflineFallback(this.snapshot, this.cause);

  /// Snapshot from bookmark storage.
  final DiseaseSummary snapshot;

  /// Original load failure.
  final AppException cause;
}

/// Failed to load disease detail.
final class DiseaseDetailFailure extends DiseaseDetailLoadResult {
  /// Creates a failure result.
  const DiseaseDetailFailure(this.error);

  /// Load error.
  final AppException error;
}

/// Use case for viewing a disease detail.
final class ViewDiseaseDetailUsecase {
  /// Creates a view-disease-detail use case.
  const ViewDiseaseDetailUsecase({
    required DiseaseRepository diseaseRepository,
    required BrowsingHistoryRepository browsingHistoryRepository,
    required BookmarkRepository bookmarkRepository,
    DiseaseBookmarkSnapshotCodec snapshotCodec =
        const DiseaseBookmarkSnapshotCodec(),
  }) : _diseaseRepository = diseaseRepository,
       _browsingHistoryRepository = browsingHistoryRepository,
       _bookmarkRepository = bookmarkRepository,
       _snapshotCodec = snapshotCodec;

  final DiseaseRepository _diseaseRepository;
  final BrowsingHistoryRepository _browsingHistoryRepository;
  final BookmarkRepository _bookmarkRepository;
  final DiseaseBookmarkSnapshotCodec _snapshotCodec;

  /// Loads a disease detail and updates local viewing side effects.
  Future<DiseaseDetailLoadResult> execute(String id) async {
    final diseaseResult = await _diseaseRepository.getDisease(id);
    return switch (diseaseResult) {
      Ok<Disease>(:final value) => _loaded(id, value),
      Err<Disease>(:final error) when canUseBookmarkSnapshotFallback(error) =>
        _offlineFallback(id, error),
      Err<Disease>(:final error) => DiseaseDetailFailure(error),
    };
  }

  Future<DiseaseDetailLoadResult> _loaded(String id, Disease disease) async {
    final results = await (
      _browsingHistoryRepository.upsert(id),
      _bookmarkRepository.existsById(id),
    ).wait;
    final isBookmarked = switch (results.$2) {
      Ok<bool>(:final value) => value,
      Err<bool>() => false,
    };
    if (isBookmarked) {
      final summary = _snapshotCodec.fromDisease(disease);
      await _bookmarkRepository.updateSnapshot(
        id,
        _snapshotCodec.encode(summary),
      );
    }
    return DiseaseDetailLoaded(disease, isBookmarked: isBookmarked);
  }

  Future<DiseaseDetailLoadResult> _offlineFallback(
    String id,
    AppException error,
  ) async {
    final fallback = await _bookmarkRepository.findById(id);
    return switch (fallback) {
      Ok<BookmarkEntry?>(value: final entry?) => DiseaseDetailOfflineFallback(
        _snapshotCodec.decode(entry.snapshotJson),
        error,
      ),
      _ => DiseaseDetailFailure(error),
    };
  }
}
