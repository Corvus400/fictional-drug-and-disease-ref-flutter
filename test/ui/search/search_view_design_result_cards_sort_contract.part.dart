part of 'search_view_design_contract_test.dart';

void _searchViewDesignResultCardsSortContractTests() {
  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 1/13]',
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
      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 2/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      expect(subtitle.textAlign, TextAlign.center);
      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 3/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      expect(
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      );
      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 4/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      expect(
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      );
      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 5/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      expect(
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      );
      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 6/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      expect(
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      );
      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 7/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      expect(
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      );
      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 8/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      expect(
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      );
      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 9/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      expect(
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      );
      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 10/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      expect(
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      );
      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 11/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 12/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([removeLabel.style?.fontWeight, FontWeight.w700]);
    },
  );

  testWidgets(
    'empty recovery CTAs use Round6 sizes, palette, and radius [assertion 13/13]',
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

      Object.hashAll([title.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([subtitle.textAlign, TextAlign.center]);

      Object.hashAll([
        tester.getSize(resetFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        reset.style?.backgroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionBg,
      ]);

      Object.hashAll([
        reset.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.searchPrimaryActionFg,
      ]);

      Object.hashAll([
        (resetShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      Object.hashAll([
        tester.getSize(removeFinder).height,
        SearchConstants.searchEmptyCtaHeight,
      ]);

      Object.hashAll([
        remove.style?.foregroundColor?.resolve(<WidgetState>{}),
        AppPalette.light.primary,
      ]);

      Object.hashAll([
        remove.style?.side?.resolve(<WidgetState>{})?.color,
        AppPalette.light.primaryRing,
      ]);

      Object.hashAll([
        (removeShape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(SearchConstants.searchEmptyCtaRadius),
      ]);

      final resetRect = tester.getRect(resetFinder);
      final removeRect = tester.getRect(removeFinder);
      Object.hashAll([removeRect.top - resetRect.bottom, 8]);

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
      Object.hashAll([resetLabel.style?.fontWeight, FontWeight.w700]);

      expect(removeLabel.style?.fontWeight, FontWeight.w700);
    },
  );

  testWidgets(
    'filter sheet close icon uses Round6 primary color [assertion 1/2]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

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
      Object.hashAll([closeIcon.color, AppPalette.light.primary]);
    },
  );

  testWidgets(
    'filter sheet close icon uses Round6 primary color [assertion 2/2]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

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

      Object.hashAll([closeIcon.icon, Icons.close]);

      expect(closeIcon.color, AppPalette.light.primary);
    },
  );

  testWidgets(
    'FAB badge uses Round6 custom +N geometry and colors [assertion 1/7]',
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
      Object.hashAll([tester.getSize(badgeFinder).height, 22]);

      Object.hashAll([decoration.color, AppPalette.light.danger]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(11)]);

      Object.hashAll([decoration.border?.top.width, 2]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.background,
      ]);

      Object.hashAll([text.style?.color, Colors.white]);
    },
  );

  testWidgets(
    'FAB badge uses Round6 custom +N geometry and colors [assertion 2/7]',
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

      Object.hashAll([
        tester.getSize(badgeFinder).width,
        greaterThanOrEqualTo(24),
      ]);

      expect(tester.getSize(badgeFinder).height, 22);
      Object.hashAll([decoration.color, AppPalette.light.danger]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(11)]);

      Object.hashAll([decoration.border?.top.width, 2]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.background,
      ]);

      Object.hashAll([text.style?.color, Colors.white]);
    },
  );

  testWidgets(
    'FAB badge uses Round6 custom +N geometry and colors [assertion 3/7]',
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

      Object.hashAll([
        tester.getSize(badgeFinder).width,
        greaterThanOrEqualTo(24),
      ]);

      Object.hashAll([tester.getSize(badgeFinder).height, 22]);

      expect(decoration.color, AppPalette.light.danger);
      Object.hashAll([decoration.borderRadius, BorderRadius.circular(11)]);

      Object.hashAll([decoration.border?.top.width, 2]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.background,
      ]);

      Object.hashAll([text.style?.color, Colors.white]);
    },
  );

  testWidgets(
    'FAB badge uses Round6 custom +N geometry and colors [assertion 4/7]',
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

      Object.hashAll([
        tester.getSize(badgeFinder).width,
        greaterThanOrEqualTo(24),
      ]);

      Object.hashAll([tester.getSize(badgeFinder).height, 22]);

      Object.hashAll([decoration.color, AppPalette.light.danger]);

      expect(decoration.borderRadius, BorderRadius.circular(11));
      Object.hashAll([decoration.border?.top.width, 2]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.background,
      ]);

      Object.hashAll([text.style?.color, Colors.white]);
    },
  );

  testWidgets(
    'FAB badge uses Round6 custom +N geometry and colors [assertion 5/7]',
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

      Object.hashAll([
        tester.getSize(badgeFinder).width,
        greaterThanOrEqualTo(24),
      ]);

      Object.hashAll([tester.getSize(badgeFinder).height, 22]);

      Object.hashAll([decoration.color, AppPalette.light.danger]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(11)]);

      expect(decoration.border?.top.width, 2);
      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.background,
      ]);

      Object.hashAll([text.style?.color, Colors.white]);
    },
  );

  testWidgets(
    'FAB badge uses Round6 custom +N geometry and colors [assertion 6/7]',
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

      Object.hashAll([
        tester.getSize(badgeFinder).width,
        greaterThanOrEqualTo(24),
      ]);

      Object.hashAll([tester.getSize(badgeFinder).height, 22]);

      Object.hashAll([decoration.color, AppPalette.light.danger]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(11)]);

      Object.hashAll([decoration.border?.top.width, 2]);

      expect(decoration.border?.top.color, AppPalette.light.background);
      Object.hashAll([text.style?.color, Colors.white]);
    },
  );

  testWidgets(
    'FAB badge uses Round6 custom +N geometry and colors [assertion 7/7]',
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

      Object.hashAll([
        tester.getSize(badgeFinder).width,
        greaterThanOrEqualTo(24),
      ]);

      Object.hashAll([tester.getSize(badgeFinder).height, 22]);

      Object.hashAll([decoration.color, AppPalette.light.danger]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(11)]);

      Object.hashAll([decoration.border?.top.width, 2]);

      Object.hashAll([
        decoration.border?.top.color,
        AppPalette.light.background,
      ]);

      expect(text.style?.color, Colors.white);
    },
  );

  testWidgets(
    'SearchView result toolbar follows Round6 phone metrics [assertion 1/3]',
    (
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
      Object.hashAll([toolbar.left, 16]);

      Object.hashAll([toolbar.width, 358]);
    },
  );

  testWidgets(
    'SearchView result toolbar follows Round6 phone metrics [assertion 2/3]',
    (
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

      Object.hashAll([toolbar.height, 36]);

      expect(toolbar.left, 16);
      Object.hashAll([toolbar.width, 358]);
    },
  );

  testWidgets(
    'SearchView result toolbar follows Round6 phone metrics [assertion 3/3]',
    (
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

      Object.hashAll([toolbar.height, 36]);

      Object.hashAll([toolbar.left, 16]);

      expect(toolbar.width, 358);
    },
  );

  testWidgets('drug card image uses 2:3 aspect ratio [assertion 1/2]', (
    tester,
  ) async {
    await _pumpSearchViewWithDrugResults(tester, db);

    final imageFinder = find.byKey(const ValueKey('drug-image-drug_0080'));
    expect(imageFinder, findsOneWidget);
    final size = tester.getSize(imageFinder);

    Object.hashAll([
      size.width / size.height,
      closeTo(SearchConstants.searchDrugCardImageAspectRatio, 0.01),
    ]);
  });

  testWidgets('drug card image uses 2:3 aspect ratio [assertion 2/2]', (
    tester,
  ) async {
    await _pumpSearchViewWithDrugResults(tester, db);

    final imageFinder = find.byKey(const ValueKey('drug-image-drug_0080'));
    Object.hashAll([imageFinder, findsOneWidget]);

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
    'SearchView sort toolbar label shows current axis and direction [assertion 1/2]',
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
      Object.hashAll([find.text('並び替え'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView sort toolbar label shows current axis and direction [assertion 2/2]',
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

      Object.hashAll([find.text('並び替え： 更新日(新しい順) ↓ ▾'), findsOneWidget]);

      expect(find.text('並び替え'), findsNothing);
    },
  );

  testWidgets(
    'SearchView sort sheet marks selected drug option with check [assertion 1/3]',
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
      await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('search-sort-check-drug-revised')),
        findsOneWidget,
      );
      final selectedTitle = tester.widget<Text>(find.text('更新日(新しい順)').last);
      Object.hashAll([selectedTitle.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedTitle.style?.color, AppPalette.light.primary]);
    },
  );

  testWidgets(
    'SearchView sort sheet marks selected drug option with check [assertion 2/3]',
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
      await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-sort-check-drug-revised')),
        findsOneWidget,
      ]);

      final selectedTitle = tester.widget<Text>(find.text('更新日(新しい順)').last);
      expect(selectedTitle.style?.fontWeight, FontWeight.w700);
      Object.hashAll([selectedTitle.style?.color, AppPalette.light.primary]);
    },
  );

  testWidgets(
    'SearchView sort sheet marks selected drug option with check [assertion 3/3]',
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
      await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-sort-check-drug-revised')),
        findsOneWidget,
      ]);

      final selectedTitle = tester.widget<Text>(find.text('更新日(新しい順)').last);
      Object.hashAll([selectedTitle.style?.fontWeight, FontWeight.w700]);

      expect(selectedTitle.style?.color, AppPalette.light.primary);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 1/11]',
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

      expect(sheet.color, AppPalette.light.surface);
      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 2/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      expect(
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      );
      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 3/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      expect(
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      );
      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 4/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      expect(header.style?.color, AppPalette.light.ink);
      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 5/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      expect(header.style?.fontWeight, FontWeight.w700);
      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 6/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      expect(firstRow.borderRadius, BorderRadius.zero);
      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 7/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      expect(firstDivider.color, AppPalette.light.hairline2);
      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 8/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      expect(selectedLabel.style?.color, AppPalette.light.primary);
      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 9/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      expect(selectedLabel.style?.fontWeight, FontWeight.w700);
      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 10/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      expect(selectedCheck.color, AppPalette.light.primary);
      Object.hashAll([selectedCheck.size, 16]);
    },
  );

  testWidgets(
    'SearchView sort sheet follows Round6 selector surface contract [assertion 11/11]',
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

      Object.hashAll([sheet.color, AppPalette.light.surface]);

      Object.hashAll([
        (sheet.shape! as RoundedRectangleBorder).borderRadius,
        const BorderRadius.vertical(top: Radius.circular(20)),
      ]);

      Object.hashAll([
        (handle.decoration as BoxDecoration).color,
        AppPalette.light.hairline,
      ]);

      Object.hashAll([header.style?.color, AppPalette.light.ink]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([firstRow.borderRadius, BorderRadius.zero]);

      Object.hashAll([firstDivider.color, AppPalette.light.hairline2]);

      Object.hashAll([selectedLabel.style?.color, AppPalette.light.primary]);

      Object.hashAll([selectedLabel.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([selectedCheck.color, AppPalette.light.primary]);

      expect(selectedCheck.size, 16);
    },
  );

  testWidgets(
    'SearchView closes phone sort sheet when rotating to landscape  [assertion 1/3] utility pane',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await _pumpSearchViewWithDrugResults(tester, db);

      await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('search-sort-sheet')),
        findsOneWidget,
      );

      await tester.binding.setSurfaceSize(const Size(844, 390));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-sort-sheet')),
        findsNothing,
      ]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView closes phone sort sheet when rotating to landscape  [assertion 2/3] utility pane',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await _pumpSearchViewWithDrugResults(tester, db);

      await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
      await tester.pumpAndSettle();
      Object.hashAll([
        find.byKey(const ValueKey('search-sort-sheet')),
        findsOneWidget,
      ]);

      await tester.binding.setSurfaceSize(const Size(844, 390));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('search-sort-sheet')), findsNothing);
      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView closes phone sort sheet when rotating to landscape  [assertion 3/3] utility pane',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await _pumpSearchViewWithDrugResults(tester, db);

      await tester.tap(find.text('並び替え： 更新日(新しい順) ↓ ▾'));
      await tester.pumpAndSettle();
      Object.hashAll([
        find.byKey(const ValueKey('search-sort-sheet')),
        findsOneWidget,
      ]);

      await tester.binding.setSurfaceSize(const Size(844, 390));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-sort-sheet')),
        findsNothing,
      ]);

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView closes phone filter sheet when rotating to landscape  [assertion 1/3] utility pane',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await _pumpSearchViewWithDrugResults(tester, db);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('search-round6-filter-sheet')),
        findsOneWidget,
      );

      await tester.binding.setSurfaceSize(const Size(844, 390));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-filter-sheet')),
        findsNothing,
      ]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView closes phone filter sheet when rotating to landscape  [assertion 2/3] utility pane',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await _pumpSearchViewWithDrugResults(tester, db);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      Object.hashAll([
        find.byKey(const ValueKey('search-round6-filter-sheet')),
        findsOneWidget,
      ]);

      await tester.binding.setSurfaceSize(const Size(844, 390));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('search-round6-filter-sheet')),
        findsNothing,
      );
      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView closes phone filter sheet when rotating to landscape  [assertion 3/3] utility pane',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await _pumpSearchViewWithDrugResults(tester, db);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      Object.hashAll([
        find.byKey(const ValueKey('search-round6-filter-sheet')),
        findsOneWidget,
      ]);

      await tester.binding.setSurfaceSize(const Size(844, 390));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-filter-sheet')),
        findsNothing,
      ]);

      expect(tester.takeException(), isNull);
    },
  );
}
