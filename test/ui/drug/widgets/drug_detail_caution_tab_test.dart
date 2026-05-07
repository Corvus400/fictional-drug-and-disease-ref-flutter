import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_caution_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailCautionTab renders D6-D11 Detail Spec panels', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(child: DrugDetailCautionTab(drug: drug)),
        ),
      ),
    );

    expect(find.byType(DetailPanel), findsNWidgets(3));
    expect(find.text('D6'), findsOneWidget);
    expect(find.text('禁忌'), findsOneWidget);
    expect(
      find.textContaining(drug.contraindications.first.content),
      findsOneWidget,
    );
    expect(find.text('D10'), findsOneWidget);
    expect(find.text('特定の背景を有する患者への注意'), findsOneWidget);
    expect(find.byType(DetailAccordion), findsNWidgets(7));
    expect(find.byType(ExpansionTile), findsNothing);
    expect(find.text('D11'), findsOneWidget);
    expect(find.text('相互作用'), findsOneWidget);
    expect(find.text('併用禁忌（0）'), findsOneWidget);
    expect(find.text('併用注意（0）'), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.byType(TabBar), findsOneWidget);
  });

  testWidgets('DrugDetailCautionTab switches D11 interaction inner TabBar', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(child: DrugDetailCautionTab(drug: drug)),
        ),
      ),
    );

    await tester.ensureVisible(find.text('併用注意（0）'));
    await tester.tap(find.text('併用注意（0）'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<Tab>(find.widgetWithText(Tab, '併用注意（0）')).text,
      '併用注意（0）',
    );
  });

  testWidgets('DrugDetailCautionTab opens D10 precautions as accordions', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(child: DrugDetailCautionTab(drug: drug)),
        ),
      ),
    );

    expect(find.text('特定の背景を有する患者への注意'), findsOneWidget);
    expect(find.byType(DetailAccordion), findsNWidgets(7));
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
