import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_helpers.dart';
import '../../helpers/test_app_database.dart';

late AppDatabase _db;

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
    _db = createTestAppDatabase();
  });

  tearDown(() async {
    await clearTestAppDatabase(_db);
  });

  tearDownAll(() async {
    await _db.close();
  });

  _ribbonGolden('phone');
  _ribbonGolden('tablet');
  _screenChromeGolden('search', _searchBody);
  _screenChromeGolden('drug_detail', _drugDetailBody);
  _screenChromeGolden('disease_detail', _diseaseDetailBody);
}

void _ribbonGolden(String sizeName) {
  runGoldenMatrix(
    fileNamePrefix: 'disclaimer_ribbon_$sizeName',
    description: 'DisclaimerRibbon $sizeName',
    sizes: [sizeName],
    textScalers: const ['normal'],
    builder: (theme, size, scaler) => MaterialApp(
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: DisclaimerRibbon(),
        ),
      ),
    ),
  );
}

void _screenChromeGolden(
  String name,
  Widget Function(ThemeData theme) bodyBuilder,
) {
  runGoldenMatrix(
    fileNamePrefix: 'disclaimer_shell_$name',
    description: 'Disclaimer shell $name',
    sizes: const ['phone', 'tablet'],
    textScalers: const ['normal'],
    builder: (theme, size, scaler) => _withProviders(
      name,
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: bodyBuilder(theme),
          bottomNavigationBar: AppShellBottomNavigation(
            selectedIndex: 0,
            onDestinationSelected: (_) {},
          ),
        ),
      ),
    ),
    whilePerforming: (tester) async {
      await tester.pump();
      await tester.pumpAndSettle();
      return null;
    },
  );
}

Widget _searchBody(ThemeData theme) {
  return SearchView(currentTime: DateTime.utc(2026, 5, 5, 9));
}

Widget _drugDetailBody(ThemeData theme) {
  return DrugDetailView(id: _drugFixture().id);
}

Widget _diseaseDetailBody(ThemeData theme) {
  return DiseaseDetailView(id: _diseaseFixture().id);
}

Widget _withProviders(String name, Widget child) {
  final drugDto = _drugFixture();
  final diseaseDto = _diseaseFixture();
  final drugApiClient = _MockDrugApiClient();
  final diseaseApiClient = _MockDiseaseApiClient();
  final categoryApiClient = _MockCategoryApiClient();
  final fallbackCacheManager = _fallbackImageCacheManager();
  final fileCacheManager = _mockCacheManagerWithImage('$name-detail.png');

  when(categoryApiClient.getCategories).thenAnswer(
    (_) async => _categoriesFixture(),
  );
  when(
    () => drugApiClient.getDrug(any()),
  ).thenAnswer((_) async => drugDto);
  when(
    () => diseaseApiClient.getDisease(any()),
  ).thenAnswer((_) async => diseaseDto);
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
  ).thenAnswer((_) async => _diseaseListFixture());

  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(_db),
      drugApiClientProvider.overrideWithValue(drugApiClient),
      diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
      categoryApiClientProvider.overrideWithValue(categoryApiClient),
      drugCardImageCacheManagerProvider.overrideWithValue(fallbackCacheManager),
      drugDetailHeroImageCacheManagerProvider.overrideWithValue(
        fileCacheManager,
      ),
      streamBookmarkStateProvider(
        drugDto.id,
      ).overrideWith((ref) => const Stream<bool>.empty()),
      streamBookmarkStateProvider(
        diseaseDto.id,
      ).overrideWith((ref) => const Stream<bool>.empty()),
    ],
    child: child,
  );
}

_MockBaseCacheManager _fallbackImageCacheManager() {
  final cacheManager = _MockBaseCacheManager();
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(StateError('golden tests render fallback images'));
  return cacheManager;
}

_MockBaseCacheManager _mockCacheManagerWithImage(String name) {
  final cacheManager = _MockBaseCacheManager();
  final imageFile = _writeTestImageFile(name);
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenAnswer((_) async => imageFile);
  return cacheManager;
}

file.File _writeTestImageFile(String name) {
  const fileSystem = LocalFileSystem();
  final ioFile = File('${Directory.systemTemp.path}/$name');
  final bytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAIAAAADCAYAAAC56t6BAAAAG0lEQVR4nGPQj978/'
    '86GG/8Z/gMBiMMA4oEAAPBbEzen1b62AAAAAElFTkSuQmCC',
  );
  ioFile.writeAsBytesSync(bytes);
  return fileSystem.file(ioFile.path);
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

DrugDto _drugFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_drugs__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}

DiseaseDto _diseaseFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_diseases__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}
