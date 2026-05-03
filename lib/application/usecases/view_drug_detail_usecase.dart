import 'package:fictional_drug_and_disease_ref/application/bookmarks/detail_fallback_policy.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Result of loading a drug detail surface.
sealed class DrugDetailLoadResult {
  const DrugDetailLoadResult();
}

/// Successfully loaded drug detail.
final class DrugDetailLoaded extends DrugDetailLoadResult {
  /// Creates a loaded result.
  const DrugDetailLoaded(this.drug, {required this.isBookmarked});

  /// Loaded drug.
  final Drug drug;

  /// Current bookmark state.
  final bool isBookmarked;
}

/// Offline fallback loaded from a bookmark snapshot.
final class DrugDetailOfflineFallback extends DrugDetailLoadResult {
  /// Creates an offline fallback result.
  const DrugDetailOfflineFallback(this.snapshot, this.cause);

  /// Snapshot from bookmark storage.
  final DrugSummary snapshot;

  /// Original load failure.
  final AppException cause;
}

/// Failed to load drug detail.
final class DrugDetailFailure extends DrugDetailLoadResult {
  /// Creates a failure result.
  const DrugDetailFailure(this.error);

  /// Load error.
  final AppException error;
}

/// Use case for viewing a drug detail.
final class ViewDrugDetailUsecase {
  /// Creates a view-drug-detail use case.
  const ViewDrugDetailUsecase({
    required DrugRepository drugRepository,
    required BrowsingHistoryRepository browsingHistoryRepository,
    required BookmarkRepository bookmarkRepository,
    DrugBookmarkSnapshotCodec snapshotCodec = const DrugBookmarkSnapshotCodec(),
  }) : _drugRepository = drugRepository,
       _browsingHistoryRepository = browsingHistoryRepository,
       _bookmarkRepository = bookmarkRepository,
       _snapshotCodec = snapshotCodec;

  final DrugRepository _drugRepository;
  final BrowsingHistoryRepository _browsingHistoryRepository;
  final BookmarkRepository _bookmarkRepository;
  final DrugBookmarkSnapshotCodec _snapshotCodec;

  /// Loads a drug detail and updates local viewing side effects.
  Future<DrugDetailLoadResult> execute(String id) async {
    final drugResult = await _drugRepository.getDrug(id);
    return switch (drugResult) {
      Ok<Drug>(:final value) => _loaded(id, value),
      Err<Drug>(:final error) when canUseBookmarkSnapshotFallback(error) =>
        _offlineFallback(id, error),
      Err<Drug>(:final error) => DrugDetailFailure(error),
    };
  }

  Future<DrugDetailLoadResult> _loaded(String id, Drug drug) async {
    final results = await (
      _browsingHistoryRepository.upsert(id),
      _bookmarkRepository.existsById(id),
    ).wait;
    final isBookmarked = switch (results.$2) {
      Ok<bool>(:final value) => value,
      Err<bool>() => false,
    };
    if (isBookmarked) {
      final summary = _snapshotCodec.fromDrug(drug);
      await _bookmarkRepository.updateSnapshot(
        id,
        _snapshotCodec.encode(summary),
      );
    }
    return DrugDetailLoaded(drug, isBookmarked: isBookmarked);
  }

  Future<DrugDetailLoadResult> _offlineFallback(
    String id,
    AppException error,
  ) async {
    final fallback = await _bookmarkRepository.findById(id);
    return switch (fallback) {
      Ok<BookmarkEntry?>(value: final entry?) => DrugDetailOfflineFallback(
        _snapshotCodec.decode(entry.snapshotJson),
        error,
      ),
      _ => DrugDetailFailure(error),
    };
  }
}
