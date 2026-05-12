import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('HistoryScreenNotifier', () {
    late AppDatabase db;
    late _MockDrugApiClient drugApiClient;
    late _MockDiseaseApiClient diseaseApiClient;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      drugApiClient = _MockDrugApiClient();
      diseaseApiClient = _MockDiseaseApiClient();
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('build starts with loading state', () {
      final container = _createContainer(
        db,
        drugApiClient: drugApiClient,
        diseaseApiClient: diseaseApiClient,
      );
      addTearDown(container.dispose);

      final state = container.read(historyScreenProvider);

      expect(state, isA<HistoryLoading>());
    });

    test('selectTab filters mixed drug and disease rows', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 11, 9));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 11, 10));
      final container = _createContainer(
        db,
        drugApiClient: drugApiClient,
        diseaseApiClient: diseaseApiClient,
      );
      addTearDown(container.dispose);
      final subscription = container.listen(historyScreenProvider, (_, _) {});
      addTearDown(subscription.close);

      await _settleHistory(container);
      container.read(historyScreenProvider.notifier).selectTab(HistoryTab.drug);

      final state = container.read(historyScreenProvider);
      expect(state, isA<HistoryLoaded>());
      final loaded = state as HistoryLoaded;
      expect(loaded.selectedTab, HistoryTab.drug);
      expect(loaded.rows, hasLength(1));
      expect(loaded.rows.single, isA<HistoryDrugRow>());
      expect(
        (loaded.rows.single as HistoryDrugRow).summary.id,
        _drugSummary.id,
      );
      expect(loaded.hasNameFailure, isFalse);
    });

    test('deleteRow removes a row and reloads visible rows', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 11, 9));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 11, 10));
      final container = _createContainer(
        db,
        drugApiClient: drugApiClient,
        diseaseApiClient: diseaseApiClient,
      );
      addTearDown(container.dispose);
      final subscription = container.listen(historyScreenProvider, (_, _) {});
      addTearDown(subscription.close);
      await _settleHistory(container);

      await container
          .read(historyScreenProvider.notifier)
          .deleteRow(
            _diseaseSummary.id,
          );
      await _settleHistory(container);

      final state = container.read(historyScreenProvider) as HistoryLoaded;
      expect(state.rows, hasLength(1));
      expect(state.rows.single.id, _drugSummary.id);
    });

    test('clearAll maps an empty stream emission to HistoryEmpty', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 11, 9));
      final container = _createContainer(
        db,
        drugApiClient: drugApiClient,
        diseaseApiClient: diseaseApiClient,
      );
      addTearDown(container.dispose);
      final subscription = container.listen(historyScreenProvider, (_, _) {});
      addTearDown(subscription.close);
      await _settleHistory(container);

      await container.read(historyScreenProvider.notifier).clearAll();
      await _settleHistory(container);

      expect(container.read(historyScreenProvider), isA<HistoryEmpty>());
    });

    test('snapshot misses can resolve names from the API', () async {
      await BrowsingHistoryRepository(
        db.browsingHistoriesDao,
      ).upsert('drug_0080', viewedAt: DateTime.utc(2026, 5, 11, 9));
      when(
        () => drugApiClient.getDrug('drug_0080'),
      ).thenAnswer((_) async => _drugDtoFixture());
      final container = _createContainer(
        db,
        drugApiClient: drugApiClient,
        diseaseApiClient: diseaseApiClient,
      );
      addTearDown(container.dispose);
      final subscription = container.listen(historyScreenProvider, (_, _) {});
      addTearDown(subscription.close);

      final state = await _settleHistory(container) as HistoryLoaded;

      expect(state.rows.single, isA<HistoryDrugRow>());
      expect((state.rows.single as HistoryDrugRow).summary.id, 'drug_0080');
      verify(() => drugApiClient.getDrug('drug_0080')).called(1);
    });

    test(
      'API failures become row-level unresolved state and retry can recover',
      () async {
        await BrowsingHistoryRepository(
          db.browsingHistoriesDao,
        ).upsert('drug_0080', viewedAt: DateTime.utc(2026, 5, 11, 9));
        when(
          () => drugApiClient.getDrug('drug_0080'),
        ).thenThrow(Exception('network down'));
        final container = _createContainer(
          db,
          drugApiClient: drugApiClient,
          diseaseApiClient: diseaseApiClient,
        );
        addTearDown(container.dispose);
        final subscription = container.listen(historyScreenProvider, (_, _) {});
        addTearDown(subscription.close);

        final failed = await _settleHistory(container) as HistoryLoaded;

        expect(failed.hasNameFailure, isTrue);
        expect(failed.rows.single, isA<HistoryUnresolvedRow>());

        await BookmarkRepository(db.bookmarksDao).insert(
          id: _drug0080Summary.id,
          snapshotJson: const DrugBookmarkSnapshotCodec().encode(
            _drug0080Summary,
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 12),
        );
        await container.read(historyScreenProvider.notifier).retryFailedNames();

        final recovered =
            container.read(historyScreenProvider) as HistoryLoaded;
        expect(recovered.hasNameFailure, isFalse);
        expect(recovered.rows.single, isA<HistoryDrugRow>());
        expect(
          (recovered.rows.single as HistoryDrugRow).summary.brandName,
          _drug0080Summary.brandName,
        );
      },
    );
  });
}

ProviderContainer _createContainer(
  AppDatabase db, {
  required DrugApiClient drugApiClient,
  required DiseaseApiClient diseaseApiClient,
}) {
  return ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      drugApiClientProvider.overrideWithValue(drugApiClient),
      diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
    ],
  );
}

Future<HistoryScreenState> _settleHistory(ProviderContainer container) async {
  for (var i = 0; i < 10; i += 1) {
    await pumpEventQueue();
    final state = container.read(historyScreenProvider);
    if (state is! HistoryLoading) {
      return state;
    }
  }
  return container.read(historyScreenProvider);
}

Future<void> _seedDrug(
  AppDatabase db,
  DrugSummary summary,
  DateTime viewedAt,
) async {
  await BookmarkRepository(db.bookmarksDao).insert(
    id: summary.id,
    snapshotJson: const DrugBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: DateTime.utc(2026, 5, 10),
  );
  await BrowsingHistoryRepository(
    db.browsingHistoriesDao,
  ).upsert(summary.id, viewedAt: viewedAt);
}

Future<void> _seedDisease(
  AppDatabase db,
  DiseaseSummary summary,
  DateTime viewedAt,
) async {
  await BookmarkRepository(db.bookmarksDao).insert(
    id: summary.id,
    snapshotJson: const DiseaseBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: DateTime.utc(2026, 5, 10),
  );
  await BrowsingHistoryRepository(
    db.browsingHistoriesDao,
  ).upsert(summary.id, viewedAt: viewedAt);
}

const _drugSummary = DrugSummary(
  id: 'drug_001',
  brandName: 'アムロジン錠5mg',
  genericName: 'アムロジピンベシル酸塩',
  therapeuticCategoryName: '持続性Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'アムロジンジョウ',
  atcCode: 'C08CA01',
  revisedAt: '2026-05-10',
  imageUrl: '/v1/images/drugs/drug_001',
);

const _drug0080Summary = DrugSummary(
  id: 'drug_0080',
  brandName: '再取得成功薬',
  genericName: 'リトライ確認成分',
  therapeuticCategoryName: 'テスト用薬効分類',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'サイシュトクセイコウヤク',
  atcCode: 'C08CA01',
  revisedAt: '2026-05-12',
  imageUrl: '/v1/images/drugs/drug_0080',
);

const _diseaseSummary = DiseaseSummary(
  id: 'disease_001',
  name: '本態性高血圧症',
  icd10Chapter: 'IX',
  medicalDepartment: ['cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'ホンタイセイコウケツアツショウ',
  revisedAt: '2026-05-10',
);

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

DrugDto _drugDtoFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}
