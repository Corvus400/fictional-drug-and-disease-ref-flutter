import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('DrugDetailScreenNotifier', () {
    late AppDatabase db;
    late _MockDrugApiClient apiClient;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      apiClient = _MockDrugApiClient();
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('initial state returns loading phase and overview tab', () {
      final dto = _drugFixture();
      when(() => apiClient.getDrug('drug_001')).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);

      final state = container.read(drugDetailScreenProvider('drug_001'));

      expect(state.phase, isA<DrugDetailLoadingPhase>());
      expect(state.activeTab, DrugDetailTab.overview);
      expect(state.isBookmarked, isFalse);
      expect(state.isBookmarkBusy, isFalse);
      expect(state.bookmarkError, isNull);
    });

    test('load success maps detail and bookmark state', () async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await pumpEventQueue();

      final state = container.read(drugDetailScreenProvider(dto.id));
      expect(state.phase, isA<DrugDetailLoadedPhase>());
      final phase = state.phase as DrugDetailLoadedPhase;
      expect(phase.drug.id, dto.id);
      expect(phase.drug.brandName, dto.brandName);
      expect(state.isBookmarked, isFalse);
      expect(state.activeTab, DrugDetailTab.overview);
    });

    test('load network failure with bookmark maps error phase', () async {
      final dto = _drugFixture();
      final drug = dto.toDomain();
      const snapshotCodec = DrugBookmarkSnapshotCodec();
      await BookmarkRepository(db.bookmarksDao).insert(
        id: dto.id,
        snapshotJson: snapshotCodec.encode(snapshotCodec.fromDrug(drug)),
        bookmarkedAt: DateTime.utc(2026, 5, 4),
      );
      when(() => apiClient.getDrug(dto.id)).thenThrow(_connectionError(dto.id));
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await pumpEventQueue();

      final state = container.read(drugDetailScreenProvider(dto.id));
      expect(state.phase, isA<DrugDetailErrorPhase>());
      final phase = state.phase as DrugDetailErrorPhase;
      expect(phase.error, isA<NetworkException>());
      expect(state.activeTab, DrugDetailTab.overview);
    });

    test('load api failure maps error phase', () async {
      when(() => apiClient.getDrug('missing')).thenThrow(_badResponse(404));
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider('missing'),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await pumpEventQueue();

      final state = container.read(drugDetailScreenProvider('missing'));
      expect(state.phase, isA<DrugDetailErrorPhase>());
      final phase = state.phase as DrugDetailErrorPhase;
      expect(phase.error, isA<ApiException>());
      expect(state.isBookmarked, isFalse);
      expect(state.activeTab, DrugDetailTab.overview);
    });

    test('select tab changes active tab without reloading detail', () async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();

      container
          .read(drugDetailScreenProvider(dto.id).notifier)
          .selectTab(DrugDetailTab.caution);

      final state = container.read(drugDetailScreenProvider(dto.id));
      expect(state.activeTab, DrugDetailTab.caution);
      expect(state.phase, isA<DrugDetailLoadedPhase>());
      expect((state.phase as DrugDetailLoadedPhase).drug.id, dto.id);
      verify(() => apiClient.getDrug(dto.id)).called(1);
    });

    test('bookmark stream data updates bookmark state', () async {
      final dto = _drugFixture();
      final bookmarkStream = StreamController<bool>.broadcast();
      addTearDown(bookmarkStream.close);
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => bookmarkStream.stream),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();

      bookmarkStream.add(true);
      await pumpEventQueue();

      expect(
        container.read(drugDetailScreenProvider(dto.id)).isBookmarked,
        isTrue,
      );
    });

    test('toggle bookmark sets busy state and updates result', () async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();

      final toggle = container
          .read(drugDetailScreenProvider(dto.id).notifier)
          .toggleBookmark();

      expect(
        container.read(drugDetailScreenProvider(dto.id)).isBookmarkBusy,
        isTrue,
      );
      await toggle;
      final state = container.read(drugDetailScreenProvider(dto.id));
      expect(state.isBookmarkBusy, isFalse);
      expect(state.isBookmarked, isTrue);
      expect(state.bookmarkError, isNull);
    });

    test('toggle bookmark ignores second tap while busy', () async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();

      final notifier = container.read(
        drugDetailScreenProvider(dto.id).notifier,
      );
      final first = notifier.toggleBookmark();
      final second = notifier.toggleBookmark();
      await Future.wait([first, second]);

      final state = container.read(drugDetailScreenProvider(dto.id));
      expect(state.isBookmarked, isTrue);
      expect(state.isBookmarkBusy, isFalse);
      expect(state.bookmarkError, isNull);
      final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
        dto.id,
      );
      expect((bookmark as Ok).value, isNotNull);
    });

    test('toggle bookmark failure clears busy and stores error', () async {
      final dto = _drugFixture();
      final drug = dto.toDomain();
      const snapshotCodec = DrugBookmarkSnapshotCodec();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();
      await BookmarkRepository(db.bookmarksDao).insert(
        id: dto.id,
        snapshotJson: snapshotCodec.encode(snapshotCodec.fromDrug(drug)),
        bookmarkedAt: DateTime.utc(2026, 5, 4),
      );

      await container
          .read(drugDetailScreenProvider(dto.id).notifier)
          .toggleBookmark();

      final state = container.read(drugDetailScreenProvider(dto.id));
      expect(state.isBookmarkBusy, isFalse);
      expect(state.isBookmarked, isFalse);
      expect(state.bookmarkError, isA<StorageException>());
    });

    test('clear bookmark error clears only bookmark error', () async {
      final dto = _drugFixture();
      final drug = dto.toDomain();
      const snapshotCodec = DrugBookmarkSnapshotCodec();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();
      await BookmarkRepository(db.bookmarksDao).insert(
        id: dto.id,
        snapshotJson: snapshotCodec.encode(snapshotCodec.fromDrug(drug)),
        bookmarkedAt: DateTime.utc(2026, 5, 4),
      );
      await container
          .read(drugDetailScreenProvider(dto.id).notifier)
          .toggleBookmark();
      final failed = container.read(drugDetailScreenProvider(dto.id));
      expect(failed.bookmarkError, isA<StorageException>());

      container
          .read(drugDetailScreenProvider(dto.id).notifier)
          .clearBookmarkError();

      final cleared = container.read(drugDetailScreenProvider(dto.id));
      expect(cleared.bookmarkError, isNull);
      expect(cleared.phase, same(failed.phase));
      expect(cleared.isBookmarked, failed.isBookmarked);
    });

    test('retry returns to loading and reloads detail', () async {
      final dto = _drugFixture();
      var calls = 0;
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async {
        calls += 1;
        if (calls == 1) {
          throw _badResponse(500);
        }
        return dto;
      });
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        drugDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();
      expect(
        container.read(drugDetailScreenProvider(dto.id)).phase,
        isA<DrugDetailErrorPhase>(),
      );

      final retry = container
          .read(drugDetailScreenProvider(dto.id).notifier)
          .retry();

      expect(
        container.read(drugDetailScreenProvider(dto.id)).phase,
        isA<DrugDetailLoadingPhase>(),
      );
      await retry;
      final state = container.read(drugDetailScreenProvider(dto.id));
      expect(state.phase, isA<DrugDetailLoadedPhase>());
      expect((state.phase as DrugDetailLoadedPhase).drug.id, dto.id);
      expect(calls, 2);
    });
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

DrugDto _drugFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}

DioException _connectionError(String id) {
  return DioException(
    requestOptions: RequestOptions(path: '/v1/drugs/$id'),
    type: DioExceptionType.connectionError,
  );
}

DioException _badResponse(int statusCode) {
  final requestOptions = RequestOptions(path: '/v1/drugs/missing');
  return DioException(
    requestOptions: requestOptions,
    response: Response<Object?>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: {
        'code': 'NOT_FOUND',
        'message': 'missing',
      },
    ),
    type: DioExceptionType.badResponse,
  );
}
