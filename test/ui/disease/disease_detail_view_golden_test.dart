import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_helpers.dart';
import '../../helpers/test_app_database.dart';

late AppDatabase _db;

void main() {
  setUpAll(() {
    _db = createTestAppDatabase();
  });

  tearDown(() async {
    await clearTestAppDatabase(_db);
  });

  tearDownAll(() async {
    await _db.close();
  });

  const tabs = <String, DiseaseDetailTab>{
    'overview': DiseaseDetailTab.overview,
    'diagnosis': DiseaseDetailTab.diagnosis,
    'treatment': DiseaseDetailTab.treatment,
    'clinical_course': DiseaseDetailTab.clinicalCourse,
    'related': DiseaseDetailTab.related,
  };

  for (final entry in tabs.entries) {
    final tabKey = entry.key;
    final tab = entry.value;

    runGoldenMatrix(
      fileNamePrefix: 'disease_$tabKey',
      description: 'Disease detail $tabKey',
      builder: (theme, size, scaler) {
        final dto = _diseaseFixture();
        final drugDto = _drugFixture();
        final apiClient = _MockDiseaseApiClient();
        final drugApiClient = _MockDrugApiClient();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        for (final id in dto.relatedDrugIds) {
          when(
            () => drugApiClient.getDrug(id),
          ).thenAnswer((_) async => drugDto);
        }
        return ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(_db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
            drugApiClientProvider.overrideWithValue(drugApiClient),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
            theme: theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DiseaseDetailView(id: dto.id),
          ),
        );
      },
      whilePerforming: (tester) async {
        await tester.pump();
        await tester.pump();
        for (final element in find.byType(DiseaseDetailView).evaluate()) {
          final container = ProviderScope.containerOf(element);
          container
              .read(diseaseDetailScreenProvider(_diseaseFixture().id).notifier)
              .selectTab(tab);
        }
        await tester.pumpAndSettle();
        return null;
      },
    );
  }
}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

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
