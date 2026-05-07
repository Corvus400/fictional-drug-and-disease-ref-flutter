import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
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
    'dose': '用法・用量',
    'caution': '注意・併用',
    'adverse_effects': '副作用',
    'pharmacokinetics': '薬物動態',
    'related': '関連',
  };

  for (final entry in tabs.entries) {
    final tabKey = entry.key;
    final tabLabel = entry.value;

    runGoldenMatrix(
      fileNamePrefix: 'drug_$tabKey',
      description: 'Drug detail $tabKey',
      builder: (theme, size, scaler) {
        final dto = _drugFixture();
        final apiClient = _MockDrugApiClient();
        when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
        return ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(_db),
            drugApiClientProvider.overrideWithValue(apiClient),
            streamBookmarkStateProvider(
              dto.id,
            ).overrideWith((ref) => const Stream<bool>.empty()),
          ],
          child: MaterialApp(
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
