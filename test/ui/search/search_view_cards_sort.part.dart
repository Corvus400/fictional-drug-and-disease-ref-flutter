part of 'search_view_test.dart';

void _searchViewCardsSortTests() {
  testWidgets(
    'SearchView labels all ICD-10 chapters in disease cards [assertion 1/2]',
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
      ).thenAnswer((_) async => _diseaseListFixtureForChapter('chapter_ii'));
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

      expect(find.text('ICD-10: II 新生物'), findsOneWidget);
      Object.hashAll([find.textContaining('chapter_ii'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView labels all ICD-10 chapters in disease cards [assertion 2/2]',
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
      ).thenAnswer((_) async => _diseaseListFixtureForChapter('chapter_ii'));
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

      Object.hashAll([find.text('ICD-10: II 新生物'), findsOneWidget]);

      expect(find.textContaining('chapter_ii'), findsNothing);
    },
  );

  testWidgets(
    'SearchView stretches disease cards to the result width [assertion 1/2]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

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

      final listRect = tester.getRect(
        find.byKey(const PageStorageKey<String>('diseaseSearchResults')),
      );
      final cardRect = tester.getRect(
        find.byKey(
          ValueKey('disease-card-${_diseaseListFixture().items.first.id}'),
        ),
      );

      expect(cardRect.left, listRect.left + SearchConstants.searchTabletGutter);
      Object.hashAll([
        cardRect.width,
        listRect.width - SearchConstants.searchTabletGutter * 2,
      ]);
    },
  );

  testWidgets(
    'SearchView stretches disease cards to the result width [assertion 2/2]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

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

      final listRect = tester.getRect(
        find.byKey(const PageStorageKey<String>('diseaseSearchResults')),
      );
      final cardRect = tester.getRect(
        find.byKey(
          ValueKey('disease-card-${_diseaseListFixture().items.first.id}'),
        ),
      );

      Object.hashAll([
        cardRect.left,
        listRect.left + SearchConstants.searchTabletGutter,
      ]);

      expect(
        cardRect.width,
        listRect.width - SearchConstants.searchTabletGutter * 2,
      );
    },
  );

  testWidgets(
    'SearchView disease result cards do not render history-only affordances [assertion 1/7]',
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

      expect(find.byType(DiseaseResultCard), findsWidgets);
      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('disease-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView disease result cards do not render history-only affordances [assertion 2/7]',
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

      Object.hashAll([find.byType(DiseaseResultCard), findsWidgets]);

      expect(find.byType(Dismissible), findsNothing);
      Object.hashAll([
        find.byKey(const ValueKey('disease-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView disease result cards do not render history-only affordances [assertion 3/7]',
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

      Object.hashAll([find.byType(DiseaseResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      expect(
        find.byKey(const ValueKey('disease-card-trailing-time')),
        findsNothing,
      );
      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView disease result cards do not render history-only affordances [assertion 4/7]',
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

      Object.hashAll([find.byType(DiseaseResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('disease-card-trailing-time')),
        findsNothing,
      ]);

      expect(find.text('たった今'), findsNothing);
      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView disease result cards do not render history-only affordances [assertion 5/7]',
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

      Object.hashAll([find.byType(DiseaseResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('disease-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      expect(find.text('5分前'), findsNothing);
      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView disease result cards do not render history-only affordances [assertion 6/7]',
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

      Object.hashAll([find.byType(DiseaseResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('disease-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      expect(find.textContaining('昨日 '), findsNothing);
      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView disease result cards do not render history-only affordances [assertion 7/7]',
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

      Object.hashAll([find.byType(DiseaseResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('disease-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      expect(
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      );
    },
  );

  testWidgets('SearchView colors drug regulatory badges by classification', (
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
          home: const SearchView(debugLogDrugImageErrors: false),
        ),
      ),
    );

    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    final poison = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('drug-regulatory-badge-poison')).first,
    );
    final prescription = tester.widget<DecoratedBox>(
      find
          .byKey(const ValueKey('drug-regulatory-badge-prescription_required'))
          .first,
    );
    final psychotropic = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('drug-regulatory-badge-psychotropic_2')).first,
    );
    final ordinary = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey('drug-regulatory-badge-ordinary')).first,
    );

    final colors = {
      (poison.decoration as BoxDecoration).color,
      (prescription.decoration as BoxDecoration).color,
      (psychotropic.decoration as BoxDecoration).color,
      (ordinary.decoration as BoxDecoration).color,
    };
    expect(colors, hasLength(4));
  });

  testWidgets(
    'SearchView drug result cards do not render history-only affordances [assertion 1/7]',
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
      ).thenAnswer((_) async => _drugListFixture());
      final imageCacheManager = _MockBaseCacheManager();
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('widget tests render the fallback image'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      expect(find.byType(DrugResultCard), findsWidgets);
      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView drug result cards do not render history-only affordances [assertion 2/7]',
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
      ).thenAnswer((_) async => _drugListFixture());
      final imageCacheManager = _MockBaseCacheManager();
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('widget tests render the fallback image'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DrugResultCard), findsWidgets]);

      expect(find.byType(Dismissible), findsNothing);
      Object.hashAll([
        find.byKey(const ValueKey('drug-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView drug result cards do not render history-only affordances [assertion 3/7]',
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
      ).thenAnswer((_) async => _drugListFixture());
      final imageCacheManager = _MockBaseCacheManager();
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('widget tests render the fallback image'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DrugResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      expect(
        find.byKey(const ValueKey('drug-card-trailing-time')),
        findsNothing,
      );
      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView drug result cards do not render history-only affordances [assertion 4/7]',
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
      ).thenAnswer((_) async => _drugListFixture());
      final imageCacheManager = _MockBaseCacheManager();
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('widget tests render the fallback image'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DrugResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-card-trailing-time')),
        findsNothing,
      ]);

      expect(find.text('たった今'), findsNothing);
      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView drug result cards do not render history-only affordances [assertion 5/7]',
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
      ).thenAnswer((_) async => _drugListFixture());
      final imageCacheManager = _MockBaseCacheManager();
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('widget tests render the fallback image'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DrugResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      expect(find.text('5分前'), findsNothing);
      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView drug result cards do not render history-only affordances [assertion 6/7]',
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
      ).thenAnswer((_) async => _drugListFixture());
      final imageCacheManager = _MockBaseCacheManager();
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('widget tests render the fallback image'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DrugResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      expect(find.textContaining('昨日 '), findsNothing);
      Object.hashAll([
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'SearchView drug result cards do not render history-only affordances [assertion 7/7]',
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
      ).thenAnswer((_) async => _drugListFixture());
      final imageCacheManager = _MockBaseCacheManager();
      when(
        () => imageCacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('widget tests render the fallback image'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            drugCardImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(debugLogDrugImageErrors: false),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DrugResultCard), findsWidgets]);

      Object.hashAll([find.byType(Dismissible), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-card-trailing-time')),
        findsNothing,
      ]);

      Object.hashAll([find.text('たった今'), findsNothing]);

      Object.hashAll([find.text('5分前'), findsNothing]);

      Object.hashAll([find.textContaining('昨日 '), findsNothing]);

      expect(
        find.byWidgetPredicate((widget) {
          final key = widget.key;
          return key is ValueKey<String> &&
              key.value.startsWith('delete-history-');
        }),
        findsNothing,
      );
    },
  );

  testWidgets(
    'SearchView opens drug sort sheet from results toolbar [assertion 1/4]',
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
      ).thenAnswer((_) async => _drugListFixture());
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
        'sort keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('並び替え').first);
      await tester.pumpAndSettle();

      expect(find.text('更新日(新しい順)'), findsOneWidget);
      Object.hashAll([find.text('ブランド名カナ'), findsOneWidget]);

      Object.hashAll([find.text('ATC コード'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類名'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView opens drug sort sheet from results toolbar [assertion 2/4]',
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
      ).thenAnswer((_) async => _drugListFixture());
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
        'sort keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('並び替え').first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('更新日(新しい順)'), findsOneWidget]);

      expect(find.text('ブランド名カナ'), findsOneWidget);
      Object.hashAll([find.text('ATC コード'), findsOneWidget]);

      Object.hashAll([find.text('薬効分類名'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView opens drug sort sheet from results toolbar [assertion 3/4]',
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
      ).thenAnswer((_) async => _drugListFixture());
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
        'sort keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('並び替え').first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('更新日(新しい順)'), findsOneWidget]);

      Object.hashAll([find.text('ブランド名カナ'), findsOneWidget]);

      expect(find.text('ATC コード'), findsOneWidget);
      Object.hashAll([find.text('薬効分類名'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView opens drug sort sheet from results toolbar [assertion 4/4]',
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
      ).thenAnswer((_) async => _drugListFixture());
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
        'sort keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('並び替え').first);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('更新日(新しい順)'), findsOneWidget]);

      Object.hashAll([find.text('ブランド名カナ'), findsOneWidget]);

      Object.hashAll([find.text('ATC コード'), findsOneWidget]);

      expect(find.text('薬効分類名'), findsOneWidget);
    },
  );

  testWidgets('SearchView applies selected drug sort from sort sheet', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
        keywordTarget: any(named: 'keywordTarget'),
        sort: any(named: 'sort'),
      ),
    ).thenAnswer((_) async => _drugListFixture());
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
      'sort apply keyword',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('並び替え').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('ATC コード'));
    await tester.pumpAndSettle();

    verify(
      () => drugApiClient.getDrugs(
        page: 1,
        pageSize: 20,
        keyword: 'sort apply keyword',
        keywordTarget: any(named: 'keywordTarget'),
        sort: 'atc_code',
      ),
    ).called(1);
  });

  testWidgets(
    'SearchView renders skeletonized loading list while search is pending [assertion 1/5]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final pending = Completer<DrugListResponseDto>();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) => pending.future);

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
        'pending keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pump();

      expect(
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
        findsOneWidget,
      );
      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
      );
      final effect = skeletonizer.effect! as ShimmerEffect;
      Object.hashAll([
        effect.colors,
        [
          AppPalette.light.surface2,
          AppPalette.light.surface3,
          AppPalette.light.surface2,
        ],
      ]);

      Object.hashAll([find.text('合計 — 件'), findsNothing]);

      Object.hashAll([find.text('検索中…'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-loading-skeleton-card')),
        findsNWidgets(5),
      ]);

      pending.complete(_drugListFixture());
    },
  );

  testWidgets(
    'SearchView renders skeletonized loading list while search is pending [assertion 2/5]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final pending = Completer<DrugListResponseDto>();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) => pending.future);

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
        'pending keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pump();

      Object.hashAll([
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
        findsOneWidget,
      ]);

      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
      );
      final effect = skeletonizer.effect! as ShimmerEffect;
      expect(effect.colors, [
        AppPalette.light.surface2,
        AppPalette.light.surface3,
        AppPalette.light.surface2,
      ]);
      Object.hashAll([find.text('合計 — 件'), findsNothing]);

      Object.hashAll([find.text('検索中…'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-loading-skeleton-card')),
        findsNWidgets(5),
      ]);

      pending.complete(_drugListFixture());
    },
  );

  testWidgets(
    'SearchView renders skeletonized loading list while search is pending [assertion 3/5]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final pending = Completer<DrugListResponseDto>();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) => pending.future);

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
        'pending keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pump();

      Object.hashAll([
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
        findsOneWidget,
      ]);

      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
      );
      final effect = skeletonizer.effect! as ShimmerEffect;
      Object.hashAll([
        effect.colors,
        [
          AppPalette.light.surface2,
          AppPalette.light.surface3,
          AppPalette.light.surface2,
        ],
      ]);

      expect(find.text('合計 — 件'), findsNothing);
      Object.hashAll([find.text('検索中…'), findsNothing]);

      Object.hashAll([
        find.byKey(const ValueKey('search-loading-skeleton-card')),
        findsNWidgets(5),
      ]);

      pending.complete(_drugListFixture());
    },
  );

  testWidgets(
    'SearchView renders skeletonized loading list while search is pending [assertion 4/5]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final pending = Completer<DrugListResponseDto>();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) => pending.future);

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
        'pending keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pump();

      Object.hashAll([
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
        findsOneWidget,
      ]);

      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
      );
      final effect = skeletonizer.effect! as ShimmerEffect;
      Object.hashAll([
        effect.colors,
        [
          AppPalette.light.surface2,
          AppPalette.light.surface3,
          AppPalette.light.surface2,
        ],
      ]);

      Object.hashAll([find.text('合計 — 件'), findsNothing]);

      expect(find.text('検索中…'), findsNothing);
      Object.hashAll([
        find.byKey(const ValueKey('search-loading-skeleton-card')),
        findsNWidgets(5),
      ]);

      pending.complete(_drugListFixture());
    },
  );

  testWidgets(
    'SearchView renders skeletonized loading list while search is pending [assertion 5/5]',
    (
      tester,
    ) async {
      final drugApiClient = _MockDrugApiClient();
      final pending = Completer<DrugListResponseDto>();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).thenAnswer((_) => pending.future);

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
        'pending keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pump();

      Object.hashAll([
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
        findsOneWidget,
      ]);

      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
      );
      final effect = skeletonizer.effect! as ShimmerEffect;
      Object.hashAll([
        effect.colors,
        [
          AppPalette.light.surface2,
          AppPalette.light.surface3,
          AppPalette.light.surface2,
        ],
      ]);

      Object.hashAll([find.text('合計 — 件'), findsNothing]);

      Object.hashAll([find.text('検索中…'), findsNothing]);

      expect(
        find.byKey(const ValueKey('search-loading-skeleton-card')),
        findsNWidgets(5),
      );

      pending.complete(_drugListFixture());
    },
  );
}
