part of 'search_view_test.dart';

void _searchViewResultsNavigationTests() {
  testWidgets(
    'SearchView renders drug results from repository state [assertion 1/4]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final categoryApiClient = _MockCategoryApiClient();
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
            drugApiClientProvider.overrideWithValue(drugApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'fixture keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final item = _drugListFixture().items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      expect(find.text(item.brandName), findsOneWidget);
      Object.hashAll([find.text(item.genericName), findsOneWidget]);

      Object.hashAll([
        find.text('合計 ${_drugListFixture().totalCount} 件'),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester.widget<ListView>(find.byType(ListView)).key,
        const PageStorageKey<String>('drugSearchResults'),
      ]);
    },
  );

  testWidgets(
    'SearchView renders drug results from repository state [assertion 2/4]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final categoryApiClient = _MockCategoryApiClient();
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
            drugApiClientProvider.overrideWithValue(drugApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'fixture keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final item = _drugListFixture().items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      Object.hashAll([find.text(item.brandName), findsOneWidget]);

      expect(find.text(item.genericName), findsOneWidget);
      Object.hashAll([
        find.text('合計 ${_drugListFixture().totalCount} 件'),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester.widget<ListView>(find.byType(ListView)).key,
        const PageStorageKey<String>('drugSearchResults'),
      ]);
    },
  );

  testWidgets(
    'SearchView renders drug results from repository state [assertion 3/4]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final categoryApiClient = _MockCategoryApiClient();
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
            drugApiClientProvider.overrideWithValue(drugApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'fixture keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final item = _drugListFixture().items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      Object.hashAll([find.text(item.brandName), findsOneWidget]);

      Object.hashAll([find.text(item.genericName), findsOneWidget]);

      expect(
        find.text('合計 ${_drugListFixture().totalCount} 件'),
        findsOneWidget,
      );
      Object.hashAll([
        tester.widget<ListView>(find.byType(ListView)).key,
        const PageStorageKey<String>('drugSearchResults'),
      ]);
    },
  );

  testWidgets(
    'SearchView renders drug results from repository state [assertion 4/4]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final categoryApiClient = _MockCategoryApiClient();
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
            drugApiClientProvider.overrideWithValue(drugApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'fixture keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final item = _drugListFixture().items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      Object.hashAll([find.text(item.brandName), findsOneWidget]);

      Object.hashAll([find.text(item.genericName), findsOneWidget]);

      Object.hashAll([
        find.text('合計 ${_drugListFixture().totalCount} 件'),
        findsOneWidget,
      ]);

      expect(
        tester.widget<ListView>(find.byType(ListView)).key,
        const PageStorageKey<String>('drugSearchResults'),
      );
    },
  );

  testWidgets(
    'result card tap navigates to drug detail with correct id [assertion 1/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      final item = fixture.items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        observers: [appRouteObserver],
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
              GoRoute(
                path: 'disease/:id',
                builder: (context, state) =>
                    Text('disease-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'drug detail keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      expect(find.text(item.brandName), findsAtLeastNWidgets(1));

      await tester.tap(find.text(item.brandName).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('drug-detail-${item.id}'), findsOneWidget]);

      Object.hashAll([
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.drugDetail(item.id),
      ]);
    },
  );

  testWidgets(
    'result card tap navigates to drug detail with correct id [assertion 2/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      final item = fixture.items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        observers: [appRouteObserver],
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
              GoRoute(
                path: 'disease/:id',
                builder: (context, state) =>
                    Text('disease-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'drug detail keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      Object.hashAll([find.text(item.brandName), findsAtLeastNWidgets(1)]);

      await tester.tap(find.text(item.brandName).first);
      await tester.pumpAndSettle();

      expect(find.text('drug-detail-${item.id}'), findsOneWidget);
      Object.hashAll([
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.drugDetail(item.id),
      ]);
    },
  );

  testWidgets(
    'result card tap navigates to drug detail with correct id [assertion 3/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      final item = fixture.items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        observers: [appRouteObserver],
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
              GoRoute(
                path: 'disease/:id',
                builder: (context, state) =>
                    Text('disease-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'drug detail keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      Object.hashAll([find.text(item.brandName), findsAtLeastNWidgets(1)]);

      await tester.tap(find.text(item.brandName).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('drug-detail-${item.id}'), findsOneWidget]);

      expect(
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.drugDetail(item.id),
      );
    },
  );

  testWidgets(
    'scroll_position_preserved_across_detail_navigation_(T13) [assertion 1/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final firstPage = _scrollRestorationFixture(page: 1);
      final secondPage = _scrollRestorationFixture(page: 2);
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((invocation) async {
        final page = invocation.namedArguments[#page] as int;
        return page == 1 ? firstPage : secondPage;
      });

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );
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
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'scroll restoration keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final listFinder = find.byKey(
        const PageStorageKey<String>('drugSearchResults'),
      );
      final scrollableFinder = find.descendant(
        of: listFinder,
        matching: find.byType(Scrollable),
      );
      final targetCard = find.byKey(
        const ValueKey('drug-card-scroll_drug_1_10'),
      );
      await tester.drag(listFinder, const Offset(0, -900));
      await tester.pumpAndSettle();
      await tester.ensureVisible(targetCard);
      await tester.pumpAndSettle();
      final beforePush = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      expect(beforePush, greaterThan(0));

      await tester.tap(targetCard);
      await tester.pumpAndSettle();
      Object.hashAll([
        find.text('drug-detail-scroll_drug_1_10'),
        findsOneWidget,
      ]);

      await container.read(searchScreenProvider.notifier).loadMore();
      await tester.pumpAndSettle();
      router.pop();
      await tester.pumpAndSettle();

      final afterPop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      Object.hashAll([afterPop, closeTo(beforePush, 1)]);
    },
  );

  testWidgets(
    'scroll_position_preserved_across_detail_navigation_(T13) [assertion 2/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final firstPage = _scrollRestorationFixture(page: 1);
      final secondPage = _scrollRestorationFixture(page: 2);
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((invocation) async {
        final page = invocation.namedArguments[#page] as int;
        return page == 1 ? firstPage : secondPage;
      });

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );
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
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'scroll restoration keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final listFinder = find.byKey(
        const PageStorageKey<String>('drugSearchResults'),
      );
      final scrollableFinder = find.descendant(
        of: listFinder,
        matching: find.byType(Scrollable),
      );
      final targetCard = find.byKey(
        const ValueKey('drug-card-scroll_drug_1_10'),
      );
      await tester.drag(listFinder, const Offset(0, -900));
      await tester.pumpAndSettle();
      await tester.ensureVisible(targetCard);
      await tester.pumpAndSettle();
      final beforePush = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      Object.hashAll([beforePush, greaterThan(0)]);

      await tester.tap(targetCard);
      await tester.pumpAndSettle();
      expect(find.text('drug-detail-scroll_drug_1_10'), findsOneWidget);

      await container.read(searchScreenProvider.notifier).loadMore();
      await tester.pumpAndSettle();
      router.pop();
      await tester.pumpAndSettle();

      final afterPop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      Object.hashAll([afterPop, closeTo(beforePush, 1)]);
    },
  );

  testWidgets(
    'scroll_position_preserved_across_detail_navigation_(T13) [assertion 3/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final firstPage = _scrollRestorationFixture(page: 1);
      final secondPage = _scrollRestorationFixture(page: 2);
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((invocation) async {
        final page = invocation.namedArguments[#page] as int;
        return page == 1 ? firstPage : secondPage;
      });

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );
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
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'scroll restoration keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final listFinder = find.byKey(
        const PageStorageKey<String>('drugSearchResults'),
      );
      final scrollableFinder = find.descendant(
        of: listFinder,
        matching: find.byType(Scrollable),
      );
      final targetCard = find.byKey(
        const ValueKey('drug-card-scroll_drug_1_10'),
      );
      await tester.drag(listFinder, const Offset(0, -900));
      await tester.pumpAndSettle();
      await tester.ensureVisible(targetCard);
      await tester.pumpAndSettle();
      final beforePush = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      Object.hashAll([beforePush, greaterThan(0)]);

      await tester.tap(targetCard);
      await tester.pumpAndSettle();
      Object.hashAll([
        find.text('drug-detail-scroll_drug_1_10'),
        findsOneWidget,
      ]);

      await container.read(searchScreenProvider.notifier).loadMore();
      await tester.pumpAndSettle();
      router.pop();
      await tester.pumpAndSettle();

      final afterPop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      expect(afterPop, closeTo(beforePush, 1));
    },
  );

  testWidgets(
    'ios_primary_scroll_to_top_does_not_reset_search_results_(T15) [assertion 1/2]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final firstPage = _scrollRestorationFixture(page: 1);
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => firstPage);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'primary scroll keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final listFinder = find.byKey(
        const PageStorageKey<String>('drugSearchResults'),
      );
      final scrollableFinder = find.descendant(
        of: listFinder,
        matching: find.byType(Scrollable),
      );
      final targetCard = find.byKey(
        const ValueKey('drug-card-scroll_drug_1_10'),
      );
      await tester.drag(listFinder, const Offset(0, -900));
      await tester.pumpAndSettle();
      await tester.ensureVisible(targetCard);
      await tester.pumpAndSettle();

      final beforePrimaryScrollToTop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      expect(beforePrimaryScrollToTop, greaterThan(0));

      final primaryController = PrimaryScrollController.maybeOf(
        tester.element(listFinder),
      );
      if (primaryController != null && primaryController.hasClients) {
        primaryController.jumpTo(0);
        await tester.pump();
      }

      final afterPrimaryScrollToTop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      Object.hashAll([
        afterPrimaryScrollToTop,
        closeTo(beforePrimaryScrollToTop, 1),
      ]);
    },
  );

  testWidgets(
    'ios_primary_scroll_to_top_does_not_reset_search_results_(T15) [assertion 2/2]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final firstPage = _scrollRestorationFixture(page: 1);
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => firstPage);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'primary scroll keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final listFinder = find.byKey(
        const PageStorageKey<String>('drugSearchResults'),
      );
      final scrollableFinder = find.descendant(
        of: listFinder,
        matching: find.byType(Scrollable),
      );
      final targetCard = find.byKey(
        const ValueKey('drug-card-scroll_drug_1_10'),
      );
      await tester.drag(listFinder, const Offset(0, -900));
      await tester.pumpAndSettle();
      await tester.ensureVisible(targetCard);
      await tester.pumpAndSettle();

      final beforePrimaryScrollToTop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      Object.hashAll([beforePrimaryScrollToTop, greaterThan(0)]);

      final primaryController = PrimaryScrollController.maybeOf(
        tester.element(listFinder),
      );
      if (primaryController != null && primaryController.hasClients) {
        primaryController.jumpTo(0);
        await tester.pump();
      }

      final afterPrimaryScrollToTop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      expect(afterPrimaryScrollToTop, closeTo(beforePrimaryScrollToTop, 1));
    },
  );

  testWidgets(
    'result card tap navigates to disease detail with correct id [assertion 1/3]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final fixture = _diseaseListFixture();
      final item = fixture.items.first;
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
              GoRoute(
                path: 'disease/:id',
                builder: (context, state) =>
                    Text('disease-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'disease detail keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      expect(find.text(item.name), findsAtLeastNWidgets(1));

      await tester.tap(find.text(item.name).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('disease-detail-${item.id}'), findsOneWidget]);

      Object.hashAll([
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.diseaseDetail(item.id),
      ]);
    },
  );

  testWidgets(
    'result card tap navigates to disease detail with correct id [assertion 2/3]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final fixture = _diseaseListFixture();
      final item = fixture.items.first;
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
              GoRoute(
                path: 'disease/:id',
                builder: (context, state) =>
                    Text('disease-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'disease detail keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      Object.hashAll([find.text(item.name), findsAtLeastNWidgets(1)]);

      await tester.tap(find.text(item.name).first);
      await tester.pumpAndSettle();

      expect(find.text('disease-detail-${item.id}'), findsOneWidget);
      Object.hashAll([
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.diseaseDetail(item.id),
      ]);
    },
  );

  testWidgets(
    'result card tap navigates to disease detail with correct id [assertion 3/3]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final fixture = _diseaseListFixture();
      final item = fixture.items.first;
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                const SearchView(debugLogDrugImageErrors: false),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
              ),
              GoRoute(
                path: 'disease/:id',
                builder: (context, state) =>
                    Text('disease-detail-${state.pathParameters['id']}'),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'disease detail keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      Object.hashAll([find.text(item.name), findsAtLeastNWidgets(1)]);

      await tester.tap(find.text(item.name).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('disease-detail-${item.id}'), findsOneWidget]);

      expect(
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.diseaseDetail(item.id),
      );
    },
  );

  testWidgets(
    'drug_card_image_url_uses_size_M_(T07) [assertion 1/2]',
    (tester) async {
      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'https://api.example.test',
        ),
      );
      final drugApiClient = _MockDrugApiClient();
      final imageCacheManager = _MockBaseCacheManager();
      final fixture = _drugListFixture();
      final imageFile = _writeTestImageFile('drug-card-t07.png');
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => imageFile);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'image keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final item = fixture.items.first;
      expect(find.byKey(ValueKey('drug-image-${item.id}')), findsOneWidget);
      final imageProvider = tester
          .widget<Image>(find.byKey(ValueKey('drug-image-${item.id}')))
          .image;
      Object.hashAll([
        imageProvider,
        isA<ResizeImage>().having(
          (image) => image.imageProvider,
          'imageProvider',
          isA<FileImage>(),
        ),
      ]);

      verify(
        () => imageCacheManager.getSingleFile(
          'https://api.example.test/v1/images/drugs/${item.id}?size=M',
          key:
              'drug-card-image-v2::https://api.example.test/v1/images/drugs/'
              '${item.id}?size=M',
          headers: any(named: 'headers'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'drug_card_image_url_uses_size_M_(T07) [assertion 2/2]',
    (tester) async {
      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'https://api.example.test',
        ),
      );
      final drugApiClient = _MockDrugApiClient();
      final imageCacheManager = _MockBaseCacheManager();
      final fixture = _drugListFixture();
      final imageFile = _writeTestImageFile('drug-card-t07.png');
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => imageFile);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'image keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final item = fixture.items.first;
      Object.hashAll([
        find.byKey(ValueKey('drug-image-${item.id}')),
        findsOneWidget,
      ]);

      final imageProvider = tester
          .widget<Image>(find.byKey(ValueKey('drug-image-${item.id}')))
          .image;
      expect(
        imageProvider,
        isA<ResizeImage>().having(
          (image) => image.imageProvider,
          'imageProvider',
          isA<FileImage>(),
        ),
      );
      verify(
        () => imageCacheManager.getSingleFile(
          'https://api.example.test/v1/images/drugs/${item.id}?size=M',
          key:
              'drug-card-image-v2::https://api.example.test/v1/images/drugs/'
              '${item.id}?size=M',
          headers: any(named: 'headers'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView renders Round6 drug card badges and metadata [assertion 1/4]',
    (
      tester,
    ) async {
      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'https://api.example.test',
        ),
      );
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'card metadata keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final item = fixture.items.first;
      expect(find.text('毒薬'), findsAtLeastNWidgets(1));
      Object.hashAll([find.text('処方箋医薬品'), findsAtLeastNWidgets(1)]);

      Object.hashAll([find.text('ATC: ${item.atcCode}'), findsOneWidget]);

      Object.hashAll([find.text('改訂 2026/05/01'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView renders Round6 drug card badges and metadata [assertion 2/4]',
    (
      tester,
    ) async {
      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'https://api.example.test',
        ),
      );
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'card metadata keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final item = fixture.items.first;
      Object.hashAll([find.text('毒薬'), findsAtLeastNWidgets(1)]);

      expect(find.text('処方箋医薬品'), findsAtLeastNWidgets(1));
      Object.hashAll([find.text('ATC: ${item.atcCode}'), findsOneWidget]);

      Object.hashAll([find.text('改訂 2026/05/01'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView renders Round6 drug card badges and metadata [assertion 3/4]',
    (
      tester,
    ) async {
      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'https://api.example.test',
        ),
      );
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'card metadata keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final item = fixture.items.first;
      Object.hashAll([find.text('毒薬'), findsAtLeastNWidgets(1)]);

      Object.hashAll([find.text('処方箋医薬品'), findsAtLeastNWidgets(1)]);

      expect(find.text('ATC: ${item.atcCode}'), findsOneWidget);
      Object.hashAll([find.text('改訂 2026/05/01'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView renders Round6 drug card badges and metadata [assertion 4/4]',
    (
      tester,
    ) async {
      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'https://api.example.test',
        ),
      );
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => fixture);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'card metadata keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final item = fixture.items.first;
      Object.hashAll([find.text('毒薬'), findsAtLeastNWidgets(1)]);

      Object.hashAll([find.text('処方箋医薬品'), findsAtLeastNWidgets(1)]);

      Object.hashAll([find.text('ATC: ${item.atcCode}'), findsOneWidget]);

      expect(find.text('改訂 2026/05/01'), findsOneWidget);
    },
  );

  testWidgets('SearchView loads next page near list end', (tester) async {
    final drugApiClient = _MockDrugApiClient();
    final fixture = _drugListFixture();
    final scrollableFixture = fixture.copyWith(
      items: List.filled(20, fixture.items.first),
    );
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
      ),
    ).thenAnswer((_) async => scrollableFixture);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );
    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'load more keyword',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const PageStorageKey<String>('drugSearchResults')),
      const Offset(0, -3000),
    );
    await tester.pumpAndSettle();

    verify(
      () => drugApiClient.getDrugs(
        page: 2,
        pageSize: 20,
        keyword: 'load more keyword',
        keywordTarget: any(named: 'keywordTarget'),
      ),
    ).called(greaterThanOrEqualTo(1));
  });

  testWidgets('inertial_scroll_triggers_load_more_(T12)', (tester) async {
    final drugApiClient = _MockDrugApiClient();
    final fixture = _drugListFixture();
    final scrollableFixture = fixture.copyWith(
      items: List.filled(20, fixture.items.first),
    );
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
      ),
    ).thenAnswer((_) async => scrollableFixture);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );
    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'inertial load more keyword',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    ScrollUpdateNotification(
      metrics: FixedScrollMetrics(
        minScrollExtent: 0,
        maxScrollExtent: 1000,
        pixels: 950,
        viewportDimension: 600,
        axisDirection: AxisDirection.down,
        devicePixelRatio: 1,
      ),
      context: tester.element(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
      ),
      scrollDelta: 40,
    ).dispatch(
      tester.element(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
      ),
    );
    await tester.pumpAndSettle();

    verify(
      () => drugApiClient.getDrugs(
        page: 2,
        pageSize: 20,
        keyword: 'inertial load more keyword',
        keywordTarget: any(named: 'keywordTarget'),
      ),
    ).called(greaterThanOrEqualTo(1));
  });

  testWidgets('SearchView renders empty state for empty drug results', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    final categoryApiClient = _MockCategoryApiClient();
    when(
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
      ),
    ).thenAnswer(
      (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('該当する結果がありません'), findsOneWidget);
  });

  testWidgets('SearchView renders empty state recovery CTAs [assertion 1/7]', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('条件をリセット'), findsOneWidget);
    Object.hashAll([find.text('絞り込みを 1 つずつ外す'), findsOneWidget]);

    Object.hashAll([find.text('検索キーワードや絞り込みを\n見直してください。'), findsOneWidget]);

    Object.hashAll([find.text('部分一致に変更'), findsNothing]);

    Object.hashAll([
      find.widgetWithText(FilledButton, '条件をリセット'),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    ]);

    Object.hashAll([find.widgetWithText(TextButton, '部分一致に変更'), findsNothing]);
  });

  testWidgets('SearchView renders empty state recovery CTAs [assertion 2/7]', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件をリセット'), findsOneWidget]);

    expect(find.text('絞り込みを 1 つずつ外す'), findsOneWidget);
    Object.hashAll([find.text('検索キーワードや絞り込みを\n見直してください。'), findsOneWidget]);

    Object.hashAll([find.text('部分一致に変更'), findsNothing]);

    Object.hashAll([
      find.widgetWithText(FilledButton, '条件をリセット'),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    ]);

    Object.hashAll([find.widgetWithText(TextButton, '部分一致に変更'), findsNothing]);
  });

  testWidgets('SearchView renders empty state recovery CTAs [assertion 3/7]', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件をリセット'), findsOneWidget]);

    Object.hashAll([find.text('絞り込みを 1 つずつ外す'), findsOneWidget]);

    expect(find.text('検索キーワードや絞り込みを\n見直してください。'), findsOneWidget);
    Object.hashAll([find.text('部分一致に変更'), findsNothing]);

    Object.hashAll([
      find.widgetWithText(FilledButton, '条件をリセット'),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    ]);

    Object.hashAll([find.widgetWithText(TextButton, '部分一致に変更'), findsNothing]);
  });

  testWidgets('SearchView renders empty state recovery CTAs [assertion 4/7]', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件をリセット'), findsOneWidget]);

    Object.hashAll([find.text('絞り込みを 1 つずつ外す'), findsOneWidget]);

    Object.hashAll([find.text('検索キーワードや絞り込みを\n見直してください。'), findsOneWidget]);

    expect(find.text('部分一致に変更'), findsNothing);
    Object.hashAll([
      find.widgetWithText(FilledButton, '条件をリセット'),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    ]);

    Object.hashAll([find.widgetWithText(TextButton, '部分一致に変更'), findsNothing]);
  });

  testWidgets('SearchView renders empty state recovery CTAs [assertion 5/7]', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件をリセット'), findsOneWidget]);

    Object.hashAll([find.text('絞り込みを 1 つずつ外す'), findsOneWidget]);

    Object.hashAll([find.text('検索キーワードや絞り込みを\n見直してください。'), findsOneWidget]);

    Object.hashAll([find.text('部分一致に変更'), findsNothing]);

    expect(find.widgetWithText(FilledButton, '条件をリセット'), findsOneWidget);
    Object.hashAll([
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    ]);

    Object.hashAll([find.widgetWithText(TextButton, '部分一致に変更'), findsNothing]);
  });

  testWidgets('SearchView renders empty state recovery CTAs [assertion 6/7]', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件をリセット'), findsOneWidget]);

    Object.hashAll([find.text('絞り込みを 1 つずつ外す'), findsOneWidget]);

    Object.hashAll([find.text('検索キーワードや絞り込みを\n見直してください。'), findsOneWidget]);

    Object.hashAll([find.text('部分一致に変更'), findsNothing]);

    Object.hashAll([
      find.widgetWithText(FilledButton, '条件をリセット'),
      findsOneWidget,
    ]);

    expect(
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    );
    Object.hashAll([find.widgetWithText(TextButton, '部分一致に変更'), findsNothing]);
  });

  testWidgets('SearchView renders empty state recovery CTAs [assertion 7/7]', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件をリセット'), findsOneWidget]);

    Object.hashAll([find.text('絞り込みを 1 つずつ外す'), findsOneWidget]);

    Object.hashAll([find.text('検索キーワードや絞り込みを\n見直してください。'), findsOneWidget]);

    Object.hashAll([find.text('部分一致に変更'), findsNothing]);

    Object.hashAll([
      find.widgetWithText(FilledButton, '条件をリセット'),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    ]);

    expect(find.widgetWithText(TextButton, '部分一致に変更'), findsNothing);
  });

  testWidgets(
    'empty state shows 64x64 surface3 circle with magnifier icon [assertion 1/7]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'empty icon keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-empty-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;

      expect(constraints.minWidth, 64);
      Object.hashAll([constraints.maxWidth, 64]);

      Object.hashAll([constraints.minHeight, 64]);

      Object.hashAll([constraints.maxHeight, 64]);

      Object.hashAll([decoration.color, AppPalette.light.surface3]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([
        find.descendant(
          of: find.byKey(const ValueKey('search-empty-icon')),
          matching: find.byIcon(Icons.search_off),
        ),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'empty state shows 64x64 surface3 circle with magnifier icon [assertion 2/7]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'empty icon keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-empty-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;

      Object.hashAll([constraints.minWidth, 64]);

      expect(constraints.maxWidth, 64);
      Object.hashAll([constraints.minHeight, 64]);

      Object.hashAll([constraints.maxHeight, 64]);

      Object.hashAll([decoration.color, AppPalette.light.surface3]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([
        find.descendant(
          of: find.byKey(const ValueKey('search-empty-icon')),
          matching: find.byIcon(Icons.search_off),
        ),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'empty state shows 64x64 surface3 circle with magnifier icon [assertion 3/7]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'empty icon keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-empty-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;

      Object.hashAll([constraints.minWidth, 64]);

      Object.hashAll([constraints.maxWidth, 64]);

      expect(constraints.minHeight, 64);
      Object.hashAll([constraints.maxHeight, 64]);

      Object.hashAll([decoration.color, AppPalette.light.surface3]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([
        find.descendant(
          of: find.byKey(const ValueKey('search-empty-icon')),
          matching: find.byIcon(Icons.search_off),
        ),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'empty state shows 64x64 surface3 circle with magnifier icon [assertion 4/7]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'empty icon keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-empty-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;

      Object.hashAll([constraints.minWidth, 64]);

      Object.hashAll([constraints.maxWidth, 64]);

      Object.hashAll([constraints.minHeight, 64]);

      expect(constraints.maxHeight, 64);
      Object.hashAll([decoration.color, AppPalette.light.surface3]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([
        find.descendant(
          of: find.byKey(const ValueKey('search-empty-icon')),
          matching: find.byIcon(Icons.search_off),
        ),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'empty state shows 64x64 surface3 circle with magnifier icon [assertion 5/7]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'empty icon keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-empty-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;

      Object.hashAll([constraints.minWidth, 64]);

      Object.hashAll([constraints.maxWidth, 64]);

      Object.hashAll([constraints.minHeight, 64]);

      Object.hashAll([constraints.maxHeight, 64]);

      expect(decoration.color, AppPalette.light.surface3);
      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([
        find.descendant(
          of: find.byKey(const ValueKey('search-empty-icon')),
          matching: find.byIcon(Icons.search_off),
        ),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'empty state shows 64x64 surface3 circle with magnifier icon [assertion 6/7]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'empty icon keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-empty-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;

      Object.hashAll([constraints.minWidth, 64]);

      Object.hashAll([constraints.maxWidth, 64]);

      Object.hashAll([constraints.minHeight, 64]);

      Object.hashAll([constraints.maxHeight, 64]);

      Object.hashAll([decoration.color, AppPalette.light.surface3]);

      expect(decoration.shape, BoxShape.circle);
      Object.hashAll([
        find.descendant(
          of: find.byKey(const ValueKey('search-empty-icon')),
          matching: find.byIcon(Icons.search_off),
        ),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'empty state shows 64x64 surface3 circle with magnifier icon [assertion 7/7]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'empty icon keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-empty-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;

      Object.hashAll([constraints.minWidth, 64]);

      Object.hashAll([constraints.maxWidth, 64]);

      Object.hashAll([constraints.minHeight, 64]);

      Object.hashAll([constraints.maxHeight, 64]);

      Object.hashAll([decoration.color, AppPalette.light.surface3]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      expect(
        find.descendant(
          of: find.byKey(const ValueKey('search-empty-icon')),
          matching: find.byIcon(Icons.search_off),
        ),
        findsOneWidget,
      );
    },
  );
}
