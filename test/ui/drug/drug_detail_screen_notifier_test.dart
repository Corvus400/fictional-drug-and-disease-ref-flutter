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

    test(
      'initial state returns loading phase and overview tab [assertion 1/5]',
      () {
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
        Object.hashAll([state.activeTab, DrugDetailTab.overview]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 2/5]',
      () {
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

        Object.hashAll([state.phase, isA<DrugDetailLoadingPhase>()]);

        expect(state.activeTab, DrugDetailTab.overview);
        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 3/5]',
      () {
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

        Object.hashAll([state.phase, isA<DrugDetailLoadingPhase>()]);

        Object.hashAll([state.activeTab, DrugDetailTab.overview]);

        expect(state.isBookmarked, isFalse);
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 4/5]',
      () {
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

        Object.hashAll([state.phase, isA<DrugDetailLoadingPhase>()]);

        Object.hashAll([state.activeTab, DrugDetailTab.overview]);

        Object.hashAll([state.isBookmarked, isFalse]);

        expect(state.isBookmarkBusy, isFalse);
        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'initial state returns loading phase and overview tab [assertion 5/5]',
      () {
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

        Object.hashAll([state.phase, isA<DrugDetailLoadingPhase>()]);

        Object.hashAll([state.activeTab, DrugDetailTab.overview]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.isBookmarkBusy, isFalse]);

        expect(state.bookmarkError, isNull);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 1/5]',
      () async {
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
        Object.hashAll([phase.drug.id, dto.id]);

        Object.hashAll([phase.drug.brandName, dto.brandName]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.activeTab, DrugDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 2/5]',
      () async {
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
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        final phase = state.phase as DrugDetailLoadedPhase;
        expect(phase.drug.id, dto.id);
        Object.hashAll([phase.drug.brandName, dto.brandName]);

        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.activeTab, DrugDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 3/5]',
      () async {
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
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        final phase = state.phase as DrugDetailLoadedPhase;
        Object.hashAll([phase.drug.id, dto.id]);

        expect(phase.drug.brandName, dto.brandName);
        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.activeTab, DrugDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 4/5]',
      () async {
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
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        final phase = state.phase as DrugDetailLoadedPhase;
        Object.hashAll([phase.drug.id, dto.id]);

        Object.hashAll([phase.drug.brandName, dto.brandName]);

        expect(state.isBookmarked, isFalse);
        Object.hashAll([state.activeTab, DrugDetailTab.overview]);
      },
    );

    test(
      'load success maps detail and bookmark state [assertion 5/5]',
      () async {
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
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        final phase = state.phase as DrugDetailLoadedPhase;
        Object.hashAll([phase.drug.id, dto.id]);

        Object.hashAll([phase.drug.brandName, dto.brandName]);

        Object.hashAll([state.isBookmarked, isFalse]);

        expect(state.activeTab, DrugDetailTab.overview);
      },
    );

    test(
      'load network failure with bookmark maps error phase [assertion 1/3]',
      () async {
        final dto = _drugFixture();
        final drug = dto.toDomain();
        const snapshotCodec = DrugBookmarkSnapshotCodec();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(snapshotCodec.fromDrug(drug)),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        when(
          () => apiClient.getDrug(dto.id),
        ).thenThrow(_connectionError(dto.id));
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
        Object.hashAll([phase.error, isA<NetworkException>()]);

        Object.hashAll([state.activeTab, DrugDetailTab.overview]);
      },
    );

    test(
      'load network failure with bookmark maps error phase [assertion 2/3]',
      () async {
        final dto = _drugFixture();
        final drug = dto.toDomain();
        const snapshotCodec = DrugBookmarkSnapshotCodec();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(snapshotCodec.fromDrug(drug)),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        when(
          () => apiClient.getDrug(dto.id),
        ).thenThrow(_connectionError(dto.id));
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
        Object.hashAll([state.phase, isA<DrugDetailErrorPhase>()]);

        final phase = state.phase as DrugDetailErrorPhase;
        expect(phase.error, isA<NetworkException>());
        Object.hashAll([state.activeTab, DrugDetailTab.overview]);
      },
    );

    test(
      'load network failure with bookmark maps error phase [assertion 3/3]',
      () async {
        final dto = _drugFixture();
        final drug = dto.toDomain();
        const snapshotCodec = DrugBookmarkSnapshotCodec();
        await BookmarkRepository(db.bookmarksDao).insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(snapshotCodec.fromDrug(drug)),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );
        when(
          () => apiClient.getDrug(dto.id),
        ).thenThrow(_connectionError(dto.id));
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
        Object.hashAll([state.phase, isA<DrugDetailErrorPhase>()]);

        final phase = state.phase as DrugDetailErrorPhase;
        Object.hashAll([phase.error, isA<NetworkException>()]);

        expect(state.activeTab, DrugDetailTab.overview);
      },
    );

    test('load api failure maps error phase [assertion 1/4]', () async {
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
      Object.hashAll([phase.error, isA<ApiException>()]);

      Object.hashAll([state.isBookmarked, isFalse]);

      Object.hashAll([state.activeTab, DrugDetailTab.overview]);
    });

    test('load api failure maps error phase [assertion 2/4]', () async {
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
      Object.hashAll([state.phase, isA<DrugDetailErrorPhase>()]);

      final phase = state.phase as DrugDetailErrorPhase;
      expect(phase.error, isA<ApiException>());
      Object.hashAll([state.isBookmarked, isFalse]);

      Object.hashAll([state.activeTab, DrugDetailTab.overview]);
    });

    test('load api failure maps error phase [assertion 3/4]', () async {
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
      Object.hashAll([state.phase, isA<DrugDetailErrorPhase>()]);

      final phase = state.phase as DrugDetailErrorPhase;
      Object.hashAll([phase.error, isA<ApiException>()]);

      expect(state.isBookmarked, isFalse);
      Object.hashAll([state.activeTab, DrugDetailTab.overview]);
    });

    test('load api failure maps error phase [assertion 4/4]', () async {
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
      Object.hashAll([state.phase, isA<DrugDetailErrorPhase>()]);

      final phase = state.phase as DrugDetailErrorPhase;
      Object.hashAll([phase.error, isA<ApiException>()]);

      Object.hashAll([state.isBookmarked, isFalse]);

      expect(state.activeTab, DrugDetailTab.overview);
    });

    test(
      'select tab changes active tab without reloading detail [assertion 1/3]',
      () async {
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
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DrugDetailLoadedPhase).drug.id,
          dto.id,
        ]);

        verify(() => apiClient.getDrug(dto.id)).called(1);
      },
    );

    test(
      'select tab changes active tab without reloading detail [assertion 2/3]',
      () async {
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
        Object.hashAll([state.activeTab, DrugDetailTab.caution]);

        expect(state.phase, isA<DrugDetailLoadedPhase>());
        Object.hashAll([
          (state.phase as DrugDetailLoadedPhase).drug.id,
          dto.id,
        ]);

        verify(() => apiClient.getDrug(dto.id)).called(1);
      },
    );

    test(
      'select tab changes active tab without reloading detail [assertion 3/3]',
      () async {
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
        Object.hashAll([state.activeTab, DrugDetailTab.caution]);

        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        expect((state.phase as DrugDetailLoadedPhase).drug.id, dto.id);
        verify(() => apiClient.getDrug(dto.id)).called(1);
      },
    );

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

    test(
      'toggle bookmark sets busy state and updates result [assertion 1/4]',
      () async {
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
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.isBookmarked, isTrue]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'toggle bookmark sets busy state and updates result [assertion 2/4]',
      () async {
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

        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).isBookmarkBusy,
          isTrue,
        ]);

        await toggle;
        final state = container.read(drugDetailScreenProvider(dto.id));
        expect(state.isBookmarkBusy, isFalse);
        Object.hashAll([state.isBookmarked, isTrue]);

        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'toggle bookmark sets busy state and updates result [assertion 3/4]',
      () async {
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

        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).isBookmarkBusy,
          isTrue,
        ]);

        await toggle;
        final state = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        expect(state.isBookmarked, isTrue);
        Object.hashAll([state.bookmarkError, isNull]);
      },
    );

    test(
      'toggle bookmark sets busy state and updates result [assertion 4/4]',
      () async {
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

        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).isBookmarkBusy,
          isTrue,
        ]);

        await toggle;
        final state = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.isBookmarked, isTrue]);

        expect(state.bookmarkError, isNull);
      },
    );

    test(
      'toggle bookmark ignores second tap while busy [assertion 1/4]',
      () async {
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
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.bookmarkError, isNull]);

        final bookmark = await BookmarkRepository(db.bookmarksDao).findById(
          dto.id,
        );
        Object.hashAll([(bookmark as Ok).value, isNotNull]);
      },
    );

    test(
      'toggle bookmark ignores second tap while busy [assertion 2/4]',
      () async {
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
      'toggle bookmark ignores second tap while busy [assertion 3/4]',
      () async {
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
      'toggle bookmark ignores second tap while busy [assertion 4/4]',
      () async {
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
      'toggle bookmark failure clears busy and stores error [assertion 1/3]',
      () async {
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
        Object.hashAll([state.isBookmarked, isFalse]);

        Object.hashAll([state.bookmarkError, isA<StorageException>()]);
      },
    );

    test(
      'toggle bookmark failure clears busy and stores error [assertion 2/3]',
      () async {
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
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        expect(state.isBookmarked, isFalse);
        Object.hashAll([state.bookmarkError, isA<StorageException>()]);
      },
    );

    test(
      'toggle bookmark failure clears busy and stores error [assertion 3/3]',
      () async {
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
        Object.hashAll([state.isBookmarkBusy, isFalse]);

        Object.hashAll([state.isBookmarked, isFalse]);

        expect(state.bookmarkError, isA<StorageException>());
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 1/4]',
      () async {
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
        Object.hashAll([cleared.bookmarkError, isNull]);

        Object.hashAll([cleared.phase, same(failed.phase)]);

        Object.hashAll([cleared.isBookmarked, failed.isBookmarked]);
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 2/4]',
      () async {
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
        Object.hashAll([failed.bookmarkError, isA<StorageException>()]);

        container
            .read(drugDetailScreenProvider(dto.id).notifier)
            .clearBookmarkError();

        final cleared = container.read(drugDetailScreenProvider(dto.id));
        expect(cleared.bookmarkError, isNull);
        Object.hashAll([cleared.phase, same(failed.phase)]);

        Object.hashAll([cleared.isBookmarked, failed.isBookmarked]);
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 3/4]',
      () async {
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
        Object.hashAll([failed.bookmarkError, isA<StorageException>()]);

        container
            .read(drugDetailScreenProvider(dto.id).notifier)
            .clearBookmarkError();

        final cleared = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([cleared.bookmarkError, isNull]);

        expect(cleared.phase, same(failed.phase));
        Object.hashAll([cleared.isBookmarked, failed.isBookmarked]);
      },
    );

    test(
      'clear bookmark error clears only bookmark error [assertion 4/4]',
      () async {
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
        Object.hashAll([failed.bookmarkError, isA<StorageException>()]);

        container
            .read(drugDetailScreenProvider(dto.id).notifier)
            .clearBookmarkError();

        final cleared = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([cleared.bookmarkError, isNull]);

        Object.hashAll([cleared.phase, same(failed.phase)]);

        expect(cleared.isBookmarked, failed.isBookmarked);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 1/5]',
      () async {
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

        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DrugDetailLoadedPhase).drug.id,
          dto.id,
        ]);

        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 2/5]',
      () async {
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
        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailErrorPhase>(),
        ]);

        final retry = container
            .read(drugDetailScreenProvider(dto.id).notifier)
            .retry();

        expect(
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailLoadingPhase>(),
        );
        await retry;
        final state = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DrugDetailLoadedPhase).drug.id,
          dto.id,
        ]);

        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 3/5]',
      () async {
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
        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailErrorPhase>(),
        ]);

        final retry = container
            .read(drugDetailScreenProvider(dto.id).notifier)
            .retry();

        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(drugDetailScreenProvider(dto.id));
        expect(state.phase, isA<DrugDetailLoadedPhase>());
        Object.hashAll([
          (state.phase as DrugDetailLoadedPhase).drug.id,
          dto.id,
        ]);

        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 4/5]',
      () async {
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
        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailErrorPhase>(),
        ]);

        final retry = container
            .read(drugDetailScreenProvider(dto.id).notifier)
            .retry();

        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        expect((state.phase as DrugDetailLoadedPhase).drug.id, dto.id);
        Object.hashAll([calls, 2]);
      },
    );

    test(
      'retry returns to loading and reloads detail [assertion 5/5]',
      () async {
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
        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailErrorPhase>(),
        ]);

        final retry = container
            .read(drugDetailScreenProvider(dto.id).notifier)
            .retry();

        Object.hashAll([
          container.read(drugDetailScreenProvider(dto.id)).phase,
          isA<DrugDetailLoadingPhase>(),
        ]);

        await retry;
        final state = container.read(drugDetailScreenProvider(dto.id));
        Object.hashAll([state.phase, isA<DrugDetailLoadedPhase>()]);

        Object.hashAll([
          (state.phase as DrugDetailLoadedPhase).drug.id,
          dto.id,
        ]);

        expect(calls, 2);
      },
    );
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
        'type':
            'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/not-found',
        'title': 'Resource not found',
        'status': 404,
        'detail': 'missing',
      },
    ),
    type: DioExceptionType.badResponse,
  );
}
