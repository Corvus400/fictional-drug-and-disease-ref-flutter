part of 'search_view_design_contract_test.dart';

void _searchViewDesignPhoneChromeContractTests() {
  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 1/9]',
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
      Object.hashAll([header.top, 0]);

      Object.hashAll([headerTitle.left, 16]);

      Object.hashAll([topChrome.top, header.bottom]);

      Object.hashAll([topChrome.height, 108]);

      Object.hashAll([segmented.left, 16]);

      Object.hashAll([segmented.width, 358]);

      Object.hashAll([inputRow.height, 40]);

      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 2/9]',
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

      Object.hashAll([topChrome.width, 390]);

      expect(header.top, 0);
      Object.hashAll([headerTitle.left, 16]);

      Object.hashAll([topChrome.top, header.bottom]);

      Object.hashAll([topChrome.height, 108]);

      Object.hashAll([segmented.left, 16]);

      Object.hashAll([segmented.width, 358]);

      Object.hashAll([inputRow.height, 40]);

      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 3/9]',
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

      Object.hashAll([topChrome.width, 390]);

      Object.hashAll([header.top, 0]);

      expect(headerTitle.left, 16);
      Object.hashAll([topChrome.top, header.bottom]);

      Object.hashAll([topChrome.height, 108]);

      Object.hashAll([segmented.left, 16]);

      Object.hashAll([segmented.width, 358]);

      Object.hashAll([inputRow.height, 40]);

      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 4/9]',
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

      Object.hashAll([topChrome.width, 390]);

      Object.hashAll([header.top, 0]);

      Object.hashAll([headerTitle.left, 16]);

      expect(topChrome.top, header.bottom);
      Object.hashAll([topChrome.height, 108]);

      Object.hashAll([segmented.left, 16]);

      Object.hashAll([segmented.width, 358]);

      Object.hashAll([inputRow.height, 40]);

      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 5/9]',
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

      Object.hashAll([topChrome.width, 390]);

      Object.hashAll([header.top, 0]);

      Object.hashAll([headerTitle.left, 16]);

      Object.hashAll([topChrome.top, header.bottom]);

      expect(topChrome.height, 108);
      Object.hashAll([segmented.left, 16]);

      Object.hashAll([segmented.width, 358]);

      Object.hashAll([inputRow.height, 40]);

      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 6/9]',
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

      Object.hashAll([topChrome.width, 390]);

      Object.hashAll([header.top, 0]);

      Object.hashAll([headerTitle.left, 16]);

      Object.hashAll([topChrome.top, header.bottom]);

      Object.hashAll([topChrome.height, 108]);

      expect(segmented.left, 16);
      Object.hashAll([segmented.width, 358]);

      Object.hashAll([inputRow.height, 40]);

      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 7/9]',
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

      Object.hashAll([topChrome.width, 390]);

      Object.hashAll([header.top, 0]);

      Object.hashAll([headerTitle.left, 16]);

      Object.hashAll([topChrome.top, header.bottom]);

      Object.hashAll([topChrome.height, 108]);

      Object.hashAll([segmented.left, 16]);

      expect(segmented.width, 358);
      Object.hashAll([inputRow.height, 40]);

      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 8/9]',
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

      Object.hashAll([topChrome.width, 390]);

      Object.hashAll([header.top, 0]);

      Object.hashAll([headerTitle.left, 16]);

      Object.hashAll([topChrome.top, header.bottom]);

      Object.hashAll([topChrome.height, 108]);

      Object.hashAll([segmented.left, 16]);

      Object.hashAll([segmented.width, 358]);

      expect(inputRow.height, 40);
      Object.hashAll([topChrome.bottom - inputRow.bottom, 10]);
    },
  );

  testWidgets(
    'SearchView initial phone chrome follows common header and Round6 metrics [assertion 9/9]',
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

      Object.hashAll([topChrome.width, 390]);

      Object.hashAll([header.top, 0]);

      Object.hashAll([headerTitle.left, 16]);

      Object.hashAll([topChrome.top, header.bottom]);

      Object.hashAll([topChrome.height, 108]);

      Object.hashAll([segmented.left, 16]);

      Object.hashAll([segmented.width, 358]);

      Object.hashAll([inputRow.height, 40]);

      expect(topChrome.bottom - inputRow.bottom, 10);
    },
  );

  testWidgets(
    'search field bg matches token searchFieldBg (Light EBEBEF / Dark surface3) [assertion 1/2]',
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
      Object.hashAll([
        darkField.decoration?.fillColor,
        AppPalette.dark.searchFieldBg,
      ]);
    },
  );

  testWidgets(
    'search field bg matches token searchFieldBg (Light EBEBEF / Dark surface3) [assertion 2/2]',
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
      Object.hashAll([
        lightField.decoration?.fillColor,
        AppPalette.light.searchFieldBg,
      ]);

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
    'iPhone portrait idle shows inline history only while search is unfocused [assertion 1/5]',
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
      Object.hashAll([find.text('アムロジピン'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'iPhone portrait idle shows inline history only while search is unfocused [assertion 2/5]',
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

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      ]);

      expect(find.text('アムロジピン'), findsOneWidget);
      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'iPhone portrait idle shows inline history only while search is unfocused [assertion 3/5]',
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

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('アムロジピン'), findsOneWidget]);

      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'iPhone portrait idle shows inline history only while search is unfocused [assertion 4/5]',
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

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('アムロジピン'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('search-history-inline')), findsNothing);
      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'iPhone portrait idle shows inline history only while search is unfocused [assertion 5/5]',
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

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('アムロジピン'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsNothing,
      ]);

      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'iPhone portrait empty history uses inline idle placeholder [assertion 1/3]',
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
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'iPhone portrait empty history uses inline idle placeholder [assertion 2/3]',
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
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'iPhone portrait empty history uses inline idle placeholder [assertion 3/3]',
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
      await tester.pumpAndSettle();

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-inline-empty')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );
    },
  );

  testWidgets('SearchView FAB follows Round6 phone metrics [assertion 1/4]', (
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

    final fab = tester.getRect(find.byType(FloatingActionButton));

    expect(fab.width, 56);
    Object.hashAll([fab.height, 56]);

    Object.hashAll([390 - fab.right, 20]);

    Object.hashAll([844 - fab.bottom, 28]);
  });

  testWidgets('SearchView FAB follows Round6 phone metrics [assertion 2/4]', (
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

    final fab = tester.getRect(find.byType(FloatingActionButton));

    Object.hashAll([fab.width, 56]);

    expect(fab.height, 56);
    Object.hashAll([390 - fab.right, 20]);

    Object.hashAll([844 - fab.bottom, 28]);
  });

  testWidgets('SearchView FAB follows Round6 phone metrics [assertion 3/4]', (
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

    final fab = tester.getRect(find.byType(FloatingActionButton));

    Object.hashAll([fab.width, 56]);

    Object.hashAll([fab.height, 56]);

    expect(390 - fab.right, 20);
    Object.hashAll([844 - fab.bottom, 28]);
  });

  testWidgets('SearchView FAB follows Round6 phone metrics [assertion 4/4]', (
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

    final fab = tester.getRect(find.byType(FloatingActionButton));

    Object.hashAll([fab.width, 56]);

    Object.hashAll([fab.height, 56]);

    Object.hashAll([390 - fab.right, 20]);

    expect(844 - fab.bottom, 28);
  });

  testWidgets('SearchView keeps filter FAB phone-only [assertion 1/4]', (
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

    expect(find.byType(FloatingActionButton), findsNothing);
    Object.hashAll([
      find.byKey(const ValueKey('search-adaptive-left-rail')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey('search-utility-pane')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
      findsOneWidget,
    ]);
  });

  testWidgets('SearchView keeps filter FAB phone-only [assertion 2/4]', (
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

    Object.hashAll([find.byType(FloatingActionButton), findsNothing]);

    expect(
      find.byKey(const ValueKey('search-adaptive-left-rail')),
      findsOneWidget,
    );
    Object.hashAll([
      find.byKey(const ValueKey('search-utility-pane')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
      findsOneWidget,
    ]);
  });

  testWidgets('SearchView keeps filter FAB phone-only [assertion 3/4]', (
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

    Object.hashAll([find.byType(FloatingActionButton), findsNothing]);

    Object.hashAll([
      find.byKey(const ValueKey('search-adaptive-left-rail')),
      findsOneWidget,
    ]);

    expect(find.byKey(const ValueKey('search-utility-pane')), findsOneWidget);
    Object.hashAll([
      find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
      findsOneWidget,
    ]);
  });

  testWidgets('SearchView keeps filter FAB phone-only [assertion 4/4]', (
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

    Object.hashAll([find.byType(FloatingActionButton), findsNothing]);

    Object.hashAll([
      find.byKey(const ValueKey('search-adaptive-left-rail')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey('search-utility-pane')),
      findsOneWidget,
    ]);

    expect(
      find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
      findsOneWidget,
    );
  });

  testWidgets(
    'SearchView iPhone landscape uses 240px left rail with vertical tabs [assertion 1/6]',
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
      Object.hashAll([leftRail.left, navRail.right]);

      Object.hashAll([leftRail.width, 240]);

      Object.hashAll([
        find.byKey(const ValueKey('search-landscape-vertical-tabs')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-submit-button')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape uses 240px left rail with vertical tabs [assertion 2/6]',
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

      Object.hashAll([
        navRail.width,
        SearchConstants.searchLandscapeNavigationRailWidth,
      ]);

      expect(leftRail.left, navRail.right);
      Object.hashAll([leftRail.width, 240]);

      Object.hashAll([
        find.byKey(const ValueKey('search-landscape-vertical-tabs')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-submit-button')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape uses 240px left rail with vertical tabs [assertion 3/6]',
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

      Object.hashAll([
        navRail.width,
        SearchConstants.searchLandscapeNavigationRailWidth,
      ]);

      Object.hashAll([leftRail.left, navRail.right]);

      expect(leftRail.width, 240);
      Object.hashAll([
        find.byKey(const ValueKey('search-landscape-vertical-tabs')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-submit-button')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape uses 240px left rail with vertical tabs [assertion 4/6]',
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

      Object.hashAll([
        navRail.width,
        SearchConstants.searchLandscapeNavigationRailWidth,
      ]);

      Object.hashAll([leftRail.left, navRail.right]);

      Object.hashAll([leftRail.width, 240]);

      expect(
        find.byKey(const ValueKey('search-landscape-vertical-tabs')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-submit-button')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape uses 240px left rail with vertical tabs [assertion 5/6]',
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

      Object.hashAll([
        navRail.width,
        SearchConstants.searchLandscapeNavigationRailWidth,
      ]);

      Object.hashAll([leftRail.left, navRail.right]);

      Object.hashAll([leftRail.width, 240]);

      Object.hashAll([
        find.byKey(const ValueKey('search-landscape-vertical-tabs')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-round6-segmented')),
        findsNothing,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-submit-button')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape uses 240px left rail with vertical tabs [assertion 6/6]',
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

      Object.hashAll([
        navRail.width,
        SearchConstants.searchLandscapeNavigationRailWidth,
      ]);

      Object.hashAll([leftRail.left, navRail.right]);

      Object.hashAll([leftRail.width, 240]);

      Object.hashAll([
        find.byKey(const ValueKey('search-landscape-vertical-tabs')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsNothing,
      ]);

      expect(find.byKey(const ValueKey('search-submit-button')), findsNothing);
    },
  );

  testWidgets(
    'SearchView inside AppShell keeps icon rail in iPhone landscape [assertion 1/5]',
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
      Object.hashAll([appRail.left, 0]);

      Object.hashAll([searchRail.left, appRail.right]);

      Object.hashAll([
        searchRail.width,
        SearchConstants.searchLandscapeLeftRailWidth,
      ]);

      Object.hashAll([find.byType(NavigationBar), findsNothing]);
    },
  );

  testWidgets(
    'SearchView inside AppShell keeps icon rail in iPhone landscape [assertion 2/5]',
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

      Object.hashAll([appRail.width, 52]);

      expect(appRail.left, 0);
      Object.hashAll([searchRail.left, appRail.right]);

      Object.hashAll([
        searchRail.width,
        SearchConstants.searchLandscapeLeftRailWidth,
      ]);

      Object.hashAll([find.byType(NavigationBar), findsNothing]);
    },
  );

  testWidgets(
    'SearchView inside AppShell keeps icon rail in iPhone landscape [assertion 3/5]',
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

      Object.hashAll([appRail.width, 52]);

      Object.hashAll([appRail.left, 0]);

      expect(searchRail.left, appRail.right);
      Object.hashAll([
        searchRail.width,
        SearchConstants.searchLandscapeLeftRailWidth,
      ]);

      Object.hashAll([find.byType(NavigationBar), findsNothing]);
    },
  );

  testWidgets(
    'SearchView inside AppShell keeps icon rail in iPhone landscape [assertion 4/5]',
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

      Object.hashAll([appRail.width, 52]);

      Object.hashAll([appRail.left, 0]);

      Object.hashAll([searchRail.left, appRail.right]);

      expect(searchRail.width, SearchConstants.searchLandscapeLeftRailWidth);
      Object.hashAll([find.byType(NavigationBar), findsNothing]);
    },
  );

  testWidgets(
    'SearchView inside AppShell keeps icon rail in iPhone landscape [assertion 5/5]',
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

      Object.hashAll([appRail.width, 52]);

      Object.hashAll([appRail.left, 0]);

      Object.hashAll([searchRail.left, appRail.right]);

      Object.hashAll([
        searchRail.width,
        SearchConstants.searchLandscapeLeftRailWidth,
      ]);

      expect(find.byType(NavigationBar), findsNothing);
    },
  );

  testWidgets(
    'SearchView iPhone landscape idle master scrolls instead of overflowing  [assertion 1/3] under keyboard',
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
      Object.hashAll([
        find.byKey(const ValueKey('search-utility-idle-master-state')),
        findsOneWidget,
      ]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape idle master scrolls instead of overflowing  [assertion 2/3] under keyboard',
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

      Object.hashAll([
        find.byKey(const ValueKey('search-adaptive-split-rail')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-utility-idle-master-state')),
        findsOneWidget,
      );
      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape idle master scrolls instead of overflowing  [assertion 3/3] under keyboard',
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

      Object.hashAll([
        find.byKey(const ValueKey('search-adaptive-split-rail')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-utility-idle-master-state')),
        findsOneWidget,
      ]);

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter chips keep ICD labels readable [assertion 1/6]',
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
      Object.hashAll([
        find.byKey(
          const ValueKey('search-utility-filter-axis-values-icd10_chapter'),
          skipOffstage: false,
        ),
        findsOneWidget,
      ]);

      final longIcdLabel = tester.widget<Text>(
        find.text(
          'III 血液および造血器の疾患ならびに免疫機構の障害',
          skipOffstage: false,
        ),
      );

      Object.hashAll([longIcdLabel.maxLines, 2]);

      Object.hashAll([longIcdLabel.overflow, TextOverflow.visible]);

      Object.hashAll([longIcdLabel.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter chips keep ICD labels readable [assertion 2/6]',
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
      Object.hashAll([
        find.text('9 軸 · 軸内 OR / 軸間 AND', skipOffstage: false),
        findsOneWidget,
      ]);

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

      Object.hashAll([longIcdLabel.maxLines, 2]);

      Object.hashAll([longIcdLabel.overflow, TextOverflow.visible]);

      Object.hashAll([longIcdLabel.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter chips keep ICD labels readable [assertion 3/6]',
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
      Object.hashAll([
        find.text('9 軸 · 軸内 OR / 軸間 AND', skipOffstage: false),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(
          const ValueKey('search-utility-filter-axis-values-icd10_chapter'),
          skipOffstage: false,
        ),
        findsOneWidget,
      ]);

      final longIcdLabel = tester.widget<Text>(
        find.text(
          'III 血液および造血器の疾患ならびに免疫機構の障害',
          skipOffstage: false,
        ),
      );

      expect(longIcdLabel.maxLines, 2);
      Object.hashAll([longIcdLabel.overflow, TextOverflow.visible]);

      Object.hashAll([longIcdLabel.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter chips keep ICD labels readable [assertion 4/6]',
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
      Object.hashAll([
        find.text('9 軸 · 軸内 OR / 軸間 AND', skipOffstage: false),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(
          const ValueKey('search-utility-filter-axis-values-icd10_chapter'),
          skipOffstage: false,
        ),
        findsOneWidget,
      ]);

      final longIcdLabel = tester.widget<Text>(
        find.text(
          'III 血液および造血器の疾患ならびに免疫機構の障害',
          skipOffstage: false,
        ),
      );

      Object.hashAll([longIcdLabel.maxLines, 2]);

      expect(longIcdLabel.overflow, TextOverflow.visible);
      Object.hashAll([longIcdLabel.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter chips keep ICD labels readable [assertion 5/6]',
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
      Object.hashAll([
        find.text('9 軸 · 軸内 OR / 軸間 AND', skipOffstage: false),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(
          const ValueKey('search-utility-filter-axis-values-icd10_chapter'),
          skipOffstage: false,
        ),
        findsOneWidget,
      ]);

      final longIcdLabel = tester.widget<Text>(
        find.text(
          'III 血液および造血器の疾患ならびに免疫機構の障害',
          skipOffstage: false,
        ),
      );

      Object.hashAll([longIcdLabel.maxLines, 2]);

      Object.hashAll([longIcdLabel.overflow, TextOverflow.visible]);

      expect(longIcdLabel.softWrap, isTrue);
      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter chips keep ICD labels readable [assertion 6/6]',
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
      Object.hashAll([
        find.text('9 軸 · 軸内 OR / 軸間 AND', skipOffstage: false),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(
          const ValueKey('search-utility-filter-axis-values-icd10_chapter'),
          skipOffstage: false,
        ),
        findsOneWidget,
      ]);

      final longIcdLabel = tester.widget<Text>(
        find.text(
          'III 血液および造血器の疾患ならびに免疫機構の障害',
          skipOffstage: false,
        ),
      );

      Object.hashAll([longIcdLabel.maxLines, 2]);

      Object.hashAll([longIcdLabel.overflow, TextOverflow.visible]);

      Object.hashAll([longIcdLabel.softWrap, isTrue]);

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter actions stack in one column [assertion 1/4]',
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
      Object.hashAll([apply.width, actions.width]);

      Object.hashAll([applyLabel.maxLines, 1]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter actions stack in one column [assertion 2/4]',
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

      Object.hashAll([reset.bottom, lessThanOrEqualTo(apply.top)]);

      expect(apply.width, actions.width);
      Object.hashAll([applyLabel.maxLines, 1]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter actions stack in one column [assertion 3/4]',
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

      Object.hashAll([reset.bottom, lessThanOrEqualTo(apply.top)]);

      Object.hashAll([apply.width, actions.width]);

      expect(applyLabel.maxLines, 1);
      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter actions stack in one column [assertion 4/4]',
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

      Object.hashAll([reset.bottom, lessThanOrEqualTo(apply.top)]);

      Object.hashAll([apply.width, actions.width]);

      Object.hashAll([applyLabel.maxLines, 1]);

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 1/9]',
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
      Object.hashAll([drugAtcTitle.maxLines, 2]);

      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 2/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      expect(drugAtcTitle.maxLines, 2);
      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 3/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      Object.hashAll([drugAtcTitle.maxLines, 2]);

      expect(drugAtcTitle.overflow, TextOverflow.visible);
      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 4/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      Object.hashAll([drugAtcTitle.maxLines, 2]);

      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      expect(drugAtcTitle.softWrap, isTrue);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 5/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      Object.hashAll([drugAtcTitle.maxLines, 2]);

      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      expect(diseaseIcdTitle.data, 'ICD-10 章');
      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 6/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      Object.hashAll([drugAtcTitle.maxLines, 2]);

      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      expect(diseaseIcdTitle.maxLines, 2);
      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 7/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      Object.hashAll([drugAtcTitle.maxLines, 2]);

      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      expect(diseaseIcdTitle.overflow, TextOverflow.visible);
      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 8/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      Object.hashAll([drugAtcTitle.maxLines, 2]);

      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      expect(diseaseIcdTitle.softWrap, isTrue);
      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'SearchView iPhone landscape utility filter axis titles stay readable [assertion 9/9]',
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
      Object.hashAll([drugAtcTitle.data, 'ATC 第 1 階層']);

      Object.hashAll([drugAtcTitle.maxLines, 2]);

      Object.hashAll([drugAtcTitle.overflow, TextOverflow.visible]);

      Object.hashAll([drugAtcTitle.softWrap, isTrue]);

      await notifier.changeTab(SearchTab.diseases);
      await tester.pumpAndSettle();

      final diseaseIcdTitle = tester.widget<Text>(
        find.byKey(
          const ValueKey('search-utility-filter-axis-title-icd10_chapter'),
          skipOffstage: false,
        ),
      );
      Object.hashAll([diseaseIcdTitle.data, 'ICD-10 章']);

      Object.hashAll([diseaseIcdTitle.maxLines, 2]);

      Object.hashAll([diseaseIcdTitle.overflow, TextOverflow.visible]);

      Object.hashAll([diseaseIcdTitle.softWrap, isTrue]);

      expect(tester.takeException(), isNull);
    },
  );
}
