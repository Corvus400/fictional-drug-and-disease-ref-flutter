import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  testWidgets('SearchView renders Round6 search chrome without placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
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

  testWidgets('SearchView uses SearchPalette from theme', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
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
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
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

  testWidgets('SearchView deletes a persisted history row from dropdown', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
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

  testWidgets('SearchView clears persisted history after confirmation', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
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

  testWidgets('SearchView renders drug results from repository state', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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
  });

  testWidgets('SearchView loads next page near list end', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    final fixture = _drugListFixture();
    final scrollableFixture = fixture.copyWith(
      items: List.filled(20, fixture.items.first),
    );
    addTearDown(db.close);
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
      find.byKey(const ValueKey('search-results-list')),
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
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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
      'empty keyword',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('該当する結果がありません'), findsOneWidget);
  });

  testWidgets('SearchView renders empty state recovery CTAs', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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
    expect(find.text('条件を1つ外す'), findsOneWidget);
    expect(find.text('部分一致に変更'), findsOneWidget);
  });

  testWidgets('SearchView renders error state for search failure', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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
    expect(find.text('再試行'), findsOneWidget);
  });

  testWidgets('SearchView retry runs search again after failure', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    var callCount = 0;
    addTearDown(db.close);
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
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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
    await tester.pump();

    expect(find.text('絞り込み'), findsOneWidget);
    expect(find.text('結果を見る'), findsOneWidget);
  });

  testWidgets('SearchView opens drug sort sheet from results toolbar', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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

    await tester.tap(find.text('並び替え'));
    await tester.pumpAndSettle();

    expect(find.text('更新日 (新しい順)'), findsOneWidget);
    expect(find.text('ブランド名カナ'), findsOneWidget);
    expect(find.text('ATC コード'), findsOneWidget);
    expect(find.text('薬効分類名'), findsOneWidget);
  });

  testWidgets('SearchView applies selected drug sort from sort sheet', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final drugApiClient = _MockDrugApiClient();
    addTearDown(db.close);
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

    await tester.tap(find.text('並び替え'));
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
      final db = AppDatabase(NativeDatabase.memory());
      final drugApiClient = _MockDrugApiClient();
      final pending = Completer<DrugListResponseDto>();
      addTearDown(db.close);
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
      expect(
        find.byKey(const ValueKey('search-loading-skeleton-card')),
        findsNWidgets(5),
      );

      pending.complete(_drugListFixture());
    },
  );
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}
