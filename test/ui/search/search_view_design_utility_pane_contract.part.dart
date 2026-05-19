part of 'search_view_design_contract_test.dart';

void _searchViewDesignUtilityPaneContractTests() {
  testWidgets(
    'SearchView tablet renders utility pane instead of modal-only chrome',
    (
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
            home: const SearchView(),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsNothing);
      expect(
        find.byKey(const ValueKey('search-adaptive-left-rail')),
        findsNothing,
      );
      expect(find.byKey(const ValueKey('search-utility-pane')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('search-utility-filter-section')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('search-utility-sort-section')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('search-utility-history-section')),
        findsOneWidget,
      );
    },
  );

  testWidgets('SearchView utility pane uses design surface hierarchy', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(834, 1194));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: _baseOverrides(db),
        child: MaterialApp(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final pane = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('search-utility-pane')),
    );
    final paneDecoration = pane.decoration as BoxDecoration;
    expect(paneDecoration.color, AppPalette.dark.surface2);

    final historyCard = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byKey(const ValueKey('search-utility-history-section')),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    final historyCardDecoration = historyCard.decoration as BoxDecoration;
    expect(historyCardDecoration.color, AppPalette.dark.surface);

    final expandedAxis = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('search-utility-filter-axis-regulatory_class')),
    );
    final expandedAxisDecoration = expandedAxis.decoration as BoxDecoration;
    expect(expandedAxisDecoration.color, AppPalette.dark.surface);
    expect(
      (expandedAxisDecoration.border! as Border).top.color,
      AppPalette.dark.primaryRing,
    );

    final collapsedAxis = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('search-utility-filter-axis-dosage_form')),
    );
    final collapsedAxisDecoration = collapsedAxis.decoration as BoxDecoration;
    expect(collapsedAxisDecoration.color, AppPalette.dark.surface2);
    expect(
      (collapsedAxisDecoration.border! as Border).top.color,
      AppPalette.dark.hairline2,
    );
  });

  testWidgets('SearchView utility pane follows light typography and controls', (
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
          home: const SearchView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final filterSection = find.byKey(
      const ValueKey('search-utility-filter-section'),
    );
    final filterTitle = tester.widget<Text>(
      find.descendant(of: filterSection, matching: find.text('絞り込み')),
    );
    expect(filterTitle.style?.color, AppPalette.light.ink);
    expect(filterTitle.style?.fontSize, 12);
    expect(filterTitle.style?.fontWeight, FontWeight.w700);

    final policy = tester.widget<Text>(
      find.byKey(const ValueKey('search-utility-filter-policy')),
    );
    expect(policy.style?.color, AppPalette.light.muted);
    expect(policy.style?.fontSize, 11);
    expect(policy.style?.fontWeight, FontWeight.w500);

    final axisTitle = tester.widget<Text>(
      find.descendant(
        of: find.byKey(
          const ValueKey('search-utility-filter-axis-regulatory_class'),
        ),
        matching: find.text('規制区分'),
      ),
    );
    expect(axisTitle.style?.color, AppPalette.light.ink);
    expect(axisTitle.style?.fontSize, 12);
    expect(axisTitle.style?.fontWeight, FontWeight.w700);

    final axisMeta = tester.widget<Text>(find.text('11 値・複数選択 OR'));
    expect(axisMeta.style?.color, AppPalette.light.muted);
    expect(axisMeta.style?.fontSize, 10.5);
    expect(axisMeta.style?.fontWeight, FontWeight.w500);
    expect(
      find.descendant(
        of: find.byKey(
          const ValueKey('search-utility-filter-axis-regulatory_class'),
        ),
        matching: find.byIcon(Icons.chevron_right),
      ),
      findsNothing,
    );

    final axisSummary = tester.widget<Text>(find.text('すべて').first);
    expect(axisSummary.style?.color, AppPalette.light.muted);
    expect(axisSummary.style?.fontSize, 11);
    expect(axisSummary.style?.fontWeight, FontWeight.w500);

    final clearHistory = tester.widget<Text>(find.text('すべて消す'));
    expect(clearHistory.style?.fontSize, 11.5);
    expect(clearHistory.style?.fontWeight, FontWeight.w600);

    final resetButton = tester.widget<TextButton>(
      find.byKey(const ValueKey('search-utility-filter-reset')),
    );
    expect(
      resetButton.style?.foregroundColor?.resolve({}),
      AppPalette.light.primary,
    );
    expect(resetButton.style?.textStyle?.resolve({})?.fontSize, 12);
    expect(
      resetButton.style?.textStyle?.resolve({})?.fontWeight,
      FontWeight.w600,
    );
    final resetText = tester.widget<Text>(find.text('リセット'));
    expect(resetText.style?.fontSize, 12);
    expect(resetText.style?.fontWeight, FontWeight.w600);

    final applyButton = tester.widget<FilledButton>(
      find.byKey(const ValueKey('search-utility-filter-apply')),
    );
    expect(
      applyButton.style?.backgroundColor?.resolve({}),
      AppPalette.light.primaryCont,
    );
    expect(
      applyButton.style?.foregroundColor?.resolve({}),
      AppPalette.light.onPrimaryCont,
    );
    final shape = applyButton.style?.shape?.resolve({});
    expect(shape, isA<RoundedRectangleBorder>());
    expect(
      (shape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(8),
    );
    expect(applyButton.style?.textStyle?.resolve({})?.fontSize, 13);
    expect(
      applyButton.style?.textStyle?.resolve({})?.fontWeight,
      FontWeight.w700,
    );
  });

  testWidgets('SearchView utility sort follows grouped option contract', (
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
          home: const SearchView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final group = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('search-utility-sort-options')),
    );
    final groupDecoration = group.decoration as BoxDecoration;
    expect(groupDecoration.color, AppPalette.light.hairline2);
    expect(groupDecoration.borderRadius, BorderRadius.circular(6));

    final selected = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byKey(
              const ValueKey('search-utility-sort-revised_at'),
              skipOffstage: false,
            ),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    final selectedDecoration = selected.decoration as BoxDecoration;
    expect(selectedDecoration.color, AppPalette.light.primarySoft);
    expect(selectedDecoration.border, isNull);

    final selectedLabel = tester.widget<Text>(
      find.descendant(
        of: find.byKey(
          const ValueKey('search-utility-sort-revised_at'),
          skipOffstage: false,
        ),
        matching: find.text('更新日(新しい順)'),
      ),
    );
    expect(selectedLabel.style?.color, AppPalette.light.primary);
    expect(selectedLabel.style?.fontSize, 12.5);
    expect(selectedLabel.style?.fontWeight, FontWeight.w700);

    final unselected = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byKey(
              const ValueKey('search-utility-sort-brand_name_kana'),
              skipOffstage: false,
            ),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    final unselectedDecoration = unselected.decoration as BoxDecoration;
    expect(unselectedDecoration.color, AppPalette.light.surface);
    expect(unselectedDecoration.border, isNull);

    final unselectedLabel = tester.widget<Text>(
      find.descendant(
        of: find.byKey(
          const ValueKey('search-utility-sort-brand_name_kana'),
          skipOffstage: false,
        ),
        matching: find.text('ブランド名カナ'),
      ),
    );
    expect(unselectedLabel.style?.color, AppPalette.light.ink);
    expect(unselectedLabel.style?.fontSize, 12.5);
    expect(unselectedLabel.style?.fontWeight, FontWeight.w500);

    final selectedRadio = tester.widget<Container>(
      find.byKey(
        const ValueKey('search-utility-sort-radio-revised_at'),
        skipOffstage: false,
      ),
    );
    final selectedRadioDecoration = selectedRadio.decoration! as BoxDecoration;
    expect(
      selectedRadio.constraints,
      const BoxConstraints.tightFor(width: 18, height: 18),
    );
    expect(selectedRadioDecoration.border?.top.color, AppPalette.light.primary);

    final unselectedRadio = tester.widget<Container>(
      find.byKey(
        const ValueKey('search-utility-sort-radio-brand_name_kana'),
        skipOffstage: false,
      ),
    );
    final unselectedRadioDecoration =
        unselectedRadio.decoration! as BoxDecoration;
    expect(
      unselectedRadioDecoration.border?.top.color,
      AppPalette.light.muted2,
    );
  });

  testWidgets('SearchView utility empty history uses compact placeholder', (
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
          home: const SearchView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('search-utility-history-empty')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('search-utility-history-empty-icon')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('search-history-inline-empty')),
      findsNothing,
    );
    expect(
      tester.getSize(
        find.byKey(const ValueKey('search-utility-history-empty-icon')),
      ),
      const Size(28, 28),
    );
    expect(
      tester
          .getRect(
            find.byKey(const ValueKey('search-utility-history-section')),
          )
          .height,
      lessThan(210),
    );
  });

  testWidgets('SearchView 600dp shortest side already uses utility pane', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(600, 900));
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

    expect(find.byKey(const ValueKey('search-utility-pane')), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });

  testWidgets(
    'SearchView utility pane renders idle hint and controls',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final container = ProviderContainer(overrides: _baseOverrides(db));
      addTearDown(container.dispose);
      final codec = container.read(searchQueryCodecProvider);
      final repository = container.read(searchHistoryRepositoryProvider);
      for (var index = 0; index < 6; index += 1) {
        await repository.insertWithDedup(
          id: 'utility_history_$index',
          target: 'drug',
          queryJson: codec.encode(
            DrugSearchParams(
              keyword: 'ユーティリティ履歴$index',
              dosageForm: index.isEven ? const ['tablet'] : null,
            ),
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

      expect(
        find.byKey(const ValueKey('search-utility-idle-master-state')),
        findsOneWidget,
      );
      expect(find.text('検索キーワードを入力'), findsOneWidget);
      expect(find.text('履歴やフィルタからも始められます。'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('search-utility-history-section')),
          matching: find.text('最近の検索'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('search-utility-history-section')),
          matching: find.text('検索履歴'),
        ),
        findsNothing,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget.key is ValueKey<String> &&
              (widget.key! as ValueKey<String>).value.startsWith(
                'search-utility-history-row-',
              ),
        ),
        findsNWidgets(5),
      );
      expect(find.text('ユーティリティ履歴5'), findsOneWidget);
      expect(find.text('ユーティリティ履歴0'), findsNothing);
      expect(find.text('6 件'), findsOneWidget);
      expect(
        find.byKey(
          const ValueKey('search-utility-history-query-utility_history_5'),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey('search-utility-history-count-utility_history_5'),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey('search-utility-history-when-utility_history_5'),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey('search-utility-history-filter-utility_history_4'),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey(
            'search-utility-history-filter-empty-utility_history_5',
          ),
        ),
        findsOneWidget,
      );
      expect(find.text('絞込'), findsWidgets);
      expect(find.text('絞り込み +1'), findsNothing);
      expect(find.text('7 軸 · 軸内 OR / 軸間 AND'), findsOneWidget);
      expect(find.text('11 値・複数選択 OR'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('search-utility-filter-reset')),
        findsOneWidget,
      );
      expect(find.text('結果を見る (0 件)'), findsOneWidget);
      expect(
        find.byKey(
          const ValueKey('search-utility-sort-radio-revised_at'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey('search-utility-sort-revised_at'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SearchView utility pane switches disease axes and sort options',
    (
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
            home: const SearchView(),
          ),
        ),
      );

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      expect(find.text('9 軸 · 軸内 OR / 軸間 AND'), findsOneWidget);
      expect(find.text('ICD-10 章'), findsOneWidget);
      expect(find.text('診療科'), findsOneWidget);
      expect(find.text('重症度評価あり'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.byKey(
          const ValueKey('search-utility-sort-name_kana'),
          skipOffstage: false,
        ),
        120,
        scrollable: find.descendant(
          of: find.byKey(const ValueKey('search-utility-pane')),
          matching: find.byType(Scrollable),
        ),
      );
      expect(
        find.byKey(
          const ValueKey('search-utility-sort-name_kana'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey('search-utility-sort-icd10_chapter'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('SearchView FAB uses Round6 colors in both modes', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    Future<void> pumpWithTheme(ThemeData theme, {ThemeMode? themeMode}) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _baseOverrides(db),
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
    expect(fab.backgroundColor, AppPalette.light.filterFabBg);
    expect(fab.foregroundColor, AppPalette.light.filterFabFg);

    await tester.pumpWidget(const SizedBox.shrink());
    await pumpWithTheme(AppTheme.dark(), themeMode: ThemeMode.dark);
    fab = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );
    expect(fab.backgroundColor, AppPalette.dark.filterFabBg);
    expect(fab.foregroundColor, AppPalette.dark.filterFabFg);
  });

  testWidgets('search submit button uses Round6 primary palette and radius', (
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

    final button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('search-submit-button')),
    );
    final shape = button.style?.shape?.resolve(<WidgetState>{});

    expect(
      button.style?.backgroundColor?.resolve(<WidgetState>{}),
      AppPalette.light.searchPrimaryActionBg,
    );
    expect(
      button.style?.foregroundColor?.resolve(<WidgetState>{}),
      AppPalette.light.searchPrimaryActionFg,
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
        overrides: _baseOverrides(db),
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
      AppPalette.dark.searchPrimaryActionBg,
    );
    expect(
      button.style?.foregroundColor?.resolve(<WidgetState>{}),
      AppPalette.dark.searchPrimaryActionFg,
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
      AppPalette.light.searchPrimaryActionBg,
    );
    expect(
      cta.style?.foregroundColor?.resolve(<WidgetState>{}),
      AppPalette.light.searchPrimaryActionFg,
    );
    expect(
      (shape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(SearchConstants.searchErrorCtaRadius),
    );
  });
}
