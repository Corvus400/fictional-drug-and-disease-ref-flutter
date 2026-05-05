import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/search_drugs_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SearchDrugsUsecase', () {
    late AppDatabase db;
    late _MockDrugApiClient apiClient;
    late SearchHistoryRepository historyRepository;
    late SearchDrugsUsecase usecase;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      apiClient = _MockDrugApiClient();
      historyRepository = SearchHistoryRepository(db.searchHistoriesDao);
      usecase = SearchDrugsUsecase(
        drugRepository: DrugRepository(apiClient),
        searchHistoryRepository: historyRepository,
        codec: const SearchQueryCodec(),
        clock: () => DateTime.utc(2026, 5, 5, 12),
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('execute returns page and records drug search history', () async {
      final dto = _drugListFixture();
      when(
        () => apiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordMatch: any(named: 'keywordMatch'),
          sort: any(named: 'sort'),
        ),
      ).thenAnswer((_) async => dto);

      final result = await usecase.execute(
        const DrugSearchParams(
          page: 1,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          sort: DrugSort.revisedAtDesc,
        ),
      );

      expect(result, isA<Ok<DrugListPage>>());
      final histories = await historyRepository.findByTarget('drug');
      final entries = (histories as Ok).value;
      expect(entries, hasLength(1));
      expect(entries.single.target, 'drug');
      expect(entries.single.totalCount, dto.totalCount);
      expect(entries.single.searchedAt, DateTime.utc(2026, 5, 5, 12));
      expect(entries.single.queryJson, contains('"keyword":"アムロ"'));
    });
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}
