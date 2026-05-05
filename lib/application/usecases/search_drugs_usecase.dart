import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';

/// Clock used for search history timestamps.
typedef SearchHistoryClock = DateTime Function();

/// Searches drugs and records a best-effort local history row on success.
final class SearchDrugsUsecase {
  /// Creates the use case.
  const SearchDrugsUsecase({
    required DrugRepository drugRepository,
    required SearchHistoryRepository searchHistoryRepository,
    required SearchQueryCodec codec,
    SearchHistoryClock clock = _defaultClock,
  }) : _drugRepository = drugRepository,
       _searchHistoryRepository = searchHistoryRepository,
       _codec = codec,
       _clock = clock;

  static DateTime _defaultClock() => DateTime.now().toUtc();

  final DrugRepository _drugRepository;
  final SearchHistoryRepository _searchHistoryRepository;
  final SearchQueryCodec _codec;
  final SearchHistoryClock _clock;

  /// Executes a drug search.
  Future<Result<DrugListPage>> execute(DrugSearchParams params) async {
    final result = await _drugRepository.getDrugs(params);
    if (result is Ok<DrugListPage>) {
      await _recordHistory(params, result.value.totalCount);
    }
    return result;
  }

  Future<void> _recordHistory(DrugSearchParams params, int totalCount) async {
    if (!hasSearchHistoryKeyword(params.keyword)) {
      return;
    }
    final searchedAt = _clock();
    final queryJson = _codec.encode(params);
    final result = await _searchHistoryRepository.insertWithDedup(
      id: buildSearchHistoryId('drug', searchedAt, queryJson),
      target: 'drug',
      queryJson: queryJson,
      searchedAt: searchedAt,
      totalCount: totalCount,
    );
    if (result is Err<void>) {
      appLogger.w(
        'failed to record drug search history',
        error: result.error,
      );
    }
  }
}

/// Builds deterministic-ish search history ids without adding a UUID package.
String buildSearchHistoryId(String target, DateTime searchedAt, String query) {
  final epoch = searchedAt.millisecondsSinceEpoch;
  final hash = query.hashCode.toUnsigned(32).toRadixString(16);
  return '${target}_${epoch}_$hash';
}

/// Whether search params have a displayable keyword for search history.
bool hasSearchHistoryKeyword(String? keyword) {
  return keyword != null && keyword.trim().isNotEmpty;
}
