import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_diagnosis_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiseaseDetailDiagnosisTab switches E8-E10 inner tabs', (
    tester,
  ) async {
    final disease = _diseaseFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DiseaseDetailDiagnosisTab(disease: disease)),
      ),
    );

    expect(find.text('診断基準'), findsWidgets);
    expect(
      find.text(disease.diagnosticCriteria.required.first),
      findsOneWidget,
    );

    await tester.tap(find.text('必須検査'));
    await tester.pump();
    expect(find.text(disease.requiredExams.first.name), findsOneWidget);

    await tester.tap(find.text('重症度分類'));
    await tester.pump();
    expect(find.text(disease.severityGrading!.gradingSystem), findsOneWidget);
  });
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
