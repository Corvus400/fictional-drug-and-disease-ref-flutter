import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

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
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../helpers/test_app_database.dart';

part 'search_view_chrome_inline_history.part.dart';

part 'search_view_history_dropdown.part.dart';

part 'search_view_results_navigation.part.dart';

part 'search_view_filters_states.part.dart';

part 'search_view_cards_sort.part.dart';

late AppDatabase db;

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  setUp(() {
    binding.platformDispatcher.views.single
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
  });

  setUpAll(() {
    db = createTestAppDatabase();
  });

  _searchViewChromeInlineHistoryTests();
  _searchViewHistoryDropdownTests();
  _searchViewResultsNavigationTests();
  _searchViewFiltersStatesTests();
  _searchViewCardsSortTests();

  tearDown(() async {
    binding.platformDispatcher.views.single
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
    await clearTestAppDatabase(db);
  });

  tearDownAll(() async {
    await db.close();
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

file.File _writeTestImageFile(String name) {
  const fileSystem = LocalFileSystem();
  final ioFile = File('${Directory.systemTemp.path}/$name');
  final bytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAFgwJ/'
    'l6cG7wAAAABJRU5ErkJggg==',
  );
  ioFile.writeAsBytesSync(
    bytes,
  );
  return fileSystem.file(ioFile.path);
}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}

DrugListResponseDto _scrollRestorationFixture({required int page}) {
  final fixture = _drugListFixture();
  final base = fixture.items.first;
  return fixture.copyWith(
    items: [
      for (var index = 0; index < 20; index++)
        base.copyWith(
          id: 'scroll_drug_${page}_$index',
          brandName: 'Scroll Drug $page-$index',
          genericName: 'Scroll Generic $page-$index',
        ),
    ],
    page: page,
    pageSize: 20,
    totalPages: 3,
    totalCount: 60,
  );
}

DiseaseListResponseDto _diseaseListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseListResponseDto.fromJson(json);
}

DiseaseListResponseDto _diseaseListFixtureForChapter(String chapter) {
  return DiseaseListResponseDto.fromJson({
    'items': [
      {
        'id': 'disease_chapter_contract',
        'name': 'サンプル疾患',
        'icd10_chapter': chapter,
        'medical_department': ['internal_medicine'],
        'chronicity': 'chronic',
        'infectious': false,
        'name_kana': 'サンプルシッカン',
        'revised_at': '2026-04-17',
      },
    ],
    'page': 1,
    'page_size': 20,
    'total_pages': 1,
    'total_count': 1,
    'disclaimer': 'FICTIONAL DATA - NOT FOR MEDICAL USE / 架空データ・医療判断には使用不可',
  });
}

CategoriesResponseDto _categoriesFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_categories.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return CategoriesResponseDto.fromJson(json);
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
