import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
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

  // Design source:
  // Round6/round6-screens.jsx TopChrome phone metrics.
  // Round6/Search - Round 6 (Light|Dark).html phone state 01.
  testWidgets(
    'SearchView initial phone chrome follows Round6 vertical metrics',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );

      final topChrome = tester.getRect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      expect(topChrome.width, 390);
      expect(topChrome.height, 191);
      expect(segmented.left, 16);
      expect(segmented.width, 358);
      expect(inputRow.height, 40);
      expect(topChrome.bottom - inputRow.bottom, 10);
    },
  );

  testWidgets('SearchView FAB follows Round6 phone metrics', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    final fab = tester.getRect(find.byType(FloatingActionButton));

    expect(fab.width, 56);
    expect(fab.height, 56);
    expect(390 - fab.right, 20);
    expect(844 - fab.bottom, 28);
  });

  // Design source:
  // Round6/round6-screens.jsx S5 ResultToolbar.
  testWidgets('SearchView result toolbar follows Round6 phone metrics', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'アムロ',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    final toolbar = tester.getRect(
      find.byKey(const ValueKey('search-results-toolbar')),
    );

    expect(toolbar.height, 36);
    expect(toolbar.left, 16);
    expect(toolbar.width, 358);
  });

  // Design source:
  // Round5/Search - Round 5.html TASK 4 keyboard drag-to-dismiss.
  testWidgets('SearchView result list dismisses keyboard on drag', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'アムロ',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    final listView = tester.widget<ListView>(
      find.byKey(const ValueKey('search-results-list')),
    );
    expect(
      listView.keyboardDismissBehavior,
      ScrollViewKeyboardDismissBehavior.onDrag,
    );
  });

  // Design source:
  // Round5/Search - Round 5.html TASK 2 chip rail overflow.
  testWidgets('SearchView applied chip rail follows Round5 overflow contract', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    final categoryApiClient = _MockCategoryApiClient();
    addTearDown(db.close);
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
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());

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
          home: const SearchView(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('毒薬'));
    await tester.tap(find.text('劇薬'));
    await tester.tap(find.text('処方箋医薬品'));
    await tester.tap(find.textContaining('結果を見る'));
    await tester.pumpAndSettle();

    final rail = tester.getRect(
      find.byKey(const ValueKey('search-applied-filter-bar')),
    );
    final fade = tester.getRect(
      find.byKey(const ValueKey('search-applied-filter-fade')),
    );
    final chevron = tester.getRect(
      find.byKey(const ValueKey('search-applied-filter-chevron')),
    );

    expect(rail.height, 36);
    expect(fade.right, rail.right);
    expect(fade.width, 30);
    expect(chevron.right, rail.right - 4);
  });

  // Design source:
  // Round6/round6-screens.jsx FilterSheet phone top=100, radius=20.
  testWidgets('SearchView filter sheet follows Round6 phone geometry', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final db = AppDatabase(NativeDatabase.memory());
    final categoryApiClient = _MockCategoryApiClient();
    addTearDown(db.close);
    when(
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final sheet = tester.getRect(
      find.byKey(const ValueKey('search-round6-filter-sheet')),
    );
    final material = tester.widget<Material>(
      find.byKey(const ValueKey('search-round6-filter-sheet-material')),
    );
    final shape = material.shape! as RoundedRectangleBorder;

    expect(sheet.top, 100);
    expect(sheet.left, 0);
    expect(sheet.width, 390);
    expect(sheet.height, 744);
    expect(
      shape.borderRadius,
      const BorderRadius.vertical(top: Radius.circular(20)),
    );
  });

  // Design source:
  // Round6/round6-screens.jsx FilterSheet handle/header/axis policy.
  testWidgets('SearchView drug filter uses the standard Round6 bottom sheet', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final db = AppDatabase(NativeDatabase.memory());
    final categoryApiClient = _MockCategoryApiClient();
    addTearDown(db.close);
    when(
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.text('絞り込み（医薬品）'), findsOneWidget);
    expect(find.text('7 軸 · 軸内 OR / 軸間 AND'), findsOneWidget);
    expect(find.text('リセット'), findsOneWidget);

    final handle = tester.getRect(
      find.byKey(const ValueKey('search-filter-handle')),
    );
    expect(handle.width, 40);
    expect(handle.height, 4);

    expect(find.text('薬事分類'), findsOneWidget);
    expect(find.text('剤形'), findsOneWidget);
    expect(find.text('投与経路'), findsOneWidget);
    expect(find.text('ATC 第 1 階層'), findsOneWidget);
    expect(find.text('薬効分類'), findsOneWidget);
    expect(find.text('副作用キーワード'), findsOneWidget);
    expect(find.text('患者背景'), findsOneWidget);
  });

  // Design source:
  // Round6/round6-screens.jsx TabletFrame and TopChrome gutter=28.
  testWidgets('SearchView tablet chrome follows Round6 gutters', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(834, 1194));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    final topChrome = tester.getRect(
      find.byKey(const ValueKey('search-round6-top-chrome')),
    );
    final segmented = tester.getRect(
      find.byKey(const ValueKey('search-round6-segmented')),
    );
    final inputRow = tester.getRect(
      find.byKey(const ValueKey('search-round6-input-row')),
    );

    expect(topChrome.width, 834);
    expect(segmented.left, 28);
    expect(segmented.width, 778);
    expect(inputRow.left, 28);
    expect(inputRow.width, 778);
    expect(inputRow.height, 44);
  });
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
