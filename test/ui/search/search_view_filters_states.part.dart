part of 'search_view_test.dart';

void _searchViewFiltersStatesTests() {
  testWidgets('SearchView empty results keep history out of result space', (
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
    expect(
      find.byKey(const ValueKey('search-applied-filter-bar')),
      findsOneWidget,
    );
    expect(find.text('合計 0 件'), findsOneWidget);
    expect(find.text('該当する結果がありません'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('SearchView renders error state for search failure', (
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
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
    final iconContainer = tester.widget<Container>(
      find.byKey(const ValueKey('search-error-icon')),
    );
    final constraints = iconContainer.constraints!;
    final decoration = iconContainer.decoration! as BoxDecoration;
    final warningIcon = tester.widget<Icon>(
      find.byIcon(Icons.warning_amber_rounded),
    );

    expect(constraints.minWidth, 72);
    expect(constraints.maxWidth, 72);
    expect(constraints.minHeight, 72);
    expect(constraints.maxHeight, 72);
    expect(decoration.color, AppPalette.light.dangerCont);
    expect(decoration.shape, BoxShape.circle);
    expect(warningIcon.size, 36);
    expect(warningIcon.color, AppPalette.light.danger);
    expect(find.text('もう一度試してください。'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '再試行'), findsOneWidget);
    expect(find.text('Type: NetworkException'), findsOneWidget);
    expect(find.textContaining('Status:'), findsNothing);
  });

  testWidgets(
    'SearchView renders error diagnostics for api response failure',
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
              'code': 'INVALID',
              'message': 'invalid keyword',
              'details': 'keyword must be shorter',
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
      expect(find.text('予期しないエラー'), findsOneWidget);
      expect(find.text('Type: ApiException'), findsOneWidget);
      expect(find.text('Status: 422'), findsOneWidget);
      expect(find.text('Code: INVALID'), findsOneWidget);
      expect(find.text('Message: invalid keyword'), findsOneWidget);
      expect(find.text('Details: keyword must be shorter'), findsOneWidget);
    },
  );

  testWidgets('business_error_shows_business_text_(T05)', (tester) async {
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
          statusCode: 400,
          data: const {
            'code': 'INVALID_ONSET_PATTERN',
            'message': 'invalid onset pattern',
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
    expect(find.text('通信エラー'), findsNothing);
    expect(find.text('指定された条件をご確認ください。'), findsOneWidget);
    expect(find.text('Type: ApiException'), findsOneWidget);
    expect(find.text('Code: INVALID_ONSET_PATTERN'), findsOneWidget);
  });

  testWidgets('SearchView retry runs search again after failure', (
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
    expect(find.text(item.brandName), findsOneWidget);
    expect(callCount, 2);
  });

  testWidgets('SearchView opens filter sheet from FAB with applied count', (
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

    expect(find.text('絞り込み（医薬品）'), findsOneWidget);
    expect(find.textContaining('結果を見る'), findsOneWidget);
  });

  testWidgets('SearchView applies drug filters from category master sheet', (
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
    expect(find.text('剤形'), findsOneWidget);
    expect(find.text('投与経路'), findsOneWidget);
    expect(find.text('ATC 第 1 階層'), findsOneWidget);
    expect(find.text('薬効分類'), findsOneWidget);
    expect(find.text('副作用キーワード'), findsOneWidget);
    expect(find.text('患者背景'), findsOneWidget);
    expect(find.text('毒薬'), findsOneWidget);

    await _tapVisible(tester, find.text('毒薬'));
    await _tapVisible(tester, find.text('剤形'));
    await tester.pumpAndSettle();
    expect(find.text('錠剤'), findsOneWidget);
    await _tapVisible(tester, find.text('錠剤'));
    await _tapVisible(tester, find.text('投与経路'));
    await tester.pumpAndSettle();
    expect(find.text('内服'), findsOneWidget);
    await _tapVisible(tester, find.text('内服'));
    await _tapVisible(tester, find.text('ATC 第 1 階層'));
    await tester.pumpAndSettle();
    expect(find.text('C 循環器系'), findsOneWidget);
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
  });

  testWidgets('SearchView shows applied filters and hides history on results', (
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
    expect(find.text('適用中'), findsOneWidget);
    expect(find.text('毒薬'), findsWidgets);
    expect(find.text('錠剤'), findsWidgets);
    expect(find.text('検索履歴'), findsNothing);
  });

  testWidgets('applied chip tap removes only that chip', (tester) async {
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
    expect(find.descendant(of: bar, matching: find.text('錠剤')), findsOneWidget);

    final poisonChipTapTarget = find
        .ancestor(
          of: find.descendant(of: bar, matching: find.text('毒薬')),
          matching: find.byType(InkWell),
        )
        .first;
    await tester.tap(poisonChipTapTarget);
    await tester.pumpAndSettle();

    expect(find.descendant(of: bar, matching: find.text('毒薬')), findsNothing);
    expect(find.descendant(of: bar, matching: find.text('錠剤')), findsOneWidget);
  });

  testWidgets('disease applied chip labels match mock-server enum kDoc', (
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
    expect(
      find.descendant(of: bar, matching: find.text('再発性')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bar, matching: find.text('間欠性')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bar, matching: find.text('血液検査')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bar, matching: find.text('relapsing')),
      findsNothing,
    );
    expect(
      find.descendant(of: bar, matching: find.text('intermittent')),
      findsNothing,
    );
    expect(
      find.descendant(of: bar, matching: find.text('blood_test')),
      findsNothing,
    );
  });

  testWidgets('SearchView applies disease filters from category master sheet', (
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
    expect(find.text('診療科'), findsOneWidget);
    expect(find.text('慢性度'), findsOneWidget);
    expect(find.text('感染性'), findsOneWidget);
    expect(find.text('症状キーワード'), findsOneWidget);
    expect(find.text('発症パターン'), findsOneWidget);
    expect(find.text('検査区分'), findsOneWidget);
    expect(find.text('薬物治療あり'), findsOneWidget);
    expect(find.text('重症度評価あり'), findsOneWidget);
    expect(find.text('IX 循環器系の疾患'), findsOneWidget);
    expect(find.text('規制区分'), findsNothing);

    await _tapVisible(tester, find.text('IX 循環器系の疾患'));
    await _tapVisible(tester, find.text('診療科'));
    await tester.pumpAndSettle();
    expect(find.text('循環器内科'), findsOneWidget);
    await _tapVisible(tester, find.text('循環器内科'));
    await _tapVisible(tester, find.text('発症パターン'));
    await tester.pumpAndSettle();
    expect(find.text('間欠性'), findsOneWidget);
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
  });

  testWidgets('SearchView renders disease summary fields in result cards', (
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
    expect(find.text('感染症科'), findsWidgets);
    expect(find.text('救急科'), findsWidgets);
    expect(find.text('急性'), findsWidgets);
    expect(find.text('感染性'), findsWidgets);
  });
}
