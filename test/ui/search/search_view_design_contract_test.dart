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
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

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
          overrides: [appDatabaseProvider.overrideWithValue(db)],
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

  testWidgets(
    'search field bg matches token searchFieldBg (Light EBEBEF / Dark surface3)',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );

      final lightField = tester.widget<TextField>(
        find.byKey(const ValueKey('search-field')),
      );
      expect(
        lightField.decoration?.fillColor,
        SearchPalette.light.searchFieldBg,
      );

      await tester.pumpWidget(const SizedBox.shrink());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MaterialApp(
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.dark,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );

      final darkField = tester.widget<TextField>(
        find.byKey(const ValueKey('search-field')),
      );
      expect(darkField.decoration?.fillColor, SearchPalette.dark.searchFieldBg);
    },
  );

  testWidgets('SearchView FAB follows Round6 phone metrics', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
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

    final drugApiClient = _MockDrugApiClient();
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

  testWidgets(
    'SearchView sort toolbar label shows current axis and direction',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final drugApiClient = _MockDrugApiClient();
      _stubDrugSearch(drugApiClient);

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

      expect(find.text('並び替え： 更新日(新しい順) ↓ ▾'), findsOneWidget);
      expect(find.text('並び替え'), findsNothing);
    },
  );

  testWidgets('SearchView sort sheet marks selected drug option with check', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final drugApiClient = _MockDrugApiClient();
    _stubDrugSearch(drugApiClient);

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
    await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('search-sort-check-drug-revised')),
      findsOneWidget,
    );
    final selectedTitle = tester.widget<Text>(find.text('更新日(新しい順)').last);
    expect(selectedTitle.style?.fontWeight, FontWeight.w700);
    expect(selectedTitle.style?.color, SearchPalette.light.primary);
  });

  // Design source:
  // Round5/Search - Round 5.html TASK 4 keyboard drag-to-dismiss.
  testWidgets('SearchView result list dismisses keyboard on drag', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
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
      find.byKey(const PageStorageKey<String>('drugSearchResults')),
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

    final drugApiClient = _MockDrugApiClient();
    final categoryApiClient = _MockCategoryApiClient();
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

  testWidgets('SearchView applied chip rail uses Round6 chip visuals', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final drugApiClient = _MockDrugApiClient();
    final categoryApiClient = _MockCategoryApiClient();
    _stubDrugSearch(drugApiClient);
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
    await tester.tap(find.textContaining('結果を見る'));
    await tester.pumpAndSettle();

    final label = tester.widget<Text>(find.text('適用中'));
    expect(label.style?.fontWeight, FontWeight.w700);
    expect(label.style?.letterSpacing, 0.5);
    expect(label.style?.color, SearchPalette.light.muted);

    final chipFinder = find.byKey(
      const ValueKey('search-applied-filter-chip-毒薬'),
    );
    expect(chipFinder, findsOneWidget);
    final chip = tester.widget<DecoratedBox>(chipFinder);
    final decoration = chip.decoration as BoxDecoration;
    expect(decoration.color, SearchPalette.light.primarySoft);
    expect(decoration.border?.top.color, SearchPalette.light.primaryRing);
    expect(decoration.border?.top.width, 0.5);
    expect(decoration.borderRadius, BorderRadius.circular(14));

    final closeFinder = find.byKey(
      const ValueKey('search-applied-filter-close-毒薬'),
    );
    expect(closeFinder, findsOneWidget);
    final close = tester.widget<DecoratedBox>(closeFinder);
    final closeDecoration = close.decoration as BoxDecoration;
    expect(closeDecoration.color, const Color(0x2E007AFF));
    expect(closeDecoration.borderRadius, BorderRadius.circular(8));
  });

  testWidgets(
    'SearchView applied chip rail labels ATC chips with category text',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final drugApiClient = _MockDrugApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      _stubDrugSearch(drugApiClient);
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
      await tester.scrollUntilVisible(
        find.text('ATC 第 1 階層'),
        120,
        scrollable: find
            .descendant(
              of: find.byType(BottomSheet),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('A 消化器系および代謝'),
        80,
        scrollable: find
            .descendant(
              of: find.byType(BottomSheet),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(find.text('A 消化器系および代謝'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      expect(find.text('A 消化器系および代謝'), findsOneWidget);
      expect(find.text('A'), findsNothing);
    },
  );

  testWidgets(
    'SearchView applied chip rail labels therapeutic category chips with '
    'category text',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final drugApiClient = _MockDrugApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      _stubDrugSearch(drugApiClient);
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
      await tester.scrollUntilVisible(
        find.text('薬効分類'),
        120,
        scrollable: find
            .descendant(
              of: find.byType(BottomSheet),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(find.text('薬効分類'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('消化器系および代謝').last,
        80,
        scrollable: find
            .descendant(
              of: find.byType(BottomSheet),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(find.text('消化器系および代謝').last);
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      expect(find.text('消化器系および代謝'), findsWidgets);
      expect(find.text('alimentary_metabolism'), findsNothing);
    },
  );

  // Design source:
  // Round6/round6-screens.jsx FilterSheet phone top=100, radius=20.
  testWidgets('SearchView filter sheet follows Round6 phone geometry', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final categoryApiClient = _MockCategoryApiClient();
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

    final categoryApiClient = _MockCategoryApiClient();
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
  // Round6/round6-screens.jsx FilterChip selected/unselected token contract.
  testWidgets(
    'SearchView drug filter selected chip follows Round6 token contract',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final categoryApiClient = _MockCategoryApiClient();
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
      await tester.tap(find.text('毒薬'));
      await tester.pump();

      final selectedFinder = find.byKey(
        const ValueKey('search-filter-pill-chip-selected-poison'),
      );
      expect(selectedFinder, findsOneWidget);
      final selected = tester.widget<DecoratedBox>(selectedFinder);
      final decoration = selected.decoration as BoxDecoration;
      expect(decoration.color, SearchPalette.light.primarySoft);
      expect(decoration.border?.top.color, SearchPalette.light.primaryRing);
      expect(decoration.border?.top.width, 0.5);
      expect(decoration.borderRadius, BorderRadius.circular(16));
      expect(
        find.descendant(
          of: selectedFinder,
          matching: find.byKey(
            const ValueKey('search-filter-pill-check-poison'),
          ),
        ),
        findsOneWidget,
      );
      final unselectedFinder = find.byKey(
        const ValueKey('search-filter-pill-chip-unselected-potent'),
      );
      expect(unselectedFinder, findsOneWidget);
      final unselected = tester.widget<DecoratedBox>(unselectedFinder);
      final unselectedDecoration = unselected.decoration as BoxDecoration;
      expect(unselectedDecoration.color, SearchPalette.light.surface);
      expect(
        unselectedDecoration.border?.top.color,
        SearchPalette.light.hairline,
      );
      expect(unselectedDecoration.border?.top.width, 0.5);
      expect(find.byType(FilterChip), findsNothing);
    },
  );

  testWidgets('SearchView drug filter footer count updates after chip toggle', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final drugApiClient = _MockDrugApiClient();
    final categoryApiClient = _MockCategoryApiClient();
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
    ).thenAnswer((_) async => _drugListFixture().copyWith(totalCount: 17));
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
    expect(find.text('結果を見る (0 件)'), findsOneWidget);

    await tester.tap(find.text('毒薬'));
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump();

    expect(find.text('結果を見る (17 件)'), findsOneWidget);
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
        overrides: [appDatabaseProvider.overrideWithValue(db)],
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

CategoriesResponseDto _categoriesFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_categories.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return CategoriesResponseDto.fromJson(json);
}
