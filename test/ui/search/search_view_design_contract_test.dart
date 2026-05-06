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
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
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

  testWidgets('SearchView FAB uses Round6 colors in both modes', (
    tester,
  ) async {
    Future<void> pumpWithTheme(ThemeData theme, {ThemeMode? themeMode}) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MaterialApp(
            theme: themeMode == ThemeMode.dark ? AppTheme.light() : theme,
            darkTheme: themeMode == ThemeMode.dark ? theme : null,
            themeMode: themeMode ?? ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );
    }

    await pumpWithTheme(AppTheme.light());
    var fab = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );
    expect(fab.backgroundColor, SearchPalette.light.filterFabBg);
    expect(fab.foregroundColor, SearchPalette.light.filterFabFg);

    await tester.pumpWidget(const SizedBox.shrink());
    await pumpWithTheme(AppTheme.dark(), themeMode: ThemeMode.dark);
    fab = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );
    expect(fab.backgroundColor, SearchPalette.dark.filterFabBg);
    expect(fab.foregroundColor, SearchPalette.dark.filterFabFg);
  });

  testWidgets('search submit button uses Round6 primary palette and radius', (
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

    final button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('search-submit-button')),
    );
    final shape = button.style?.shape?.resolve(<WidgetState>{});

    expect(
      button.style?.backgroundColor?.resolve(<WidgetState>{}),
      SearchPalette.light.searchPrimaryActionBg,
    );
    expect(
      button.style?.foregroundColor?.resolve(<WidgetState>{}),
      SearchPalette.light.searchPrimaryActionFg,
    );
    expect(
      (shape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(SearchConstants.searchButtonRadius),
    );
    final label = tester.widget<Text>(
      find.descendant(
        of: find.byKey(const ValueKey('search-submit-button')),
        matching: find.text('検索'),
      ),
    );
    expect(label.style?.fontWeight, FontWeight.w700);
  });

  testWidgets('dark search submit button uses Round6 primary button colors', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    final button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('search-submit-button')),
    );

    expect(
      button.style?.backgroundColor?.resolve(<WidgetState>{}),
      SearchPalette.dark.searchPrimaryActionBg,
    );
    expect(
      button.style?.foregroundColor?.resolve(<WidgetState>{}),
      SearchPalette.dark.searchPrimaryActionFg,
    );
  });

  testWidgets('error retry CTA uses Round6 primary palette and radius', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v1/drugs'),
        type: DioExceptionType.connectionError,
      ),
    );

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
      'network failure keyword',
    );
    await tester.tap(find.byKey(const ValueKey('search-submit-button')));
    await tester.pumpAndSettle();

    final ctaFinder = find.byKey(const ValueKey('search-error-retry-cta'));
    final cta = tester.widget<FilledButton>(ctaFinder);
    final shape = cta.style?.shape?.resolve(<WidgetState>{});

    expect(
      tester.getSize(ctaFinder).height,
      SearchConstants.searchErrorCtaHeight,
    );
    expect(
      cta.style?.backgroundColor?.resolve(<WidgetState>{}),
      SearchPalette.light.searchPrimaryActionBg,
    );
    expect(
      cta.style?.foregroundColor?.resolve(<WidgetState>{}),
      SearchPalette.light.searchPrimaryActionFg,
    );
    expect(
      (shape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(SearchConstants.searchErrorCtaRadius),
    );
  });

  testWidgets('empty recovery CTAs use Round6 sizes, palette, and radius', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
      ),
    ).thenAnswer(
      (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
    );

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
      'empty keyword',
    );
    await tester.tap(find.byKey(const ValueKey('search-submit-button')));
    await tester.pumpAndSettle();

    final title = tester.widget<Text>(find.text('該当する結果がありません'));
    final subtitle = tester.widget<Text>(
      find.text('検索キーワードや絞り込みを\n見直してください。'),
    );
    final resetFinder = find.byKey(const ValueKey('search-empty-reset-cta'));
    final removeFinder = find.byKey(
      const ValueKey('search-empty-remove-one-cta'),
    );
    final reset = tester.widget<FilledButton>(resetFinder);
    final remove = tester.widget<OutlinedButton>(removeFinder);
    final resetShape = reset.style?.shape?.resolve(<WidgetState>{});
    final removeShape = remove.style?.shape?.resolve(<WidgetState>{});

    expect(title.style?.fontWeight, FontWeight.w700);
    expect(subtitle.textAlign, TextAlign.center);
    expect(
      tester.getSize(resetFinder).height,
      SearchConstants.searchEmptyCtaHeight,
    );
    expect(
      reset.style?.backgroundColor?.resolve(<WidgetState>{}),
      SearchPalette.light.searchPrimaryActionBg,
    );
    expect(
      reset.style?.foregroundColor?.resolve(<WidgetState>{}),
      SearchPalette.light.searchPrimaryActionFg,
    );
    expect(
      (resetShape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
    );
    expect(
      tester.getSize(removeFinder).height,
      SearchConstants.searchEmptyCtaHeight,
    );
    expect(
      remove.style?.foregroundColor?.resolve(<WidgetState>{}),
      SearchPalette.light.primary,
    );
    expect(
      remove.style?.side?.resolve(<WidgetState>{})?.color,
      SearchPalette.light.primaryRing,
    );
    expect(
      (removeShape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
    );
    final resetRect = tester.getRect(resetFinder);
    final removeRect = tester.getRect(removeFinder);
    expect(removeRect.top - resetRect.bottom, 8);
    final resetLabel = tester.widget<Text>(
      find.descendant(
        of: resetFinder,
        matching: find.text('条件をリセット'),
      ),
    );
    final removeLabel = tester.widget<Text>(
      find.descendant(
        of: removeFinder,
        matching: find.text('絞り込みを 1 つずつ外す'),
      ),
    );
    expect(resetLabel.style?.fontWeight, FontWeight.w700);
    expect(removeLabel.style?.fontWeight, FontWeight.w700);
  });

  testWidgets('filter sheet close icon uses Round6 primary color', (
    tester,
  ) async {
    final categoryApiClient = _MockCategoryApiClient();
    final drugApiClient = _MockDrugApiClient();
    _stubDrugSearch(drugApiClient);
    when(categoryApiClient.getCategories).thenAnswer(
      (_) async => _categoriesFixture(),
    );

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

    final closeButton = tester.widget<IconButton>(
      find.byKey(const ValueKey('filter-sheet-close-icon')),
    );
    final closeIcon = closeButton.icon as Icon;

    expect(closeIcon.icon, Icons.close);
    expect(closeIcon.color, SearchPalette.light.primary);
  });

  testWidgets('FAB badge uses Round6 custom +N geometry and colors', (
    tester,
  ) async {
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

    final context = tester.element(find.byType(SearchView));
    await ProviderScope.containerOf(context)
        .read(searchScreenProvider.notifier)
        .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
    await tester.pumpAndSettle();

    final badgeFinder = find.byKey(const ValueKey('search-fab-badge'));
    final badge = tester.widget<Container>(badgeFinder);
    final decoration = badge.decoration! as BoxDecoration;
    final text = tester.widget<Text>(
      find.descendant(of: badgeFinder, matching: find.text('+2')),
    );

    expect(tester.getSize(badgeFinder).width, greaterThanOrEqualTo(24));
    expect(tester.getSize(badgeFinder).height, 22);
    expect(decoration.color, SearchPalette.light.danger);
    expect(decoration.borderRadius, BorderRadius.circular(11));
    expect(decoration.border?.top.width, 2);
    expect(decoration.border?.top.color, SearchPalette.light.background);
    expect(text.style?.color, Colors.white);
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

  testWidgets('drug card image uses 2:3 aspect ratio', (tester) async {
    await _pumpSearchViewWithDrugResults(tester, db);

    final imageFinder = find.byKey(const ValueKey('drug-image-drug_0080'));
    expect(imageFinder, findsOneWidget);
    final size = tester.getSize(imageFinder);

    expect(
      size.width / size.height,
      closeTo(SearchConstants.searchDrugCardImageAspectRatio, 0.01),
      reason: 'image should be 2:3 to match native 512x768 source',
    );
  });

  testWidgets('drug card image keeps file cache sizing key', (tester) async {
    await _pumpSearchViewWithDrugResults(tester, db);

    expect(find.byKey(const ValueKey('drug-image-drug_0080')), findsOneWidget);
  });

  testWidgets('drug card cacheManager is non-null', (tester) async {
    await _pumpSearchViewWithDrugResults(tester, db);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(SearchView)),
    );
    expect(container.read(drugCardImageCacheManagerProvider), isNotNull);
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

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract',
    (
      tester,
    ) async {
      await _pumpSearchViewWithDrugResults(tester, db);

      await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
      await tester.pumpAndSettle();

      final sheet = tester.widget<Material>(
        find.byKey(const ValueKey('search-sort-sheet')),
      );
      final handle = tester.widget<DecoratedBox>(
        find.byKey(const ValueKey('search-sort-sheet-handle')),
      );
      final header = tester.widget<Text>(
        find.descendant(
          of: find.byKey(const ValueKey('search-sort-sheet-header')),
          matching: find.text('並び替え'),
        ),
      );
      final firstRow = tester.widget<InkWell>(
        find.byKey(const ValueKey('search-sort-row-drug-revised')),
      );
      final firstDivider = tester.widget<Divider>(
        find.byKey(const ValueKey('search-sort-divider-drug-revised')),
      );
      final selectedLabel = tester.widget<Text>(
        find.descendant(
          of: find.byKey(const ValueKey('search-sort-row-drug-revised')),
          matching: find.text('更新日(新しい順)'),
        ),
      );
      final selectedCheck = tester.widget<Icon>(
        find.byKey(const ValueKey('search-sort-check-drug-revised')),
      );

      expect(sheet.color, SearchPalette.light.surface);
      expect(
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      );
      expect(
        (handle.decoration as BoxDecoration).color,
        SearchPalette.light.hairline,
      );
      expect(header.style?.color, SearchPalette.light.ink);
      expect(header.style?.fontWeight, FontWeight.w700);
      expect(firstRow.borderRadius, BorderRadius.zero);
      expect(firstDivider.color, SearchPalette.light.hairline2);
      expect(selectedLabel.style?.color, SearchPalette.light.primary);
      expect(selectedLabel.style?.fontWeight, FontWeight.w700);
      expect(selectedCheck.color, SearchPalette.light.primary);
      expect(selectedCheck.size, 16);
    },
  );

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

  testWidgets('history dropdown follows Round6 divider and keyboard geometry', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    final codec = container.read(searchQueryCodecProvider);
    final repository = container.read(searchHistoryRepositoryProvider);
    for (var index = 0; index < 5; index += 1) {
      await repository.insertWithDedup(
        id: 'round6_keyboard_history_$index',
        target: 'drug',
        queryJson: codec.encode(
          DrugSearchParams(keyword: 'キーボード履歴$index'),
        ),
        searchedAt: DateTime.utc(2026, 5, 5, 9, index),
        totalCount: index + 1,
      );
    }

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MediaQuery(
            data: MediaQueryData(
              size: Size(390, 844),
              viewInsets: EdgeInsets.only(bottom: 300),
            ),
            child: SearchView(),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pumpAndSettle();

    final dropdown = tester.getRect(
      find.byKey(const ValueKey('search-history-dropdown')),
    );
    final divider = tester.widget<Divider>(
      find.byKey(
        const ValueKey('search-history-row-divider-round6_keyboard_history_4'),
      ),
    );

    expect(dropdown.height, lessThanOrEqualTo(250));
    expect(divider.color, SearchPalette.light.hairline2);
    expect(divider.thickness, 0.5);
    expect(find.text('キーボード履歴4'), findsOneWidget);
  });

  testWidgets('history actions follow Round6 light controls', (tester) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    final codec = container.read(searchQueryCodecProvider);
    final repository = container.read(searchHistoryRepositoryProvider);
    await repository.insertWithDedup(
      id: 'round6_history_action',
      target: 'drug',
      queryJson: codec.encode(const DrugSearchParams(keyword: 'アムロジピン')),
      searchedAt: DateTime.utc(2026, 5, 5, 8, 50),
      totalCount: 23,
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(currentTime: DateTime.utc(2026, 5, 5, 9)),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pumpAndSettle();

    final clearButton = tester.widget<TextButton>(
      find.byKey(const ValueKey('clear-history-button')),
    );
    final clearLabel = clearButton.child! as Text;
    expect(clearLabel.style?.fontWeight, FontWeight.w700);
    expect(clearLabel.style?.color, SearchPalette.light.primary);

    final deleteBgFinder = find.byKey(
      const ValueKey('search-history-delete-bg-round6_history_action'),
    );
    expect(deleteBgFinder, findsOneWidget);
    final deleteBg = tester.widget<DecoratedBox>(deleteBgFinder);
    final decoration = deleteBg.decoration as BoxDecoration;
    expect(decoration.color, SearchPalette.light.surface3);
    expect(decoration.borderRadius, BorderRadius.circular(11));
    expect(tester.getSize(deleteBgFinder), const Size(22, 22));

    final deleteIcon = tester.widget<Icon>(
      find.descendant(of: deleteBgFinder, matching: find.byIcon(Icons.close)),
    );
    expect(deleteIcon.size, 9);
    expect(deleteIcon.color, SearchPalette.light.muted);
  });

  testWidgets('focused search cancel follows Round6 bold action text', (
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

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pumpAndSettle();

    final cancel = tester.widget<Text>(find.text('キャンセル'));
    expect(cancel.style?.color, SearchPalette.light.primary);
    expect(cancel.style?.fontWeight, FontWeight.w700);
  });

  testWidgets('loading-more footer uses Round6 spinner and progress text', (
    tester,
  ) async {
    final page2 = Completer<DrugListResponseDto>();
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
      ),
    ).thenAnswer((invocation) {
      final page = invocation.namedArguments[#page] as int?;
      if (page == 2) {
        return page2.future;
      }
      final fixture = _drugListFixture();
      return Future.value(
        fixture.copyWith(items: fixture.items.take(4).toList()),
      );
    });
    when(
      () => drugApiClient.getDrugs(
        page: 2,
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
    ).thenAnswer((_) => page2.future);

    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        drugApiClientProvider.overrideWithValue(drugApiClient),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
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
      'loading more keyword',
    );
    await tester.tap(find.byKey(const ValueKey('search-submit-button')));
    await tester.pumpAndSettle();
    unawaited(container.read(searchScreenProvider.notifier).loadMore());
    await tester.pump();
    expect(
      container.read(searchScreenProvider).phase,
      isA<SearchPhaseLoadingMore>(),
    );
    await tester.drag(
      find.byKey(const PageStorageKey<String>('drugSearchResults')),
      const Offset(0, -3000),
    );
    await tester.pump();

    final footerFinder = find.byKey(const ValueKey('search-load-more-footer'));
    final footer = tester.widget<DecoratedBox>(footerFinder);
    final decoration = footer.decoration as BoxDecoration;
    final spinner = tester.widget<CircularProgressIndicator>(
      find.byKey(const ValueKey('search-load-more-spinner')),
    );

    expect(find.text('さらに読み込む · 1 / 6'), findsOneWidget);
    expect(spinner.strokeWidth, 2);
    expect(spinner.color, SearchPalette.light.primary);
    expect(decoration.color, SearchPalette.light.surface);
    expect(decoration.border?.top.color, SearchPalette.light.hairline);
    expect(decoration.borderRadius, BorderRadius.circular(10));

    page2.complete(_drugListFixture().copyWith(page: 2));
  });

  testWidgets('result list reserves Round6 bottom padding from SSOT', (
    tester,
  ) async {
    final fixture = _drugListFixture();
    await _pumpSearchViewWithDrugResults(
      tester,
      db,
      response: fixture.copyWith(items: fixture.items.take(1).toList()),
    );

    final spacer = tester.widget<SizedBox>(
      find.byKey(const ValueKey('search-results-bottom-padding')),
    );

    expect(spacer.height, SearchConstants.searchListBottomPadding);
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
    await _tapVisible(tester, find.text('毒薬'));
    await _tapVisible(tester, find.text('劇薬'));
    await _tapVisible(tester, find.text('処方箋医薬品'));
    await _tapVisible(tester, find.text('剤形'));
    await _tapVisible(tester, find.text('錠剤'));
    await _tapVisible(tester, find.text('投与経路'));
    await _tapVisible(tester, find.text('内服'));
    await _tapVisible(tester, find.textContaining('結果を見る'));
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

    expect(rail.left, 0);
    expect(rail.right, 390);
    expect(rail.height, 48);
    expect(fade.right, rail.right);
    expect(fade.width, 30);
    expect(chevron.right, rail.right - 4);
  });

  testWidgets('chip_bar_chevron_visibility_matches_scrollability_(T09)', (
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
    await tester.tap(find.textContaining('結果を見る'));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('search-applied-filter-chevron')),
      findsNothing,
    );
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
    final drugApiClient = _MockDrugApiClient();
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
    final drugApiClient = _MockDrugApiClient();
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

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.text('絞り込み（医薬品）'), findsOneWidget);
    expect(find.text('7 軸 · 軸内 OR / 軸間 AND'), findsOneWidget);
    expect(find.text('リセット'), findsOneWidget);

    final handle = tester.getRect(
      find.byKey(const ValueKey('search-filter-handle')),
    );
    expect(handle.width, 40);
    expect(handle.height, 4);

    expect(find.text('規制区分'), findsOneWidget);
    expect(find.text('剤形'), findsOneWidget);
    expect(find.text('投与経路'), findsOneWidget);
    expect(find.text('ATC 第 1 階層'), findsOneWidget);
    expect(find.text('薬効分類'), findsOneWidget);
    expect(find.text('副作用キーワード'), findsOneWidget);
    expect(find.text('患者背景'), findsOneWidget);
  });

  // Design source:
  // Round6/round6-screens.jsx FilterSheet red-box contract from 15.47.48.png.
  testWidgets(
    'SearchView drug filter red-box controls follow Round6 light contract',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final categoryApiClient = _MockCategoryApiClient();
      final drugApiClient = _MockDrugApiClient();
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
      await tester.tap(find.text('劇薬'));
      await tester.pump();
      await tester.tap(find.text('処方箋医薬品'));
      await tester.pump();

      final selectedFinder = find.byKey(
        const ValueKey('search-filter-pill-chip-selected-potent'),
      );
      expect(selectedFinder, findsOneWidget);
      final selected = tester.widget<DecoratedBox>(selectedFinder);
      final decoration = selected.decoration as BoxDecoration;
      expect(decoration.color, SearchPalette.light.primarySoft);
      expect(decoration.border?.top.color, SearchPalette.light.primaryRing);
      expect(decoration.border?.top.width, 0.5);
      expect(decoration.borderRadius, BorderRadius.circular(14));
      expect(tester.getSize(selectedFinder).height, 30);
      expect(
        DefaultTextStyle.of(tester.element(find.text('劇薬'))).style.color,
        SearchPalette.light.primary,
      );
      expect(
        DefaultTextStyle.of(tester.element(find.text('劇薬'))).style.fontWeight,
        FontWeight.w700,
      );
      expect(
        find.descendant(
          of: selectedFinder,
          matching: find.byKey(
            const ValueKey('search-filter-pill-check-potent'),
          ),
        ),
        findsOneWidget,
      );
      final selectedCheck = tester.widget<Icon>(
        find.byKey(const ValueKey('search-filter-pill-check-potent')),
      );
      expect(selectedCheck.size, 10);
      expect(selectedCheck.color, SearchPalette.light.primary);

      final unselectedFinder = find.byKey(
        const ValueKey('search-filter-pill-chip-unselected-poison'),
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
      expect(unselectedDecoration.borderRadius, BorderRadius.circular(14));
      expect(tester.getSize(unselectedFinder).height, 30);
      expect(
        DefaultTextStyle.of(tester.element(find.text('毒薬'))).style.color,
        SearchPalette.light.ink2,
      );
      expect(
        DefaultTextStyle.of(tester.element(find.text('毒薬'))).style.fontWeight,
        FontWeight.w500,
      );

      final countPillFinder = find.byKey(
        const ValueKey('search-filter-count-pill-regulatoryClass'),
      );
      final countPillBoxFinder = find.descendant(
        of: countPillFinder,
        matching: find.byType(DecoratedBox),
      );
      final countPill = tester.widget<DecoratedBox>(countPillBoxFinder);
      final countDecoration = countPill.decoration as BoxDecoration;
      expect(countDecoration.color, SearchPalette.light.primary);
      expect(countDecoration.borderRadius, BorderRadius.circular(9));
      expect(tester.getSize(countPillBoxFinder).height, 18);
      final countTextFinder = find.descendant(
        of: countPillFinder,
        matching: find.text('2'),
      );
      final countText = tester.widget<Text>(countTextFinder);
      expect(countText.style?.color, SearchPalette.light.onPrimary);
      expect(countText.style?.fontWeight, FontWeight.w700);

      final title = tester.widget<Text>(find.text('絞り込み（医薬品）'));
      expect(title.style?.color, SearchPalette.light.ink);
      expect(title.style?.fontWeight, FontWeight.w700);

      final reset = tester.widget<Text>(find.text('リセット'));
      expect(reset.style?.color, SearchPalette.light.primary);
      expect(reset.style?.fontWeight, FontWeight.w700);

      final closeButton = tester.widget<IconButton>(
        find.byKey(const ValueKey('filter-sheet-close-icon')),
      );
      final closeIcon = closeButton.icon as Icon;
      expect(closeIcon.color, SearchPalette.light.primary);

      final ctaLabel = tester.widget<Text>(
        find.descendant(
          of: find.byKey(const ValueKey('filterApplyCta')),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Text && widget.data?.startsWith('結果を見る') == true,
          ),
        ),
      );
      expect(ctaLabel.style?.fontSize, 15);
      expect(ctaLabel.style?.fontWeight, FontWeight.w700);
      expect(find.byType(FilterChip), findsNothing);
    },
  );

  testWidgets('drug_regulatory_axis_title_is_kisei_kubun_(T15)', (
    tester,
  ) async {
    final categoryApiClient = _MockCategoryApiClient();
    final drugApiClient = _MockDrugApiClient();
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

    expect(find.text('規制区分'), findsOneWidget);
    expect(find.text('薬事分類'), findsNothing);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget.key is ValueKey<String> &&
            (widget.key! as ValueKey<String>).value.startsWith(
              'search-filter-pill-chip-unselected-',
            ),
      ),
      findsNWidgets(11),
    );
  });

  testWidgets('filter_cta_uses_primary_palette_in_both_modes_(T16)', (
    tester,
  ) async {
    Future<void> pumpFilter(Brightness brightness) async {
      final categoryApiClient = _MockCategoryApiClient();
      final drugApiClient = _MockDrugApiClient();
      _stubDrugSearch(drugApiClient);
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());

      final theme = brightness == Brightness.dark
          ? AppTheme.dark()
          : AppTheme.light();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: MaterialApp(
            theme: brightness == Brightness.dark ? AppTheme.light() : theme,
            darkTheme: brightness == Brightness.dark ? theme : null,
            themeMode: brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
    }

    Future<void> verifyCta(Brightness brightness) async {
      final palette = brightness == Brightness.dark
          ? SearchPalette.dark
          : SearchPalette.light;
      final cta = tester.widget<FilledButton>(
        find.byKey(const ValueKey('filterApplyCta')),
      );
      expect(
        cta.style?.backgroundColor?.resolve(<WidgetState>{}),
        palette.primary,
      );
      expect(
        cta.style?.foregroundColor?.resolve(<WidgetState>{}),
        palette.onPrimary,
      );
    }

    await pumpFilter(Brightness.light);
    await verifyCta(Brightness.light);

    await tester.pumpWidget(const SizedBox.shrink());
    await clearTestAppDatabase(db);

    await pumpFilter(Brightness.dark);
    await verifyCta(Brightness.dark);
  });

  testWidgets('axis_summary_and_hint_share_single_row_(T17)', (
    tester,
  ) async {
    final categoryApiClient = _MockCategoryApiClient();
    final drugApiClient = _MockDrugApiClient();
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

    final summaryFinder = find.byKey(
      const ValueKey('axisSummary_regulatoryClass'),
    );
    final hintFinder = find.byKey(
      const ValueKey('axisHint_regulatoryClass'),
    );
    expect(summaryFinder, findsOneWidget);
    expect(hintFinder, findsOneWidget);

    final summaryRows = find
        .ancestor(of: summaryFinder, matching: find.byType(Row))
        .evaluate()
        .toSet();
    final hintRows = find
        .ancestor(of: hintFinder, matching: find.byType(Row))
        .evaluate()
        .toSet();
    expect(summaryRows.intersection(hintRows), isNotEmpty);

    final summaryRect = tester.getRect(summaryFinder);
    final hintRect = tester.getRect(hintFinder);
    expect(summaryRect.right, lessThanOrEqualTo(hintRect.left));
  });

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
    expect(find.text('結果を見る (17 件)'), findsOneWidget);

    await tester.tap(find.text('毒薬'));
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump();

    expect(find.text('結果を見る (17 件)'), findsOneWidget);
  });

  testWidgets('filter_sheet_loads_preview_count_on_open_(T06)', (
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

    expect(find.text('結果を見る (17 件)'), findsOneWidget);
    verify(
      () => drugApiClient.getDrugs(
        page: 1,
        pageSize: 1,
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
    ).called(1);
  });

  testWidgets('axis_summary_uses_ellipsis_overflow_(T10)', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final diseaseApiClient = _MockDiseaseApiClient();
    final categoryApiClient = _MockCategoryApiClient();
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
    ).thenAnswer((_) async => _diseaseListFixture().copyWith(totalCount: 9));
    when(
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
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

    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await _tapVisible(tester, find.text('I 感染症および寄生虫症'));
    await _tapVisible(tester, find.text('II 新生物'));

    final summary = tester.widget<Text>(
      find.text('I 感染症および寄生虫症, II 新生物'),
    );
    expect(summary.maxLines, 1);
    expect(summary.overflow, TextOverflow.ellipsis);
  });

  testWidgets('drug_card_image_is_vertically_centered_(T08)', (
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
      'center image',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    final item = _drugListFixture().items.first;
    final card = find.byKey(ValueKey('drug-card-${item.id}'));
    final row = tester.widget<Row>(
      find.descendant(of: card, matching: find.byType(Row)).first,
    );

    expect(row.crossAxisAlignment, CrossAxisAlignment.center);
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

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

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
}) async {
  final drugApiClient = _MockDrugApiClient();
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
}
