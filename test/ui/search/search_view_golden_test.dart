import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  _searchGolden(
    description: 'S1 idle light',
    fileName: 'search_s1_idle_light',
    theme: AppTheme.light(),
  );

  _searchGolden(
    description: 'S1 idle dark',
    fileName: 'search_s1_idle_dark',
    theme: AppTheme.dark(),
  );

  _searchGolden(
    description: 'S2 history light',
    fileName: 'search_s2_history_light',
    theme: AppTheme.light(),
    whilePerforming: _openHistory,
  );

  _searchGolden(
    description: 'S2 history dark',
    fileName: 'search_s2_history_dark',
    theme: AppTheme.dark(),
    whilePerforming: _openHistory,
  );

  _searchGolden(
    description: 'S3 loading light',
    fileName: 'search_s3_loading_light',
    theme: AppTheme.light(),
    responseCompleter: Completer<DrugListResponseDto>(),
    whilePerforming: _performPendingSearch,
  );

  _searchGolden(
    description: 'S3 loading dark',
    fileName: 'search_s3_loading_dark',
    theme: AppTheme.dark(),
    responseCompleter: Completer<DrugListResponseDto>(),
    whilePerforming: _performPendingSearch,
  );

  _searchGolden(
    description: 'S4 loading more light',
    fileName: 'search_s4_loading_more_light',
    theme: AppTheme.light(),
    response: _drugListFixture(),
    page2Completer: Completer<DrugListResponseDto>(),
    whilePerforming: _triggerLoadingMore,
  );

  _searchGolden(
    description: 'S4 loading more dark',
    fileName: 'search_s4_loading_more_dark',
    theme: AppTheme.dark(),
    response: _drugListFixture(),
    page2Completer: Completer<DrugListResponseDto>(),
    whilePerforming: _triggerLoadingMore,
  );

  _searchGolden(
    description: 'S5 drug results light',
    fileName: 'search_s5_drug_results_light',
    theme: AppTheme.light(),
    response: _drugListFixture(),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S5 drug results dark',
    fileName: 'search_s5_drug_results_dark',
    theme: AppTheme.dark(),
    response: _drugListFixture(),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S6 empty light',
    fileName: 'search_s6_empty_light',
    theme: AppTheme.light(),
    response: _drugListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S6 empty dark',
    fileName: 'search_s6_empty_dark',
    theme: AppTheme.dark(),
    response: _drugListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S7 error light',
    fileName: 'search_s7_error_light',
    theme: AppTheme.light(),
    error: DioException(
      requestOptions: RequestOptions(path: '/v1/drugs'),
      type: DioExceptionType.connectionError,
    ),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S8 drug filters light',
    fileName: 'search_s8_filter_drugs_light',
    theme: AppTheme.light(),
    whilePerforming: _openDrugFilter,
  );

  _searchGolden(
    description: 'S8 drug filters dark',
    fileName: 'search_s8_filter_drugs_dark',
    theme: AppTheme.dark(),
    whilePerforming: _openDrugFilter,
  );

  _searchGolden(
    description: 'S9 disease filters light',
    fileName: 'search_s9_filter_diseases_light',
    theme: AppTheme.light(),
    whilePerforming: _openDiseaseFilter,
  );

  _searchGolden(
    description: 'S9 disease filters dark',
    fileName: 'search_s9_filter_diseases_dark',
    theme: AppTheme.dark(),
    whilePerforming: _openDiseaseFilter,
  );

  _searchGolden(
    description: 'S10 sort light',
    fileName: 'search_s10_sort_light',
    theme: AppTheme.light(),
    response: _drugListFixture(),
    whilePerforming: _openSort,
  );

  _searchGolden(
    description: 'S10 sort dark',
    fileName: 'search_s10_sort_dark',
    theme: AppTheme.dark(),
    response: _drugListFixture(),
    whilePerforming: _openSort,
  );

  _searchGolden(
    description: 'T1 tablet history light',
    fileName: 'search_t1_tablet_history_light',
    theme: AppTheme.light(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    whilePerforming: _openHistory,
  );

  _searchGolden(
    description: 'T1 tablet history dark',
    fileName: 'search_t1_tablet_history_dark',
    theme: AppTheme.dark(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    whilePerforming: _openHistory,
  );

  _searchGolden(
    description: 'T2 tablet results light',
    fileName: 'search_t2_tablet_results_light',
    theme: AppTheme.light(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    response: _drugListFixture(),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'T2 tablet results dark',
    fileName: 'search_t2_tablet_results_dark',
    theme: AppTheme.dark(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    response: _drugListFixture(),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'T3 tablet drug filters light',
    fileName: 'search_t3_tablet_filter_light',
    theme: AppTheme.light(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    whilePerforming: _openDrugFilter,
  );

  _searchGolden(
    description: 'T3 tablet drug filters dark',
    fileName: 'search_t3_tablet_filter_dark',
    theme: AppTheme.dark(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    whilePerforming: _openDrugFilter,
  );

  _searchGolden(
    description: 'S7 error dark',
    fileName: 'search_s7_error_dark',
    theme: AppTheme.dark(),
    error: DioException(
      requestOptions: RequestOptions(path: '/v1/drugs'),
      type: DioExceptionType.connectionError,
    ),
    whilePerforming: _performSearch,
  );
}

void _searchGolden({
  required String description,
  required String fileName,
  required ThemeData theme,
  BoxConstraints constraints = const BoxConstraints.tightFor(
    width: 390,
    height: 844,
  ),
  DrugListResponseDto? response,
  Completer<DrugListResponseDto>? responseCompleter,
  Completer<DrugListResponseDto>? page2Completer,
  Object? error,
  Interaction? whilePerforming,
}) {
  unawaited(
    goldenTest(
      description,
      fileName: fileName,
      constraints: constraints,
      builder: () {
        final db = AppDatabase(NativeDatabase.memory());
        final drugApiClient = _MockDrugApiClient();
        final categoryApiClient = _MockCategoryApiClient();
        when(
          categoryApiClient.getCategories,
        ).thenAnswer((_) async => _categoriesFixture());
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
        return ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: MaterialApp(
            theme: theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        );
      },
      whilePerforming: whilePerforming,
    ),
  );
}

Future<Future<void> Function()?> _openHistory(WidgetTester tester) async {
  final context = tester.element(find.byType(SearchView));
  final container = ProviderScope.containerOf(context);
  final repository = container.read(searchHistoryRepositoryProvider);
  final codec = container.read(searchQueryCodecProvider);
  await repository.insertWithDedup(
    id: 'golden_history_1',
    target: 'drug',
    queryJson: codec.encode(const DrugSearchParams(keyword: 'アムロジピン')),
    searchedAt: DateTime.utc(2026, 5, 5, 8, 50),
    totalCount: 23,
  );
  await repository.insertWithDedup(
    id: 'golden_history_2',
    target: 'drug',
    queryJson: codec.encode(const DrugSearchParams(keyword: 'ロサルタン K')),
    searchedAt: DateTime.utc(2026, 5, 4, 22, 15),
    totalCount: 8,
  );
  await tester.tap(find.byKey(const ValueKey('search-field')));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _performSearch(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const ValueKey('search-field')),
    'golden keyword',
  );
  await tester.tap(find.byType(FilledButton).first);
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _performPendingSearch(
  WidgetTester tester,
) async {
  await tester.enterText(
    find.byKey(const ValueKey('search-field')),
    'アムロ',
  );
  await tester.tap(find.byType(FilledButton).first);
  await tester.pump();
  return null;
}

Future<Future<void> Function()?> _triggerLoadingMore(
  WidgetTester tester,
) async {
  await _performSearch(tester);
  await tester.drag(
    find.byKey(const ValueKey('search-results-list')),
    const Offset(0, -820),
  );
  await tester.pump();
  return null;
}

Future<Future<void> Function()?> _openDrugFilter(WidgetTester tester) async {
  await tester.enterText(find.byKey(const ValueKey('search-field')), 'アムロ');
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openDiseaseFilter(WidgetTester tester) async {
  await tester.tap(find.text('疾患'));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const ValueKey('search-field')), '高血圧');
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  return null;
}

Future<Future<void> Function()?> _openSort(WidgetTester tester) async {
  await _performSearch(tester);
  await tester.tap(find.text('並び替え'));
  await tester.pumpAndSettle();
  return null;
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}

CategoriesResponseDto _categoriesFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_categories.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return CategoriesResponseDto.fromJson(json);
}
