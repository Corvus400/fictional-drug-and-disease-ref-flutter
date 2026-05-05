import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('SearchScreenNotifier', () {
    late AppDatabase db;
    late _MockDrugApiClient drugApiClient;
    late _MockDiseaseApiClient diseaseApiClient;
    late ProviderContainer container;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      drugApiClient = _MockDrugApiClient();
      diseaseApiClient = _MockDiseaseApiClient();
      container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
        ],
      );
    });

    tearDown(() async {
      await pumpEventQueue();
      container.dispose();
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('build starts with idle drug state', () {
      final state = container.read(searchScreenProvider);

      expect(state.tab, SearchTab.drugs);
      expect(state.queryText, '');
      expect(state.phase, isA<SearchPhaseIdle>());
    });

    test('changeQueryText updates text without running search', () {
      container.read(searchScreenProvider.notifier).changeQueryText('アムロ');

      final state = container.read(searchScreenProvider);
      final queryText = state.queryText;
      final phase = state.phase;
      expect(queryText, 'アムロ');
      expect(phase, isA<SearchPhaseIdle>());
    });

    test('performSearch loads drug results and records history', () async {
      final dto = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
        ),
      ).thenAnswer((_) async => dto);
      final notifier = container.read(searchScreenProvider.notifier)
        ..changeQueryText('アムロ');

      await notifier.performSearch();

      final state = container.read(searchScreenProvider);
      final phase = state.phase as SearchPhaseResults;
      final view = phase.view as DrugSearchResultsView;
      expect(view.items, isNotEmpty);
      expect(state.historyForTab, hasLength(1));
      expect(state.historyForTab.single.queryText, 'アムロ');
      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: 20,
          keyword: 'アムロ',
        ),
      ).called(1);
    });

    test('selectHistory restores query and searches immediately', () async {
      final dto = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
        ),
      ).thenAnswer((_) async => dto);
      const params = DrugSearchParams(keyword: '履歴');
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_001',
            target: 'drug',
            queryJson: container.read(searchQueryCodecProvider).encode(params),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 1,
          );
      final notifier = container.read(searchScreenProvider.notifier);
      await notifier.loadHistory();

      await notifier.selectHistory(
        container.read(searchScreenProvider).historyForTab.single,
      );

      final state = container.read(searchScreenProvider);
      expect(state.queryText, '履歴');
      expect(state.phase, isA<SearchPhaseResults>());
    });

    test('removeChipAt clears single-value drug axis', () async {
      _stubDrugSearch(drugApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.applyDrugFilter(categoryAtc: 'A');
      expect(
        container.read(searchScreenProvider).appliedChips.items,
        hasLength(1),
      );

      await notifier.removeChipAt(0);

      final state = container.read(searchScreenProvider);
      expect(state.appliedChips.items, isEmpty);
      expect(state.drugParams.categoryAtc, isNull);
      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: 20,
          categoryAtc: any(named: 'categoryAtc'),
          keyword: any(named: 'keyword'),
        ),
      ).called(2);
    });

    test(
      'removeOneChip removes the oldest applied chip and clears its axis on '
      'drugParams',
      () async {
        _stubDrugSearch(drugApiClient);
        final notifier = container.read(searchScreenProvider.notifier);

        await notifier.applyDrugFilter(
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
        );
        await notifier.removeOneChip();

        final state = container.read(searchScreenProvider);
        expect(state.drugParams.regulatoryClass, isNull);
        expect(state.drugParams.dosageForm, ['tablet']);
        expect(state.appliedChips.items, hasLength(1));
        expect(state.appliedChips.items.single.axis, 'dosageForm');
      },
    );

    test('removeOneChip is no-op when appliedChips is empty', () async {
      _stubDrugSearch(drugApiClient);
      final notifier = container.read(searchScreenProvider.notifier);
      final before = container.read(searchScreenProvider);

      await notifier.removeOneChip();

      final after = container.read(searchScreenProvider);
      expect(after.appliedChips.items, isEmpty);
      expect(after.drugParams, same(before.drugParams));
      expect(after.diseaseParams, same(before.diseaseParams));
      verifyNever(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          categoryAtc: any(named: 'categoryAtc'),
          therapeuticCategory: any(named: 'therapeuticCategory'),
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          route: any(named: 'route'),
          keyword: any(named: 'keyword'),
          adverseReactionKeyword: any(named: 'adverseReactionKeyword'),
          precautionCategory: any(named: 'precautionCategory'),
        ),
      );
    });

    test(
      'removeOneChip on disease tab clears the oldest disease axis',
      () async {
        _stubDiseaseSearch(diseaseApiClient);
        final notifier = container.read(searchScreenProvider.notifier);

        await notifier.changeTab(SearchTab.diseases);
        await notifier.applyDiseaseFilter(chronicity: ['chronic']);
        await notifier.removeOneChip();

        final state = container.read(searchScreenProvider);
        expect(state.diseaseParams.chronicity, isNull);
        expect(state.appliedChips.items, isEmpty);
      },
    );

    test('removeOneChip preserves params for non-removed axes', () async {
      _stubDrugSearch(drugApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.applyDrugFilter(
        regulatoryClass: ['poison'],
        dosageForm: ['tablet'],
      );
      await notifier.removeOneChip();

      final state = container.read(searchScreenProvider);
      expect(state.drugParams.regulatoryClass, isNull);
      expect(state.drugParams.dosageForm, ['tablet']);
      expect(state.appliedChips.items.single.label, 'tablet');
    });

    test('removeChipAt clears therapeuticCategory drug axis', () async {
      _stubDrugSearch(drugApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.applyDrugFilter(therapeuticCategory: 'CARDIOVASCULAR');
      await notifier.removeChipAt(0);

      final state = container.read(searchScreenProvider);
      expect(state.appliedChips.items, isEmpty);
      expect(state.drugParams.therapeuticCategory, isNull);
    });

    test(
      'removeChipAt removes one value from regulatoryClass drug axis',
      () async {
        _stubDrugSearch(drugApiClient);
        final notifier = container.read(searchScreenProvider.notifier);

        await notifier.applyDrugFilter(regulatoryClass: ['poison', 'potent']);
        await notifier.removeChipAt(0);

        final state = container.read(searchScreenProvider);
        expect(state.drugParams.regulatoryClass, ['potent']);
        expect(state.appliedChips.items.single.label, 'potent');
      },
    );

    test(
      'removeChipAt nulls dosageForm drug axis when last value removed',
      () async {
        _stubDrugSearch(drugApiClient);
        final notifier = container.read(searchScreenProvider.notifier);

        await notifier.applyDrugFilter(dosageForm: ['tablet']);
        await notifier.removeChipAt(0);

        expect(
          container.read(searchScreenProvider).drugParams.dosageForm,
          isNull,
        );
      },
    );

    test(
      'removeChipAt nulls route drug axis when last value removed',
      () async {
        _stubDrugSearch(drugApiClient);
        final notifier = container.read(searchScreenProvider.notifier);

        await notifier.applyDrugFilter(route: ['oral']);
        await notifier.removeChipAt(0);

        expect(container.read(searchScreenProvider).drugParams.route, isNull);
      },
    );

    test('removeChipAt clears adverseReactionKeyword drug axis', () async {
      _stubDrugSearch(drugApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.applyDrugFilter(adverseReactionKeyword: '頭痛');
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).drugParams.adverseReactionKeyword,
        isNull,
      );
    });

    test('removeChipAt nulls precautionCategory drug axis', () async {
      _stubDrugSearch(drugApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.applyDrugFilter(precautionCategory: ['PREGNANT']);
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).drugParams.precautionCategory,
        isNull,
      );
    });

    test('removeChipAt nulls icd10Chapter disease axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(icd10Chapter: ['chapter_ii']);
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).diseaseParams.icd10Chapter,
        isNull,
      );
    });

    test(
      'removeChipAt removes one value from department disease axis',
      () async {
        _stubDiseaseSearch(diseaseApiClient);
        final notifier = container.read(searchScreenProvider.notifier);

        await notifier.changeTab(SearchTab.diseases);
        await notifier.applyDiseaseFilter(
          department: ['internal_medicine', 'cardiology'],
        );
        await notifier.removeChipAt(0);

        final state = container.read(searchScreenProvider);
        expect(state.diseaseParams.department, ['cardiology']);
        expect(state.appliedChips.items.single.label, 'cardiology');
      },
    );

    test('removeChipAt nulls chronicity disease axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(chronicity: ['chronic']);
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).diseaseParams.chronicity,
        isNull,
      );
    });

    test('removeChipAt nulls bool disease infectious axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(infectious: true);
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).diseaseParams.infectious,
        isNull,
      );
    });

    test('removeChipAt clears symptomKeyword disease axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(symptomKeyword: '発熱');
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).diseaseParams.symptomKeyword,
        isNull,
      );
    });

    test('removeChipAt nulls onsetPattern disease axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(onsetPattern: ['acute']);
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).diseaseParams.onsetPattern,
        isNull,
      );
    });

    test('removeChipAt nulls examCategory disease axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(examCategory: ['blood']);
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).diseaseParams.examCategory,
        isNull,
      );
    });

    test('removeChipAt nulls pharmacological treatment disease axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(hasPharmacologicalTreatment: true);
      await notifier.removeChipAt(0);

      expect(
        container
            .read(searchScreenProvider)
            .diseaseParams
            .hasPharmacologicalTreatment,
        isNull,
      );
    });

    test('removeChipAt nulls severity grading disease axis', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      await notifier.applyDiseaseFilter(hasSeverityGrading: true);
      await notifier.removeChipAt(0);

      expect(
        container.read(searchScreenProvider).diseaseParams.hasSeverityGrading,
        isNull,
      );
    });

    test(
      'changeDiseaseSort updates diseaseParams.sort and triggers re-search',
      () async {
        _stubDiseaseSearch(diseaseApiClient);
        final notifier = container.read(searchScreenProvider.notifier);

        await notifier.changeTab(SearchTab.diseases);
        await notifier.changeDiseaseSort(DiseaseSort.nameKana);

        final state = container.read(searchScreenProvider);
        expect(state.diseaseParams.sort, DiseaseSort.nameKana);
        verify(
          () => diseaseApiClient.getDiseases(
            page: 1,
            pageSize: 20,
            icd10Chapter: any(named: 'icd10Chapter'),
            department: any(named: 'department'),
            chronicity: any(named: 'chronicity'),
            infectious: any(named: 'infectious'),
            keyword: any(named: 'keyword'),
            keywordMatch: any(named: 'keywordMatch'),
            keywordTarget: any(named: 'keywordTarget'),
            symptomKeyword: any(named: 'symptomKeyword'),
            onsetPattern: any(named: 'onsetPattern'),
            examCategory: any(named: 'examCategory'),
            hasPharmacologicalTreatment: any(
              named: 'hasPharmacologicalTreatment',
            ),
            hasSeverityGrading: any(named: 'hasSeverityGrading'),
            sort: DiseaseSort.nameKana.serialName,
          ),
        ).called(1);
      },
    );

    test('changeDiseaseSort supports all disease sort axes', () async {
      _stubDiseaseSearch(diseaseApiClient);
      final notifier = container.read(searchScreenProvider.notifier);

      await notifier.changeTab(SearchTab.diseases);
      for (final sort in DiseaseSort.values) {
        await notifier.changeDiseaseSort(sort);
        expect(container.read(searchScreenProvider).diseaseParams.sort, sort);
      }
    });
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

void _stubDrugSearch(_MockDrugApiClient drugApiClient) {
  when(
    () => drugApiClient.getDrugs(
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
      categoryAtc: any(named: 'categoryAtc'),
      therapeuticCategory: any(named: 'therapeuticCategory'),
      regulatoryClass: any(named: 'regulatoryClass'),
      dosageForm: any(named: 'dosageForm'),
      route: any(named: 'route'),
      keyword: any(named: 'keyword'),
      adverseReactionKeyword: any(named: 'adverseReactionKeyword'),
      precautionCategory: any(named: 'precautionCategory'),
    ),
  ).thenAnswer((_) async => _drugListFixture());
}

void _stubDiseaseSearch(_MockDiseaseApiClient diseaseApiClient) {
  when(
    () => diseaseApiClient.getDiseases(
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
      icd10Chapter: any(named: 'icd10Chapter'),
      department: any(named: 'department'),
      chronicity: any(named: 'chronicity'),
      infectious: any(named: 'infectious'),
      keyword: any(named: 'keyword'),
      symptomKeyword: any(named: 'symptomKeyword'),
      onsetPattern: any(named: 'onsetPattern'),
      examCategory: any(named: 'examCategory'),
      hasPharmacologicalTreatment: any(
        named: 'hasPharmacologicalTreatment',
      ),
      hasSeverityGrading: any(named: 'hasSeverityGrading'),
    ),
  ).thenAnswer((_) async => _diseaseListFixture());
}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}

DiseaseListResponseDto _diseaseListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseListResponseDto.fromJson(json);
}
