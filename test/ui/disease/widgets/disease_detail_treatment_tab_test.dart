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
  testWidgets('DiseaseDetailTreatmentTab renders E11 and E12', (tester) async {
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
    expect(find.text('E11'), findsOneWidget);
    expect(find.text('鑑別・合併症'), findsOneWidget);
    expect(find.byType(DetailKvRow), findsNWidgets(2));
    expect(find.text('鑑別'), findsOneWidget);
    expect(find.text(disease.differentialDiagnoses.join('、')), findsOneWidget);
    expect(find.text('合併症'), findsOneWidget);
    expect(find.text(disease.complications.join('、')), findsOneWidget);
    expect(find.text('E12'), findsOneWidget);
    expect(find.text('治療'), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byType(DetailExamTable), findsOneWidget);
    expect(find.text('薬物療法'), findsOneWidget);
    expect(find.text('非薬物療法'), findsOneWidget);
    expect(find.text('急性期プロトコル'), findsOneWidget);
    expect(
      find.text(disease.treatments.nonPharmacological.first.heading),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
      findsOneWidget,
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
