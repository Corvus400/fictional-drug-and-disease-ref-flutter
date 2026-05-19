import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../helpers/test_app_database.dart';

void main() {
  late AppDatabase db;
  late _MockDrugApiClient apiClient;
  late _MockBaseCacheManager cacheManager;

  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
    db = createTestAppDatabase();
  });

  setUp(() {
    apiClient = _MockDrugApiClient();
    cacheManager = _mockCacheManagerWithImage('drug-detail-view-hero.png');
  });

  tearDown(() async {
    await clearTestAppDatabase(db);
  });

  tearDownAll(() async {
    await db.close();
  });

  testWidgets('DrugDetailView shows shimmer skeleton while loading', (
    tester,
  ) async {
    final pending = Completer<DrugDto>();
    when(() => apiClient.getDrug('drug_001')).thenAnswer((_) => pending.future);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
          drugDetailHeroImageCacheManagerProvider.overrideWithValue(
            cacheManager,
          ),
          streamBookmarkStateProvider(
            'drug_001',
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const DrugDetailView(id: 'drug_001'),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Skeletonizer && widget.enabled,
      ),
      findsOneWidget,
    );

    pending.complete(_drugFixture());
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets(
    'DrugDetailView does not show visible loading copy while loading',
    (
      tester,
    ) async {
      final pending = Completer<DrugDto>();
      when(
        () => apiClient.getDrug('drug_001'),
      ).thenAnswer((_) => pending.future);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              'drug_001',
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const DrugDetailView(id: 'drug_001'),
          ),
        ),
      );

      expect(find.text('読み込み中'), findsNothing);

      pending.complete(_drugFixture());
      await tester.pump();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows network error message and retry action [assertion 1/2]',
    (
      tester,
    ) async {
      when(
        () => apiClient.getDrug('drug_001'),
      ).thenThrow(const SocketException('offline'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              'drug_001',
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const DrugDetailView(id: 'drug_001'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('ネットワークに接続できません'), findsOneWidget);
      Object.hashAll([find.text('再試行'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows network error message and retry action [assertion 2/2]',
    (
      tester,
    ) async {
      when(
        () => apiClient.getDrug('drug_001'),
      ).thenThrow(const SocketException('offline'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              'drug_001',
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const DrugDetailView(id: 'drug_001'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([find.text('ネットワークに接続できません'), findsOneWidget]);

      expect(find.text('再試行'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 1/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      ]);

      Object.hashAll([find.text('概要'), findsWidgets]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク'), findsOneWidget]);

      Object.hashAll([find.text('用量計算'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 2/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      );
      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      ]);

      Object.hashAll([find.text('概要'), findsWidgets]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク'), findsOneWidget]);

      Object.hashAll([find.text('用量計算'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 3/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      ]);

      expect(
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      );
      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      ]);

      Object.hashAll([find.text('概要'), findsWidgets]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク'), findsOneWidget]);

      Object.hashAll([find.text('用量計算'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 4/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      ]);

      expect(
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      );
      Object.hashAll([find.text('概要'), findsWidgets]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク'), findsOneWidget]);

      Object.hashAll([find.text('用量計算'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 5/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      ]);

      expect(find.text('概要'), findsWidgets);
      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク'), findsOneWidget]);

      Object.hashAll([find.text('用量計算'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 6/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      ]);

      Object.hashAll([find.text('概要'), findsWidgets]);

      expect(find.text('用法・用量'), findsOneWidget);
      Object.hashAll([find.text('ブックマーク'), findsOneWidget]);

      Object.hashAll([find.text('用量計算'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 7/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      ]);

      Object.hashAll([find.text('概要'), findsWidgets]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      expect(find.text('ブックマーク'), findsOneWidget);
      Object.hashAll([find.text('用量計算'), findsOneWidget]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView shows responsive shell with tabs and footer [assertion 8/8]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-layout')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-generic-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-brand-name-kana')),
        findsNothing,
      ]);

      Object.hashAll([find.text('概要'), findsWidgets]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク'), findsOneWidget]);

      expect(find.text('用量計算'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 1/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 2/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      );
      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 3/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      expect(
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 4/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.toolbarHeight, DetailConstants.appBarHeight);
      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 5/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      expect(
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      );
      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 6/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      expect(appBar.titleTextStyle?.fontWeight, FontWeight.w600);
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 7/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      expect(
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 8/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      );
      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 9/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      expect(firstNavIndex.data, '1');
      Object.hashAll([firstNavIndex.style?.fontWeight, FontWeight.w700]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView uses tablet two-pane layout at tablet width [assertion 10/10]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-shell')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
        findsOneWidget,
      ]);

      Object.hashAll([
        tester
            .widget<SizedBox>(
              find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
            )
            .width,
        240,
      ]);

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      Object.hashAll([appBar.toolbarHeight, DetailConstants.appBarHeight]);

      Object.hashAll([
        appBar.titleTextStyle?.fontSize,
        DetailConstants.appBarTitleFontSize,
      ]);

      Object.hashAll([appBar.titleTextStyle?.fontWeight, FontWeight.w600]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
        findsNWidgets(DrugDetailTab.values.length),
      ]);

      final firstNavIndex = tester.widget<Text>(
        find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
      );
      Object.hashAll([firstNavIndex.data, '1']);

      expect(firstNavIndex.style?.fontWeight, FontWeight.w700);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView D19 dose calculator button opens /calc [assertion 1/2]',
    (
      tester,
    ) async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final router = GoRouter(
        initialLocation: AppRoutes.drugDetail(dto.id),
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) => const SizedBox.shrink(),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) => DrugDetailView(
                  id: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.calc,
            builder: (context, state) => const Text('calc-target'),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light(),
            routerConfig: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('用量計算'));
      await tester.pumpAndSettle();

      expect(find.text('calc-target'), findsOneWidget);
      Object.hashAll([
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.calc,
      ]);
    },
  );

  testWidgets(
    'DrugDetailView D19 dose calculator button opens /calc [assertion 2/2]',
    (
      tester,
    ) async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      final router = GoRouter(
        initialLocation: AppRoutes.drugDetail(dto.id),
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) => const SizedBox.shrink(),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) => DrugDetailView(
                  id: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.calc,
            builder: (context, state) => const Text('calc-target'),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light(),
            routerConfig: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('用量計算'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('calc-target'), findsOneWidget]);

      expect(
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.calc,
      );
    },
  );

  testWidgets(
    'DrugDetailView swaps active tab body with AnimatedSwitcher [assertion 1/2]',
    (
      tester,
    ) async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('用法・用量'));
      await tester.pump();

      expect(
        find.byKey(const ValueKey('drug-detail-active-tab-switcher')),
        findsOneWidget,
      );
      Object.hashAll([
        find.descendant(
          of: find.byKey(const ValueKey('drug-detail-active-tab-body')),
          matching: find.text(dto.toDomain().dosage.standardDosage),
        ),
        findsOneWidget,
      ]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView swaps active tab body with AnimatedSwitcher [assertion 2/2]',
    (
      tester,
    ) async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('用法・用量'));
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-active-tab-switcher')),
        findsOneWidget,
      ]);

      expect(
        find.descendant(
          of: find.byKey(const ValueKey('drug-detail-active-tab-body')),
          matching: find.text(dto.toDomain().dosage.standardDosage),
        ),
        findsOneWidget,
      );

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView keeps active tab body within V2 height [assertion 1/2]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(
        find.byKey(const ValueKey('drug-detail-active-tab-body')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-phone-content-scroll')),
        findsOneWidget,
      ]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DrugDetailView keeps active tab body within V2 height [assertion 2/2]',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(apiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              cacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      Object.hashAll([
        find.byKey(const ValueKey('drug-detail-active-tab-body')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('detail-phone-content-scroll')),
        findsOneWidget,
      );

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

_MockBaseCacheManager _mockCacheManagerWithImage(String name) {
  final cacheManager = _MockBaseCacheManager();
  final imageFile = _writeTestImageFile(name);
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenAnswer((_) async => imageFile);
  return cacheManager;
}

file.File _writeTestImageFile(String name) {
  const fileSystem = LocalFileSystem();
  final ioFile = File('${Directory.systemTemp.path}/$name');
  final bytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAIAAAADCAYAAAC56t6BAAAAG0lEQVR4nGPQj978/'
    '86GG/8Z/gMBiMMA4oEAAPBbEzen1b62AAAAAElFTkSuQmCC',
  );
  ioFile.writeAsBytesSync(bytes);
  return fileSystem.file(ioFile.path);
}

DrugDto _drugFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_drugs__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}
