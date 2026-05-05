import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/search_drugs_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/search_history/search_history_entry.dart';

const _searchHistoryStorageLimit = 20;
const _searchHistoryDisplayLimit = 5;

/// Lists decoded search history rows for a target.
final class ListSearchHistoryUsecase {
  /// Creates the use case.
  const ListSearchHistoryUsecase({
    required SearchHistoryRepository searchHistoryRepository,
    required SearchQueryCodec codec,
  }) : _searchHistoryRepository = searchHistoryRepository,
       _codec = codec;

  final SearchHistoryRepository _searchHistoryRepository;
  final SearchQueryCodec _codec;

  /// Executes the use case.
  Future<Result<List<SearchHistoryEnvelope>>> execute(String target) async {
    final result = await _searchHistoryRepository.findByTarget(
      target,
      limit: _searchHistoryStorageLimit,
    );
    if (result case Err(:final error)) {
      return Result.error(error);
    }
    try {
      final historyEntries = (result as Ok<List<SearchHistoryEntry>>).value;
      final entries = historyEntries
          .map<SearchHistoryEnvelope>((entry) {
            if (entry.target == 'drug') {
              final params = _codec.decodeDrug(entry.queryJson);
              return DrugSearchHistoryEnvelope(
                id: entry.id,
                queryText: params.keyword ?? '',
                params: params,
                filterCount: _codec.filterCountFor(params),
                searchedAt: entry.searchedAt,
                totalCount: entry.totalCount,
              );
            }
            final params = _codec.decodeDisease(entry.queryJson);
            return DiseaseSearchHistoryEnvelope(
              id: entry.id,
              queryText: params.keyword ?? '',
              params: params,
              filterCount: _codec.filterCountFor(params),
              searchedAt: entry.searchedAt,
              totalCount: entry.totalCount,
            );
          })
          .where((entry) => hasSearchHistoryKeyword(entry.queryText))
          .take(_searchHistoryDisplayLimit)
          .toList(growable: false);
      return Result.ok(entries);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}
