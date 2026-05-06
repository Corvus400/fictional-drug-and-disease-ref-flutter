import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_app_database.dart';

void main() {
  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  late AppDatabase db;

  setUpAll(() {
    db = createTestAppDatabase();
  });

  tearDown(() async {
    await clearTestAppDatabase(db);
  });

  tearDownAll(() async {
    await db.close();
  });

  testWidgets('ATC 第1階層軸の hint は単一選択ラベルになる', (tester) async {
    final categoryApiClient = _MockCategoryApiClient();
    final drugApiClient = _MockDrugApiClient();
    when(
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());
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

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('ATC 第 1 階層'), findsOneWidget);
    expect(find.text('14 値・単一選択'), findsOneWidget);
    expect(find.text('14 値・複数選択 OR'), findsNothing);
  });
}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

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

DrugListResponseDto _drugListFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_drugs.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}
