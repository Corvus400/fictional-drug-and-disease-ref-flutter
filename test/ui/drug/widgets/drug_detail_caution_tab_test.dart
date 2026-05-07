import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_caution_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailCautionTab switches D11 interaction inner tabs', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailCautionTab(drug: drug)),
      ),
    );

    expect(find.text('相互作用'), findsOneWidget);
    expect(find.text('併用禁忌'), findsOneWidget);
    expect(find.text('併用注意'), findsOneWidget);

    await tester.tap(find.text('併用注意'));
    await tester.pump();

    expect(
      tester
          .widget<ChoiceChip>(
            find.widgetWithText(ChoiceChip, '併用注意'),
          )
          .selected,
      isTrue,
    );
  });

  testWidgets('DrugDetailCautionTab renders D10 precautions as accordions', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailCautionTab(drug: drug)),
      ),
    );

    expect(find.text('特定背景患者'), findsOneWidget);
    expect(find.byType(ExpansionTile), findsWidgets);
    expect(find.text('小児等'), findsOneWidget);

    await tester.tap(find.text('小児等'));
    await tester.pumpAndSettle();

    expect(
      find.text(drug.precautionsForSpecificPopulations.first.note),
      findsOneWidget,
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
