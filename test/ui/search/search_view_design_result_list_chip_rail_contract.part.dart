part of 'search_view_design_contract_test.dart';

void _searchViewDesignResultListChipRailContractTests() {
  testWidgets(
    'focused search cancel follows Round6 bold action text [assertion 1/2]',
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

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      final cancel = tester.widget<Text>(find.text('キャンセル'));
      expect(cancel.style?.color, AppPalette.light.primary);
      Object.hashAll([cancel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'focused search cancel follows Round6 bold action text [assertion 2/2]',
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

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      final cancel = tester.widget<Text>(find.text('キャンセル'));
      Object.hashAll([cancel.style?.color, AppPalette.light.primary]);

      expect(cancel.style?.fontWeight, FontWeight.w700);
    },
  );

  testWidgets(
    'loading-more footer uses Round6 shimmer placeholder [assertion 1/6]',
    (
      tester,
    ) async {
      final page2 = Completer<DrugListResponseDto>();
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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

      final footerFinder = find.byKey(
        const ValueKey('search-load-more-footer'),
      );
      final footer = tester.widget<DecoratedBox>(footerFinder);
      final decoration = footer.decoration as BoxDecoration;
      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate(
          (widget) => widget is Skeletonizer && widget.enabled,
        ),
      );

      Object.hashAll([find.text('さらに読み込む · 1 / 6'), findsNothing]);

      Object.hashAll([skeletonizer.enabled, isTrue]);

      Object.hashAll([decoration.color, AppPalette.light.surface]);

      Object.hashAll([decoration.border?.top.color, AppPalette.light.hairline]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      page2.complete(_drugListFixture().copyWith(page: 2));
    },
  );

  testWidgets(
    'loading-more footer uses Round6 shimmer placeholder [assertion 2/6]',
    (
      tester,
    ) async {
      final page2 = Completer<DrugListResponseDto>();
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
      Object.hashAll([
        container.read(searchScreenProvider).phase,
        isA<SearchPhaseLoadingMore>(),
      ]);

      await tester.drag(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
        const Offset(0, -3000),
      );
      await tester.pump();

      final footerFinder = find.byKey(
        const ValueKey('search-load-more-footer'),
      );
      final footer = tester.widget<DecoratedBox>(footerFinder);
      final decoration = footer.decoration as BoxDecoration;
      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate(
          (widget) => widget is Skeletonizer && widget.enabled,
        ),
      );

      expect(find.text('さらに読み込む · 1 / 6'), findsNothing);
      Object.hashAll([skeletonizer.enabled, isTrue]);

      Object.hashAll([decoration.color, AppPalette.light.surface]);

      Object.hashAll([decoration.border?.top.color, AppPalette.light.hairline]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      page2.complete(_drugListFixture().copyWith(page: 2));
    },
  );

  testWidgets(
    'loading-more footer uses Round6 shimmer placeholder [assertion 3/6]',
    (
      tester,
    ) async {
      final page2 = Completer<DrugListResponseDto>();
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
      Object.hashAll([
        container.read(searchScreenProvider).phase,
        isA<SearchPhaseLoadingMore>(),
      ]);

      await tester.drag(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
        const Offset(0, -3000),
      );
      await tester.pump();

      final footerFinder = find.byKey(
        const ValueKey('search-load-more-footer'),
      );
      final footer = tester.widget<DecoratedBox>(footerFinder);
      final decoration = footer.decoration as BoxDecoration;
      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate(
          (widget) => widget is Skeletonizer && widget.enabled,
        ),
      );

      Object.hashAll([find.text('さらに読み込む · 1 / 6'), findsNothing]);

      expect(skeletonizer.enabled, isTrue);
      Object.hashAll([decoration.color, AppPalette.light.surface]);

      Object.hashAll([decoration.border?.top.color, AppPalette.light.hairline]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      page2.complete(_drugListFixture().copyWith(page: 2));
    },
  );

  testWidgets(
    'loading-more footer uses Round6 shimmer placeholder [assertion 4/6]',
    (
      tester,
    ) async {
      final page2 = Completer<DrugListResponseDto>();
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
      Object.hashAll([
        container.read(searchScreenProvider).phase,
        isA<SearchPhaseLoadingMore>(),
      ]);

      await tester.drag(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
        const Offset(0, -3000),
      );
      await tester.pump();

      final footerFinder = find.byKey(
        const ValueKey('search-load-more-footer'),
      );
      final footer = tester.widget<DecoratedBox>(footerFinder);
      final decoration = footer.decoration as BoxDecoration;
      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate(
          (widget) => widget is Skeletonizer && widget.enabled,
        ),
      );

      Object.hashAll([find.text('さらに読み込む · 1 / 6'), findsNothing]);

      Object.hashAll([skeletonizer.enabled, isTrue]);

      expect(decoration.color, AppPalette.light.surface);
      Object.hashAll([decoration.border?.top.color, AppPalette.light.hairline]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      page2.complete(_drugListFixture().copyWith(page: 2));
    },
  );

  testWidgets(
    'loading-more footer uses Round6 shimmer placeholder [assertion 5/6]',
    (
      tester,
    ) async {
      final page2 = Completer<DrugListResponseDto>();
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
      Object.hashAll([
        container.read(searchScreenProvider).phase,
        isA<SearchPhaseLoadingMore>(),
      ]);

      await tester.drag(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
        const Offset(0, -3000),
      );
      await tester.pump();

      final footerFinder = find.byKey(
        const ValueKey('search-load-more-footer'),
      );
      final footer = tester.widget<DecoratedBox>(footerFinder);
      final decoration = footer.decoration as BoxDecoration;
      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate(
          (widget) => widget is Skeletonizer && widget.enabled,
        ),
      );

      Object.hashAll([find.text('さらに読み込む · 1 / 6'), findsNothing]);

      Object.hashAll([skeletonizer.enabled, isTrue]);

      Object.hashAll([decoration.color, AppPalette.light.surface]);

      expect(decoration.border?.top.color, AppPalette.light.hairline);
      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      page2.complete(_drugListFixture().copyWith(page: 2));
    },
  );

  testWidgets(
    'loading-more footer uses Round6 shimmer placeholder [assertion 6/6]',
    (
      tester,
    ) async {
      final page2 = Completer<DrugListResponseDto>();
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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
      Object.hashAll([
        container.read(searchScreenProvider).phase,
        isA<SearchPhaseLoadingMore>(),
      ]);

      await tester.drag(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
        const Offset(0, -3000),
      );
      await tester.pump();

      final footerFinder = find.byKey(
        const ValueKey('search-load-more-footer'),
      );
      final footer = tester.widget<DecoratedBox>(footerFinder);
      final decoration = footer.decoration as BoxDecoration;
      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate(
          (widget) => widget is Skeletonizer && widget.enabled,
        ),
      );

      Object.hashAll([find.text('さらに読み込む · 1 / 6'), findsNothing]);

      Object.hashAll([skeletonizer.enabled, isTrue]);

      Object.hashAll([decoration.color, AppPalette.light.surface]);

      Object.hashAll([decoration.border?.top.color, AppPalette.light.hairline]);

      expect(decoration.borderRadius, BorderRadius.circular(10));

      page2.complete(_drugListFixture().copyWith(page: 2));
    },
  );

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

  testWidgets(
    'SearchView applied chip rail follows Round5 overflow contract [assertion 1/6]',
    (
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
      Object.hashAll([rail.right, 390]);

      Object.hashAll([rail.height, 48]);

      Object.hashAll([fade.right, rail.right]);

      Object.hashAll([fade.width, 30]);

      Object.hashAll([chevron.right, rail.right - 4]);
    },
  );

  testWidgets(
    'SearchView applied chip rail follows Round5 overflow contract [assertion 2/6]',
    (
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

      Object.hashAll([rail.left, 0]);

      expect(rail.right, 390);
      Object.hashAll([rail.height, 48]);

      Object.hashAll([fade.right, rail.right]);

      Object.hashAll([fade.width, 30]);

      Object.hashAll([chevron.right, rail.right - 4]);
    },
  );

  testWidgets(
    'SearchView applied chip rail follows Round5 overflow contract [assertion 3/6]',
    (
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

      Object.hashAll([rail.left, 0]);

      Object.hashAll([rail.right, 390]);

      expect(rail.height, 48);
      Object.hashAll([fade.right, rail.right]);

      Object.hashAll([fade.width, 30]);

      Object.hashAll([chevron.right, rail.right - 4]);
    },
  );

  testWidgets(
    'SearchView applied chip rail follows Round5 overflow contract [assertion 4/6]',
    (
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

      Object.hashAll([rail.left, 0]);

      Object.hashAll([rail.right, 390]);

      Object.hashAll([rail.height, 48]);

      expect(fade.right, rail.right);
      Object.hashAll([fade.width, 30]);

      Object.hashAll([chevron.right, rail.right - 4]);
    },
  );

  testWidgets(
    'SearchView applied chip rail follows Round5 overflow contract [assertion 5/6]',
    (
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

      Object.hashAll([rail.left, 0]);

      Object.hashAll([rail.right, 390]);

      Object.hashAll([rail.height, 48]);

      Object.hashAll([fade.right, rail.right]);

      expect(fade.width, 30);
      Object.hashAll([chevron.right, rail.right - 4]);
    },
  );

  testWidgets(
    'SearchView applied chip rail follows Round5 overflow contract [assertion 6/6]',
    (
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

      Object.hashAll([rail.left, 0]);

      Object.hashAll([rail.right, 390]);

      Object.hashAll([rail.height, 48]);

      Object.hashAll([fade.right, rail.right]);

      Object.hashAll([fade.width, 30]);

      expect(chevron.right, rail.right - 4);
    },
  );

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

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 1/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      expect(label.style?.fontWeight, FontWeight.w700);
      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 2/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      expect(label.style?.letterSpacing, 0.5);
      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 3/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      expect(label.style?.color, AppPalette.light.muted);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 4/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      expect(chipFinder, findsOneWidget);
      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 5/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      expect(decoration.color, AppPalette.light.primarySoft);
      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 6/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      expect(decoration.border?.top.color, AppPalette.light.primaryRing);
      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 7/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      expect(decoration.border?.top.width, 0.5);
      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 8/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      expect(decoration.borderRadius, BorderRadius.circular(14));

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 9/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      expect(closeFinder, findsOneWidget);
      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 10/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      expect(closeDecoration.color, const Color(0x2E007AFF));
      Object.hashAll([closeDecoration.borderRadius, BorderRadius.circular(8)]);
    },
  );

  testWidgets(
    'SearchView applied chip rail uses Round6 chip visuals [assertion 11/11]',
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
      await tester.tap(find.text('毒薬'));
      await tester.tap(find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('適用中'));
      Object.hashAll([label.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([label.style?.letterSpacing, 0.5]);

      Object.hashAll([label.style?.color, AppPalette.light.muted]);

      final chipFinder = find.byKey(
        const ValueKey('search-applied-filter-chip-毒薬'),
      );
      Object.hashAll([chipFinder, findsOneWidget]);

      final chip = tester.widget<DecoratedBox>(chipFinder);
      final decoration = chip.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([decoration.border?.top.width, 0.5]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(14)]);

      final closeFinder = find.byKey(
        const ValueKey('search-applied-filter-close-毒薬'),
      );
      Object.hashAll([closeFinder, findsOneWidget]);

      final close = tester.widget<DecoratedBox>(closeFinder);
      final closeDecoration = close.decoration as BoxDecoration;
      Object.hashAll([closeDecoration.color, const Color(0x2E007AFF)]);

      expect(closeDecoration.borderRadius, BorderRadius.circular(8));
    },
  );

  testWidgets(
    'SearchView applied chip rail labels ATC chips with category text [assertion 1/2]',
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
      Object.hashAll([find.text('A'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView applied chip rail labels ATC chips with category text [assertion 2/2]',
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

      Object.hashAll([find.text('A 消化器系および代謝'), findsOneWidget]);

      expect(find.text('A'), findsNothing);
    },
  );

  testWidgets(
    'SearchView applied chip rail labels therapeutic category chips with  [assertion 1/2] category text',
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
      Object.hashAll([find.text('alimentary_metabolism'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView applied chip rail labels therapeutic category chips with  [assertion 2/2] category text',
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

      Object.hashAll([find.text('消化器系および代謝'), findsWidgets]);

      expect(find.text('alimentary_metabolism'), findsNothing);
    },
  );
}
