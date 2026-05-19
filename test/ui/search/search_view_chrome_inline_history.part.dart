part of 'search_view_test.dart';

void _searchViewChromeInlineHistoryTests() {
  testWidgets('SearchView renders Round6 search chrome without placeholder', (
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

    expect(find.text('検索'), findsWidgets);
    expect(find.text('医薬品'), findsOneWidget);
    expect(find.text('疾患'), findsOneWidget);
    expect(find.text('医薬品名・YJ・ATC コード'), findsOneWidget);
    expect(find.text('検索画面（プレースホルダー）'), findsNothing);
    expect(find.textContaining('Health:'), findsNothing);
  });

  testWidgets('empty_history_text_shown_only_when_phone_idle_unfocused_(T11)', (
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
    expect(find.text('検索履歴はまだありません'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('search-history-inline-empty')),
      findsNothing,
    );
    expect(find.text('検索履歴はまだありません'), findsNothing);
    expect(
      find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
      findsNothing,
    );
    expect(find.byKey(const ValueKey('search-history-dropdown')), findsNothing);
  });

  testWidgets(
    'SearchView renders no-history empty state after disease tab switch',
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

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      expect(find.text('検索履歴はまだありません'), findsOneWidget);
      expect(
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsOneWidget,
      );
    },
  );

  testWidgets('SearchView clear button clears the visible search text', (
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

    await tester.enterText(find.byKey(const ValueKey('search-field')), 'アムロ');
    await tester.pump();
    expect(find.text('アムロ'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('search-query-clear-button')));
    await tester.pump();

    expect(find.text('アムロ'), findsNothing);
    expect(find.text('医薬品名・YJ・ATC コード'), findsOneWidget);
  });

  testWidgets('clear_button_retains_focus_(T02)', (tester) async {
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

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.enterText(find.byKey(const ValueKey('search-field')), 'アムロ');
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('search-query-clear-button')));
    await tester.pump();

    final editableText = tester.widget<EditableText>(find.byType(EditableText));
    expect(editableText.focusNode.hasFocus, isTrue);
  });

  testWidgets('SearchView search field shows keyboard on single retap', (
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

    final field = find.byKey(const ValueKey('search-field'));
    await tester.tap(field);
    await tester.pump();
    expect(tester.testTextInput.isVisible, isTrue);

    tester.testTextInput.hide();
    tester.testTextInput.log.clear();
    final editableText = tester.widget<EditableText>(find.byType(EditableText));
    expect(editableText.focusNode.hasFocus, isTrue);
    expect(tester.testTextInput.isVisible, isFalse);

    await tester.tap(field);
    await tester.pump();

    expect(tester.testTextInput.isVisible, isTrue);
    expect(
      tester.testTextInput.log.any((call) => call.method == 'TextInput.show'),
      isTrue,
    );
  });

  testWidgets('SearchView returns cancel action to search on outside tap', (
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

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();
    expect(find.text('キャンセル'), findsOneWidget);

    await tester.tapAt(const Offset(20, 500));
    await tester.pump();

    expect(find.text('キャンセル'), findsNothing);
    expect(find.text('検索'), findsWidgets);
  });

  testWidgets('search_view_unfocuses_on_didPopNext_(T03)', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorObservers: [appRouteObserver],
          home: const SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isTrue,
    );

    final searchContext = tester.element(find.byType(SearchView));
    unawaited(
      Navigator.of(searchContext).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Text('Detail')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    Navigator.of(searchContext).pop();
    await tester.pumpAndSettle();

    final editableText = tester.widget<EditableText>(find.byType(EditableText));
    expect(editableText.focusNode.hasFocus, isFalse);
  });

  testWidgets('SearchView uses shared tab header plus Round6 search chrome', (
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

    expect(find.byType(AppBar), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('app-tab-header-title')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('search-round6-top-chrome')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('search-round6-segmented')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('search-round6-input-row')),
      findsOneWidget,
    );
  });

  testWidgets('SearchView uses AppPalette from theme', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, AppPalette.light.background);
  });

  testWidgets('SearchView renders persisted search history while idle', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'search_001',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(keyword: '履歴由来キーワード'),
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

    expect(find.text('最近の検索'), findsOneWidget);
    expect(find.text('履歴由来キーワード'), findsOneWidget);
    expect(find.text('7 件'), findsOneWidget);
  });

  testWidgets('history row tap restores params and triggers search', (
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
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        drugApiClientProvider.overrideWithValue(drugApiClient),
      ],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'history_restore_target',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(keyword: '復元キーワード'),
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
    expect(find.text('復元キーワード'), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('history-row-history_restore_target')),
    );
    await tester.pumpAndSettle();

    expect(find.text('復元キーワード'), findsWidgets);
    verify(
      () => drugApiClient.getDrugs(
        page: 1,
        pageSize: 20,
        keyword: '復元キーワード',
        keywordTarget: any(named: 'keywordTarget'),
      ),
    ).called(1);
    expect(container.read(searchScreenProvider).historyDropdownOpen, false);
  });
}
