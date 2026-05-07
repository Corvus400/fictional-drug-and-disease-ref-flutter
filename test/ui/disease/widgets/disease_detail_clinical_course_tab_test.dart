import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_clinical_course_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiseaseDetailClinicalCourseTab renders E13 and E14', (
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
            child: DiseaseDetailClinicalCourseTab(disease: disease),
          ),
        ),
      ),
    );

    expect(find.byType(DetailPanel), findsNWidgets(2));
    expect(find.text('E13'), findsOneWidget);
    expect(find.text('予後'), findsOneWidget);
    expect(find.text(disease.prognosis!), findsOneWidget);
    expect(find.text('E14'), findsOneWidget);
    expect(find.text('予防'), findsOneWidget);
    expect(find.textContaining('1.'), findsOneWidget);
    expect(find.text(disease.prevention.first), findsOneWidget);
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
