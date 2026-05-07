import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_view.dart';
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

  _diseaseDetailGolden(
    description: 'Disease detail phone overview light',
    fileName: 'disease_p1_overview_light',
    theme: AppTheme.light(),
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone overview dark',
    fileName: 'disease_p2_overview_dark',
    theme: AppTheme.dark(),
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone diagnosis light',
    fileName: 'disease_p3_diagnosis_light',
    theme: AppTheme.light(),
    selectTabLabel: '診断',
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone diagnosis dark',
    fileName: 'disease_p4_diagnosis_dark',
    theme: AppTheme.dark(),
    selectTabLabel: '診断',
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone treatment light',
    fileName: 'disease_p5_treatment_light',
    theme: AppTheme.light(),
    selectTabLabel: '治療',
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone treatment dark',
    fileName: 'disease_p6_treatment_dark',
    theme: AppTheme.dark(),
    selectTabLabel: '治療',
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone clinical course light',
    fileName: 'disease_p7_clinical_course_light',
    theme: AppTheme.light(),
    selectTabLabel: '経過',
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone clinical course dark',
    fileName: 'disease_p8_clinical_course_dark',
    theme: AppTheme.dark(),
    selectTabLabel: '経過',
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone related light',
    fileName: 'disease_p9_related_light',
    theme: AppTheme.light(),
    selectTabLabel: '関連',
  );

  _diseaseDetailGolden(
    description: 'Disease detail phone related dark',
    fileName: 'disease_p10_related_dark',
    theme: AppTheme.dark(),
    selectTabLabel: '関連',
  );

  _diseaseDetailGolden(
    description: 'Disease detail tablet overview light',
    fileName: 'disease_t1_overview_light',
    theme: AppTheme.light(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
  );

  _diseaseDetailGolden(
    description: 'Disease detail tablet overview dark',
    fileName: 'disease_t2_overview_dark',
    theme: AppTheme.dark(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
  );

  _diseaseDetailGolden(
    description: 'Disease detail tablet diagnosis light',
    fileName: 'disease_t3_diagnosis_light',
    theme: AppTheme.light(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    selectTabLabel: '診断',
  );

  _diseaseDetailGolden(
    description: 'Disease detail tablet diagnosis dark',
    fileName: 'disease_t4_diagnosis_dark',
    theme: AppTheme.dark(),
    constraints: const BoxConstraints.tightFor(width: 834, height: 1194),
    selectTabLabel: '診断',
  );
}

void _diseaseDetailGolden({
  required String description,
  required String fileName,
  required ThemeData theme,
  BoxConstraints constraints = const BoxConstraints.tightFor(
    width: 390,
    height: 844,
  ),
  String? selectTabLabel,
}) {
  unawaited(
    goldenTest(
      description,
      fileName: fileName,
      constraints: constraints,
      builder: () {
        final dto = _diseaseFixture();
        final apiClient = _MockDiseaseApiClient();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: fileName,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: ProviderScope(
                  overrides: [
                    appDatabaseProvider.overrideWithValue(_db),
                    diseaseApiClientProvider.overrideWithValue(apiClient),
                    streamBookmarkStateProvider(
                      dto.id,
                    ).overrideWith((ref) => const Stream<bool>.empty()),
                  ],
                  child: MaterialApp(
                    theme: theme,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    home: DiseaseDetailView(id: dto.id),
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
