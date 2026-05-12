import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

const _drugPrefix = 'drug_';
const _diseasePrefix = 'disease_';

/// Resolves bookmark snapshot JSON into display row data.
final class ResolveBookmarkRowsUsecase {
  /// Creates the use case.
  const ResolveBookmarkRowsUsecase({
    required DrugBookmarkSnapshotCodec drugCodec,
    required DiseaseBookmarkSnapshotCodec diseaseCodec,
  }) : _drugCodec = drugCodec,
       _diseaseCodec = diseaseCodec;

  final DrugBookmarkSnapshotCodec _drugCodec;
  final DiseaseBookmarkSnapshotCodec _diseaseCodec;

  /// Executes the use case.
  Result<List<ResolvedBookmarkRow>> execute(List<BookmarkEntry> entries) {
    final rows = <ResolvedBookmarkRow>[];
    for (final entry in entries) {
      final resolved = _resolveOne(entry);
      if (resolved case Err<ResolvedBookmarkRow>(:final error)) {
        return Result.error(error);
      }
      rows.add((resolved as Ok<ResolvedBookmarkRow>).value);
    }
    return Result.ok(rows);
  }

  Result<ResolvedBookmarkRow> _resolveOne(BookmarkEntry entry) {
    try {
      if (entry.id.startsWith(_drugPrefix)) {
        return Result.ok(
          ResolvedBookmarkDrugRow(
            id: entry.id,
            bookmarkedAt: entry.bookmarkedAt,
            summary: _drugCodec.decode(entry.snapshotJson),
          ),
        );
      }
      if (entry.id.startsWith(_diseasePrefix)) {
        return Result.ok(
          ResolvedBookmarkDiseaseRow(
            id: entry.id,
            bookmarkedAt: entry.bookmarkedAt,
            summary: _diseaseCodec.decode(entry.snapshotJson),
          ),
        );
      }
      return Result.error(
        ParseException(
          cause: FormatException('Unknown bookmark id: ${entry.id}'),
        ),
      );
    } on Object catch (error, stackTrace) {
      return Result.error(ParseException(cause: error, stackTrace: stackTrace));
    }
  }
}

/// Resolved bookmark row.
sealed class ResolvedBookmarkRow {
  const ResolvedBookmarkRow({
    required this.id,
    required this.bookmarkedAt,
  });

  /// Bookmark id.
  final String id;

  /// Saved timestamp.
  final DateTime bookmarkedAt;
}

/// Resolved drug bookmark row.
final class ResolvedBookmarkDrugRow extends ResolvedBookmarkRow {
  /// Creates a resolved drug row.
  const ResolvedBookmarkDrugRow({
    required super.id,
    required super.bookmarkedAt,
    required this.summary,
  });

  /// Drug summary decoded from snapshot.
  final DrugSummary summary;
}

/// Resolved disease bookmark row.
final class ResolvedBookmarkDiseaseRow extends ResolvedBookmarkRow {
  /// Creates a resolved disease row.
  const ResolvedBookmarkDiseaseRow({
    required super.id,
    required super.bookmarkedAt,
    required this.summary,
  });

  /// Disease summary decoded from snapshot.
  final DiseaseSummary summary;
}
