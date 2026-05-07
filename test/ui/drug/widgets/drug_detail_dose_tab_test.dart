import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_dose_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailDoseTab renders D7-D9 Detail Spec panels', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(child: DrugDetailDoseTab(drug: drug)),
        ),
      ),
    );

    expect(find.byType(DetailPanel), findsNWidgets(3));
    expect(find.text('D7'), findsOneWidget);
    expect(find.text('効能・効果'), findsOneWidget);
    expect(find.text('D8'), findsOneWidget);
    expect(find.text('用法・用量'), findsOneWidget);
    expect(find.text('D9'), findsOneWidget);
    expect(find.text('用法・用量に関連する注意'), findsOneWidget);
    expect(find.text('標準'), findsOneWidget);
    expect(find.text(drug.dosage.standardDosage), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.byType(TabBar), findsOneWidget);
  });

  testWidgets('DrugDetailDoseTab switches D8 inner TabBar bodies', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(child: DrugDetailDoseTab(drug: drug)),
        ),
      ),
    );

    await tester.tap(find.text('年齢別'));
    await tester.pumpAndSettle();
    expect(tester.widget<Tab>(find.widgetWithText(Tab, '年齢別')).text, '年齢別');

    await tester.tap(find.text('腎機能'));
    await tester.pumpAndSettle();
    expect(tester.widget<Tab>(find.widgetWithText(Tab, '腎機能')).text, '腎機能');

    await tester.tap(find.text('肝機能'));
    await tester.pumpAndSettle();
    expect(tester.widget<Tab>(find.widgetWithText(Tab, '肝機能')).text, '肝機能');
  });

  testWidgets('DrugDetailDoseTab localizes hepatic severity enums', (
    tester,
  ) async {
    final drug = _drugFixture(
      hepaticSeverities: ['mild', 'moderate', 'severe'],
    ).toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(child: DrugDetailDoseTab(drug: drug)),
        ),
      ),
    );

    await tester.tap(find.text('肝機能'));
    await tester.pumpAndSettle();

    expect(find.textContaining('軽度:'), findsOneWidget);
    expect(find.textContaining('中等度:'), findsOneWidget);
    expect(find.textContaining('重度:'), findsOneWidget);
    expect(find.textContaining('mild:'), findsNothing);
    expect(find.textContaining('moderate:'), findsNothing);
    expect(find.textContaining('severe:'), findsNothing);
  });
}

DrugDto _drugFixture({List<String>? hepaticSeverities}) {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_drugs__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  if (hepaticSeverities != null) {
    final dosage = json['dosage'] as Map<String, dynamic>;
    dosage['hepatic_adjustment'] = [
      for (final severity in hepaticSeverities)
        {
          'severity': severity,
          'dose': '$severity dose',
        },
    ];
  }
  return DrugDto.fromJson(json);
}
