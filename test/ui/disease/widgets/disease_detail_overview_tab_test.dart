import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_overview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiseaseDetailOverviewTab renders E3 and E4', (tester) async {
    final disease = _diseaseFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DiseaseDetailOverviewTab(disease: disease)),
      ),
    );

    expect(find.text('同義語'), findsOneWidget);
    expect(find.text(disease.synonyms.first), findsOneWidget);
    expect(find.text('概要'), findsOneWidget);
    expect(find.text(disease.summary), findsOneWidget);
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
