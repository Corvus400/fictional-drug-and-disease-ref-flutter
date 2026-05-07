import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
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

  const tabs = <String, String?>{
    'overview': null,
    'diagnosis': '診断',
    'treatment': '治療',
    'clinical_course': '経過',
    'related': '関連',
  };

  for (final entry in tabs.entries) {
    final tabKey = entry.key;
    final tabLabel = entry.value;

    runGoldenMatrix(
      fileNamePrefix: 'disease_$tabKey',
      description: 'Disease detail $tabKey',
      builder: (theme, size, scaler) {
        final dto = _diseaseFixture();
        final apiClient = _MockDiseaseApiClient();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        return ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(_db),
            diseaseApiClientProvider.overrideWithValue(apiClient),
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
        if (tabLabel != null) {
          final tabFinder = find.text(tabLabel);
          final count = tabFinder.evaluate().length;
          for (var index = 0; index < count; index++) {
            await tester.tap(tabFinder.at(index), warnIfMissed: false);
            await tester.pump(const Duration(milliseconds: 250));
          }
        }
        return null;
      },
    );
  }
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
