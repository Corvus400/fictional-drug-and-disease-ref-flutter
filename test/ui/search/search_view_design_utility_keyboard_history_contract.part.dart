part of 'search_view_design_contract_test.dart';

void _searchViewDesignUtilityKeyboardHistoryContractTests() {
  testWidgets('SearchView utility pane does not open phone sort sheet', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(834, 1194));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await _pumpSearchViewWithDrugResults(tester, db);

    expect(find.byKey(const ValueKey('search-utility-pane')), findsOneWidget);
    await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('search-sort-sheet')), findsNothing);
  });

  testWidgets('SearchView utility pane filter axes expand inside two-pane', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(834, 1194));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await _pumpSearchViewWithDrugResults(tester, db);

    final axis = find.byKey(
      const ValueKey('search-utility-filter-axis-dosage_form'),
    );
    expect(axis, findsOneWidget);
    expect(
      find.byKey(
        const ValueKey('search-utility-filter-axis-values-dosage_form'),
      ),
      findsNothing,
    );

    await tester.tap(axis);
    await tester.pumpAndSettle();

    expect(
      find.byKey(
        const ValueKey('search-utility-filter-axis-values-dosage_form'),
      ),
      findsOneWidget,
    );
    expect(find.text('錠剤', skipOffstage: false), findsOneWidget);
  });

  testWidgets('SearchView keeps iPad portrait utility layout under keyboard', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(834, 1194));
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
              size: Size(834, 1194),
              viewInsets: EdgeInsets.only(bottom: 804),
            ),
            child: SearchView(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('search-round6-top-chrome')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('search-utility-pane')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('search-adaptive-split-rail')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('search-landscape-vertical-tabs')),
      findsNothing,
    );
  });

  testWidgets('SearchView keeps iPad landscape utility layout under keyboard', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1194, 834));
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
              size: Size(1194, 834),
              viewInsets: EdgeInsets.only(bottom: 414),
            ),
            child: SearchView(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('search-round6-top-chrome')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('search-utility-pane')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('search-adaptive-split-rail')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('search-landscape-vertical-tabs')),
      findsNothing,
    );
  });

  testWidgets('SearchView utility pane reserves keyboard bottom inset', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1194, 834));
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
              size: Size(1194, 834),
              viewInsets: EdgeInsets.only(bottom: 414),
            ),
            child: SearchView(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final scroll = tester.widget<ListView>(
      find.byKey(const ValueKey('search-utility-pane-scroll')),
    );
    final padding = scroll.padding! as EdgeInsets;

    expect(padding.bottom, greaterThanOrEqualTo(434));
  });

  testWidgets(
    'SearchView utility pane reads raw view inset '
    'when route MediaQuery is zero',
    (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(1194, 834)
        ..viewInsets = const FakeViewPadding(bottom: 414);
      addTearDown(() {
        tester.view
          ..resetViewInsets()
          ..resetPhysicalSize()
          ..resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const MediaQuery(
              data: MediaQueryData(size: Size(1194, 834)),
              child: SearchView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final scroll = tester.widget<ListView>(
        find.byKey(const ValueKey('search-utility-pane-scroll')),
      );
      final padding = scroll.padding! as EdgeInsets;

      expect(padding.bottom, greaterThanOrEqualTo(434));
    },
  );

  testWidgets('SearchView utility pane interaction dismisses search keyboard', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1194, 834));
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

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();
    expect(tester.testTextInput.isVisible, isTrue);

    await tester.tap(
      find.byKey(const ValueKey('search-utility-filter-axis-regulatory_class')),
    );
    await tester.pump();

    expect(tester.testTextInput.isVisible, isFalse);
  });

  testWidgets(
    'SearchView utility pane filter CTA count previews toggled chips '
    'in two-pane',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final drugApiClient = _MockDrugApiClient();
      final categoryApiClient = _MockCategoryApiClient();
      when(categoryApiClient.getCategories).thenAnswer(
        (_) async => _categoriesFixture(),
      );
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
      ).thenAnswer((invocation) async {
        final pageSize = invocation.namedArguments[#pageSize] as int?;
        return _drugListFixture().copyWith(
          items: pageSize == 1 ? _drugListFixture().items.take(1).toList() : [],
          totalCount: pageSize == 1 ? 17 : 0,
        );
      });

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
      await tester.pumpAndSettle();

      expect(find.text('結果を見る (0 件)'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('search-utility-filter-axis-dosage_form')),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('錠剤', skipOffstage: false));
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pump();

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
    },
  );

  testWidgets(
    'SearchView keeps result count and sort toolbar sticky above two-pane list',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await _pumpSearchViewWithDrugResults(tester, db);

      final toolbarFinder = find.byKey(
        const ValueKey('search-results-toolbar'),
      );
      final firstTop = tester.getTopLeft(toolbarFinder).dy;

      await tester.drag(
        find.byKey(const PageStorageKey<String>('drugSearchResults')),
        const Offset(0, -360),
      );
      await tester.pumpAndSettle();

      expect(toolbarFinder, findsOneWidget);
      expect(
        find.descendant(of: toolbarFinder, matching: find.text('合計 120 件')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: toolbarFinder,
          matching: find.text('並び替え： 更新日(新しい順) ↓ ▾'),
        ),
        findsOneWidget,
      );
      expect(tester.getTopLeft(toolbarFinder).dy, firstTop);
    },
  );

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

  testWidgets('inline history follows Round6 divider and latest-five limit', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final container = ProviderContainer(overrides: _baseOverrides(db));
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
          home: SearchView(currentTime: DateTime.utc(2026, 5, 5, 9, 10)),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final inline = tester.getRect(
      find.byKey(const ValueKey('search-history-inline')),
    );
    final dividers = tester.widgetList<Divider>(
      find.descendant(
        of: find.byKey(const ValueKey('search-history-inline')),
        matching: find.byType(Divider),
      ),
    );

    expect(inline.width, 358);
    expect(dividers, hasLength(4));
    expect(dividers.first.color, AppPalette.light.hairline2);
    expect(dividers.first.thickness, 0.5);
    expect(find.text('キーボード履歴4'), findsOneWidget);
    expect(find.text('キーボード履歴0'), findsOneWidget);
    expect(
      find.byKey(
        const ValueKey('history-row-when-round6_keyboard_history_4'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const ValueKey('history-row-filter-empty-round6_keyboard_history_4'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const ValueKey('history-target-pill-round6_keyboard_history_4'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('delete-history-round6_keyboard_history_4')),
      findsNothing,
    );
    expect(find.byKey(const ValueKey('search-history-dropdown')), findsNothing);
  });

  testWidgets('history actions follow Round6 light controls', (tester) async {
    final container = ProviderContainer(overrides: _baseOverrides(db));
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

    await tester.pumpAndSettle();

    final clearButton = tester.widget<TextButton>(
      find.byKey(const ValueKey('clear-history-button')),
    );
    final clearLabel = clearButton.child! as Text;
    expect(clearLabel.style?.fontWeight, FontWeight.w700);
    expect(clearLabel.style?.color, AppPalette.light.primary);

    expect(
      find.byKey(const ValueKey('delete-history-round6_history_action')),
      findsNothing,
    );
    expect(
      find.byKey(
        const ValueKey('search-history-delete-bg-round6_history_action'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const ValueKey('history-row-filter-empty-round6_history_action'),
      ),
      findsOneWidget,
    );
  });
}
