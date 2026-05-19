part of 'search_view_test.dart';

void _searchViewChromeInlineHistoryTests() {
  testWidgets(
    'SearchView renders Round6 search chrome without placeholder [assertion 1/6]',
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

      expect(find.text('検索'), findsWidgets);
      Object.hashAll([find.text('医薬品'), findsOneWidget]);

      Object.hashAll([find.text('疾患'), findsOneWidget]);

      Object.hashAll([find.text('医薬品名・YJ・ATC コード'), findsOneWidget]);

      Object.hashAll([find.text('検索画面（プレースホルダー）'), findsNothing]);

      Object.hashAll([find.textContaining('Health:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 search chrome without placeholder [assertion 2/6]',
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

      Object.hashAll([find.text('検索'), findsWidgets]);

      expect(find.text('医薬品'), findsOneWidget);
      Object.hashAll([find.text('疾患'), findsOneWidget]);

      Object.hashAll([find.text('医薬品名・YJ・ATC コード'), findsOneWidget]);

      Object.hashAll([find.text('検索画面（プレースホルダー）'), findsNothing]);

      Object.hashAll([find.textContaining('Health:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 search chrome without placeholder [assertion 3/6]',
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

      Object.hashAll([find.text('検索'), findsWidgets]);

      Object.hashAll([find.text('医薬品'), findsOneWidget]);

      expect(find.text('疾患'), findsOneWidget);
      Object.hashAll([find.text('医薬品名・YJ・ATC コード'), findsOneWidget]);

      Object.hashAll([find.text('検索画面（プレースホルダー）'), findsNothing]);

      Object.hashAll([find.textContaining('Health:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 search chrome without placeholder [assertion 4/6]',
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

      Object.hashAll([find.text('検索'), findsWidgets]);

      Object.hashAll([find.text('医薬品'), findsOneWidget]);

      Object.hashAll([find.text('疾患'), findsOneWidget]);

      expect(find.text('医薬品名・YJ・ATC コード'), findsOneWidget);
      Object.hashAll([find.text('検索画面（プレースホルダー）'), findsNothing]);

      Object.hashAll([find.textContaining('Health:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 search chrome without placeholder [assertion 5/6]',
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

      Object.hashAll([find.text('検索'), findsWidgets]);

      Object.hashAll([find.text('医薬品'), findsOneWidget]);

      Object.hashAll([find.text('疾患'), findsOneWidget]);

      Object.hashAll([find.text('医薬品名・YJ・ATC コード'), findsOneWidget]);

      expect(find.text('検索画面（プレースホルダー）'), findsNothing);
      Object.hashAll([find.textContaining('Health:'), findsNothing]);
    },
  );

  testWidgets(
    'SearchView renders Round6 search chrome without placeholder [assertion 6/6]',
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

      Object.hashAll([find.text('検索'), findsWidgets]);

      Object.hashAll([find.text('医薬品'), findsOneWidget]);

      Object.hashAll([find.text('疾患'), findsOneWidget]);

      Object.hashAll([find.text('医薬品名・YJ・ATC コード'), findsOneWidget]);

      Object.hashAll([find.text('検索画面（プレースホルダー）'), findsNothing]);

      expect(find.textContaining('Health:'), findsNothing);
    },
  );

  testWidgets(
    'empty_history_text_shown_only_when_phone_idle_unfocused_(T11) [assertion 1/6]',
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
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'empty_history_text_shown_only_when_phone_idle_unfocused_(T11) [assertion 2/6]',
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
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'empty_history_text_shown_only_when_phone_idle_unfocused_(T11) [assertion 3/6]',
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
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'empty_history_text_shown_only_when_phone_idle_unfocused_(T11) [assertion 4/6]',
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
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'empty_history_text_shown_only_when_phone_idle_unfocused_(T11) [assertion 5/6]',
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
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsNothing,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'empty_history_text_shown_only_when_phone_idle_unfocused_(T11) [assertion 6/6]',
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

      Object.hashAll([
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsNothing,
      ]);

      expect(
        find.byKey(const ValueKey('search-history-dropdown')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'SearchView renders no-history empty state after disease tab switch [assertion 1/2]',
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
      Object.hashAll([
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView renders no-history empty state after disease tab switch [assertion 2/2]',
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

      Object.hashAll([find.text('検索履歴はまだありません'), findsOneWidget]);

      expect(
        find.text('検索すると最新 5 件まで表示されます。履歴は端末内にのみ保存されます。'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SearchView clear button clears the visible search text [assertion 1/3]',
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

      await tester.enterText(find.byKey(const ValueKey('search-field')), 'アムロ');
      await tester.pump();
      expect(find.text('アムロ'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('search-query-clear-button')));
      await tester.pump();

      Object.hashAll([find.text('アムロ'), findsNothing]);

      Object.hashAll([find.text('医薬品名・YJ・ATC コード'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView clear button clears the visible search text [assertion 2/3]',
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

      await tester.enterText(find.byKey(const ValueKey('search-field')), 'アムロ');
      await tester.pump();
      Object.hashAll([find.text('アムロ'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('search-query-clear-button')));
      await tester.pump();

      expect(find.text('アムロ'), findsNothing);
      Object.hashAll([find.text('医薬品名・YJ・ATC コード'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView clear button clears the visible search text [assertion 3/3]',
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

      await tester.enterText(find.byKey(const ValueKey('search-field')), 'アムロ');
      await tester.pump();
      Object.hashAll([find.text('アムロ'), findsOneWidget]);

      await tester.tap(find.byKey(const ValueKey('search-query-clear-button')));
      await tester.pump();

      Object.hashAll([find.text('アムロ'), findsNothing]);

      expect(find.text('医薬品名・YJ・ATC コード'), findsOneWidget);
    },
  );

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

  testWidgets(
    'SearchView search field shows keyboard on single retap [assertion 1/5]',
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

      final field = find.byKey(const ValueKey('search-field'));
      await tester.tap(field);
      await tester.pump();
      expect(tester.testTextInput.isVisible, isTrue);

      tester.testTextInput.hide();
      tester.testTextInput.log.clear();
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      Object.hashAll([editableText.focusNode.hasFocus, isTrue]);

      Object.hashAll([tester.testTextInput.isVisible, isFalse]);

      await tester.tap(field);
      await tester.pump();

      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      Object.hashAll([
        tester.testTextInput.log.any((call) => call.method == 'TextInput.show'),
        isTrue,
      ]);
    },
  );

  testWidgets(
    'SearchView search field shows keyboard on single retap [assertion 2/5]',
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

      final field = find.byKey(const ValueKey('search-field'));
      await tester.tap(field);
      await tester.pump();
      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      tester.testTextInput.hide();
      tester.testTextInput.log.clear();
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editableText.focusNode.hasFocus, isTrue);
      Object.hashAll([tester.testTextInput.isVisible, isFalse]);

      await tester.tap(field);
      await tester.pump();

      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      Object.hashAll([
        tester.testTextInput.log.any((call) => call.method == 'TextInput.show'),
        isTrue,
      ]);
    },
  );

  testWidgets(
    'SearchView search field shows keyboard on single retap [assertion 3/5]',
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

      final field = find.byKey(const ValueKey('search-field'));
      await tester.tap(field);
      await tester.pump();
      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      tester.testTextInput.hide();
      tester.testTextInput.log.clear();
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      Object.hashAll([editableText.focusNode.hasFocus, isTrue]);

      expect(tester.testTextInput.isVisible, isFalse);

      await tester.tap(field);
      await tester.pump();

      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      Object.hashAll([
        tester.testTextInput.log.any((call) => call.method == 'TextInput.show'),
        isTrue,
      ]);
    },
  );

  testWidgets(
    'SearchView search field shows keyboard on single retap [assertion 4/5]',
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

      final field = find.byKey(const ValueKey('search-field'));
      await tester.tap(field);
      await tester.pump();
      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      tester.testTextInput.hide();
      tester.testTextInput.log.clear();
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      Object.hashAll([editableText.focusNode.hasFocus, isTrue]);

      Object.hashAll([tester.testTextInput.isVisible, isFalse]);

      await tester.tap(field);
      await tester.pump();

      expect(tester.testTextInput.isVisible, isTrue);
      Object.hashAll([
        tester.testTextInput.log.any((call) => call.method == 'TextInput.show'),
        isTrue,
      ]);
    },
  );

  testWidgets(
    'SearchView search field shows keyboard on single retap [assertion 5/5]',
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

      final field = find.byKey(const ValueKey('search-field'));
      await tester.tap(field);
      await tester.pump();
      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      tester.testTextInput.hide();
      tester.testTextInput.log.clear();
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      Object.hashAll([editableText.focusNode.hasFocus, isTrue]);

      Object.hashAll([tester.testTextInput.isVisible, isFalse]);

      await tester.tap(field);
      await tester.pump();

      Object.hashAll([tester.testTextInput.isVisible, isTrue]);

      expect(
        tester.testTextInput.log.any((call) => call.method == 'TextInput.show'),
        isTrue,
      );
    },
  );

  testWidgets(
    'SearchView returns cancel action to search on outside tap [assertion 1/3]',
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

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();
      expect(find.text('キャンセル'), findsOneWidget);

      await tester.tapAt(const Offset(20, 500));
      await tester.pump();

      Object.hashAll([find.text('キャンセル'), findsNothing]);

      Object.hashAll([find.text('検索'), findsWidgets]);
    },
  );

  testWidgets(
    'SearchView returns cancel action to search on outside tap [assertion 2/3]',
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

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();
      Object.hashAll([find.text('キャンセル'), findsOneWidget]);

      await tester.tapAt(const Offset(20, 500));
      await tester.pump();

      expect(find.text('キャンセル'), findsNothing);
      Object.hashAll([find.text('検索'), findsWidgets]);
    },
  );

  testWidgets(
    'SearchView returns cancel action to search on outside tap [assertion 3/3]',
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

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();
      Object.hashAll([find.text('キャンセル'), findsOneWidget]);

      await tester.tapAt(const Offset(20, 500));
      await tester.pump();

      Object.hashAll([find.text('キャンセル'), findsNothing]);

      expect(find.text('検索'), findsWidgets);
    },
  );

  testWidgets('search_view_unfocuses_on_didPopNext_(T03) [assertion 1/2]', (
    tester,
  ) async {
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
    Object.hashAll([editableText.focusNode.hasFocus, isFalse]);
  });

  testWidgets('search_view_unfocuses_on_didPopNext_(T03) [assertion 2/2]', (
    tester,
  ) async {
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
    Object.hashAll([
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isTrue,
    ]);

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

  testWidgets(
    'SearchView uses shared tab header plus Round6 search chrome [assertion 1/5]',
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

      expect(find.byType(AppBar), findsOneWidget);
      Object.hashAll([
        find.byKey(const ValueKey<String>('app-tab-header-title')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-top-chrome')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-input-row')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView uses shared tab header plus Round6 search chrome [assertion 2/5]',
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

      Object.hashAll([find.byType(AppBar), findsOneWidget]);

      expect(
        find.byKey(const ValueKey<String>('app-tab-header-title')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-round6-top-chrome')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-input-row')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView uses shared tab header plus Round6 search chrome [assertion 3/5]',
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

      Object.hashAll([find.byType(AppBar), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('app-tab-header-title')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-round6-top-chrome')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-input-row')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView uses shared tab header plus Round6 search chrome [assertion 4/5]',
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

      Object.hashAll([find.byType(AppBar), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('app-tab-header-title')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-top-chrome')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-round6-segmented')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('search-round6-input-row')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'SearchView uses shared tab header plus Round6 search chrome [assertion 5/5]',
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

      Object.hashAll([find.byType(AppBar), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('app-tab-header-title')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-top-chrome')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('search-round6-segmented')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('search-round6-input-row')),
        findsOneWidget,
      );
    },
  );

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

  testWidgets(
    'SearchView renders persisted search history while idle [assertion 1/3]',
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
      Object.hashAll([find.text('履歴由来キーワード'), findsOneWidget]);

      Object.hashAll([find.text('7 件'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView renders persisted search history while idle [assertion 2/3]',
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

      Object.hashAll([find.text('最近の検索'), findsOneWidget]);

      expect(find.text('履歴由来キーワード'), findsOneWidget);
      Object.hashAll([find.text('7 件'), findsOneWidget]);
    },
  );

  testWidgets(
    'SearchView renders persisted search history while idle [assertion 3/3]',
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

      Object.hashAll([find.text('最近の検索'), findsOneWidget]);

      Object.hashAll([find.text('履歴由来キーワード'), findsOneWidget]);

      expect(find.text('7 件'), findsOneWidget);
    },
  );

  testWidgets(
    'history row tap restores params and triggers search [assertion 1/3]',
    (
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

      Object.hashAll([find.text('復元キーワード'), findsWidgets]);

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: 20,
          keyword: '復元キーワード',
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
      Object.hashAll([
        container.read(searchScreenProvider).historyDropdownOpen,
        false,
      ]);
    },
  );

  testWidgets(
    'history row tap restores params and triggers search [assertion 2/3]',
    (
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
      Object.hashAll([find.text('復元キーワード'), findsOneWidget]);

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
      Object.hashAll([
        container.read(searchScreenProvider).historyDropdownOpen,
        false,
      ]);
    },
  );

  testWidgets(
    'history row tap restores params and triggers search [assertion 3/3]',
    (
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
      Object.hashAll([find.text('復元キーワード'), findsOneWidget]);

      await tester.tap(
        find.byKey(const ValueKey('history-row-history_restore_target')),
      );
      await tester.pumpAndSettle();

      Object.hashAll([find.text('復元キーワード'), findsWidgets]);

      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: 20,
          keyword: '復元キーワード',
          keywordTarget: any(named: 'keywordTarget'),
        ),
      ).called(1);
      expect(container.read(searchScreenProvider).historyDropdownOpen, false);
    },
  );
}
