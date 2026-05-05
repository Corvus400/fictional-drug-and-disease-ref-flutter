import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SearchScreenNotifier', () {
    late AppDatabase db;
    late _MockDrugApiClient drugApiClient;
    late ProviderContainer container;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      drugApiClient = _MockDrugApiClient();
      container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(drugApiClient),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(db.close);
    });

    test('build starts with idle drug state', () {
      final state = container.read(searchScreenProvider);

      expect(state.tab, SearchTab.drugs);
      expect(state.queryText, '');
      expect(state.phase, isA<SearchPhaseIdle>());
    });

    test('changeQueryText updates text without running search', () {
      container.read(searchScreenProvider.notifier).changeQueryText('アムロ');

      final state = container.read(searchScreenProvider);
      final queryText = state.queryText;
      final phase = state.phase;
      expect(queryText, 'アムロ');
      expect(phase, isA<SearchPhaseIdle>());
    });

    test('performSearch loads drug results and records history', () async {
      final dto = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
        ),
      ).thenAnswer((_) async => dto);
      final notifier = container.read(searchScreenProvider.notifier)
        ..changeQueryText('アムロ');

      await notifier.performSearch();

      final state = container.read(searchScreenProvider);
      final phase = state.phase as SearchPhaseResults;
      final view = phase.view as DrugSearchResultsView;
      expect(view.items, isNotEmpty);
      expect(state.historyForTab, hasLength(1));
      expect(state.historyForTab.single.queryText, 'アムロ');
      verify(
        () => drugApiClient.getDrugs(
          page: 1,
          pageSize: 20,
          keyword: 'アムロ',
        ),
      ).called(1);
    });

    test('selectHistory restores query and searches immediately', () async {
      final dto = _drugListFixture();
      when(
        () => drugApiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          keyword: any(named: 'keyword'),
        ),
      ).thenAnswer((_) async => dto);
      const params = DrugSearchParams(keyword: '履歴');
      await container
          .read(searchHistoryRepositoryProvider)
          .insertWithDedup(
            id: 'search_001',
            target: 'drug',
            queryJson: container.read(searchQueryCodecProvider).encode(params),
            searchedAt: DateTime.utc(2026, 5, 5),
            totalCount: 1,
          );
      final notifier = container.read(searchScreenProvider.notifier);
      await notifier.loadHistory();

      await notifier.selectHistory(
        container.read(searchScreenProvider).historyForTab.single,
      );

      final state = container.read(searchScreenProvider);
      expect(state.queryText, '履歴');
      expect(state.phase, isA<SearchPhaseResults>());
    });
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}
