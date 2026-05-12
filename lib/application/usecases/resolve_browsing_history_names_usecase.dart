import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/browsing_history/name_resolution_cache.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

const _drugPrefix = 'drug_';
const _diseasePrefix = 'disease_';

/// Resolves display names for browsing history entries.
final class ResolveBrowsingHistoryNamesUsecase {
  /// Creates the use case.
  const ResolveBrowsingHistoryNamesUsecase({
    required BookmarkRepository bookmarkRepository,
    required DrugRepository drugRepository,
    required DiseaseRepository diseaseRepository,
    required DrugBookmarkSnapshotCodec drugCodec,
    required DiseaseBookmarkSnapshotCodec diseaseCodec,
    required NameResolutionCache cache,
  }) : _bookmarkRepository = bookmarkRepository,
       _drugCodec = drugCodec,
       _diseaseCodec = diseaseCodec,
       _cache = cache;

  final BookmarkRepository _bookmarkRepository;
  final DrugBookmarkSnapshotCodec _drugCodec;
  final DiseaseBookmarkSnapshotCodec _diseaseCodec;
  final NameResolutionCache _cache;

  /// Executes the use case.
  Future<Map<String, NameResolution>> execute(
    List<BrowsingHistoryEntry> entries,
  ) async {
    final resolved = <String, NameResolution>{};
    for (final entry in entries) {
      final id = entry.id;
      final cached = _cache.get(id);
      if (cached is NameResolution) {
        resolved[id] = cached;
        continue;
      }

      final resolution = await _resolveOne(id);
      resolved[id] = resolution;
      if (resolution is NameResolvedDrug || resolution is NameResolvedDisease) {
        _cache.put(id, resolution);
      }
    }
    return resolved;
  }

  Future<NameResolution> _resolveOne(String id) async {
    if (id.startsWith(_drugPrefix)) {
      return _resolveDrug(id);
    }
    if (id.startsWith(_diseasePrefix)) {
      return _resolveDisease(id);
    }
    return NameResolutionFailed(id: id);
  }

  Future<NameResolution> _resolveDrug(String id) async {
    final bookmark = await _bookmarkRepository.findById(id);
    if (bookmark case Ok<BookmarkEntry?>(:final value)) {
      if (value == null) {
        return NameResolutionFailed(id: id);
      }
      try {
        return NameResolvedDrug(summary: _drugCodec.decode(value.snapshotJson));
      } on Object {
        return NameResolutionFailed(id: id);
      }
    }
    return NameResolutionFailed(id: id);
  }

  Future<NameResolution> _resolveDisease(String id) async {
    final bookmark = await _bookmarkRepository.findById(id);
    if (bookmark case Ok<BookmarkEntry?>(:final value)) {
      if (value == null) {
        return NameResolutionFailed(id: id);
      }
      try {
        return NameResolvedDisease(
          summary: _diseaseCodec.decode(value.snapshotJson),
        );
      } on Object {
        return NameResolutionFailed(id: id);
      }
    }
    return NameResolutionFailed(id: id);
  }
}

/// Name resolution result.
sealed class NameResolution {
  const NameResolution();
}

/// Successfully resolved drug row.
final class NameResolvedDrug extends NameResolution {
  /// Creates the result.
  const NameResolvedDrug({required this.summary});

  /// Resolved summary.
  final DrugSummary summary;
}

/// Successfully resolved disease row.
final class NameResolvedDisease extends NameResolution {
  /// Creates the result.
  const NameResolvedDisease({required this.summary});

  /// Resolved summary.
  final DiseaseSummary summary;
}

/// Failed to resolve a row.
final class NameResolutionFailed extends NameResolution {
  /// Creates the result.
  const NameResolutionFailed({required this.id});

  /// Failed id.
  final String id;
}
