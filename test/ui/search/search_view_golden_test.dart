import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_helpers.dart';
import '../../helpers/test_app_database.dart';

late AppDatabase _db;

void main() {
  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  setUpAll(() {
    _db = createTestAppDatabase();
  });

  tearDown(() async {
    await clearTestAppDatabase(_db);
  });

  tearDownAll(() async {
    await _db.close();
  });

  _searchGoldenMatrix(name: 's1_idle', whilePerforming: _seedDrugHistory);
  _searchGoldenMatrix(
    name: 's22_disease_idle',
    whilePerforming: _seedDiseaseHistory,
  );
  _searchGoldenMatrix(name: 's2_history', whilePerforming: _openHistory);
  _searchGoldenMatrix(
    name: 's23_disease_history',
    whilePerforming: _openDiseaseHistory,
  );
  _searchGoldenMatrix(
    name: 's16_empty_history',
    whilePerforming: _openEmptyHistory,
  );
  _searchGoldenMatrix(
    name: 's24_disease_empty_history',
    whilePerforming: _openDiseaseEmptyHistory,
  );
  _searchGoldenMatrix(
    name: 's3_loading',
    responseCompleter: Completer<DrugListResponseDto>(),
    whilePerforming: _performPendingSearch,
  );
  _searchGoldenMatrix(
    name: 's4_loading_more',
    response: _drugListFixture(),
    page2Completer: Completer<DrugListResponseDto>(),
    whilePerforming: _triggerLoadingMore,
  );
  _searchGoldenMatrix(
    name: 's5_drug_results',
    response: _drugListFixture(),
    whilePerforming: _performSearch,
  );
  _searchGoldenMatrix(
    name: 's6_empty',
    response: _drugListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _performSearch,
  );
  _searchGoldenMatrix(
    name: 's7_error',
    error: DioException(
      requestOptions: RequestOptions(path: '/v1/drugs'),
      type: DioExceptionType.connectionError,
    ),
    whilePerforming: _performSearch,
  );
  _searchGoldenMatrix(
    name: 's8_filter_drugs',
    sizes: _phoneModalGoldenSizes,
    whilePerforming: _openDrugFilter,
  );
  _searchGoldenMatrix(
    name: 's9_filter_diseases',
    sizes: _phoneModalGoldenSizes,
    whilePerforming: _openDiseaseFilter,
  );
  _searchGoldenMatrix(
    name: 's10_sort',
    response: _drugListFixture(),
    sizes: _phoneModalGoldenSizes,
    whilePerforming: _openSort,
  );
  _searchGoldenMatrix(
    name: 's17_disease_loading',
    diseaseResponseCompleter: Completer<DiseaseListResponseDto>(),
    whilePerforming: _performPendingDiseaseSearch,
  );
  _searchGoldenMatrix(
    name: 's11_disease_results',
    diseaseResponse: _diseaseListFixture(),
    whilePerforming: _performDiseaseSearch,
  );
  _searchGoldenMatrix(
    name: 's12_disease_loading_more',
    diseaseResponse: _diseaseListFixture(),
    diseasePage2Completer: Completer<DiseaseListResponseDto>(),
    whilePerforming: _triggerDiseaseLoadingMore,
  );
  _searchGoldenMatrix(
    name: 's13_disease_empty',
    diseaseResponse: _diseaseListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _performDiseaseSearch,
  );
  _searchGoldenMatrix(
    name: 's14_disease_error',
    diseaseError: DioException(
      requestOptions: RequestOptions(path: '/v1/diseases'),
      type: DioExceptionType.connectionError,
    ),
    whilePerforming: _performDiseaseSearch,
  );
  _searchGoldenMatrix(
    name: 's15_disease_sort',
    diseaseResponse: _diseaseListFixture(),
    sizes: _phoneModalGoldenSizes,
    whilePerforming: _openDiseaseSort,
  );
  _searchGoldenMatrix(
    name: 's18_drug_filtered_results',
    response: _drugListFixture(),
    whilePerforming: _applyDrugFilter,
  );
  _searchGoldenMatrix(
    name: 's19_drug_filtered_empty',
    response: _drugListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _applyDrugFilter,
  );
  _searchGoldenMatrix(
    name: 's20_disease_filtered_results',
    diseaseResponse: _diseaseListFixture(),
    whilePerforming: _applyDiseaseFilter,
  );
  _searchGoldenMatrix(
    name: 's21_disease_filtered_empty',
    diseaseResponse: _diseaseListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _applyDiseaseFilter,
  );
}

void _searchGoldenMatrix({
  required String name,
  DrugListResponseDto? response,
  DiseaseListResponseDto? diseaseResponse,
  Completer<DrugListResponseDto>? responseCompleter,
  Completer<DrugListResponseDto>? page2Completer,
  Completer<DiseaseListResponseDto>? diseaseResponseCompleter,
  Completer<DiseaseListResponseDto>? diseasePage2Completer,
  Object? error,
  Object? diseaseError,
  Iterable<String>? sizes,
  GoldenInteraction? whilePerforming,
}) {
  runGoldenMatrix(
    fileNamePrefix: 'search_$name',
    description: 'Search $name',
    sizes: sizes ?? _searchSpecGoldenSizes,
    customSizes: _searchSpecCustomSizes,
    builder: (theme, size, scaler) {
      final drugApiClient = _MockDrugApiClient();
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
      if (diseaseError != null) {
        when(
          () => diseaseApiClient.getDiseases(
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
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
            sort: any(named: 'sort'),
          ),
        ).thenThrow(diseaseError);
      } else {
        when(
          () => diseaseApiClient.getDiseases(
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
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
            sort: any(named: 'sort'),
          ),
        ).thenAnswer((invocation) {
          final page = invocation.namedArguments[#page] as int? ?? 1;
          if (page == 2 && diseasePage2Completer != null) {
            return diseasePage2Completer.future;
          }
          if (diseaseResponseCompleter != null) {
            return diseaseResponseCompleter.future;
          }
          return Future.value(diseaseResponse ?? _diseaseListFixture());
        });
      }

      if (error != null) {
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
            keywordMatch: any(named: 'keywordMatch'),
            keywordTarget: any(named: 'keywordTarget'),
            adverseReactionKeyword: any(named: 'adverseReactionKeyword'),
            precautionCategory: any(named: 'precautionCategory'),
            sort: any(named: 'sort'),
          ),
        ).thenThrow(error);
      } else {
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
            keywordMatch: any(named: 'keywordMatch'),
            keywordTarget: any(named: 'keywordTarget'),
            adverseReactionKeyword: any(named: 'adverseReactionKeyword'),
            precautionCategory: any(named: 'precautionCategory'),
            sort: any(named: 'sort'),
          ),
        ).thenAnswer((invocation) {
          final page = invocation.namedArguments[#page] as int? ?? 1;
          if (page == 2 && page2Completer != null) {
            return page2Completer.future;
          }
          if (responseCompleter != null) {
            return responseCompleter.future;
          }
          return Future.value(response ?? _drugListFixture());
        });
      }

      final imageCacheManager = _fallbackImageCacheManager();

      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
          drugCardImageCacheManagerProvider.overrideWithValue(
            imageCacheManager,
          ),
        ],
        child: MaterialApp(
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(
            currentTime: DateTime(2026, 5, 5, 18),
            debugLogDrugImageErrors: false,
          ),
        ),
      );
    },
    whilePerforming: whilePerforming,
  );
}

const _phoneModalGoldenSizes = ['phone'];

const _searchSpecGoldenSizes = [
  'phone',
  'iphone_landscape',
  'tablet',
  'ipad_landscape',
  'ipad_split_view',
];

const _searchSpecCustomSizes = {
  'iphone_landscape': Size(844, 390),
  'ipad_landscape': Size(1194, 834),
  'ipad_split_view': Size(960, 700),
};

Future<Future<void> Function()?> _openHistory(WidgetTester tester) async {
  await _seedDrugHistory(tester);
  return null;
}

Future<Future<void> Function()?> _seedDrugHistory(WidgetTester tester) async {
  for (final element in find.byType(SearchView).evaluate()) {
    final container = ProviderScope.containerOf(element);
    final repository = container.read(searchHistoryRepositoryProvider);
    final codec = container.read(searchQueryCodecProvider);
    await repository.insertWithDedup(
      id: 'golden_history_1',
      target: 'drug',
      queryJson: codec.encode(const DrugSearchParams(keyword: 'アムロジピン')),
      searchedAt: DateTime(2026, 5, 5, 17, 50),
      totalCount: 23,
    );
    await repository.insertWithDedup(
      id: 'golden_history_2',
      target: 'drug',
      queryJson: codec.encode(const DrugSearchParams(keyword: 'ロサルタン K')),
      searchedAt: DateTime(2026, 5, 5, 7, 15),
      totalCount: 8,
    );
    await container.read(searchScreenProvider.notifier).loadHistory();
  }
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openDiseaseHistory(
  WidgetTester tester,
) async {
  await _seedDiseaseHistory(tester);
  return null;
}

Future<Future<void> Function()?> _seedDiseaseHistory(
  WidgetTester tester,
) async {
  await _selectDiseaseTab(tester);
  for (final element in find.byType(SearchView).evaluate()) {
    final container = ProviderScope.containerOf(element);
    final repository = container.read(searchHistoryRepositoryProvider);
    final codec = container.read(searchQueryCodecProvider);
    await repository.insertWithDedup(
      id: 'golden_disease_history_1',
      target: 'disease',
      queryJson: codec.encode(const DiseaseSearchParams(keyword: '高血圧')),
      searchedAt: DateTime(2026, 5, 5, 17, 40),
      totalCount: 14,
    );
    await repository.insertWithDedup(
      id: 'golden_disease_history_2',
      target: 'disease',
      queryJson: codec.encode(const DiseaseSearchParams(keyword: '糖尿病')),
      searchedAt: DateTime(2026, 5, 5, 6, 10),
      totalCount: 6,
    );
    await container.read(searchScreenProvider.notifier).loadHistory();
  }
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openEmptyHistory(WidgetTester tester) async {
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openDiseaseEmptyHistory(
  WidgetTester tester,
) async {
  await _selectDiseaseTab(tester);
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _performSearch(WidgetTester tester) async {
  await _enterTextAll(
    tester,
    find.byKey(const ValueKey('search-field')),
    'golden keyword',
  );
  await _tapAll(tester, find.byType(FilledButton));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _performPendingSearch(
  WidgetTester tester,
) async {
  await _enterTextAll(
    tester,
    find.byKey(const ValueKey('search-field')),
    'アムロ',
  );
  await _tapAll(tester, find.byType(FilledButton));
  await tester.pump();
  return null;
}

Future<Future<void> Function()?> _triggerLoadingMore(
  WidgetTester tester,
) async {
  await _performSearch(tester);
  await _dragAll(
    tester,
    find.byKey(const PageStorageKey<String>('drugSearchResults')),
    const Offset(0, -820),
  );
  await tester.pump();
  return null;
}

Future<Future<void> Function()?> _performDiseaseSearch(
  WidgetTester tester,
) async {
  await _selectDiseaseTab(tester);
  await _enterTextAll(
    tester,
    find.byKey(const ValueKey('search-field')),
    '高血圧',
  );
  await _tapAll(tester, find.byType(FilledButton));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _performPendingDiseaseSearch(
  WidgetTester tester,
) async {
  await _selectDiseaseTab(tester);
  await _enterTextAll(
    tester,
    find.byKey(const ValueKey('search-field')),
    '高血圧',
  );
  await _tapAll(tester, find.byType(FilledButton));
  await tester.pump();
  return null;
}

Future<Future<void> Function()?> _triggerDiseaseLoadingMore(
  WidgetTester tester,
) async {
  await _performDiseaseSearch(tester);
  await _dragAll(
    tester,
    find.byKey(const PageStorageKey<String>('diseaseSearchResults')),
    const Offset(0, -820),
  );
  await tester.pump();
  return null;
}

Future<Future<void> Function()?> _openDrugFilter(WidgetTester tester) async {
  await _enterTextAll(
    tester,
    find.byKey(const ValueKey('search-field')),
    'アムロ',
  );
  await _tapAll(tester, find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openDiseaseFilter(WidgetTester tester) async {
  await _selectDiseaseTab(tester);
  await _enterTextAll(
    tester,
    find.byKey(const ValueKey('search-field')),
    '高血圧',
  );
  await _tapAll(tester, find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openSort(WidgetTester tester) async {
  await _performSearch(tester);
  await _tapAll(tester, find.textContaining('並び替え'));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openDiseaseSort(WidgetTester tester) async {
  await _performDiseaseSearch(tester);
  await _tapAll(tester, find.textContaining('並び替え'));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _applyDrugFilter(WidgetTester tester) async {
  final elements = find.byType(SearchView).evaluate().toList();
  for (final element in elements) {
    final container = ProviderScope.containerOf(element);
    await container
        .read(searchScreenProvider.notifier)
        .applyDrugFilter(
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
        );
  }
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _applyDiseaseFilter(
  WidgetTester tester,
) async {
  final elements = find.byType(SearchView).evaluate().toList();
  for (final element in elements) {
    final container = ProviderScope.containerOf(element);
    await container
        .read(searchScreenProvider.notifier)
        .changeTab(
          SearchTab.diseases,
        );
    await container
        .read(searchScreenProvider.notifier)
        .applyDiseaseFilter(
          department: ['infectious_disease'],
          chronicity: ['relapsing'],
          onsetPattern: ['intermittent'],
          examCategory: ['blood_test'],
        );
  }
  await tester.pumpAndSettle();
  return null;
}

Future<void> _selectDiseaseTab(WidgetTester tester) async {
  await _tapAll(tester, find.text('疾患'));
  await tester.pumpAndSettle();
}

Future<void> _enterTextAll(
  WidgetTester tester,
  Finder finder,
  String text,
) async {
  final count = finder.evaluate().length;
  for (var index = 0; index < count; index++) {
    await tester.enterText(finder.at(index), text);
  }
}

Future<void> _tapAll(WidgetTester tester, Finder finder) async {
  final count = finder.evaluate().length;
  for (var index = count - 1; index >= 0; index--) {
    await tester.tap(finder.at(index), warnIfMissed: false);
    await tester.pump();
  }
}

Future<void> _dragAll(
  WidgetTester tester,
  Finder finder,
  Offset offset,
) async {
  final count = finder.evaluate().length;
  for (var index = 0; index < count; index++) {
    await tester.drag(finder.at(index), offset, warnIfMissed: false);
    await tester.pump();
  }
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

_MockBaseCacheManager _fallbackImageCacheManager() {
  final cacheManager = _MockBaseCacheManager();
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(StateError('golden tests render the fallback image'));
  return cacheManager;
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

CategoriesResponseDto _categoriesFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_categories.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return CategoriesResponseDto.fromJson(json);
}
