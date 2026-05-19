part of 'search_view_design_contract_test.dart';

void _searchViewDesignPhoneChromeContractTests() {
  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
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
      final header = tester.getRect(
        find.byKey(const ValueKey('app-tab-header')),
      );
      final headerTitle = tester.getRect(
        find.byKey(const ValueKey('app-tab-header-title')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      expect(topChrome.width, 390);
      expect(header.top, 0);
      expect(headerTitle.left, 16);
      expect(topChrome.top, header.bottom);
      expect(topChrome.height, 108);
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
          overrides: _baseOverrides(db),
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
        AppPalette.light.searchFieldBg,
      );

      await tester.pumpWidget(const SizedBox.shrink());

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
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
      expect(darkField.decoration?.fillColor, AppPalette.dark.searchFieldBg);
    },
  );

  testWidgets(
    'iPhone portrait idle shows inline history only while search is unfocused',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final container = ProviderContainer(
        overrides: _baseOverrides(db),
      );
      addTearDown(container.dispose);
      final codec = container.read(searchQueryCodecProvider);
      final repository = container.read(searchHistoryRepositoryProvider);
      await repository.insertWithDedup(
        id: 'round6_inline_history',
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
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      );
      expect(find.text('アムロジピン'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('search-history-inline')), findsNothing);
      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );
    },
  );

  testWidgets('iPhone portrait empty history uses inline idle placeholder', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: _baseOverrides(db),
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('search-history-inline')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('search-history-inline-empty')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('search-history-dropdown')), findsNothing);
  });

  testWidgets('SearchView FAB follows Round6 phone metrics', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: _baseOverrides(db),
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

  testWidgets('SearchView keeps filter FAB phone-only', (tester) async {
    await tester.binding.setSurfaceSize(const Size(844, 390));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: _baseOverrides(db),
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    expect(find.byType(FloatingActionButton), findsNothing);
    expect(
      find.byKey(const ValueKey('search-adaptive-left-rail')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('search-utility-pane')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
      findsOneWidget,
    );
  });

  testWidgets(
    'SearchView iPhone landscape uses 240px left rail with vertical tabs',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(932, 430));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );

      final leftRail = tester.getRect(
        find.byKey(const ValueKey('search-adaptive-left-rail')),
      );
      final navRail = tester.getRect(
        find.byKey(const ValueKey('app-shell-navigation-rail-box')),
      );

      expect(navRail.width, SearchConstants.searchLandscapeNavigationRailWidth);
      expect(leftRail.left, navRail.right);
      expect(leftRail.width, 240);
      expect(
        find.byKey(const ValueKey('search-landscape-vertical-tabs')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('search-round6-segmented')),
        findsNothing,
      );
      expect(find.byKey(const ValueKey('search-submit-button')), findsNothing);
    },
  );

  testWidgets(
    'SearchView inside AppShell keeps icon rail in iPhone landscape',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(844, 390));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final router = buildRouter();
      addTearDown(router.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
          child: MaterialApp.router(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final appRail = tester.getRect(
        find.byKey(const ValueKey('app-shell-navigation-rail-box')),
      );
      final searchRail = tester.getRect(
        find.byKey(const ValueKey('search-adaptive-left-rail')),
      );

      expect(appRail.width, 52);
      expect(appRail.left, 0);
      expect(searchRail.left, appRail.right);
      expect(searchRail.width, SearchConstants.searchLandscapeLeftRailWidth);
      expect(find.byType(NavigationBar), findsNothing);
    },
  );

  testWidgets(
    'SearchView iPhone landscape idle master scrolls instead of overflowing '
    'under keyboard',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(844, 390));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const MediaQuery(
              data: MediaQueryData(
                size: Size(844, 390),
                viewInsets: EdgeInsets.only(bottom: 220),
              ),
              child: SearchView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('search-adaptive-split-rail')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('search-utility-idle-master-state')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter chips keep ICD labels readable',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(844, 390));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      final container = ProviderScope.containerOf(
        tester.element(find.byType(SearchView)),
      );
      final notifier = container.read(searchScreenProvider.notifier);
      await notifier.loadCategories();
      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      expect(
        find.text('9 軸 · 軸内 OR / 軸間 AND', skipOffstage: false),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey('search-utility-filter-axis-values-icd10_chapter'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );

      final longIcdLabel = tester.widget<Text>(
        find.text(
          'III 血液および造血器の疾患ならびに免疫機構の障害',
          skipOffstage: false,
        ),
      );

      expect(longIcdLabel.maxLines, 2);
      expect(longIcdLabel.overflow, TextOverflow.visible);
      expect(longIcdLabel.softWrap, isTrue);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter actions stack in one column',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(844, 390));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(SearchView)),
      );
      await container.read(searchScreenProvider.notifier).loadCategories();
      await tester.pumpAndSettle();

      final reset = tester.getRect(
        find.byKey(
          const ValueKey('search-utility-filter-reset'),
          skipOffstage: false,
        ),
      );
      final apply = tester.getRect(
        find.byKey(
          const ValueKey('search-utility-filter-apply'),
          skipOffstage: false,
        ),
      );
      final actions = tester.getRect(
        find.byKey(
          const ValueKey('search-utility-filter-actions'),
          skipOffstage: false,
        ),
      );
      final applyLabel = tester.widget<Text>(
        find.text('結果を見る (0 件)', skipOffstage: false),
      );

      expect(reset.bottom, lessThanOrEqualTo(apply.top));
      expect(apply.width, actions.width);
      expect(applyLabel.maxLines, 1);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(844, 390));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        ),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(SearchView)),
      );
      final notifier = container.read(searchScreenProvider.notifier);
      await notifier.loadCategories();
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-atc'),
          skipOffstage: false,
        ),
        80,
        scrollable: find.descendant(
          of: find.byKey(const ValueKey('search-utility-pane')),
          matching: find.byType(Scrollable),
        ),
      );

      final drugAtcTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-atc'),
          skipOffstage: false,
        ),
      );
      expect(drugAtcTitle.data, 'ATC 第 1 階層');
      expect(drugAtcTitle.maxLines, 2);
      expect(drugAtcTitle.overflow, TextOverflow.visible);
      expect(drugAtcTitle.softWrap, isTrue);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      expect(diseaseIcdTitle.data, 'ICD-10 章');
      expect(diseaseIcdTitle.maxLines, 2);
      expect(diseaseIcdTitle.overflow, TextOverflow.visible);
      expect(diseaseIcdTitle.softWrap, isTrue);
      expect(tester.takeException(), isNull);
    },
  );
}
