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
  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 1/25]',
    (
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
      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 2/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      expect(find.byType(DetailPanel), findsNWidgets(5));
      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 3/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      expect(find.text('E6'), findsOneWidget);
      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 4/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      expect(find.text('原因・病態'), findsOneWidget);
      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 5/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      expect(find.byType(DetailMarkdownBody), findsWidgets);
      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 6/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      expect(find.text('E7'), findsOneWidget);
      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 7/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      expect(find.text('症状'), findsOneWidget);
      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 8/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      expect(find.byType(DetailBadge), findsWidgets);
      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 9/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      expect(find.text(disease.symptoms.mainSymptoms.first), findsOneWidget);
      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 10/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      expect(
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      );
      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 11/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      expect(find.textContaining('発症パターン'), findsWidgets);
      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 12/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      expect(find.text('E8'), findsOneWidget);
      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 13/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      expect(find.text('診断基準'), findsWidgets);
      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 14/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      expect(
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      );
      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 15/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      expect(
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      );
      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 16/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      expect(find.text(disease.diagnosticCriteria.notes!), findsOneWidget);
      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 17/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      expect(find.text('E9'), findsOneWidget);
      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 18/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      expect(find.text('必須検査'), findsOneWidget);
      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 19/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      expect(find.byType(DetailExamTable), findsOneWidget);
      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 20/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      expect(find.text(disease.requiredExams.first.name), findsOneWidget);
      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 21/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      expect(find.text('問診'), findsOneWidget);
      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 22/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      expect(find.text('E10'), findsOneWidget);
      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 23/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      expect(find.text('重症度分類'), findsOneWidget);
      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 24/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      expect(
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      );
      Object.hashAll([
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailDiagnosisTab renders E6-E10 Detail Spec panels [assertion 25/25]',
    (
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

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(5)]);

      Object.hashAll([find.text('E6'), findsOneWidget]);

      Object.hashAll([find.text('原因・病態'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      Object.hashAll([find.text('E7'), findsOneWidget]);

      Object.hashAll([find.text('症状'), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([
        find.text(disease.symptoms.mainSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.symptoms.associatedSymptoms.first),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining('発症パターン'), findsWidgets]);

      Object.hashAll([find.text('E8'), findsOneWidget]);

      Object.hashAll([find.text('診断基準'), findsWidgets]);

      Object.hashAll([
        find.textContaining(disease.diagnosticCriteria.required.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.supporting.first),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(disease.diagnosticCriteria.notes!),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E9'), findsOneWidget]);

      Object.hashAll([find.text('必須検査'), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([
        find.text(disease.requiredExams.first.name),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('問診'), findsOneWidget]);

      Object.hashAll([find.text('E10'), findsOneWidget]);

      Object.hashAll([find.text('重症度分類'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(disease.severityGrading!.gradingSystem),
        findsOneWidget,
      ]);

      expect(
        find.byType(DetailSeverityGrade),
        findsNWidgets(disease.severityGrading!.grades.length),
      );
    },
  );
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
