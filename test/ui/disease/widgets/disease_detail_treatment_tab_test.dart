import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_treatment_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 1/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      expect(find.byType(DetailPanel), findsNWidgets(2));
      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 2/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      expect(find.text('E11'), findsOneWidget);
      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 3/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      expect(find.text('鑑別・合併症'), findsOneWidget);
      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 4/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      expect(find.byType(DetailKvRow), findsNWidgets(2));
      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 5/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      expect(find.text('鑑別'), findsOneWidget);
      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 6/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      expect(
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      );
      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 7/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      expect(find.text('合併症'), findsOneWidget);
      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 8/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      expect(find.text(disease.complications.join('、')), findsOneWidget);
      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 9/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      expect(find.text('E12'), findsOneWidget);
      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 10/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      expect(find.text('治療'), findsOneWidget);
      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 11/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      expect(find.byType(TabBar), findsOneWidget);
      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 12/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      expect(find.byType(DetailExamTable), findsOneWidget);
      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 13/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      expect(find.text('薬物療法'), findsOneWidget);
      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 14/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      expect(find.text('非薬物療法'), findsOneWidget);
      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 15/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      expect(find.text('急性期プロトコル'), findsOneWidget);
      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 16/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      expect(
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 17/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailTreatmentTab renders E11 and E12 [assertion 18/18]',
    (tester) async {
      final disease = _diseaseFixture().toDomain();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DiseaseDetailTreatmentTab(disease: disease),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('E11'), findsOneWidget]);

      Object.hashAll([find.text('鑑別・合併症'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsNWidgets(2)]);

      Object.hashAll([find.text('鑑別'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.differentialDiagnoses.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('合併症'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.complications.join('、')),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('E12'), findsOneWidget]);

      Object.hashAll([find.text('治療'), findsOneWidget]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);

      Object.hashAll([find.byType(DetailExamTable), findsOneWidget]);

      Object.hashAll([find.text('薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('非薬物療法'), findsOneWidget]);

      Object.hashAll([find.text('急性期プロトコル'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.treatments.nonPharmacological.first.heading),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
        findsNothing,
      ]);

      expect(
        find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
        findsOneWidget,
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
