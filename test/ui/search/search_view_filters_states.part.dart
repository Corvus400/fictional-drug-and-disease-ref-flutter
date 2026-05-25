part of 'search_view_test.dart';

void _searchViewFiltersStatesTests() {
  testWidgets(
    'SearchView empty results keep history out of result space [assertion 1/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer(
        (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
      );
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'overflow_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 1,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      await ProviderScope.containerOf(context)
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      expect(find.text('検索履歴'), findsNothing);
      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合計 0 件'), findsOneWidget]);

      Object.hashAll([find.text('該当する結果がありません'), findsOneWidget]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView empty results keep history out of result space [assertion 2/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer(
        (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
      );
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'overflow_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 1,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      await ProviderScope.containerOf(context)
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('検索履歴'), findsNothing]);

      expect(
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      );
      Object.hashAll([find.text('合計 0 件'), findsOneWidget]);

      Object.hashAll([find.text('該当する結果がありません'), findsOneWidget]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView empty results keep history out of result space [assertion 3/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer(
        (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
      );
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'overflow_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 1,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      await ProviderScope.containerOf(context)
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('検索履歴'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      expect(find.text('合計 0 件'), findsOneWidget);
      Object.hashAll([find.text('該当する結果がありません'), findsOneWidget]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView empty results keep history out of result space [assertion 4/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer(
        (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
      );
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'overflow_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 1,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      await ProviderScope.containerOf(context)
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('検索履歴'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合計 0 件'), findsOneWidget]);

      expect(find.text('該当する結果がありません'), findsOneWidget);
      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView empty results keep history out of result space [assertion 5/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer(
        (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
      );
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
          categoryApiClientProvider.overrideWithValue(categoryApiClient),
        ],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'overflow_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 1,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      await ProviderScope.containerOf(context)
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('検索履歴'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合計 0 件'), findsOneWidget]);

      Object.hashAll([find.text('該当する結果がありません'), findsOneWidget]);

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 1/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.text('通信エラー'), findsOneWidget);
      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 2/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 3/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      expect(constraints.minWidth, 72);
      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 4/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      expect(constraints.maxWidth, 72);
      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 5/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      expect(constraints.minHeight, 72);
      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 6/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      expect(constraints.maxHeight, 72);
      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 7/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      expect(decoration.color, AppPalette.light.dangerCont);
      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 8/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      expect(decoration.shape, BoxShape.circle);
      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 9/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      expect(warningIcon.size, 36);
      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 10/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      expect(warningIcon.color, AppPalette.light.danger);
      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 11/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      expect(find.text('もう一度試してください。'), findsOneWidget);
      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 12/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      expect(find.text('再試行'), findsOneWidget);
      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 13/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      expect(find.widgetWithText(FilledButton, '再試行'), findsOneWidget);
      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 14/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      expect(find.text('Type: NetworkException'), findsOneWidget);
      Object.hashAll([find.textContaining('Status:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders error state for search failure [assertion 15/15]',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'network failure keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      final iconContainer = tester.widget<Container>(
        find.byKey(const ValueKey('search-error-icon')),
      );
      final constraints = iconContainer.constraints!;
      final decoration = iconContainer.decoration! as BoxDecoration;
      final warningIcon = tester.widget<Icon>(
        find.byIcon(Icons.warning_amber_rounded),
      );

      Object.hashAll([constraints.minWidth, 72]);

      Object.hashAll([constraints.maxWidth, 72]);

      Object.hashAll([constraints.minHeight, 72]);

      Object.hashAll([constraints.maxHeight, 72]);

      Object.hashAll([decoration.color, AppPalette.light.dangerCont]);

      Object.hashAll([decoration.shape, BoxShape.circle]);

      Object.hashAll([warningIcon.size, 36]);

      Object.hashAll([warningIcon.color, AppPalette.light.danger]);

      Object.hashAll([find.text('もう一度試してください。'), findsOneWidget]);

      Object.hashAll([find.text('再試行'), findsOneWidget]);

      Object.hashAll([
        find.widgetWithText(FilledButton, '再試行'),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Type: NetworkException'), findsOneWidget]);

      expect(find.textContaining('Status:'), findsNothing);
    },
  );

  testWidgets(
    'SearchView renders error diagnostics for api response failure [assertion 1/7]',
    (tester) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            statusCode: 422,
            data: const {
              'type':
                  'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
              'title': 'Validation failed',
              'status': 422,
              'detail': 'keyword must be shorter',
              'errors': [
                {'field': 'keyword', 'reason': 'invalid keyword'},
              ],
            },
          ),
          type: DioExceptionType.badResponse,
        ),
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
        'invalid keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

      Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

      Object.hashAll([find.text('Status: 422'), findsOneWidget]);

      Object.hashAll([
        find.text(
          'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
        ),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Title: Validation failed'), findsOneWidget]);

      Object.hashAll([
        find.text('Detail: keyword must be shorter'),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView renders error diagnostics for api response failure [assertion 2/7]',
    (tester) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            statusCode: 422,
            data: const {
              'type':
                  'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
              'title': 'Validation failed',
              'status': 422,
              'detail': 'keyword must be shorter',
              'errors': [
                {'field': 'keyword', 'reason': 'invalid keyword'},
              ],
            },
          ),
          type: DioExceptionType.badResponse,
        ),
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
        'invalid keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      expect(find.text('条件に問題があります'), findsOneWidget);
      Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

      Object.hashAll([find.text('Status: 422'), findsOneWidget]);

      Object.hashAll([
        find.text(
          'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
        ),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Title: Validation failed'), findsOneWidget]);

      Object.hashAll([
        find.text('Detail: keyword must be shorter'),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView renders error diagnostics for api response failure [assertion 3/7]',
    (tester) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            statusCode: 422,
            data: const {
              'type':
                  'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
              'title': 'Validation failed',
              'status': 422,
              'detail': 'keyword must be shorter',
              'errors': [
                {'field': 'keyword', 'reason': 'invalid keyword'},
              ],
            },
          ),
          type: DioExceptionType.badResponse,
        ),
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
        'invalid keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

      expect(find.text('Type: ApiException'), findsOneWidget);
      Object.hashAll([find.text('Status: 422'), findsOneWidget]);

      Object.hashAll([
        find.text(
          'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
        ),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Title: Validation failed'), findsOneWidget]);

      Object.hashAll([
        find.text('Detail: keyword must be shorter'),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView renders error diagnostics for api response failure [assertion 4/7]',
    (tester) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            statusCode: 422,
            data: const {
              'type':
                  'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
              'title': 'Validation failed',
              'status': 422,
              'detail': 'keyword must be shorter',
              'errors': [
                {'field': 'keyword', 'reason': 'invalid keyword'},
              ],
            },
          ),
          type: DioExceptionType.badResponse,
        ),
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
        'invalid keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

      Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

      expect(find.text('Status: 422'), findsOneWidget);
      Object.hashAll([
        find.text(
          'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
        ),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Title: Validation failed'), findsOneWidget]);

      Object.hashAll([
        find.text('Detail: keyword must be shorter'),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView renders error diagnostics for api response failure [assertion 5/7]',
    (tester) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            statusCode: 422,
            data: const {
              'type':
                  'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
              'title': 'Validation failed',
              'status': 422,
              'detail': 'keyword must be shorter',
              'errors': [
                {'field': 'keyword', 'reason': 'invalid keyword'},
              ],
            },
          ),
          type: DioExceptionType.badResponse,
        ),
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
        'invalid keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

      Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

      Object.hashAll([find.text('Status: 422'), findsOneWidget]);

      expect(
        find.text(
          'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
        ),
        findsOneWidget,
      );
      Object.hashAll([find.text('Title: Validation failed'), findsOneWidget]);

      Object.hashAll([
        find.text('Detail: keyword must be shorter'),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView renders error diagnostics for api response failure [assertion 6/7]',
    (tester) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            statusCode: 422,
            data: const {
              'type':
                  'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
              'title': 'Validation failed',
              'status': 422,
              'detail': 'keyword must be shorter',
              'errors': [
                {'field': 'keyword', 'reason': 'invalid keyword'},
              ],
            },
          ),
          type: DioExceptionType.badResponse,
        ),
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
        'invalid keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

      Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

      Object.hashAll([find.text('Status: 422'), findsOneWidget]);

      Object.hashAll([
        find.text(
          'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
        ),
        findsOneWidget,
      ]);

      expect(find.text('Title: Validation failed'), findsOneWidget);
      Object.hashAll([
        find.text('Detail: keyword must be shorter'),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView renders error diagnostics for api response failure [assertion 7/7]',
    (tester) async {
      final drugApiClient = _MockDrugApiClient();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            statusCode: 422,
            data: const {
              'type':
                  'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
              'title': 'Validation failed',
              'status': 422,
              'detail': 'keyword must be shorter',
              'errors': [
                {'field': 'keyword', 'reason': 'invalid keyword'},
              ],
            },
          ),
          type: DioExceptionType.badResponse,
        ),
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
        'invalid keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byIcon(Icons.warning_amber_rounded),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

      Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

      Object.hashAll([find.text('Status: 422'), findsOneWidget]);

      Object.hashAll([
        find.text(
          'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
        ),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Title: Validation failed'), findsOneWidget]);

      expect(find.text('Detail: keyword must be shorter'), findsOneWidget);
    },
  );

  testWidgets('business_error_shows_business_text_(T05) [assertion 1/5]', (
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
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v1/drugs'),
        response: Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          statusCode: 422,
          data: const {
            'type':
                'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
            'title': 'Validation failed',
            'status': 422,
            'detail': 'invalid onset pattern',
            'errors': [
              {'field': 'onset_pattern', 'reason': 'invalid onset pattern'},
            ],
          },
        ),
        type: DioExceptionType.badResponse,
      ),
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
      'business error keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('条件に問題があります'), findsOneWidget);
    Object.hashAll([find.text('通信エラー'), findsNothing]);

    Object.hashAll([find.text('指定された条件をご確認ください。'), findsOneWidget]);

    Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

    Object.hashAll([
      find.text(
        'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
      ),
      findsOneWidget,
    ]);
  });

  testWidgets('business_error_shows_business_text_(T05) [assertion 2/5]', (
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
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v1/drugs'),
        response: Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          statusCode: 422,
          data: const {
            'type':
                'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
            'title': 'Validation failed',
            'status': 422,
            'detail': 'invalid onset pattern',
            'errors': [
              {'field': 'onset_pattern', 'reason': 'invalid onset pattern'},
            ],
          },
        ),
        type: DioExceptionType.badResponse,
      ),
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
      'business error keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

    expect(find.text('通信エラー'), findsNothing);
    Object.hashAll([find.text('指定された条件をご確認ください。'), findsOneWidget]);

    Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

    Object.hashAll([
      find.text(
        'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
      ),
      findsOneWidget,
    ]);
  });

  testWidgets('business_error_shows_business_text_(T05) [assertion 3/5]', (
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
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v1/drugs'),
        response: Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          statusCode: 422,
          data: const {
            'type':
                'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
            'title': 'Validation failed',
            'status': 422,
            'detail': 'invalid onset pattern',
            'errors': [
              {'field': 'onset_pattern', 'reason': 'invalid onset pattern'},
            ],
          },
        ),
        type: DioExceptionType.badResponse,
      ),
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
      'business error keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

    Object.hashAll([find.text('通信エラー'), findsNothing]);

    expect(find.text('指定された条件をご確認ください。'), findsOneWidget);
    Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

    Object.hashAll([
      find.text(
        'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
      ),
      findsOneWidget,
    ]);
  });

  testWidgets('business_error_shows_business_text_(T05) [assertion 4/5]', (
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
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v1/drugs'),
        response: Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          statusCode: 422,
          data: const {
            'type':
                'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
            'title': 'Validation failed',
            'status': 422,
            'detail': 'invalid onset pattern',
            'errors': [
              {'field': 'onset_pattern', 'reason': 'invalid onset pattern'},
            ],
          },
        ),
        type: DioExceptionType.badResponse,
      ),
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
      'business error keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

    Object.hashAll([find.text('通信エラー'), findsNothing]);

    Object.hashAll([find.text('指定された条件をご確認ください。'), findsOneWidget]);

    expect(find.text('Type: ApiException'), findsOneWidget);
    Object.hashAll([
      find.text(
        'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
      ),
      findsOneWidget,
    ]);
  });

  testWidgets('business_error_shows_business_text_(T05) [assertion 5/5]', (
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
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v1/drugs'),
        response: Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/v1/drugs'),
          statusCode: 422,
          data: const {
            'type':
                'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
            'title': 'Validation failed',
            'status': 422,
            'detail': 'invalid onset pattern',
            'errors': [
              {'field': 'onset_pattern', 'reason': 'invalid onset pattern'},
            ],
          },
        ),
        type: DioExceptionType.badResponse,
      ),
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
      'business error keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('条件に問題があります'), findsOneWidget]);

    Object.hashAll([find.text('通信エラー'), findsNothing]);

    Object.hashAll([find.text('指定された条件をご確認ください。'), findsOneWidget]);

    Object.hashAll([find.text('Type: ApiException'), findsOneWidget]);

    expect(
      find.text(
        'Problem type: https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'SearchView retry runs search again after failure [assertion 1/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      var callCount = 0;
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async {
        callCount += 1;
        if (callCount == 1) {
          throw DioException(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            type: DioExceptionType.connectionError,
          );
        }
        return _drugListFixture();
      });

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
        'retry keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.text('通信エラー'), findsOneWidget);

      await tester.tap(find.text('再試行'));
      await tester.pumpAndSettle();

      final item = _drugListFixture().items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      Object.hashAll([find.text(item.brandName), findsOneWidget]);

      Object.hashAll([callCount, 2]);
    },
  );

  testWidgets(
    'SearchView retry runs search again after failure [assertion 2/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      var callCount = 0;
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async {
        callCount += 1;
        if (callCount == 1) {
          throw DioException(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            type: DioExceptionType.connectionError,
          );
        }
        return _drugListFixture();
      });

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
        'retry keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      await tester.tap(find.text('再試行'));
      await tester.pumpAndSettle();

      final item = _drugListFixture().items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      expect(find.text(item.brandName), findsOneWidget);
      Object.hashAll([callCount, 2]);
    },
  );

  testWidgets(
    'SearchView retry runs search again after failure [assertion 3/3]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      var callCount = 0;
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async {
        callCount += 1;
        if (callCount == 1) {
          throw DioException(
            requestOptions: RequestOptions(path: '/v1/drugs'),
            type: DioExceptionType.connectionError,
          );
        }
        return _drugListFixture();
      });

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
        'retry keyword',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('通信エラー'), findsOneWidget]);

      await tester.tap(find.text('再試行'));
      await tester.pumpAndSettle();

      final item = _drugListFixture().items.firstWhere(
        (item) => item.brandName != item.genericName,
      );
      Object.hashAll([find.text(item.brandName), findsOneWidget]);

      expect(callCount, 2);
    },
  );

  testWidgets(
    'SearchView opens filter sheet from FAB with applied count [assertion 1/3]',
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
      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(
            regulatoryClass: ['test-regulatory'],
            dosageForm: ['test-form'],
          );
      await tester.pump();

      expect(find.text('+2'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('絞り込み（医薬品）'), findsOneWidget]);

      Object.hashAll([find.textContaining('結果を見る'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView opens filter sheet from FAB with applied count [assertion 2/3]',
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
      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(
            regulatoryClass: ['test-regulatory'],
            dosageForm: ['test-form'],
          );
      await tester.pump();

      Object.hashAll([find.text('+2'), findsOneWidget]);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('絞り込み（医薬品）'), findsOneWidget);
      Object.hashAll([find.textContaining('結果を見る'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView opens filter sheet from FAB with applied count [assertion 3/3]',
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
      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(
            regulatoryClass: ['test-regulatory'],
            dosageForm: ['test-form'],
          );
      await tester.pump();

      Object.hashAll([find.text('+2'), findsOneWidget]);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('絞り込み（医薬品）'), findsOneWidget]);

      expect(find.textContaining('結果を見る'), findsOneWidget);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 1/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('規制区分'), findsOneWidget);
      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 2/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      expect(find.text('剤形'), findsOneWidget);
      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 3/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      expect(find.text('投与経路'), findsOneWidget);
      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 4/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      expect(find.text('ATC 第 1 階層'), findsOneWidget);
      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 5/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      expect(find.text('薬効分類'), findsOneWidget);
      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 6/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      expect(find.text('副作用キーワード'), findsOneWidget);
      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 7/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      expect(find.text('患者背景'), findsOneWidget);
      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 8/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      expect(find.text('毒薬'), findsOneWidget);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 9/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      expect(find.text('錠剤'), findsOneWidget);
      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 10/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      expect(find.text('内服'), findsOneWidget);
      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 11/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      expect(find.text('C 循環器系'), findsOneWidget);
      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 12/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      expect(find.text('循環器系'), findsOneWidget);
      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('高齢者'), findsOneWidget]);

      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies drug filters from category master sheet [assertion 13/13]',
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('規制区分'), findsOneWidget]);

      Object.hashAll([find.text('剤形'), findsOneWidget]);

      Object.hashAll([find.text('投与経路'), findsOneWidget]);

      Object.hashAll([find.text('ATC 第 1 階層'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類'), findsOneWidget]);

      Object.hashAll([find.text('副作用キーワード'), findsOneWidget]);

      Object.hashAll([find.text('患者背景'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsOneWidget]);

      await _tapVisible(tester, find.text('毒薬'));
      await _tapVisible(tester, find.text('剤形'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('錠剤'), findsOneWidget]);

      await _tapVisible(tester, find.text('錠剤'));
      await _tapVisible(tester, find.text('投与経路'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('内服'), findsOneWidget]);

      await _tapVisible(tester, find.text('内服'));
      await _tapVisible(tester, find.text('ATC 第 1 階層'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('C 循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('C 循環器系'));
      await _tapVisible(tester, find.text('薬効分類'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器系'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器系'));
      await _tapVisible(tester, find.text('副作用キーワード'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('drug-filter-adverse-reaction')),
        '浮腫',
      );
      await _tapVisible(tester, find.text('患者背景'));
      await tester.pumpAndSettle();
      expect(find.text('高齢者'), findsOneWidget);
      await _tapVisible(tester, find.text('高齢者'));
      await _tapVisible(tester, find.textContaining('結果を見る'));
      await tester.pumpAndSettle();

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          regulatoryClass: ['poison'],
          dosageForm: ['tablet'],
          route: ['oral'],
          categoryAtc: 'C',
          therapeuticCategory: 'CARDIOVASCULAR_SYSTEM',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['GERIATRIC'],
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView shows applied filters and hides history on results [assertion 1/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      );
      Object.hashAll([find.text('適用中'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsWidgets]);

      Object.hashAll([find.text('錠剤'), findsWidgets]);

      Object.hashAll([find.text('検索履歴'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView shows applied filters and hides history on results [assertion 2/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      expect(find.text('適用中'), findsOneWidget);
      Object.hashAll([find.text('毒薬'), findsWidgets]);

      Object.hashAll([find.text('錠剤'), findsWidgets]);

      Object.hashAll([find.text('検索履歴'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView shows applied filters and hides history on results [assertion 3/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('適用中'), findsOneWidget]);

      expect(find.text('毒薬'), findsWidgets);
      Object.hashAll([find.text('錠剤'), findsWidgets]);

      Object.hashAll([find.text('検索履歴'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView shows applied filters and hides history on results [assertion 4/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('適用中'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsWidgets]);

      expect(find.text('錠剤'), findsWidgets);
      Object.hashAll([find.text('検索履歴'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView shows applied filters and hides history on results [assertion 5/5]',
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
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
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

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-applied-filter-bar')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('適用中'), findsOneWidget]);

      Object.hashAll([find.text('毒薬'), findsWidgets]);

      Object.hashAll([find.text('錠剤'), findsWidgets]);

      expect(find.text('検索履歴'), findsNothing);
    },
  );

  testWidgets('applied chip tap removes only that chip [assertion 1/4]', (
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
        regulatoryClass: any(named: 'regulatoryClass'),
        dosageForm: any(named: 'dosageForm'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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

    final context = tester.element(find.byType(SearchView));
    final container = ProviderScope.containerOf(context);
    await container
        .read(searchScreenProvider.notifier)
        .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
    await tester.pumpAndSettle();
    final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
    expect(find.descendant(of: bar, matching: find.text('毒薬')), findsOneWidget);
    Object.hashAll([
      find.descendant(of: bar, matching: find.text('錠剤')),
      findsOneWidget,
    ]);

    final poisonChipTapTarget = find
        .ancestor(
          of: find.descendant(of: bar, matching: find.text('毒薬')),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.tap(poisonChipTapTarget);
    await tester.pumpAndSettle();

    Object.hashAll([
      find.descendant(of: bar, matching: find.text('毒薬')),
      findsNothing,
    ]);

    Object.hashAll([
      find.descendant(of: bar, matching: find.text('錠剤')),
      findsOneWidget,
    ]);
  });

  testWidgets('applied chip tap removes only that chip [assertion 2/4]', (
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
        regulatoryClass: any(named: 'regulatoryClass'),
        dosageForm: any(named: 'dosageForm'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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

    final context = tester.element(find.byType(SearchView));
    final container = ProviderScope.containerOf(context);
    await container
        .read(searchScreenProvider.notifier)
        .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
    await tester.pumpAndSettle();
    final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
    Object.hashAll([
      find.descendant(of: bar, matching: find.text('毒薬')),
      findsOneWidget,
    ]);

    expect(find.descendant(of: bar, matching: find.text('錠剤')), findsOneWidget);

    final poisonChipTapTarget = find
        .ancestor(
          of: find.descendant(of: bar, matching: find.text('毒薬')),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.tap(poisonChipTapTarget);
    await tester.pumpAndSettle();

    Object.hashAll([
      find.descendant(of: bar, matching: find.text('毒薬')),
      findsNothing,
    ]);

    Object.hashAll([
      find.descendant(of: bar, matching: find.text('錠剤')),
      findsOneWidget,
    ]);
  });

  testWidgets('applied chip tap removes only that chip [assertion 3/4]', (
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
        regulatoryClass: any(named: 'regulatoryClass'),
        dosageForm: any(named: 'dosageForm'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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

    final context = tester.element(find.byType(SearchView));
    final container = ProviderScope.containerOf(context);
    await container
        .read(searchScreenProvider.notifier)
        .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
    await tester.pumpAndSettle();
    final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
    Object.hashAll([
      find.descendant(of: bar, matching: find.text('毒薬')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.descendant(of: bar, matching: find.text('錠剤')),
      findsOneWidget,
    ]);

    final poisonChipTapTarget = find
        .ancestor(
          of: find.descendant(of: bar, matching: find.text('毒薬')),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.tap(poisonChipTapTarget);
    await tester.pumpAndSettle();

    expect(find.descendant(of: bar, matching: find.text('毒薬')), findsNothing);
    Object.hashAll([
      find.descendant(of: bar, matching: find.text('錠剤')),
      findsOneWidget,
    ]);
  });

  testWidgets('applied chip tap removes only that chip [assertion 4/4]', (
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
        regulatoryClass: any(named: 'regulatoryClass'),
        dosageForm: any(named: 'dosageForm'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
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

    final context = tester.element(find.byType(SearchView));
    final container = ProviderScope.containerOf(context);
    await container
        .read(searchScreenProvider.notifier)
        .applyDrugFilter(regulatoryClass: ['poison'], dosageForm: ['tablet']);
    await tester.pumpAndSettle();
    final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
    Object.hashAll([
      find.descendant(of: bar, matching: find.text('毒薬')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.descendant(of: bar, matching: find.text('錠剤')),
      findsOneWidget,
    ]);

    final poisonChipTapTarget = find
        .ancestor(
          of: find.descendant(of: bar, matching: find.text('毒薬')),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.tap(poisonChipTapTarget);
    await tester.pumpAndSettle();

    Object.hashAll([
      find.descendant(of: bar, matching: find.text('毒薬')),
      findsNothing,
    ]);

    expect(find.descendant(of: bar, matching: find.text('錠剤')), findsOneWidget);
  });

  testWidgets(
    'disease applied chip labels match mock-server enum kDoc [assertion 1/7]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .changeTab(SearchTab.diseases);
      await container
          .read(searchScreenProvider.notifier)
          .applyDiseaseFilter(
            department: ['infectious_disease'],
            chronicity: ['relapsing'],
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          );
      await tester.pumpAndSettle();

      final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
      expect(
        find.descendant(of: bar, matching: find.text('感染症科')),
        findsOneWidget,
      );
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('再発性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('間欠性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('血液検査')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('relapsing')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('intermittent')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('blood_test')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'disease applied chip labels match mock-server enum kDoc [assertion 2/7]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .changeTab(SearchTab.diseases);
      await container
          .read(searchScreenProvider.notifier)
          .applyDiseaseFilter(
            department: ['infectious_disease'],
            chronicity: ['relapsing'],
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          );
      await tester.pumpAndSettle();

      final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('感染症科')),
        findsOneWidget,
      ]);

      expect(
        find.descendant(of: bar, matching: find.text('再発性')),
        findsOneWidget,
      );
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('間欠性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('血液検査')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('relapsing')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('intermittent')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('blood_test')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'disease applied chip labels match mock-server enum kDoc [assertion 3/7]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .changeTab(SearchTab.diseases);
      await container
          .read(searchScreenProvider.notifier)
          .applyDiseaseFilter(
            department: ['infectious_disease'],
            chronicity: ['relapsing'],
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          );
      await tester.pumpAndSettle();

      final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('感染症科')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('再発性')),
        findsOneWidget,
      ]);

      expect(
        find.descendant(of: bar, matching: find.text('間欠性')),
        findsOneWidget,
      );
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('血液検査')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('relapsing')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('intermittent')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('blood_test')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'disease applied chip labels match mock-server enum kDoc [assertion 4/7]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .changeTab(SearchTab.diseases);
      await container
          .read(searchScreenProvider.notifier)
          .applyDiseaseFilter(
            department: ['infectious_disease'],
            chronicity: ['relapsing'],
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          );
      await tester.pumpAndSettle();

      final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('感染症科')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('再発性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('間欠性')),
        findsOneWidget,
      ]);

      expect(
        find.descendant(of: bar, matching: find.text('血液検査')),
        findsOneWidget,
      );
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('relapsing')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('intermittent')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('blood_test')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'disease applied chip labels match mock-server enum kDoc [assertion 5/7]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .changeTab(SearchTab.diseases);
      await container
          .read(searchScreenProvider.notifier)
          .applyDiseaseFilter(
            department: ['infectious_disease'],
            chronicity: ['relapsing'],
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          );
      await tester.pumpAndSettle();

      final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('感染症科')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('再発性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('間欠性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('血液検査')),
        findsOneWidget,
      ]);

      expect(
        find.descendant(of: bar, matching: find.text('relapsing')),
        findsNothing,
      );
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('intermittent')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('blood_test')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'disease applied chip labels match mock-server enum kDoc [assertion 6/7]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .changeTab(SearchTab.diseases);
      await container
          .read(searchScreenProvider.notifier)
          .applyDiseaseFilter(
            department: ['infectious_disease'],
            chronicity: ['relapsing'],
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          );
      await tester.pumpAndSettle();

      final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('感染症科')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('再発性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('間欠性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('血液検査')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('relapsing')),
        findsNothing,
      ]);

      expect(
        find.descendant(of: bar, matching: find.text('intermittent')),
        findsNothing,
      );
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('blood_test')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'disease applied chip labels match mock-server enum kDoc [assertion 7/7]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      final context = tester.element(find.byType(SearchView));
      final container = ProviderScope.containerOf(context);
      await container
          .read(searchScreenProvider.notifier)
          .changeTab(SearchTab.diseases);
      await container
          .read(searchScreenProvider.notifier)
          .applyDiseaseFilter(
            department: ['infectious_disease'],
            chronicity: ['relapsing'],
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          );
      await tester.pumpAndSettle();

      final bar = find.byKey(const ValueKey('search-applied-filter-bar'));
      Object.hashAll([
        find.descendant(of: bar, matching: find.text('感染症科')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('再発性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('間欠性')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('血液検査')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('relapsing')),
        findsNothing,
      ]);

      Object.hashAll([
        find.descendant(of: bar, matching: find.text('intermittent')),
        findsNothing,
      ]);

      expect(
        find.descendant(of: bar, matching: find.text('blood_test')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 1/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('ICD-10 章'), findsOneWidget);
      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 2/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      expect(find.text('診療科'), findsOneWidget);
      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 3/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      expect(find.text('慢性度'), findsOneWidget);
      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 4/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      expect(find.text('感染性'), findsOneWidget);
      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 5/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      expect(find.text('症状キーワード'), findsOneWidget);
      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 6/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      expect(find.text('発症パターン'), findsOneWidget);
      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 7/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      expect(find.text('検査区分'), findsOneWidget);
      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 8/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      expect(find.text('薬物治療あり'), findsOneWidget);
      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 9/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      expect(find.text('重症度評価あり'), findsOneWidget);
      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 10/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      expect(find.text('IX 循環器系の疾患'), findsOneWidget);
      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 11/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      expect(find.text('規制区分'), findsNothing);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 12/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      expect(find.text('循環器内科'), findsOneWidget);
      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 13/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      expect(find.text('間欠性'), findsOneWidget);
      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('血液検査'), findsOneWidget]);

      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView applies disease filters from category master sheet [assertion 14/14]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(
        categoryApiClient.getCategories,
      ).thenAnswer((_) async => _categoriesFixture());
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            categoryApiClientProvider.overrideWithValue(categoryApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10 章'), findsOneWidget]);

      Object.hashAll([find.text('診療科'), findsOneWidget]);

      Object.hashAll([find.text('慢性度'), findsOneWidget]);

      Object.hashAll([find.text('感染性'), findsOneWidget]);

      Object.hashAll([find.text('症状キーワード'), findsOneWidget]);

      Object.hashAll([find.text('発症パターン'), findsOneWidget]);

      Object.hashAll([find.text('検査区分'), findsOneWidget]);

      Object.hashAll([find.text('薬物治療あり'), findsOneWidget]);

      Object.hashAll([find.text('重症度評価あり'), findsOneWidget]);

      Object.hashAll([find.text('IX 循環器系の疾患'), findsOneWidget]);

      Object.hashAll([find.text('規制区分'), findsNothing]);

      await _tapVisible(tester, find.text('IX 循環器系の疾患'));
      await _tapVisible(tester, find.text('診療科'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('循環器内科'), findsOneWidget]);

      await _tapVisible(tester, find.text('循環器内科'));
      await _tapVisible(tester, find.text('発症パターン'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('間欠性'), findsOneWidget]);

      await _tapVisible(tester, find.text('間欠性'));
      await _tapVisible(tester, find.text('検査区分'));
      await tester.pumpAndSettle();
      expect(find.text('血液検査'), findsOneWidget);
      await _tapVisible(tester, find.text('血液検査'));
      await _tapVisible(tester, find.textContaining('結果を見る'));

      verify(
        () => diseaseApiClient.getDiseases(
          page: 1,
          pageSize: SearchConstants.searchPageSize,
          icd10Chapter: ['chapter_ix'],
          department: ['cardiology'],
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
        ),
      ).called(1);
    },
  );

  testWidgets(
    'SearchView renders disease summary fields in result cards [assertion 1/5]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      expect(find.text('ICD-10: I 感染症および寄生虫症'), findsWidgets);
      Object.hashAll([find.text('感染症科'), findsWidgets]);

      Object.hashAll([find.text('救急科'), findsWidgets]);

      Object.hashAll([find.text('急性'), findsWidgets]);

      Object.hashAll([find.text('感染性'), findsWidgets]);
    },
  );

  testWidgets(
    'SearchView renders disease summary fields in result cards [assertion 2/5]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10: I 感染症および寄生虫症'), findsWidgets]);

      expect(find.text('感染症科'), findsWidgets);
      Object.hashAll([find.text('救急科'), findsWidgets]);

      Object.hashAll([find.text('急性'), findsWidgets]);

      Object.hashAll([find.text('感染性'), findsWidgets]);
    },
  );

  testWidgets(
    'SearchView renders disease summary fields in result cards [assertion 3/5]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10: I 感染症および寄生虫症'), findsWidgets]);

      Object.hashAll([find.text('感染症科'), findsWidgets]);

      expect(find.text('救急科'), findsWidgets);
      Object.hashAll([find.text('急性'), findsWidgets]);

      Object.hashAll([find.text('感染性'), findsWidgets]);
    },
  );

  testWidgets(
    'SearchView renders disease summary fields in result cards [assertion 4/5]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10: I 感染症および寄生虫症'), findsWidgets]);

      Object.hashAll([find.text('感染症科'), findsWidgets]);

      Object.hashAll([find.text('救急科'), findsWidgets]);

      expect(find.text('急性'), findsWidgets);
      Object.hashAll([find.text('感染性'), findsWidgets]);
    },
  );

  testWidgets(
    'SearchView renders disease summary fields in result cards [assertion 5/5]',
    (
      tester,
    ) async {
      final diseaseApiClient = _MockDiseaseApiClient();
      when(
        () => diseaseApiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) async => _diseaseListFixture());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('ICD-10: I 感染症および寄生虫症'), findsWidgets]);

      Object.hashAll([find.text('感染症科'), findsWidgets]);

      Object.hashAll([find.text('救急科'), findsWidgets]);

      Object.hashAll([find.text('急性'), findsWidgets]);

      expect(find.text('感染性'), findsWidgets);
    },
  );
}
