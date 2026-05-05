import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/search_diseases_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/search_history/search_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SearchDiseasesUsecase', () {
    late AppDatabase db;
    late _MockDiseaseApiClient apiClient;
    late SearchHistoryRepository historyRepository;
    late SearchDiseasesUsecase usecase;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      apiClient = _MockDiseaseApiClient();
      historyRepository = SearchHistoryRepository(db.searchHistoriesDao);
      usecase = SearchDiseasesUsecase(
        diseaseRepository: DiseaseRepository(apiClient),
        searchHistoryRepository: historyRepository,
        codec: const SearchQueryCodec(),
        clock: () => DateTime.utc(2026, 5, 5, 13),
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('execute returns page and records disease search history', () async {
      final dto = _diseaseListFixture();
      when(
        () => apiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordMatch: any(named: 'keywordMatch'),
          sort: any(named: 'sort'),
        ),
      ).thenAnswer((_) async => dto);

      final result = await usecase.execute(
        const DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          sort: DiseaseSort.nameKana,
        ),
      );

      expect(result, isA<Ok<DiseaseListPage>>());
      final histories = await historyRepository.findByTarget('disease');
      final entries = (histories as Ok<List<SearchHistoryEntry>>).value;
      expect(entries, hasLength(1));
      expect(entries.single.target, 'disease');
      expect(entries.single.totalCount, dto.totalCount);
      expect(entries.single.queryJson, contains('"keyword":"高血圧"'));
    });
  });
}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

DiseaseListResponseDto _diseaseListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseListResponseDto.fromJson(json);
}
