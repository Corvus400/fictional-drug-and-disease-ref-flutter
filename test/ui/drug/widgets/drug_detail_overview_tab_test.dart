import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_overview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailOverviewTab renders warning section from D3', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailOverviewTab(drug: drug)),
      ),
    );

    expect(find.text('警告'), findsOneWidget);
    expect(find.text(drug.warning.first.content), findsOneWidget);
  });

  testWidgets('DrugDetailOverviewTab renders therapeutic category from D4', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailOverviewTab(drug: drug)),
      ),
    );

    expect(find.text('薬効分類'), findsOneWidget);
    expect(find.text(drug.atcCode), findsOneWidget);
    expect(find.text(drug.therapeuticCategoryName), findsOneWidget);
    expect(find.text(drug.yjCode!), findsOneWidget);
  });

  testWidgets('DrugDetailOverviewTab renders composition from D5', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailOverviewTab(drug: drug)),
      ),
    );

    expect(find.text('組成・性状'), findsOneWidget);
    expect(find.text(drug.composition.activeIngredient), findsOneWidget);
    expect(find.text(drug.composition.appearance), findsOneWidget);
    expect(find.text(drug.composition.identificationCode!), findsOneWidget);
  });
}

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
