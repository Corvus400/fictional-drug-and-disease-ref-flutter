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
  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 1/11]',
    (
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
      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 2/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      expect(find.text('D7'), findsOneWidget);
      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 3/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      expect(find.text('効能・効果'), findsOneWidget);
      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 4/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      expect(find.text('D8'), findsOneWidget);
      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 5/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      expect(find.text('用法・用量'), findsOneWidget);
      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 6/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      expect(find.text('D9'), findsOneWidget);
      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 7/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      expect(find.text('用法・用量に関連する注意'), findsOneWidget);
      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 8/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      expect(find.text('標準'), findsOneWidget);
      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 9/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      expect(find.text(drug.dosage.standardDosage), findsOneWidget);
      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 10/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      expect(find.byType(ChoiceChip), findsNothing);
      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab renders D7-D9 Detail Spec panels [assertion 11/11]',
    (
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

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D7'), findsOneWidget]);

      Object.hashAll([find.text('効能・効果'), findsOneWidget]);

      Object.hashAll([find.text('D8'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量'), findsOneWidget]);

      Object.hashAll([find.text('D9'), findsOneWidget]);

      Object.hashAll([find.text('用法・用量に関連する注意'), findsOneWidget]);

      Object.hashAll([find.text('標準'), findsOneWidget]);

      Object.hashAll([find.text(drug.dosage.standardDosage), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      expect(find.byType(TabBar), findsOneWidget);
    },
  );

  testWidgets(
    'DrugDetailDoseTab switches D8 inner TabBar bodies [assertion 1/3]',
    (
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
      Object.hashAll([
        tester.widget<Tab>(find.widgetWithText(Tab, '腎機能')).text,
        '腎機能',
      ]);

      await tester.tap(find.text('肝機能'));
      await tester.pumpAndSettle();
      Object.hashAll([
        tester.widget<Tab>(find.widgetWithText(Tab, '肝機能')).text,
        '肝機能',
      ]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab switches D8 inner TabBar bodies [assertion 2/3]',
    (
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
      Object.hashAll([
        tester.widget<Tab>(find.widgetWithText(Tab, '年齢別')).text,
        '年齢別',
      ]);

      await tester.tap(find.text('腎機能'));
      await tester.pumpAndSettle();
      expect(tester.widget<Tab>(find.widgetWithText(Tab, '腎機能')).text, '腎機能');

      await tester.tap(find.text('肝機能'));
      await tester.pumpAndSettle();
      Object.hashAll([
        tester.widget<Tab>(find.widgetWithText(Tab, '肝機能')).text,
        '肝機能',
      ]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab switches D8 inner TabBar bodies [assertion 3/3]',
    (
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
      Object.hashAll([
        tester.widget<Tab>(find.widgetWithText(Tab, '年齢別')).text,
        '年齢別',
      ]);

      await tester.tap(find.text('腎機能'));
      await tester.pumpAndSettle();
      Object.hashAll([
        tester.widget<Tab>(find.widgetWithText(Tab, '腎機能')).text,
        '腎機能',
      ]);

      await tester.tap(find.text('肝機能'));
      await tester.pumpAndSettle();
      expect(tester.widget<Tab>(find.widgetWithText(Tab, '肝機能')).text, '肝機能');
    },
  );

  testWidgets(
    'DrugDetailDoseTab localizes hepatic severity enums [assertion 1/6]',
    (
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
      Object.hashAll([find.textContaining('中等度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('重度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('mild:'), findsNothing]);

      Object.hashAll([find.textContaining('moderate:'), findsNothing]);

      Object.hashAll([find.textContaining('severe:'), findsNothing]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab localizes hepatic severity enums [assertion 2/6]',
    (
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

      Object.hashAll([find.textContaining('軽度:'), findsOneWidget]);

      expect(find.textContaining('中等度:'), findsOneWidget);
      Object.hashAll([find.textContaining('重度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('mild:'), findsNothing]);

      Object.hashAll([find.textContaining('moderate:'), findsNothing]);

      Object.hashAll([find.textContaining('severe:'), findsNothing]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab localizes hepatic severity enums [assertion 3/6]',
    (
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

      Object.hashAll([find.textContaining('軽度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('中等度:'), findsOneWidget]);

      expect(find.textContaining('重度:'), findsOneWidget);
      Object.hashAll([find.textContaining('mild:'), findsNothing]);

      Object.hashAll([find.textContaining('moderate:'), findsNothing]);

      Object.hashAll([find.textContaining('severe:'), findsNothing]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab localizes hepatic severity enums [assertion 4/6]',
    (
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

      Object.hashAll([find.textContaining('軽度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('中等度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('重度:'), findsOneWidget]);

      expect(find.textContaining('mild:'), findsNothing);
      Object.hashAll([find.textContaining('moderate:'), findsNothing]);

      Object.hashAll([find.textContaining('severe:'), findsNothing]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab localizes hepatic severity enums [assertion 5/6]',
    (
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

      Object.hashAll([find.textContaining('軽度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('中等度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('重度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('mild:'), findsNothing]);

      expect(find.textContaining('moderate:'), findsNothing);
      Object.hashAll([find.textContaining('severe:'), findsNothing]);
    },
  );

  testWidgets(
    'DrugDetailDoseTab localizes hepatic severity enums [assertion 6/6]',
    (
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

      Object.hashAll([find.textContaining('軽度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('中等度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('重度:'), findsOneWidget]);

      Object.hashAll([find.textContaining('mild:'), findsNothing]);

      Object.hashAll([find.textContaining('moderate:'), findsNothing]);

      expect(find.textContaining('severe:'), findsNothing);
    },
  );
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
