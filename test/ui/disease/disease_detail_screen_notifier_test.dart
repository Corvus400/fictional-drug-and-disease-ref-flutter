import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('DiseaseDetailScreenNotifier', () {
    late AppDatabase db;
    late _MockDiseaseApiClient apiClient;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      apiClient = _MockDiseaseApiClient();
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test(
      'initial state returns loading phase and overview tab [assertion 1/5]',
      () {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);

        final state = container.read(diseaseDetailScreenProvider(dto.id));

        expect(state.phase, isA<DiseaseDetailLoadingPhase>());
        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 2/5]',
      () {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);

        final state = container.read(diseaseDetailScreenProvider(dto.id));

        Object.hashAll([state.phase, isA<DiseaseDetailLoadingPhase>()]);

        expect(state.activeTab, DiseaseDetailTab.overview);
        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 3/5]',
      () {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);

        final state = container.read(diseaseDetailScreenProvider(dto.id));

        Object.hashAll([state.phase, isA<DiseaseDetailLoadingPhase>()]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);

        expect(state.isBookmarked, isFalse);
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 4/5]',
      () {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);

        final state = container.read(diseaseDetailScreenProvider(dto.id));

        Object.hashAll([state.phase, isA<DiseaseDetailLoadingPhase>()]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);

        Object.hashAll([state.isBookmarked, isFalse]);

        expect(state.isBookmarkBusy, isFalse);
        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 5/5]',
      () {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);

        final state = container.read(diseaseDetailScreenProvider(dto.id));

        Object.hashAll([state.phase, isA<DiseaseDetailLoadingPhase>()]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        expect(state.bookmarkError, isNull);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 1/5]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        expect(state.phase, isA<DiseaseDetailLoadedPhase>());
        final phase = state.phase as DiseaseDetailLoadedPhase;
        Object.hashAll([phase.disease.id, dto.id]);

        Object.hashAll([phase.disease.name, dto.name]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 2/5]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        final phase = state.phase as DiseaseDetailLoadedPhase;
        expect(phase.disease.id, dto.id);
        Object.hashAll([phase.disease.name, dto.name]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 3/5]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        final phase = state.phase as DiseaseDetailLoadedPhase;
        Object.hashAll([phase.disease.id, dto.id]);

        expect(phase.disease.name, dto.name);
        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 4/5]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        final phase = state.phase as DiseaseDetailLoadedPhase;
        Object.hashAll([phase.disease.id, dto.id]);

        Object.hashAll([phase.disease.name, dto.name]);

        expect(state.isBookmarked, isFalse);
        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 5/5]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        final phase = state.phase as DiseaseDetailLoadedPhase;
        Object.hashAll([phase.disease.id, dto.id]);

        Object.hashAll([phase.disease.name, dto.name]);

        Object.hashAll([state.isBookmarked, isFalse]);

        expect(state.activeTab, DiseaseDetailTab.overview);
      },
    );

    test('load api failure maps error phase [assertion 1/4]', () async {
      when(() => apiClient.getDisease('missing')).thenThrow(_badResponse(404));
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        diseaseDetailScreenProvider('missing'),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await pumpEventQueue();

      final state = container.read(diseaseDetailScreenProvider('missing'));
      expect(state.phase, isA<DiseaseDetailErrorPhase>());
      final phase = state.phase as DiseaseDetailErrorPhase;
      Object.hashAll([phase.error, isA<ApiException>()]);

      Object.hashAll([state.isBookmarked, isFalse]);

      Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);
    });

    test('load api failure maps error phase [assertion 2/4]', () async {
      when(() => apiClient.getDisease('missing')).thenThrow(_badResponse(404));
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        diseaseDetailScreenProvider('missing'),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await pumpEventQueue();

      final state = container.read(diseaseDetailScreenProvider('missing'));
      Object.hashAll([state.phase, isA<DiseaseDetailErrorPhase>()]);

      final phase = state.phase as DiseaseDetailErrorPhase;
      expect(phase.error, isA<ApiException>());
      Object.hashAll([state.isBookmarked, isFalse]);

      Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);
    });

    test('load api failure maps error phase [assertion 3/4]', () async {
      when(() => apiClient.getDisease('missing')).thenThrow(_badResponse(404));
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        diseaseDetailScreenProvider('missing'),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await pumpEventQueue();

      final state = container.read(diseaseDetailScreenProvider('missing'));
      Object.hashAll([state.phase, isA<DiseaseDetailErrorPhase>()]);

      final phase = state.phase as DiseaseDetailErrorPhase;
      Object.hashAll([phase.error, isA<ApiException>()]);

      expect(state.isBookmarked, isFalse);
      Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);
    });

    test('load api failure maps error phase [assertion 4/4]', () async {
      when(() => apiClient.getDisease('missing')).thenThrow(_badResponse(404));
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        diseaseDetailScreenProvider('missing'),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await pumpEventQueue();

      final state = container.read(diseaseDetailScreenProvider('missing'));
      Object.hashAll([state.phase, isA<DiseaseDetailErrorPhase>()]);

      final phase = state.phase as DiseaseDetailErrorPhase;
      Object.hashAll([phase.error, isA<ApiException>()]);

      Object.hashAll([state.isBookmarked, isFalse]);

      expect(state.activeTab, DiseaseDetailTab.overview);
    });

    test(
      'load network failure with bookmark maps error phase [assertion 1/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        when(
          () => apiClient.getDisease(dto.id),
        ).thenThrow(_connectionError(dto.id));
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        expect(state.phase, isA<DiseaseDetailErrorPhase>());
        final phase = state.phase as DiseaseDetailErrorPhase;
        Object.hashAll([phase.error, isA<NetworkException>()]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'load network failure with bookmark maps error phase [assertion 2/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        when(
          () => apiClient.getDisease(dto.id),
        ).thenThrow(_connectionError(dto.id));
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailErrorPhase>()]);

        final phase = state.phase as DiseaseDetailErrorPhase;
        expect(phase.error, isA<NetworkException>());
        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'load network failure with bookmark maps error phase [assertion 3/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        when(
          () => apiClient.getDisease(dto.id),
        ).thenThrow(_connectionError(dto.id));
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailErrorPhase>()]);

        final phase = state.phase as DiseaseDetailErrorPhase;
        Object.hashAll([phase.error, isA<NetworkException>()]);

        expect(state.activeTab, DiseaseDetailTab.overview);
        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'load network failure with bookmark maps error phase [assertion 4/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        when(
          () => apiClient.getDisease(dto.id),
        ).thenThrow(_connectionError(dto.id));
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);

        await pumpEventQueue();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailErrorPhase>()]);

        final phase = state.phase as DiseaseDetailErrorPhase;
        Object.hashAll([phase.error, isA<NetworkException>()]);

        Object.hashAll([state.activeTab, DiseaseDetailTab.overview]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        expect((bookmark as Ok).value, isNotNull);
      },
    );

    test(
      'select tab changes active tab without reloading detail [assertion 1/3]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .selectTab(DiseaseDetailTab.diagnosis);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        expect(state.activeTab, DiseaseDetailTab.diagnosis);
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DiseaseDetailLoadedPhase).disease.id,
          dto.id,
        ]);

        verify(() => apiClient.getDisease(dto.id)).called(1);
      },
    );

    test(
      'select tab changes active tab without reloading detail [assertion 2/3]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .selectTab(DiseaseDetailTab.diagnosis);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.activeTab, DiseaseDetailTab.diagnosis]);

        expect(state.phase, isA<DiseaseDetailLoadedPhase>());
        Object.hashAll([
          (state.phase as DiseaseDetailLoadedPhase).disease.id,
          dto.id,
        ]);

        verify(() => apiClient.getDisease(dto.id)).called(1);
      },
    );

    test(
      'select tab changes active tab without reloading detail [assertion 3/3]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .selectTab(DiseaseDetailTab.diagnosis);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.activeTab, DiseaseDetailTab.diagnosis]);

        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        expect((state.phase as DiseaseDetailLoadedPhase).disease.id, dto.id);
        verify(() => apiClient.getDisease(dto.id)).called(1);
      },
    );

    test('bookmark stream data updates bookmark state', () async {
      final dto = _diseaseFixture();
      final bookmarkStream = StreamController<bool>.broadcast();
      addTearDown(bookmarkStream.close);
      when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => bookmarkStream.stream),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        diseaseDetailScreenProvider(dto.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await pumpEventQueue();

      bookmarkStream.add(true);
      await pumpEventQueue();

      expect(
        container.read(diseaseDetailScreenProvider(dto.id)).isBookmarked,
        isTrue,
      );
    });

    test(
      'toggle bookmark sets busy state and updates result [assertion 1/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final toggle = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        expect(
          container.read(diseaseDetailScreenProvider(dto.id)).isBookmarkBusy,
          isTrue,
        );
        await toggle;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.isBookmarked, isTrue]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'toggle bookmark sets busy state and updates result [assertion 2/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final toggle = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).isBookmarkBusy,
          isTrue,
        ]);

        await toggle;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        expect(state.isBookmarkBusy, isFalse);
        Object.hashAll([state.isBookmarked, isTrue]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'toggle bookmark sets busy state and updates result [assertion 3/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final toggle = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).isBookmarkBusy,
          isTrue,
        ]);

        await toggle;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        expect(state.isBookmarked, isTrue);
        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'toggle bookmark sets busy state and updates result [assertion 4/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final toggle = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).isBookmarkBusy,
          isTrue,
        ]);

        await toggle;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.isBookmarked, isTrue]);

        expect(state.bookmarkError, isNull);
      },
    );

    test(
      'toggle bookmark ignores second tap while busy [assertion 1/5]',
      () async {
        final dto = _diseaseFixture();
        final countingDao = _CountingBookmarksDao(db);
        final firstInsertGate = Completer<void>();
        countingDao.insertGate = firstInsertGate.future;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            bookmarksDaoProvider.overrideWithValue(countingDao),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final notifier = container.read(
          diseaseDetailScreenProvider(dto.id).notifier,
        );
        final first = notifier.toggleBookmark();
        final second = notifier.toggleBookmark();

        await pumpEventQueue();
        expect(countingDao.insertCalls, 1);
        firstInsertGate.complete();
        await Future.wait([first, second]);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarked, isTrue]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'toggle bookmark ignores second tap while busy [assertion 2/5]',
      () async {
        final dto = _diseaseFixture();
        final countingDao = _CountingBookmarksDao(db);
        final firstInsertGate = Completer<void>();
        countingDao.insertGate = firstInsertGate.future;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            bookmarksDaoProvider.overrideWithValue(countingDao),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final notifier = container.read(
          diseaseDetailScreenProvider(dto.id).notifier,
        );
        final first = notifier.toggleBookmark();
        final second = notifier.toggleBookmark();

        await pumpEventQueue();
        Object.hashAll([countingDao.insertCalls, 1]);

        firstInsertGate.complete();
        await Future.wait([first, second]);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        expect(state.isBookmarked, isTrue);
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'toggle bookmark ignores second tap while busy [assertion 3/5]',
      () async {
        final dto = _diseaseFixture();
        final countingDao = _CountingBookmarksDao(db);
        final firstInsertGate = Completer<void>();
        countingDao.insertGate = firstInsertGate.future;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            bookmarksDaoProvider.overrideWithValue(countingDao),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final notifier = container.read(
          diseaseDetailScreenProvider(dto.id).notifier,
        );
        final first = notifier.toggleBookmark();
        final second = notifier.toggleBookmark();

        await pumpEventQueue();
        Object.hashAll([countingDao.insertCalls, 1]);

        firstInsertGate.complete();
        await Future.wait([first, second]);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarked, isTrue]);

        expect(state.isBookmarkBusy, isFalse);
        Object.hashAll([state.bookmarkError, isNull]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'toggle bookmark ignores second tap while busy [assertion 4/5]',
      () async {
        final dto = _diseaseFixture();
        final countingDao = _CountingBookmarksDao(db);
        final firstInsertGate = Completer<void>();
        countingDao.insertGate = firstInsertGate.future;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            bookmarksDaoProvider.overrideWithValue(countingDao),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final notifier = container.read(
          diseaseDetailScreenProvider(dto.id).notifier,
        );
        final first = notifier.toggleBookmark();
        final second = notifier.toggleBookmark();

        await pumpEventQueue();
        Object.hashAll([countingDao.insertCalls, 1]);

        firstInsertGate.complete();
        await Future.wait([first, second]);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarked, isTrue]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        expect(state.bookmarkError, isNull);
        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'toggle bookmark ignores second tap while busy [assertion 5/5]',
      () async {
        final dto = _diseaseFixture();
        final countingDao = _CountingBookmarksDao(db);
        final firstInsertGate = Completer<void>();
        countingDao.insertGate = firstInsertGate.future;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            bookmarksDaoProvider.overrideWithValue(countingDao),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();

        final notifier = container.read(
          diseaseDetailScreenProvider(dto.id).notifier,
        );
        final first = notifier.toggleBookmark();
        final second = notifier.toggleBookmark();

        await pumpEventQueue();
        Object.hashAll([countingDao.insertCalls, 1]);

        firstInsertGate.complete();
        await Future.wait([first, second]);

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarked, isTrue]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        expect((bookmark as Ok).value, isNotNull);
      },
    );

    test(
      'toggle bookmark failure clears busy and stores error [assertion 1/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );

        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        expect(state.phase, isA<DiseaseDetailLoadedPhase>());
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.bookmarkError, isA<StorageException>()]);
      },
    );

    test(
      'toggle bookmark failure clears busy and stores error [assertion 2/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );

        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        expect(state.isBookmarkBusy, isFalse);
        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.bookmarkError, isA<StorageException>()]);
      },
    );

    test(
      'toggle bookmark failure clears busy and stores error [assertion 3/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );

        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        expect(state.isBookmarked, isFalse);
        Object.hashAll([state.bookmarkError, isA<StorageException>()]);
      },
    );

    test(
      'toggle bookmark failure clears busy and stores error [assertion 4/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );

        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();

        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.isBookmarked, isFalse]);

        expect(state.bookmarkError, isA<StorageException>());
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 1/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();
        final failed = container.read(diseaseDetailScreenProvider(dto.id));
        expect(failed.bookmarkError, isA<StorageException>());

        container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .clearBookmarkError();

        final cleared = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([cleared.bookmarkError, isNull]);

        Object.hashAll([cleared.phase, same(failed.phase)]);

        Object.hashAll([cleared.isBookmarked, failed.isBookmarked]);
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 2/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();
        final failed = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([failed.bookmarkError, isA<StorageException>()]);

        container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .clearBookmarkError();

        final cleared = container.read(diseaseDetailScreenProvider(dto.id));
        expect(cleared.bookmarkError, isNull);
        Object.hashAll([cleared.phase, same(failed.phase)]);

        Object.hashAll([cleared.isBookmarked, failed.isBookmarked]);
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 3/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();
        final failed = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([failed.bookmarkError, isA<StorageException>()]);

        container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .clearBookmarkError();

        final cleared = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([cleared.bookmarkError, isNull]);

        expect(cleared.phase, same(failed.phase));
        Object.hashAll([cleared.isBookmarked, failed.isBookmarked]);
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 4/4]',
      () async {
        final dto = _diseaseFixture();
        final disease = dto.toDomain();
        const snapshotCodec = DiseaseBookmarkSnapshotCodec();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(
            snapshotCodec.fromDisease(disease),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        await container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .toggleBookmark();
        final failed = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([failed.bookmarkError, isA<StorageException>()]);

        container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .clearBookmarkError();

        final cleared = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([cleared.bookmarkError, isNull]);

        Object.hashAll([cleared.phase, same(failed.phase)]);

        expect(cleared.isBookmarked, failed.isBookmarked);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 1/5]',
      () async {
        final dto = _diseaseFixture();
        var calls = 0;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async {
          calls += 1;
          if (calls == 1) {
            throw _badResponse(500);
          }
          return dto;
        });
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        expect(
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailErrorPhase>(),
        );

        final retry = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .retry();

        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DiseaseDetailLoadedPhase).disease.id,
          dto.id,
        ]);

        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 2/5]',
      () async {
        final dto = _diseaseFixture();
        var calls = 0;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async {
          calls += 1;
          if (calls == 1) {
            throw _badResponse(500);
          }
          return dto;
        });
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailErrorPhase>(),
        ]);

        final retry = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .retry();

        expect(
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailLoadingPhase>(),
        );
        await retry;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DiseaseDetailLoadedPhase).disease.id,
          dto.id,
        ]);

        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 3/5]',
      () async {
        final dto = _diseaseFixture();
        var calls = 0;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async {
          calls += 1;
          if (calls == 1) {
            throw _badResponse(500);
          }
          return dto;
        });
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailErrorPhase>(),
        ]);

        final retry = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .retry();

        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        expect(state.phase, isA<DiseaseDetailLoadedPhase>());
        Object.hashAll([
          (state.phase as DiseaseDetailLoadedPhase).disease.id,
          dto.id,
        ]);

        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 4/5]',
      () async {
        final dto = _diseaseFixture();
        var calls = 0;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async {
          calls += 1;
          if (calls == 1) {
            throw _badResponse(500);
          }
          return dto;
        });
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailErrorPhase>(),
        ]);

        final retry = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .retry();

        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        expect((state.phase as DiseaseDetailLoadedPhase).disease.id, dto.id);
        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 5/5]',
      () async {
        final dto = _diseaseFixture();
        var calls = 0;
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async {
          calls += 1;
          if (calls == 1) {
            throw _badResponse(500);
          }
          return dto;
        });
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          diseaseDetailScreenProvider(dto.id),
          (_, _) {},
        );
        addTearDown(subscription.close);
        await pumpEventQueue();
        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailErrorPhase>(),
        ]);

        final retry = container
            .read(diseaseDetailScreenProvider(dto.id).notifier)
            .retry();

        Object.hashAll([
          container.read(diseaseDetailScreenProvider(dto.id)).phase,
          isA<DiseaseDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(diseaseDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DiseaseDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DiseaseDetailLoadedPhase).disease.id,
          dto.id,
        ]);

        expect(calls, 2);
      },
    );
  });
}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

final class _CountingBookmarksDao extends BookmarksDao {
  _CountingBookmarksDao(super.attachedDatabase);

  int insertCalls = 0;
  Future<void>? insertGate;

  @override
  Future<void> insertBookmark(BookmarksTableCompanion companion) async {
    insertCalls += 1;
    final gate = insertGate;
    if (gate != null) {
      insertGate = null;
      await gate;
    }
    await super.insertBookmark(companion);
  }
}

DiseaseDto _diseaseFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}

DioException _connectionError(String id) {
  return DioException(
    requestOptions: RequestOptions(path: '/v1/diseases/$id'),
    type: DioExceptionType.connectionError,
  );
}

DioException _badResponse(int statusCode) {
  final requestOptions = RequestOptions(path: '/v1/diseases/missing');
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
