import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../helpers/test_app_database.dart';

void main() {
  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  late AppDatabase db;

  setUpAll(() {
    db = createTestAppDatabase();
  });

  tearDown(() async {
    await clearTestAppDatabase(db);
  });

  tearDownAll(() async {
    await db.close();
  });

  testWidgets('SearchView renders Round6 search chrome without placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
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

  testWidgets('SearchView renders Round6 no-history empty state on idle', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('検索履歴はまだありません'), findsOneWidget);
    expect(
      find.text('検索すると履歴が最大 5 件まで残ります。\n履歴は端末内にのみ保存されます。'),
      findsOneWidget,
    );
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
            home: SearchView(),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();

      expect(find.text('検索履歴はまだありません'), findsOneWidget);
      expect(
        find.text('検索すると履歴が最大 5 件まで残ります。\n履歴は端末内にのみ保存されます。'),
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
          home: SearchView(),
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
          home: SearchView(),
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

  testWidgets('SearchView returns cancel action to search on outside tap', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
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
          home: const SearchView(),
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

  testWidgets('SearchView uses Round6 custom top chrome instead of AppBar', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );

    expect(find.byType(AppBar), findsNothing);
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

  testWidgets('SearchView uses SearchPalette from theme', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, SearchPalette.light.background);
  });

  testWidgets('SearchView renders persisted search history when focused', (
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
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    expect(find.text('検索履歴'), findsOneWidget);
    expect(find.text('履歴由来キーワード'), findsOneWidget);
    expect(find.text('合計 7 件'), findsOneWidget);
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
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
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
      ),
    ).called(1);
    expect(container.read(searchScreenProvider).historyDropdownOpen, false);
  });

  testWidgets('SearchView hides idle no-history panel while focused', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('検索履歴はまだありません'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    expect(find.text('検索履歴'), findsOneWidget);
    expect(find.text('検索履歴はまだありません'), findsNothing);
  });

  testWidgets('SearchView renders Round6 history row metadata and note', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'search_round6_history',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(const DrugSearchParams(keyword: '履歴メタデータ')),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 5,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    expect(find.text('Rx'), findsOneWidget);
    expect(find.text('Dx'), findsNothing);
    expect(find.text('履歴メタデータ'), findsOneWidget);
    expect(find.text('すべて消す'), findsOneWidget);
    expect(
      find.text('最新 5 件まで表示。履歴は端末内にのみ保存されます'),
      findsOneWidget,
    );
  });

  testWidgets('drug history row shows Rx pill', (tester) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'drug_history_target_pill',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(const DrugSearchParams(keyword: '医薬品履歴')),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 4,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    expect(find.text('Rx'), findsOneWidget);
    expect(find.text('Dx'), findsNothing);
  });

  testWidgets('disease history row shows Dx pill', (tester) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'disease_history_target_pill',
          target: 'disease',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(const DiseaseSearchParams(keyword: '疾患履歴')),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 6,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    expect(find.text('Dx'), findsOneWidget);
    expect(find.text('Rx'), findsNothing);
  });

  testWidgets('history dropdown badges use Round6 target and filter colors', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'drug_history_target_pill_color',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(
                  keyword: '色確認履歴',
                  categoryAtc: 'C',
                  dosageForm: ['tablet'],
                ),
              ),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 4,
        );
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'disease_history_target_pill_color',
          target: 'disease',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(const DiseaseSearchParams(keyword: '疾患色確認履歴')),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 6,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    final containerWidget = tester.widget<Container>(
      find
          .ancestor(of: find.text('Rx'), matching: find.byType(Container))
          .first,
    );
    final decoration = containerWidget.decoration! as BoxDecoration;
    final rxText = tester.widget<Text>(find.text('Rx'));
    expect(decoration.color, SearchPalette.light.rxTint);
    expect(rxText.style?.color, SearchPalette.light.rxInk);

    final filterPill = tester.widget<Container>(
      find
          .ancestor(of: find.text('絞り込み +2'), matching: find.byType(Container))
          .first,
    );
    final filterDecoration = filterPill.decoration! as BoxDecoration;
    final filterText = tester.widget<Text>(find.text('絞り込み +2'));
    expect(filterDecoration.color, SearchPalette.light.primarySoft);
    expect(filterDecoration.border?.top.color, SearchPalette.light.primaryRing);
    expect(filterText.style?.color, SearchPalette.light.rxInk);

    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    final dxContainer = tester.widget<Container>(
      find
          .ancestor(of: find.text('Dx'), matching: find.byType(Container))
          .first,
    );
    final dxDecoration = dxContainer.decoration! as BoxDecoration;
    final dxText = tester.widget<Text>(find.text('Dx'));
    expect(dxDecoration.color, SearchPalette.light.dxTint);
    expect(dxText.style?.color, SearchPalette.light.dxInk);
  });

  testWidgets('history row subtitle includes relative time and filter pill', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 5, 5, 12);
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'history_subtitle_pill',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(
                  keyword: '字幕履歴',
                  categoryAtc: 'C',
                  dosageForm: ['tablet'],
                ),
              ),
          searchedAt: now.subtract(const Duration(minutes: 5)),
          totalCount: 5,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(currentTime: now),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();

    expect(find.text('合計 5 件'), findsOneWidget);
    expect(find.text('5分前'), findsOneWidget);
    expect(find.text('絞り込み +2'), findsOneWidget);

    final containerWidget = tester.widget<Container>(
      find
          .ancestor(of: find.text('絞り込み +2'), matching: find.byType(Container))
          .first,
    );
    final decoration = containerWidget.decoration! as BoxDecoration;
    expect(decoration.color, SearchPalette.light.primarySoft);
    expect(decoration.border?.top.color, SearchPalette.light.primaryRing);
  });

  testWidgets('SearchView deletes a persisted history row from dropdown', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'search_delete_target',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(keyword: '削除対象キーワード'),
              ),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 3,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();
    expect(find.text('削除対象キーワード'), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('delete-history-search_delete_target')),
    );
    await tester.pump();

    expect(find.text('削除対象キーワード'), findsNothing);
  });

  testWidgets('history row swipe dismisses the entry', (tester) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'swipe_target',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(keyword: 'スワイプ削除'),
              ),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 3,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();
    expect(find.text('スワイプ削除'), findsOneWidget);

    await tester.fling(
      find.byKey(const ValueKey('history-row-swipe_target')),
      const Offset(-500, 0),
      1000,
    );
    await tester.pumpAndSettle();

    expect(find.text('スワイプ削除'), findsNothing);
  });

  testWidgets(
    'history_dropdown_does_not_overflow_when_keyboard_is_visible_(T04)',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      final codec = container.read(searchQueryCodecProvider);
      final repository = container.read(searchHistoryRepositoryProvider);
      for (var index = 0; index < 5; index += 1) {
        await repository.insertWithDedup(
          id: 'keyboard_history_$index',
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
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(390, 844),
                viewInsets: EdgeInsets.only(bottom: 300),
              ),
              child: SearchView(),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('キーボード履歴4'), findsOneWidget);
    },
  );

  testWidgets('SearchView clears persisted history after confirmation', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    await container
        .read(searchHistoryRepositoryProvider)
        .insertWithDedup(
          id: 'search_clear_target',
          target: 'drug',
          queryJson: container
              .read(searchQueryCodecProvider)
              .encode(
                const DrugSearchParams(keyword: '全削除対象キーワード'),
              ),
          searchedAt: DateTime.utc(2026, 5, 5),
          totalCount: 11,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('search-field')));
    await tester.pump();
    expect(find.text('全削除対象キーワード'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('clear-history-button')));
    await tester.pump();
    expect(find.text('検索履歴を削除しますか？'), findsOneWidget);

    await tester.tap(find.text('削除'));
    await tester.pump();

    expect(find.text('全削除対象キーワード'), findsNothing);
  });

  testWidgets(
    'SearchView clears disease history from focused dropdown on iPhone width',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_clear_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患全削除対象'),
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
            home: SearchView(),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();
      expect(find.text('疾患全削除対象'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('clear-history-button')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      expect(find.text('検索履歴を削除しますか？'), findsOneWidget);

      await tester.tap(find.text('削除'));
      await tester.pump();

      expect(find.text('疾患全削除対象'), findsNothing);
    },
  );

  testWidgets(
    'SearchView deletes disease history row from focused dropdown '
    'on iPad width',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'disease_delete_target',
            target: 'disease',
            queryJson: container
                .read(searchQueryCodecProvider)
                .encode(
                  const DiseaseSearchParams(keyword: '疾患個別削除対象'),
                ),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 5,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('疾患'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('search-field')));
      await tester.pump();
      expect(find.text('疾患個別削除対象'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('delete-history-disease_delete_target')),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();

      expect(find.text('疾患個別削除対象'), findsNothing);
    },
  );

  testWidgets('SearchView renders drug results from repository state', (
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
          home: SearchView(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'fixture keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    final item = _drugListFixture().items.firstWhere(
      (item) => item.brandName != item.genericName,
    );
    expect(find.text(item.brandName), findsOneWidget);
    expect(find.text(item.genericName), findsOneWidget);
    expect(find.text('合計 ${_drugListFixture().totalCount} 件'), findsOneWidget);
    expect(
      tester.widget<ListView>(find.byType(ListView)).key,
      const PageStorageKey<String>('drugSearchResults'),
    );
  });

  testWidgets('result card tap navigates to drug detail with correct id', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    final fixture = _drugListFixture();
    final item = fixture.items.firstWhere(
      (item) => item.brandName != item.genericName,
    );
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
      ),
    ).thenAnswer((_) async => fixture);

    final router = GoRouter(
      initialLocation: AppRoutes.search,
      routes: [
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const SearchView(),
          routes: [
            GoRoute(
              path: 'drug/:id',
              builder: (context, state) =>
                  Text('drug-detail-${state.pathParameters['id']}'),
            ),
            GoRoute(
              path: 'disease/:id',
              builder: (context, state) =>
                  Text('disease-detail-${state.pathParameters['id']}'),
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'drug detail keyword',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();
    expect(find.text(item.brandName), findsAtLeastNWidgets(1));

    await tester.tap(find.text(item.brandName).first);
    await tester.pumpAndSettle();

    expect(find.text('drug-detail-${item.id}'), findsOneWidget);
    expect(
      router.routerDelegate.currentConfiguration.last.matchedLocation,
      AppRoutes.drugDetail(item.id),
    );
  });

  testWidgets('result card tap navigates to disease detail with correct id', (
    tester,
  ) async {
    final diseaseApiClient = _MockDiseaseApiClient();
    final fixture = _diseaseListFixture();
    final item = fixture.items.first;
    when(
      () => diseaseApiClient.getDiseases(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
      ),
    ).thenAnswer((_) async => fixture);

    final router = GoRouter(
      initialLocation: AppRoutes.search,
      routes: [
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const SearchView(),
          routes: [
            GoRoute(
              path: 'drug/:id',
              builder: (context, state) =>
                  Text('drug-detail-${state.pathParameters['id']}'),
            ),
            GoRoute(
              path: 'disease/:id',
              builder: (context, state) =>
                  Text('disease-detail-${state.pathParameters['id']}'),
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
        ],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );

    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'disease detail keyword',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();
    expect(find.text(item.name), findsAtLeastNWidgets(1));

    await tester.tap(find.text(item.name).first);
    await tester.pumpAndSettle();

    expect(find.text('disease-detail-${item.id}'), findsOneWidget);
    expect(
      router.routerDelegate.currentConfiguration.last.matchedLocation,
      AppRoutes.diseaseDetail(item.id),
    );
  });

  testWidgets(
    'SearchView renders drug card image from imageUrl normalized to size S',
    (tester) async {
      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'https://api.example.test',
        ),
      );
      final drugApiClient = _MockDrugApiClient();
      final fixture = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
        ),
      ).thenAnswer((_) async => fixture);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SearchView(),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('search-field')),
        'image keyword',
      );
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      final item = fixture.items.first;
      final image = tester.widget<Image>(
        find.byKey(ValueKey('drug-image-${item.id}')),
      );
      final provider = image.image as NetworkImage;

      expect(
        provider.url,
        'https://api.example.test/v1/images/drugs/${item.id}?size=S',
      );
    },
  );

  testWidgets('SearchView renders Round6 drug card badges and metadata', (
    tester,
  ) async {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
    final drugApiClient = _MockDrugApiClient();
    final fixture = _drugListFixture();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
      ),
    ).thenAnswer((_) async => fixture);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'card metadata keyword',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    final item = fixture.items.first;
    expect(find.text('毒薬'), findsAtLeastNWidgets(1));
    expect(find.text('処方箋医薬品'), findsAtLeastNWidgets(1));
    expect(find.text('ATC: ${item.atcCode}'), findsOneWidget);
    expect(find.text('改訂 2026/05/01'), findsOneWidget);
  });

  testWidgets('SearchView loads next page near list end', (tester) async {
    final drugApiClient = _MockDrugApiClient();
    final fixture = _drugListFixture();
    final scrollableFixture = fixture.copyWith(
      items: List.filled(20, fixture.items.first),
    );
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
      ),
    ).thenAnswer((_) async => scrollableFixture);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );
    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'load more keyword',
    );
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const PageStorageKey<String>('drugSearchResults')),
      const Offset(0, -3000),
    );
    await tester.pumpAndSettle();

    verify(
      () => drugApiClient.getDrugs(
        page: 2,
        pageSize: 20,
        keyword: 'load more keyword',
      ),
    ).called(greaterThanOrEqualTo(1));
  });

  testWidgets('SearchView renders empty state for empty drug results', (
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
        keyword: any(named: 'keyword'),
      ),
    ).thenAnswer(
      (_) async => _drugListFixture().copyWith(items: [], totalCount: 0),
    );

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
          home: SearchView(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('該当する結果がありません'), findsOneWidget);
  });

  testWidgets('SearchView renders empty state recovery CTAs', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty recovery keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('条件をリセット'), findsOneWidget);
    expect(find.text('絞り込みを 1 つずつ外す'), findsOneWidget);
    expect(find.text('検索キーワードや絞り込みを見直してください。'), findsOneWidget);
    expect(find.text('部分一致に変更'), findsNothing);
    expect(find.widgetWithText(FilledButton, '条件をリセット'), findsOneWidget);
    expect(
      find.widgetWithText(OutlinedButton, '絞り込みを 1 つずつ外す'),
      findsOneWidget,
    );
    expect(find.widgetWithText(TextButton, '部分一致に変更'), findsNothing);
  });

  testWidgets('empty state shows 64x64 surface3 circle with magnifier icon', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
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
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchView(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'empty icon keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    final iconContainer = tester.widget<Container>(
      find.byKey(const ValueKey('search-empty-icon')),
    );
    final constraints = iconContainer.constraints!;
    final decoration = iconContainer.decoration! as BoxDecoration;

    expect(constraints.minWidth, 64);
    expect(constraints.maxWidth, 64);
    expect(constraints.minHeight, 64);
    expect(constraints.maxHeight, 64);
    expect(decoration.color, SearchPalette.light.surface3);
    expect(decoration.shape, BoxShape.circle);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('search-empty-icon')),
        matching: find.byIcon(Icons.search_off),
      ),
      findsOneWidget,
    );
  });

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
          home: SearchView(),
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
          home: SearchView(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'network failure keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('通信エラー — もう一度'), findsOneWidget);
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
    expect(decoration.color, SearchPalette.light.dangerCont);
    expect(decoration.shape, BoxShape.circle);
    expect(warningIcon.size, 32);
    expect(warningIcon.color, SearchPalette.light.danger);
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
            home: SearchView(),
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
          home: SearchView(),
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
    expect(find.text('通信エラー — もう一度'), findsNothing);
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
          home: SearchView(),
        ),
      ),
    );
    await tester.enterText(
      find.byKey(const ValueKey('search-field')),
      'retry keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.text('通信エラー — もう一度'), findsOneWidget);

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
          home: SearchView(),
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
          home: SearchView(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('薬事分類'), findsOneWidget);
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
    expect(find.text('経口'), findsOneWidget);
    await _tapVisible(tester, find.text('経口'));
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
        therapeuticCategory: 'cardiovascular',
        adverseReactionKeyword: '浮腫',
        precautionCategory: ['GERIATRIC'],
        keyword: any(named: 'keyword'),
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
          home: SearchView(),
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
          home: SearchView(),
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
          home: SearchView(),
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
          home: SearchView(),
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
    expect(find.text('薬事分類'), findsNothing);

    await _tapVisible(tester, find.text('IX 循環器系の疾患'));
    await _tapVisible(tester, find.text('診療科'));
    await tester.pumpAndSettle();
    expect(find.text('循環器内科'), findsOneWidget);
    await _tapVisible(tester, find.text('循環器内科'));
    await _tapVisible(tester, find.textContaining('結果を見る'));

    verify(
      () => diseaseApiClient.getDiseases(
        page: 1,
        pageSize: SearchConstants.searchPageSize,
        icd10Chapter: ['chapter_ix'],
        department: ['cardiology'],
        chronicity: null,
        infectious: any(named: 'infectious'),
        keyword: any(named: 'keyword'),
        symptomKeyword: any(named: 'symptomKeyword'),
        onsetPattern: null,
        examCategory: null,
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
          home: SearchView(),
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

  testWidgets('SearchView labels all ICD-10 chapters in disease cards', (
    tester,
  ) async {
    final diseaseApiClient = _MockDiseaseApiClient();
    when(
      () => diseaseApiClient.getDiseases(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
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
          home: SearchView(),
        ),
      ),
    );

    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    expect(find.text('ICD-10: II 新生物'), findsOneWidget);
    expect(find.textContaining('chapter_ii'), findsNothing);
  });

  testWidgets('SearchView stretches disease cards to the result width', (
    tester,
  ) async {
    final diseaseApiClient = _MockDiseaseApiClient();
    when(
      () => diseaseApiClient.getDiseases(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
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
          home: SearchView(),
        ),
      ),
    );

    await tester.tap(find.text('疾患'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    final listWidth = tester
        .getSize(
          find.byKey(const PageStorageKey<String>('diseaseSearchResults')),
        )
        .width;
    final cardWidth = tester
        .getSize(
          find.byKey(
            ValueKey('disease-card-${_diseaseListFixture().items.first.id}'),
          ),
        )
        .width;
    expect(cardWidth, listWidth);
  });

  testWidgets('SearchView colors drug regulatory badges by classification', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
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

  testWidgets('SearchView opens drug sort sheet from results toolbar', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
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
          home: SearchView(),
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
    expect(find.text('ブランド名カナ'), findsOneWidget);
    expect(find.text('ATC コード'), findsOneWidget);
    expect(find.text('薬効分類名'), findsOneWidget);
  });

  testWidgets('SearchView applies selected drug sort from sort sheet', (
    tester,
  ) async {
    final drugApiClient = _MockDrugApiClient();
    when(
      () => drugApiClient.getDrugs(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        keyword: any(named: 'keyword'),
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
          home: SearchView(),
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
        sort: 'atc_code',
      ),
    ).called(1);
  });

  testWidgets(
    'SearchView renders skeletonized loading list while search is pending',
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
            home: SearchView(),
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
      expect(effect.colors, [
        SearchPalette.light.surface2,
        SearchPalette.light.surface3,
        SearchPalette.light.surface2,
      ]);
      expect(find.text('合計 — 件'), findsOneWidget);
      expect(find.text('検索中…'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('search-loading-skeleton-card')),
        findsNWidgets(5),
      );

      pending.complete(_drugListFixture());
    },
  );
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}

DiseaseListResponseDto _diseaseListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseListResponseDto.fromJson(json);
}

DiseaseListResponseDto _diseaseListFixtureForChapter(String chapter) {
  return DiseaseListResponseDto.fromJson({
    'items': [
      {
        'id': 'disease_chapter_contract',
        'name': 'サンプル疾患',
        'icd10_chapter': chapter,
        'medical_department': ['internal_medicine'],
        'chronicity': 'chronic',
        'infectious': false,
        'name_kana': 'サンプルシッカン',
        'revised_at': '2026-04-17',
      },
    ],
    'page': 1,
    'page_size': 20,
    'total_pages': 1,
    'total_count': 1,
    'disclaimer': 'FICTIONAL DATA - NOT FOR MEDICAL USE / 架空データ・医療判断には使用不可',
  });
}

CategoriesResponseDto _categoriesFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_categories.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return CategoriesResponseDto.fromJson(json);
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
