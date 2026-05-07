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

  testWidgets('DrugDetailView shows progress indicator while loading', (
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

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    pending.complete(_drugFixture());
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('DrugDetailView shows network error message and retry action', (
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
    expect(find.text('再試行'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('DrugDetailView shows responsive shell with tabs and footer', (
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
    expect(
      find.byKey(const ValueKey('drug-detail-generic-name')),
      findsNothing,
    );
    expect(find.byKey(const ValueKey('drug-detail-brand-name')), findsNothing);
    expect(
      find.byKey(const ValueKey('drug-detail-brand-name-kana')),
      findsNothing,
    );
    expect(find.text('概要'), findsWidgets);
    expect(find.text('用法・用量'), findsOneWidget);
    expect(find.text('ブックマーク'), findsOneWidget);
    expect(find.text('用量計算'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('DrugDetailView uses tablet two-pane layout at tablet width', (
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
    expect(
      find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
      findsOneWidget,
    );
    expect(
      tester
          .widget<SizedBox>(
            find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
          )
          .width,
      240,
    );
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.toolbarHeight, DetailConstants.appBarHeight);
    expect(
      appBar.titleTextStyle?.fontSize,
      DetailConstants.appBarTitleFontSize,
    );
    expect(appBar.titleTextStyle?.fontWeight, FontWeight.w600);
    expect(
      find.byKey(const ValueKey<String>('detail-tablet-nav-header')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('detail-tablet-nav-index')),
      findsNWidgets(DrugDetailTab.values.length),
    );
    final firstNavIndex = tester.widget<Text>(
      find.byKey(const ValueKey<String>('detail-tablet-nav-index')).first,
    );
    expect(firstNavIndex.data, '1');
    expect(firstNavIndex.style?.fontWeight, FontWeight.w700);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('DrugDetailView D19 dose calculator button opens /calc', (
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
    expect(
      router.routerDelegate.currentConfiguration.last.matchedLocation,
      AppRoutes.calc,
    );
  });

  testWidgets('DrugDetailView swaps active tab body with AnimatedSwitcher', (
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
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('drug-detail-active-tab-body')),
        matching: find.text(dto.toDomain().dosage.standardDosage),
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('DrugDetailView keeps active tab body within V2 height', (
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
    expect(
      find.byKey(const ValueKey<String>('detail-phone-content-scroll')),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
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
