import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
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
          streamBookmarkStateProvider(
            'drug_001',
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DrugDetailView(id: 'drug_001'),
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
          streamBookmarkStateProvider(
            'drug_001',
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DrugDetailView(id: 'drug_001'),
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

  testWidgets('DrugDetailView shows loaded shell with header tabs and footer', (
    tester,
  ) async {
    final dto = _drugFixture();
    when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          drugApiClientProvider.overrideWithValue(apiClient),
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DrugDetailView(id: dto.id),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(
      tester
          .widget<Text>(
            find.byKey(const ValueKey('drug-detail-generic-name')),
          )
          .data,
      dto.genericName,
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(const ValueKey('drug-detail-brand-name')),
          )
          .data,
      dto.brandName,
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(const ValueKey('drug-detail-brand-name-kana')),
          )
          .data,
      dto.brandNameKana,
    );
    expect(find.text('概要'), findsWidgets);
    expect(find.text('用法・用量'), findsOneWidget);
    expect(find.text('ブックマークに追加'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
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
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
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
          streamBookmarkStateProvider(
            dto.id,
          ).overrideWith((ref) => const Stream<bool>.empty()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DrugDetailView(id: dto.id),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(
      tester
          .getSize(find.byKey(const ValueKey('drug-detail-active-tab-body')))
          .height,
      lessThanOrEqualTo(598),
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

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
