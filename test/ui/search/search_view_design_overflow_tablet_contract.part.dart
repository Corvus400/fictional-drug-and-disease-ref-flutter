part of 'search_view_design_contract_test.dart';

void _searchViewDesignOverflowTabletContractTests() {
  testWidgets('axis_summary_uses_ellipsis_overflow_(T10) [assertion 1/2]', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final diseaseApiClient = _MockDiseaseApiClient();
    final categoryApiClient = _MockCategoryApiClient();
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
    ).thenAnswer((_) async => _diseaseListFixture().copyWith(totalCount: 9));
    when(
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
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

    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await _tapVisible(tester, find.text('I 感染症および寄生虫症'));
    await _tapVisible(tester, find.text('II 新生物'));

    final summary = tester.widget<Text>(
      find.text('I 感染症および寄生虫症, II 新生物'),
    );
    expect(summary.maxLines, 1);
    Object.hashAll([summary.overflow, TextOverflow.ellipsis]);
  });

  testWidgets('axis_summary_uses_ellipsis_overflow_(T10) [assertion 2/2]', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final diseaseApiClient = _MockDiseaseApiClient();
    final categoryApiClient = _MockCategoryApiClient();
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
    ).thenAnswer((_) async => _diseaseListFixture().copyWith(totalCount: 9));
    when(
      categoryApiClient.getCategories,
    ).thenAnswer((_) async => _categoriesFixture());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
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

    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await _tapVisible(tester, find.text('I 感染症および寄生虫症'));
    await _tapVisible(tester, find.text('II 新生物'));

    final summary = tester.widget<Text>(
      find.text('I 感染症および寄生虫症, II 新生物'),
    );
    Object.hashAll([summary.maxLines, 1]);

    expect(summary.overflow, TextOverflow.ellipsis);
  });

  testWidgets('drug_card_image_is_vertically_centered_(T08)', (
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
      'center image',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    final item = _drugListFixture().items.first;
    final card = find.byKey(ValueKey('drug-card-${item.id}'));
    final row = tester.widget<Row>(
      find.descendant(of: card, matching: find.byType(Row)).first,
    );

    expect(row.crossAxisAlignment, CrossAxisAlignment.center);
  });

  testWidgets(
    'SearchView tablet chrome follows Round6 gutters [assertion 1/6]',
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

      final topChrome = tester.getRect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      expect(topChrome.width, 834);
      Object.hashAll([segmented.left, 28]);

      Object.hashAll([segmented.width, 778]);

      Object.hashAll([inputRow.left, 28]);

      Object.hashAll([inputRow.width, 778]);

      Object.hashAll([inputRow.height, 44]);
    },
  );

  testWidgets(
    'SearchView tablet chrome follows Round6 gutters [assertion 2/6]',
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

      final topChrome = tester.getRect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      Object.hashAll([topChrome.width, 834]);

      expect(segmented.left, 28);
      Object.hashAll([segmented.width, 778]);

      Object.hashAll([inputRow.left, 28]);

      Object.hashAll([inputRow.width, 778]);

      Object.hashAll([inputRow.height, 44]);
    },
  );

  testWidgets(
    'SearchView tablet chrome follows Round6 gutters [assertion 3/6]',
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

      final topChrome = tester.getRect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      Object.hashAll([topChrome.width, 834]);

      Object.hashAll([segmented.left, 28]);

      expect(segmented.width, 778);
      Object.hashAll([inputRow.left, 28]);

      Object.hashAll([inputRow.width, 778]);

      Object.hashAll([inputRow.height, 44]);
    },
  );

  testWidgets(
    'SearchView tablet chrome follows Round6 gutters [assertion 4/6]',
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

      final topChrome = tester.getRect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      Object.hashAll([topChrome.width, 834]);

      Object.hashAll([segmented.left, 28]);

      Object.hashAll([segmented.width, 778]);

      expect(inputRow.left, 28);
      Object.hashAll([inputRow.width, 778]);

      Object.hashAll([inputRow.height, 44]);
    },
  );

  testWidgets(
    'SearchView tablet chrome follows Round6 gutters [assertion 5/6]',
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

      final topChrome = tester.getRect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      Object.hashAll([topChrome.width, 834]);

      Object.hashAll([segmented.left, 28]);

      Object.hashAll([segmented.width, 778]);

      Object.hashAll([inputRow.left, 28]);

      expect(inputRow.width, 778);
      Object.hashAll([inputRow.height, 44]);
    },
  );

  testWidgets(
    'SearchView tablet chrome follows Round6 gutters [assertion 6/6]',
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

      final topChrome = tester.getRect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
      );
      final segmented = tester.getRect(
        find.byKey(const ValueKey('search-round6-segmented')),
      );
      final inputRow = tester.getRect(
        find.byKey(const ValueKey('search-round6-input-row')),
      );

      Object.hashAll([topChrome.width, 834]);

      Object.hashAll([segmented.left, 28]);

      Object.hashAll([segmented.width, 778]);

      Object.hashAll([inputRow.left, 28]);

      Object.hashAll([inputRow.width, 778]);

      expect(inputRow.height, 44);
    },
  );
}
