import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_config.dart';
import '../../golden/golden_test_helpers.dart';
import '../../helpers/test_app_database.dart';

late AppDatabase _db;

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
    _db = createTestAppDatabase();
  });

  tearDown(() async {
    await clearTestAppDatabase(_db);
  });

  tearDownAll(() async {
    await _db.close();
  });

  _detailStateGolden(
    fileNamePrefix: 'drug_loading',
    description: 'Drug detail loading',
    builder: (theme, size, scaler) {
      final apiClient = _MockDrugApiClient();
      final pending = Completer<DrugDto>();
      when(() => apiClient.getDrug('drug_001')).thenAnswer(
        (_) => pending.future,
      );
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugApiClientProvider.overrideWithValue(apiClient),
          drugDetailHeroImageCacheManagerProvider.overrideWithValue(
            _mockCacheManagerWithImage('drug-detail-loading.png'),
          ),
          streamBookmarkStateProvider(
            'drug_001',
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const DrugDetailView(id: 'drug_001'),
        ),
      );
    },
    whilePerforming: (tester) async => tester.pump(),
  );

  _detailStateGolden(
    fileNamePrefix: 'drug_error',
    description: 'Drug detail error',
    builder: (theme, size, scaler) {
      final apiClient = _MockDrugApiClient();
      when(() => apiClient.getDrug('drug_001')).thenThrow(
        const SocketException('offline'),
      );
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugApiClientProvider.overrideWithValue(apiClient),
          drugDetailHeroImageCacheManagerProvider.overrideWithValue(
            _mockCacheManagerWithImage('drug-detail-error.png'),
          ),
          streamBookmarkStateProvider(
            'drug_001',
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const DrugDetailView(id: 'drug_001'),
        ),
      );
    },
    whilePerforming: (tester) async {
      await tester.pump();
      await tester.pump();
    },
  );

  const tabs = <String, DrugDetailTab>{
    'overview': DrugDetailTab.overview,
    'dose': DrugDetailTab.dose,
    'caution': DrugDetailTab.caution,
    'adverse_effects': DrugDetailTab.adverseEffects,
    'pharmacokinetics': DrugDetailTab.pharmacokinetics,
    'related': DrugDetailTab.related,
  };

  for (final entry in tabs.entries) {
    final tabKey = entry.key;
    final tab = entry.value;

    runGoldenMatrix(
      fileNamePrefix: 'drug_$tabKey',
      description: 'Drug detail $tabKey',
      builder: (theme, size, scaler) {
        final dto = _drugFixture();
        final diseaseDto = _diseaseFixture();
        final apiClient = _MockDrugApiClient();
        final diseaseApiClient = _MockDiseaseApiClient();
        final imageCacheManager = _mockCacheManagerWithImage(
          'drug-detail-golden-$tabKey.png',
        );
        when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
        for (final id in dto.relatedDiseaseIds) {
          when(
            () => diseaseApiClient.getDisease(id),
          ).thenAnswer((_) async => diseaseDto);
        }
        return ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(_db),
            drugApiClientProvider.overrideWithValue(apiClient),
            diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
            drugDetailHeroImageCacheManagerProvider.overrideWithValue(
              imageCacheManager,
            ),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DrugDetailView(id: dto.id),
          ),
        );
      },
      whilePerforming: (tester) async {
        await tester.pump();
        await tester.pump();
        for (final element in find.byType(DrugDetailView).evaluate()) {
          final container = ProviderScope.containerOf(element);
          container
              .read(drugDetailScreenProvider(_drugFixture().id).notifier)
              .selectTab(tab);
        }
        await tester.pumpAndSettle();
        return null;
      },
    );
  }

  final bookmarkControllers = <StreamController<bool>>[];
  runGoldenMatrix(
    fileNamePrefix: 'drug_overview_bookmarked',
    description: 'Drug detail bookmarked overview',
    builder: (theme, size, scaler) {
      final dto = _drugFixture();
      final apiClient = _MockDrugApiClient();
      final imageCacheManager = _mockCacheManagerWithImage(
        'drug-detail-bookmarked-overview.png',
      );
      final bookmarkController = StreamController<bool>();
      bookmarkControllers.add(bookmarkController);
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugApiClientProvider.overrideWithValue(apiClient),
          drugDetailHeroImageCacheManagerProvider.overrideWithValue(
            imageCacheManager,
          ),
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => bookmarkController.stream),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DrugDetailView(id: dto.id),
        ),
      );
    },
    whilePerforming: (tester) async {
      await tester.pump();
      await tester.pumpAndSettle();
      for (final controller in bookmarkControllers) {
        controller.add(true);
      }
      await tester.pumpAndSettle();
      expect(find.text('ブックマーク'), findsNothing);
      expect(
        find.text('ブックマーク済み'),
        findsNWidgets(_goldenMatrixScenarioCount),
      );
      for (final controller in bookmarkControllers) {
        await controller.close();
      }
      bookmarkControllers.clear();
      return null;
    },
  );
}

int get _goldenMatrixScenarioCount =>
    GoldenMatrix.sizes.length * GoldenMatrix.textScalers.length;

void _detailStateGolden({
  required String fileNamePrefix,
  required String description,
  required Widget Function(ThemeData theme, Size size, TextScaler scaler)
  builder,
  required Future<void> Function(WidgetTester tester) whilePerforming,
}) {
  const size = Size(390, 844);
  for (final MapEntry(key: themeName, value: theme) in {
    'light': AppTheme.light(),
    'dark': AppTheme.dark(),
  }.entries) {
    testWidgets(
      '$description / $themeName',
      (tester) async {
        await tester.binding.setSurfaceSize(size);
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final rootKey = ValueKey<String>('$fileNamePrefix-$themeName-root');

        await tester.pumpWidget(
          RepaintBoundary(
            key: rootKey,
            child: MediaQuery(
              data: const MediaQueryData(
                size: size,
                devicePixelRatio: GoldenMatrix.devicePixelRatio,
                textScaler: TextScaler.noScaling,
              ),
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: builder(theme, size, TextScaler.noScaling),
              ),
            ),
          ),
        );
        await whilePerforming(tester);

        await expectLater(
          find.byKey(rootKey),
          matchesGoldenFile('goldens/macos/${fileNamePrefix}_$themeName.png'),
        );

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      },
      tags: const ['golden'],
    );
  }
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

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

DiseaseDto _diseaseFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_diseases__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}
