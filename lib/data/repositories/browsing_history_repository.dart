import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';

/// Repository for persisted browsing history.
final class BrowsingHistoryRepository {
  /// Creates a browsing history repository.
  const BrowsingHistoryRepository(this._dao);

  final BrowsingHistoriesDao _dao;

  /// Inserts or updates the last viewed timestamp for an id.
  Future<Result<void>> upsert(String id, {DateTime? viewedAt}) async {
    try {
      await _dao.upsert(
        BrowsingHistoriesTableCompanion.insert(
          id: id,
          viewedAt: viewedAt ?? DateTime.now().toUtc(),
        ),
      );
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Finds browsing history entries ordered by newest first.
  Future<Result<List<BrowsingHistoryEntry>>> findAll({
    String? idPrefix,
    int? limit,
  }) async {
    try {
      final rows = await _dao.findAll(idPrefix: idPrefix, limit: limit);
      return Result.ok(rows.map(_toDomain).toList(growable: false));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes a row by id.
  Future<Result<void>> deleteById(String id) async {
    try {
      await _dao.deleteById(id);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes all rows.
  Future<Result<void>> deleteAll() async {
    try {
      await _dao.deleteAll();
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes the oldest row.
  Future<Result<void>> deleteOldest() async {
    try {
      await _dao.deleteOldest();
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Watches all rows ordered by newest first.
  Stream<List<BrowsingHistoryEntry>> watchAll() {
    return _dao.watchAll().map((rows) => rows.map(_toDomain).toList());
  }
}

BrowsingHistoryEntry _toDomain(BrowsingHistoriesTableData row) {
  return BrowsingHistoryEntry(
    id: row.id,
    viewedAt: row.viewedAt,
  );
}
