import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_pharmacokinetics_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailPharmacokineticsTab renders D15 as accordions', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DrugDetailPharmacokineticsTab(drug: drug)),
      ),
    );

    expect(find.text('補足情報'), findsOneWidget);
    expect(find.byType(ExpansionTile), findsWidgets);
    expect(find.text('過量投与'), findsOneWidget);

    await tester.tap(find.text('過量投与'));
    await tester.pumpAndSettle();

    expect(find.text(drug.overdose!.symptoms), findsOneWidget);
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
