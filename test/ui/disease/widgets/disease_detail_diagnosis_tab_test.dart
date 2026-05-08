import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_severity_grade.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_diagnosis_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels', (
    tester,
  ) async {
    final disease = _diseaseFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: DiseaseDetailDiagnosisTab(disease: disease),
          ),
        ),
      ),
    );

    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.byType(DetailPanel), findsNWidgets(5));
    expect(find.text('E6'), findsOneWidget);
    expect(find.text('原因・病態'), findsOneWidget);
    expect(find.byType(DetailMarkdownBody), findsWidgets);
    expect(find.text('E7'), findsOneWidget);
    expect(find.text('症状'), findsOneWidget);
    expect(find.byType(DetailBadge), findsWidgets);
    expect(find.text(disease.symptoms.mainSymptoms.first), findsOneWidget);
    expect(
      find.text(disease.symptoms.associatedSymptoms.first),
      findsOneWidget,
    );
    expect(find.textContaining('発症パターン'), findsWidgets);
    expect(find.text('E8'), findsOneWidget);
    expect(find.text('診断基準'), findsWidgets);
    expect(
      find.textContaining(disease.diagnosticCriteria.required.first),
      findsOneWidget,
    );
    expect(
      find.text(disease.diagnosticCriteria.supporting.first),
      findsOneWidget,
    );
    expect(find.text(disease.diagnosticCriteria.notes!), findsOneWidget);
    expect(find.text('E9'), findsOneWidget);
    expect(find.text('必須検査'), findsOneWidget);
    expect(find.byType(DetailExamTable), findsOneWidget);
    expect(find.text(disease.requiredExams.first.name), findsOneWidget);
    expect(find.text('問診'), findsOneWidget);
    expect(find.text('E10'), findsOneWidget);
    expect(find.text('重症度分類'), findsOneWidget);
    expect(
      find.textContaining(disease.severityGrading!.gradingSystem),
      findsOneWidget,
    );
    expect(
      find.byType(DetailSeverityGrade),
      findsNWidgets(disease.severityGrading!.grades.length),
    );
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
