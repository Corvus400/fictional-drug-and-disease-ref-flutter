part of 'search_view_design_contract_test.dart';

void _searchViewDesignFilterSheetContractTests() {
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
      expect(decoration.color, AppPalette.light.primarySoft);
      expect(decoration.border?.top.color, AppPalette.light.primaryRing);
      expect(decoration.border?.top.width, 0.5);
      expect(decoration.borderRadius, BorderRadius.circular(14));
      expect(tester.getSize(selectedFinder).height, 30);
      expect(
        DefaultTextStyle.of(tester.element(find.text('劇薬'))).style.color,
        AppPalette.light.primary,
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
      expect(selectedCheck.color, AppPalette.light.primary);

      final unselectedFinder = find.byKey(
        const ValueKey('search-filter-pill-chip-unselected-poison'),
      );
      expect(unselectedFinder, findsOneWidget);
      final unselected = tester.widget<DecoratedBox>(unselectedFinder);
      final unselectedDecoration = unselected.decoration as BoxDecoration;
      expect(unselectedDecoration.color, AppPalette.light.surface);
      expect(
        unselectedDecoration.border?.top.color,
        AppPalette.light.hairline,
      );
      expect(unselectedDecoration.border?.top.width, 0.5);
      expect(unselectedDecoration.borderRadius, BorderRadius.circular(14));
      expect(tester.getSize(unselectedFinder).height, 30);
      expect(
        DefaultTextStyle.of(tester.element(find.text('毒薬'))).style.color,
        AppPalette.light.ink2,
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
      expect(countDecoration.color, AppPalette.light.primary);
      expect(countDecoration.borderRadius, BorderRadius.circular(9));
      expect(tester.getSize(countPillBoxFinder).height, 18);
      final countTextFinder = find.descendant(
        of: countPillFinder,
        matching: find.text('2'),
      );
      final countText = tester.widget<Text>(countTextFinder);
      expect(countText.style?.color, AppPalette.light.onPrimary);
      expect(countText.style?.fontWeight, FontWeight.w700);

      final title = tester.widget<Text>(find.text('絞り込み（医薬品）'));
      expect(title.style?.color, AppPalette.light.ink);
      expect(title.style?.fontWeight, FontWeight.w700);

      final reset = tester.widget<Text>(find.text('リセット'));
      expect(reset.style?.color, AppPalette.light.primary);
      expect(reset.style?.fontWeight, FontWeight.w700);

      final closeButton = tester.widget<IconButton>(
        find.byKey(const ValueKey('filter-sheet-close-icon')),
      );
      final closeIcon = closeButton.icon as Icon;
      expect(closeIcon.color, AppPalette.light.primary);

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
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

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
          ? AppPalette.dark
          : AppPalette.light;
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
}
