part of 'search_view_test.dart';

void _searchViewHistoryDropdownTests() {
  testWidgets(
    'SearchView hides inline no-history panel while focused [assertion 1/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();
      expect(
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      );
      Object.hashAll([find.text('検索履歴はまだありません'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsNothing,
      ]);

      Object.hashAll([find.text('検索履歴はまだありません'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView hides inline no-history panel while focused [assertion 2/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();
      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      ]);

      expect(find.text('検索履歴はまだありません'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsNothing,
      ]);

      Object.hashAll([find.text('検索履歴はまだありません'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView hides inline no-history panel while focused [assertion 3/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();
      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('検索履歴はまだありません'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsNothing,
      );
      Object.hashAll([find.text('検索履歴はまだありません'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView hides inline no-history panel while focused [assertion 4/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();
      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('検索履歴はまだありません'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsNothing,
      ]);

      expect(find.text('検索履歴はまだありません'), findsNothing);
      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView hides inline no-history panel while focused [assertion 5/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();
      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('検索履歴はまだありません'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsNothing,
      ]);

      Object.hashAll([find.text('検索履歴はまだありません'), findsNothing]);

      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'SearchView renders Round6 history row metadata and note [assertion 1/7]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_round6_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();

      expect(
        find.byKey(const ValueKey('history-row-when-search_round6_history')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('history-row-count-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Rx'), findsNothing]);

      Object.hashAll([find.text('Dx'), findsNothing]);

      Object.hashAll([find.text('履歴メタデータ'), findsOneWidget]);

      Object.hashAll([find.text('すべて消す'), findsOneWidget]);

      Object.hashAll([find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 history row metadata and note [assertion 2/7]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_round6_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('history-row-when-search_round6_history')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('history-row-count-search_round6_history')),
        findsOneWidget,
      );
      Object.hashAll([find.text('Rx'), findsNothing]);

      Object.hashAll([find.text('Dx'), findsNothing]);

      Object.hashAll([find.text('履歴メタデータ'), findsOneWidget]);

      Object.hashAll([find.text('すべて消す'), findsOneWidget]);

      Object.hashAll([find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 history row metadata and note [assertion 3/7]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_round6_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('history-row-when-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('history-row-count-search_round6_history')),
        findsOneWidget,
      ]);

      expect(find.text('Rx'), findsNothing);
      Object.hashAll([find.text('Dx'), findsNothing]);

      Object.hashAll([find.text('履歴メタデータ'), findsOneWidget]);

      Object.hashAll([find.text('すべて消す'), findsOneWidget]);

      Object.hashAll([find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 history row metadata and note [assertion 4/7]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_round6_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('history-row-when-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('history-row-count-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Rx'), findsNothing]);

      expect(find.text('Dx'), findsNothing);
      Object.hashAll([find.text('履歴メタデータ'), findsOneWidget]);

      Object.hashAll([find.text('すべて消す'), findsOneWidget]);

      Object.hashAll([find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 history row metadata and note [assertion 5/7]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_round6_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('history-row-when-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('history-row-count-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Rx'), findsNothing]);

      Object.hashAll([find.text('Dx'), findsNothing]);

      expect(find.text('履歴メタデータ'), findsOneWidget);
      Object.hashAll([find.text('すべて消す'), findsOneWidget]);

      Object.hashAll([find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 history row metadata and note [assertion 6/7]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_round6_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('history-row-when-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('history-row-count-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Rx'), findsNothing]);

      Object.hashAll([find.text('Dx'), findsNothing]);

      Object.hashAll([find.text('履歴メタデータ'), findsOneWidget]);

      expect(find.text('すべて消す'), findsOneWidget);
      Object.hashAll([find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 history row metadata and note [assertion 7/7]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_round6_history',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('history-row-when-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('history-row-count-search_round6_history')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('Rx'), findsNothing]);

      Object.hashAll([find.text('Dx'), findsNothing]);

      Object.hashAll([find.text('履歴メタデータ'), findsOneWidget]);

      Object.hashAll([find.text('すべて消す'), findsOneWidget]);

      expect(
        find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'),
        findsNothing,
      );
    },
  );

  testWidgets('drug history row omits target pill per Round6 [assertion 1/2]', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'drug_history_target_pill',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(const DrugSearchParams(keyword: '医薬品履歴')),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 4,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );
    await tester.pump();

    expect(
      find.byKey(
        const ValueKey('history-target-pill-drug_history_target_pill'),
      ),
      findsNothing,
    );
    Object.hashAll([find.text('Dx'), findsNothing]);
  });

  testWidgets('drug history row omits target pill per Round6 [assertion 2/2]', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'drug_history_target_pill',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(const DrugSearchParams(keyword: '医薬品履歴')),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 4,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );
    await tester.pump();

    Object.hashAll([
      find.byKey(
        const ValueKey('history-target-pill-drug_history_target_pill'),
      ),
      findsNothing,
    ]);

    expect(find.text('Dx'), findsNothing);
  });

  testWidgets(
    'disease history row omits target pill per Round6 [assertion 1/2]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_history_target_pill',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DiseaseSearchParams(keyword: '疾患履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 6,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      expect(
        find.byKey(
          const ValueKey('history-target-pill-disease_history_target_pill'),
        ),
        findsNothing,
      );
      Object.hashAll([find.text('Rx'), findsNothing]);
    },
  );

  testWidgets(
    'disease history row omits target pill per Round6 [assertion 2/2]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_history_target_pill',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DiseaseSearchParams(keyword: '疾患履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 6,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(
          const ValueKey('history-target-pill-disease_history_target_pill'),
        ),
        findsNothing,
      ]);

      expect(find.text('Rx'), findsNothing);
    },
  );

  testWidgets(
    'history dropdown badges use Round6 filter colors [assertion 1/4]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'drug_history_target_pill_color',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '色確認履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 4,
          );
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_history_target_pill_color',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DiseaseSearchParams(keyword: '疾患色確認履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 6,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();

      final filterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-drug_history_target_pill_color'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final filterDecoration = filterPill.decoration as BoxDecoration;
      final filterText = tester.widget<Text>(find.text('絞込'));
      expect(filterDecoration.color, AppPalette.light.primarySoft);
      Object.hashAll([filterText.style?.color, AppPalette.light.rxInk]);

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      final emptyFilterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey(
              'history-row-filter-empty-disease_history_target_pill_color',
            ),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final emptyDecoration = emptyFilterPill.decoration as BoxDecoration;
      Object.hashAll([emptyDecoration.color, Colors.transparent]);

      Object.hashAll([
        emptyDecoration.border?.top.color,
        AppPalette.light.hairline,
      ]);
    },
  );

  testWidgets(
    'history dropdown badges use Round6 filter colors [assertion 2/4]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'drug_history_target_pill_color',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '色確認履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 4,
          );
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_history_target_pill_color',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DiseaseSearchParams(keyword: '疾患色確認履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 6,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();

      final filterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-drug_history_target_pill_color'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final filterDecoration = filterPill.decoration as BoxDecoration;
      final filterText = tester.widget<Text>(find.text('絞込'));
      Object.hashAll([filterDecoration.color, AppPalette.light.primarySoft]);

      expect(filterText.style?.color, AppPalette.light.rxInk);

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      final emptyFilterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey(
              'history-row-filter-empty-disease_history_target_pill_color',
            ),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final emptyDecoration = emptyFilterPill.decoration as BoxDecoration;
      Object.hashAll([emptyDecoration.color, Colors.transparent]);

      Object.hashAll([
        emptyDecoration.border?.top.color,
        AppPalette.light.hairline,
      ]);
    },
  );

  testWidgets(
    'history dropdown badges use Round6 filter colors [assertion 3/4]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'drug_history_target_pill_color',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '色確認履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 4,
          );
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_history_target_pill_color',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DiseaseSearchParams(keyword: '疾患色確認履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 6,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();

      final filterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-drug_history_target_pill_color'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final filterDecoration = filterPill.decoration as BoxDecoration;
      final filterText = tester.widget<Text>(find.text('絞込'));
      Object.hashAll([filterDecoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([filterText.style?.color, AppPalette.light.rxInk]);

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      final emptyFilterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey(
              'history-row-filter-empty-disease_history_target_pill_color',
            ),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final emptyDecoration = emptyFilterPill.decoration as BoxDecoration;
      expect(emptyDecoration.color, Colors.transparent);
      Object.hashAll([
        emptyDecoration.border?.top.color,
        AppPalette.light.hairline,
      ]);
    },
  );

  testWidgets(
    'history dropdown badges use Round6 filter colors [assertion 4/4]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'drug_history_target_pill_color',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '色確認履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 4,
          );
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_history_target_pill_color',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(const DiseaseSearchParams(keyword: '疾患色確認履歴')),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 6,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );
      await tester.pump();

      final filterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-drug_history_target_pill_color'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final filterDecoration = filterPill.decoration as BoxDecoration;
      final filterText = tester.widget<Text>(find.text('絞込'));
      Object.hashAll([filterDecoration.color, AppPalette.light.primarySoft]);

      Object.hashAll([filterText.style?.color, AppPalette.light.rxInk]);

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      final emptyFilterPill = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey(
              'history-row-filter-empty-disease_history_target_pill_color',
            ),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final emptyDecoration = emptyFilterPill.decoration as BoxDecoration;
      Object.hashAll([emptyDecoration.color, Colors.transparent]);

      expect(emptyDecoration.border?.top.color, AppPalette.light.hairline);
    },
  );

  testWidgets(
    'history row subtitle includes relative time and filter pill [assertion 1/4]',
    (
      tester,
    ) async {
      final now = DateTime.utc(2026, 5, 5, 12);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'history_subtitle_pill',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '字幕履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: now.subtract(const Duration(minutes: 5)),
            totalCount: 5,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(currentTime: now),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('5 件'), findsOneWidget);
      Object.hashAll([find.text('5分前'), findsOneWidget]);

      Object.hashAll([find.text('絞込'), findsOneWidget]);

      final containerWidget = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-history_subtitle_pill'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = containerWidget.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);
    },
  );

  testWidgets(
    'history row subtitle includes relative time and filter pill [assertion 2/4]',
    (
      tester,
    ) async {
      final now = DateTime.utc(2026, 5, 5, 12);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'history_subtitle_pill',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '字幕履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: now.subtract(const Duration(minutes: 5)),
            totalCount: 5,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(currentTime: now),
          ),
        ),
      );
      await tester.pump();

      Object.hashAll([find.text('5 件'), findsOneWidget]);

      expect(find.text('5分前'), findsOneWidget);
      Object.hashAll([find.text('絞込'), findsOneWidget]);

      final containerWidget = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-history_subtitle_pill'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = containerWidget.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);
    },
  );

  testWidgets(
    'history row subtitle includes relative time and filter pill [assertion 3/4]',
    (
      tester,
    ) async {
      final now = DateTime.utc(2026, 5, 5, 12);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'history_subtitle_pill',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '字幕履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: now.subtract(const Duration(minutes: 5)),
            totalCount: 5,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(currentTime: now),
          ),
        ),
      );
      await tester.pump();

      Object.hashAll([find.text('5 件'), findsOneWidget]);

      Object.hashAll([find.text('5分前'), findsOneWidget]);

      expect(find.text('絞込'), findsOneWidget);

      final containerWidget = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-history_subtitle_pill'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = containerWidget.decoration as BoxDecoration;
      Object.hashAll([decoration.color, AppPalette.light.primarySoft]);
    },
  );

  testWidgets(
    'history row subtitle includes relative time and filter pill [assertion 4/4]',
    (
      tester,
    ) async {
      final now = DateTime.utc(2026, 5, 5, 12);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'history_subtitle_pill',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(
                    keyword: '字幕履歴',
                    categoryAtc: 'C',
                    dosageForm: ['tablet'],
                  ),
                ),
            searchedAt: now.subtract(const Duration(minutes: 5)),
            totalCount: 5,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(currentTime: now),
          ),
        ),
      );
      await tester.pump();

      Object.hashAll([find.text('5 件'), findsOneWidget]);

      Object.hashAll([find.text('5分前'), findsOneWidget]);

      Object.hashAll([find.text('絞込'), findsOneWidget]);

      final containerWidget = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byKey(
            const ValueKey('history-row-filter-history_subtitle_pill'),
          ),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.color, AppPalette.light.primarySoft);
    },
  );

  testWidgets(
    'SearchView does not render per-row delete affordance in inline history [assertion 1/3]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_delete_target',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(keyword: '削除対象キーワード'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 3,
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
      await tester.pump();
      expect(find.text('削除対象キーワード'), findsOneWidget);

      Object.hashAll([
        find.byKey(const ValueKey('delete-history-search_delete_target')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(
          const ValueKey('search-history-delete-bg-search_delete_target'),
        ),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView does not render per-row delete affordance in inline history [assertion 2/3]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_delete_target',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(keyword: '削除対象キーワード'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 3,
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
      await tester.pump();
      Object.hashAll([find.text('削除対象キーワード'), findsOneWidget]);

      expect(
        find.byKey(const ValueKey('delete-history-search_delete_target')),
        findsNothing,
      );
      Object.hashAll([
        find.byKey(
          const ValueKey('search-history-delete-bg-search_delete_target'),
        ),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView does not render per-row delete affordance in inline history [assertion 3/3]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_delete_target',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(keyword: '削除対象キーワード'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 3,
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
      await tester.pump();
      Object.hashAll([find.text('削除対象キーワード'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey('delete-history-search_delete_target')),
        findsNothing,
      ]);

      expect(
        find.byKey(
          const ValueKey('search-history-delete-bg-search_delete_target'),
        ),
        findsNothing,
      );
    },
  );

  testWidgets('history row swipe dismisses the entry [assertion 1/2]', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'swipe_target',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(keyword: 'スワイプ削除'),
              ),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 3,
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
    await tester.pump();
    expect(find.text('スワイプ削除'), findsOneWidget);

    await tester.fling(
      find.byKey(const ValueKey('history-row-swipe_target')),
      const Offset(-500, 0),
      1000,
    );
    await tester.pumpAndSettle();

    Object.hashAll([find.text('スワイプ削除'), findsNothing]);
  });

  testWidgets('history row swipe dismisses the entry [assertion 2/2]', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'swipe_target',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(keyword: 'スワイプ削除'),
              ),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 3,
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
    await tester.pump();
    Object.hashAll([find.text('スワイプ削除'), findsOneWidget]);

    await tester.fling(
      find.byKey(const ValueKey('history-row-swipe_target')),
      const Offset(-500, 0),
      1000,
    );
    await tester.pumpAndSettle();

    expect(find.text('スワイプ削除'), findsNothing);
  });

  testWidgets(
    'focused_phone_history_does_not_render_under_keyboard_(T04) [assertion 1/3]',
    (tester) async {
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
          id: 'keyboard_history_$index',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(390, 844),
                viewInsets: EdgeInsets.only(bottom: 300),
              ),
              child: SearchView(debugLogDrugImageErrors: false),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();

      expect(tester.takeException(), isNull);
      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsNothing,
      ]);

      Object.hashAll([find.text('キーボード履歴4'), findsNothing]);
    },
  );

  testWidgets(
    'focused_phone_history_does_not_render_under_keyboard_(T04) [assertion 2/3]',
    (tester) async {
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
          id: 'keyboard_history_$index',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(390, 844),
                viewInsets: EdgeInsets.only(bottom: 300),
              ),
              child: SearchView(debugLogDrugImageErrors: false),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();

      Object.hashAll([tester.takeException(), isNull]);

      expect(find.byKey(const ValueKey('search-history-inline')), findsNothing);
      Object.hashAll([find.text('キーボード履歴4'), findsNothing]);
    },
  );

  testWidgets(
    'focused_phone_history_does_not_render_under_keyboard_(T04) [assertion 3/3]',
    (tester) async {
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
          id: 'keyboard_history_$index',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(390, 844),
                viewInsets: EdgeInsets.only(bottom: 300),
              ),
              child: SearchView(debugLogDrugImageErrors: false),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();

      Object.hashAll([tester.takeException(), isNull]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsNothing,
      ]);

      expect(find.text('キーボード履歴4'), findsNothing);
    },
  );

  testWidgets(
    'SearchView clears inline history after confirmation [assertion 1/3]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_clear_target',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(keyword: '全削除対象キーワード'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 11,
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
      await tester.pump();
      expect(find.text('全削除対象キーワード'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('clear-history-button')));
      await tester.pump();
      Object.hashAll([find.text('検索履歴を削除しますか？'), findsOneWidget]);

      await tester.tap(find.text('削除'));
      await tester.pump();

      Object.hashAll([find.text('全削除対象キーワード'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView clears inline history after confirmation [assertion 2/3]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_clear_target',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(keyword: '全削除対象キーワード'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 11,
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
      await tester.pump();
      Object.hashAll([find.text('全削除対象キーワード'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('clear-history-button')));
      await tester.pump();
      expect(find.text('検索履歴を削除しますか？'), findsOneWidget);

      await tester.tap(find.text('削除'));
      await tester.pump();

      Object.hashAll([find.text('全削除対象キーワード'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView clears inline history after confirmation [assertion 3/3]',
    (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_clear_target',
            target: 'drug',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DrugSearchParams(keyword: '全削除対象キーワード'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 11,
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
      await tester.pump();
      Object.hashAll([find.text('全削除対象キーワード'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('clear-history-button')));
      await tester.pump();
      Object.hashAll([find.text('検索履歴を削除しますか？'), findsOneWidget]);

      await tester.tap(find.text('削除'));
      await tester.pump();

      expect(find.text('全削除対象キーワード'), findsNothing);
    },
  );

  testWidgets(
    'SearchView clears disease history from inline history on iPhone width [assertion 1/3]',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_clear_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患全削除対象'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 7,
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
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      expect(find.text('疾患全削除対象'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('clear-history-button')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      Object.hashAll([find.text('検索履歴を削除しますか？'), findsOneWidget]);

      await tester.tap(find.text('削除'));
      await tester.pump();

      Object.hashAll([find.text('疾患全削除対象'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView clears disease history from inline history on iPhone width [assertion 2/3]',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_clear_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患全削除対象'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 7,
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
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('疾患全削除対象'), findsOneWidget]);

      await tester.tap(
        find.byKey(const ValueKey('clear-history-button')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      expect(find.text('検索履歴を削除しますか？'), findsOneWidget);

      await tester.tap(find.text('削除'));
      await tester.pump();

      Object.hashAll([find.text('疾患全削除対象'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView clears disease history from inline history on iPhone width [assertion 3/3]',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_clear_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患全削除対象'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 7,
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
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('疾患全削除対象'), findsOneWidget]);

      await tester.tap(
        find.byKey(const ValueKey('clear-history-button')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      Object.hashAll([find.text('検索履歴を削除しますか？'), findsOneWidget]);

      await tester.tap(find.text('削除'));
      await tester.pump();

      expect(find.text('疾患全削除対象'), findsNothing);
    },
  );

  testWidgets(
    'SearchView shows disease history in utility pane on iPad width [assertion 1/3]',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_delete_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患個別削除対象'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      expect(find.text('疾患個別削除対象'), findsOneWidget);
      Object.hashAll([
        find.byKey(
          const ValueKey('search-utility-history-row-disease_delete_target'),
        ),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView shows disease history in utility pane on iPad width [assertion 2/3]',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_delete_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患個別削除対象'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('疾患個別削除対象'), findsOneWidget]);

      expect(
        find.byKey(
          const ValueKey('search-utility-history-row-disease_delete_target'),
        ),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView shows disease history in utility pane on iPad width [assertion 3/3]',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_delete_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患個別削除対象'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
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
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      Object.hashAll([find.text('疾患個別削除対象'), findsOneWidget]);

      Object.hashAll([
        find.byKey(
          const ValueKey('search-utility-history-row-disease_delete_target'),
        ),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );
    },
  );
}
