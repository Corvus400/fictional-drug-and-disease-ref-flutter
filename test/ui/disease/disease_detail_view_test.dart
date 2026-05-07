import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
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

  testWidgets('DiseaseDetailView shows progress indicator while loading', (
    tester,
  ) async {
    final pending = Completer<DiseaseDto>();
    when(
      () => apiClient.getDisease('disease_001'),
    ).thenAnswer((_) => pending.future);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
          streamBookmarkStateProvider(
            'disease_001',
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DiseaseDetailView(id: 'disease_001'),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    pending.complete(_diseaseFixture());
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets(
    'DiseaseDetailView shows network error message and retry action',
    (
      tester,
    ) async {
      when(
        () => apiClient.getDisease('disease_001'),
      ).thenThrow(const SocketException('offline'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
            streamBookmarkStateProvider(
              'disease_001',
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DiseaseDetailView(id: 'disease_001'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('ネットワークに接続できません'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets(
    'DiseaseDetailView shows loaded shell with header tabs and footer',
    (tester) async {
      final dto = _diseaseFixture();
      when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DiseaseDetailView(id: dto.id),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      final disease = dto.toDomain();
      expect(find.text(disease.name), findsOneWidget);
      expect(find.text(disease.nameKana), findsOneWidget);
      expect(find.text('概要'), findsWidgets);
      expect(find.text('診断'), findsOneWidget);
      expect(find.text('ブックマークに追加'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );

  testWidgets('DiseaseDetailView swaps active tab body with AnimatedSwitcher', (
    tester,
  ) async {
    final dto = _diseaseFixture();
    when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DiseaseDetailView(id: dto.id),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('治療'));
    await tester.pump();

    expect(
      find.byKey(const ValueKey('disease-detail-active-tab-switcher')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('disease-detail-active-tab-body')),
        matching: find.text('治療'),
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('DiseaseDetailView keeps active tab body within V2 height', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final dto = _diseaseFixture();
    when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          diseaseApiClientProvider.overrideWithValue(apiClient),
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DiseaseDetailView(id: dto.id),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(
      tester
          .getSize(find.byKey(const ValueKey('disease-detail-active-tab-body')))
          .height,
      lessThanOrEqualTo(598),
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

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
