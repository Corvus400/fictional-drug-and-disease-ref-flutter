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
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../helpers/test_app_database.dart';

part 'search_view_design_phone_chrome_contract.part.dart';

part 'search_view_design_utility_pane_contract.part.dart';

part 'search_view_design_result_cards_sort_contract.part.dart';

part 'search_view_design_utility_keyboard_history_contract.part.dart';

part 'search_view_design_result_list_chip_rail_contract.part.dart';
part 'search_view_design_filter_sheet_contract.part.dart';
part 'search_view_design_overflow_tablet_contract.part.dart';

late AppDatabase db;

void main() {
  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  setUpAll(() {
    db = createTestAppDatabase();
  });

  _searchViewDesignPhoneChromeContractTests();
  _searchViewDesignUtilityPaneContractTests();
  _searchViewDesignResultCardsSortContractTests();
  _searchViewDesignUtilityKeyboardHistoryContractTests();
  _searchViewDesignResultListChipRailContractTests();
  _searchViewDesignFilterSheetContractTests();
  _searchViewDesignOverflowTabletContractTests();

  tearDown(() async {
    await clearTestAppDatabase(db);
  });

  tearDownAll(() async {
    await db.close();
  });

  // Design source:
  // Round6/round6-screens.jsx TopChrome phone metrics, with the tab title now
  // owned by AppTabHeader.

  // Design source:
  // Round6/round6-screens.jsx S5 ResultToolbar.

  // Design source:
  // Round5/Search - Round 5.html TASK 4 keyboard drag-to-dismiss.

  // Design source:
  // Round5/Search - Round 5.html TASK 2 chip rail overflow.

  // Design source:
  // Round6/round6-screens.jsx FilterSheet phone top=100, radius=20.

  // Design source:
  // Round6/round6-screens.jsx FilterSheet handle/header/axis policy.

  // Design source:
  // Round6/round6-screens.jsx FilterSheet red-box contract from 15.47.48.png.

  // Design source:
  // Round6/round6-screens.jsx TabletFrame and TopChrome gutter=28.
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

List<Override> _baseOverrides(AppDatabase db) {
  return [
    appDatabaseProvider.overrideWithValue(db),
    _categoryApiClientOverride(),
  ];
}

Override _categoryApiClientOverride() {
  final categoryApiClient = _MockCategoryApiClient();
  when(categoryApiClient.getCategories).thenAnswer(
    (_) async => _categoriesFixture(),
  );
  return categoryApiClientProvider.overrideWithValue(categoryApiClient);
}

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
      keywordMatch: any(named: 'keywordMatch'),
      keywordTarget: any(named: 'keywordTarget'),
      adverseReactionKeyword: any(named: 'adverseReactionKeyword'),
      precautionCategory: any(named: 'precautionCategory'),
      sort: any(named: 'sort'),
    ),
  ).thenAnswer((_) async => _drugListFixture());
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

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _pumpSearchViewWithDrugResults(
  WidgetTester tester,
  AppDatabase db, {
  DrugListResponseDto? response,
  MediaQueryData? mediaQueryData,
}) async {
  final drugApiClient = _MockDrugApiClient();
  final categoryApiClient = _MockCategoryApiClient();
  when(categoryApiClient.getCategories).thenAnswer(
    (_) async => _categoriesFixture(),
  );
  if (response == null) {
    _stubDrugSearch(drugApiClient);
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
    ).thenAnswer((_) async => response);
  }

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        drugApiClientProvider.overrideWithValue(drugApiClient),
        categoryApiClientProvider.overrideWithValue(categoryApiClient),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: mediaQueryData == null
            ? const SearchView()
            : MediaQuery(
                data: mediaQueryData,
                child: const SearchView(),
              ),
      ),
    ),
  );

  await tester.enterText(
    find.byKey(const ValueKey('search-field')),
    'アムロ',
  );
  await tester.tap(find.byKey(const ValueKey('search-submit-button')));
  await tester.pumpAndSettle();
}
