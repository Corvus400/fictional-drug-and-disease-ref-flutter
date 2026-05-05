import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/search_drugs_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';

/// Searches diseases and records a best-effort local history row on success.
final class SearchDiseasesUsecase {
  /// Creates the use case.
  const SearchDiseasesUsecase({
    required DiseaseRepository diseaseRepository,
    required SearchHistoryRepository searchHistoryRepository,
    required SearchQueryCodec codec,
    SearchHistoryClock clock = _defaultClock,
  }) : _diseaseRepository = diseaseRepository,
       _searchHistoryRepository = searchHistoryRepository,
       _codec = codec,
       _clock = clock;

  static DateTime _defaultClock() => DateTime.now().toUtc();

  final DiseaseRepository _diseaseRepository;
  final SearchHistoryRepository _searchHistoryRepository;
  final SearchQueryCodec _codec;
  final SearchHistoryClock _clock;

  /// Executes a disease search.
  Future<Result<DiseaseListPage>> execute(DiseaseSearchParams params) async {
    final result = await _diseaseRepository.getDiseases(params);
    if (result is Ok<DiseaseListPage>) {
      await _recordHistory(params, result.value.totalCount);
    }
    return result;
  }

  Future<void> _recordHistory(
    DiseaseSearchParams params,
    int totalCount,
  ) async {
    if (!hasSearchHistoryKeyword(params.keyword)) {
      return;
    }
    final searchedAt = _clock();
    final queryJson = _codec.encode(params);
    final result = await _searchHistoryRepository.insertWithDedup(
      id: buildSearchHistoryId('disease', searchedAt, queryJson),
      target: 'disease',
      queryJson: queryJson,
      searchedAt: searchedAt,
      totalCount: totalCount,
    );
    if (result is Err<void>) {
      appLogger.w(
        'failed to record disease search history',
        error: result.error,
      );
    }
  }
}
