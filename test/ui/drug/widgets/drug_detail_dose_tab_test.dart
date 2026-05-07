import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_dose_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailDoseTab renders standard dosage from D8', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailDoseTab(drug: drug)),
      ),
    );

    expect(find.text('用法・用量'), findsOneWidget);
    expect(find.text('標準'), findsOneWidget);
    expect(find.text(drug.dosage.standardDosage), findsOneWidget);
  });

  testWidgets('DrugDetailDoseTab switches D8 inner tab bodies', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailDoseTab(drug: drug)),
      ),
    );

    await tester.tap(find.text('年齢別'));
    await tester.pump();
    expect(
      tester
          .widget<ChoiceChip>(
            find.widgetWithText(ChoiceChip, '年齢別'),
          )
          .selected,
      isTrue,
    );

    await tester.tap(find.text('腎機能'));
    await tester.pump();
    expect(
      tester
          .widget<ChoiceChip>(
            find.widgetWithText(ChoiceChip, '腎機能'),
          )
          .selected,
      isTrue,
    );

    await tester.tap(find.text('肝機能'));
    await tester.pump();
    expect(
      tester
          .widget<ChoiceChip>(
            find.widgetWithText(ChoiceChip, '肝機能'),
          )
          .selected,
      isTrue,
    );
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
