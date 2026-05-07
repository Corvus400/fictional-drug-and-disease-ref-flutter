import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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

  _drugDetailGolden(
    description: 'Drug detail phone overview light',
    fileName: 'drug_p1_overview_light',
    theme: AppTheme.light(),
  );

  _drugDetailGolden(
    description: 'Drug detail phone overview dark',
    fileName: 'drug_p2_overview_dark',
    theme: AppTheme.dark(),
  );

  _drugDetailGolden(
    description: 'Drug detail phone dose light',
    fileName: 'drug_p3_dose_light',
    theme: AppTheme.light(),
    selectTabLabel: '用法・用量',
  );

  _drugDetailGolden(
    description: 'Drug detail phone dose dark',
    fileName: 'drug_p4_dose_dark',
    theme: AppTheme.dark(),
    selectTabLabel: '用法・用量',
  );
}

void _drugDetailGolden({
  required String description,
  required String fileName,
  required ThemeData theme,
  String? selectTabLabel,
}) {
  unawaited(
    goldenTest(
      description,
      fileName: fileName,
      constraints: const BoxConstraints.tightFor(width: 390, height: 844),
      builder: () {
        final dto = _drugFixture();
        final apiClient = _MockDrugApiClient();
        when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: fileName,
              child: SizedBox(
                width: 390,
                height: 844,
                child: ProviderScope(
                  overrides: [
                    appDatabaseProvider.overrideWithValue(_db),
                    drugApiClientProvider.overrideWithValue(apiClient),
                    streamBookmarkStateProvider(
                      dto.id,
                    ).overrideWith((ref) => const Stream<bool>.empty()),
                  ],
                  child: MaterialApp(
                    theme: theme,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    home: DrugDetailView(id: dto.id),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      whilePerforming: (tester) async {
        await tester.pump();
        await tester.pump();
        if (selectTabLabel != null) {
          await tester.tap(find.text(selectTabLabel));
          await tester.pump(const Duration(milliseconds: 250));
        }
        return null;
      },
      tags: ['golden'],
    ),
  );
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
