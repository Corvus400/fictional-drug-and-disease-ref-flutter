import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/domain/search_history/search_history_entry.dart';

/// Repository for persisted search history.
final class SearchHistoryRepository {
  /// Creates a search history repository.
  const SearchHistoryRepository(this._dao);

  final SearchHistoriesDao _dao;

  /// Inserts a search history row after removing same target/query history.
  Future<Result<void>> insertWithDedup({
    required String id,
    required String target,
    required String queryJson,
    required DateTime searchedAt,
    required int totalCount,
  }) async {
    try {
      await _dao.insertWithDedup(
        SearchHistoriesTableCompanion.insert(
          id: id,
          target: target,
          query: queryJson,
          searchedAt: searchedAt,
          totalCount: totalCount,
        ),
      );
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Finds search history rows for a target ordered by newest first.
  Future<Result<List<SearchHistoryEntry>>> findByTarget(
    String target, {
    int? limit,
  }) async {
    try {
      final rows = await _dao.findByTarget(target, limit: limit);
      return Result.ok(rows.map(_toDomain).toList(growable: false));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes a search history row by id.
  Future<Result<void>> deleteById(String id) async {
    try {
      await _dao.deleteById(id);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes all search history rows for a target.
  Future<Result<void>> clearByTarget(String target) async {
    try {
      await _dao.clearByTarget(target);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}

SearchHistoryEntry _toDomain(SearchHistoriesTableData row) {
  return SearchHistoryEntry(
    id: row.id,
    target: row.target,
    queryJson: row.query,
    searchedAt: row.searchedAt,
    totalCount: row.totalCount,
  );
}
