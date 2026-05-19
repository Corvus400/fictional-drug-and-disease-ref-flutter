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
  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 1/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      expect(find.byType(DetailPanel), findsNWidgets(3));
      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 2/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      expect(find.text('D6'), findsOneWidget);
      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 3/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      expect(find.text('禁忌'), findsOneWidget);
      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 4/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      expect(
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      );
      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 5/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      expect(find.text('D10'), findsOneWidget);
      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 6/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      expect(find.text('特定の背景を有する患者への注意'), findsOneWidget);
      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 7/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      expect(find.byType(DetailAccordion), findsNWidgets(7));
      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 8/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      expect(find.byType(ExpansionTile), findsNothing);
      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 9/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      expect(find.text('該当なし'), findsNWidgets(6));
      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 10/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      expect(find.text('D11'), findsOneWidget);
      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 11/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      expect(find.text('相互作用'), findsOneWidget);
      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 12/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      expect(find.text('併用禁忌（0）'), findsOneWidget);
      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 13/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      expect(find.text('併用注意（0）'), findsOneWidget);
      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 14/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      expect(find.byType(ChoiceChip), findsNothing);
      Object.hashAll([find.byType(TabBar), findsOneWidget]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab renders D6-D11 Detail Spec panels [assertion 15/15]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('D6'), findsOneWidget]);

      Object.hashAll([find.text('禁忌'), findsOneWidget]);

      Object.hashAll([
        find.textContaining(drug.contraindications.first.content),
        findsOneWidget,
      ]);

      Object.hashAll([find.text('D10'), findsOneWidget]);

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([find.text('D11'), findsOneWidget]);

      Object.hashAll([find.text('相互作用'), findsOneWidget]);

      Object.hashAll([find.text('併用禁忌（0）'), findsOneWidget]);

      Object.hashAll([find.text('併用注意（0）'), findsOneWidget]);

      Object.hashAll([find.byType(ChoiceChip), findsNothing]);

      expect(find.byType(TabBar), findsOneWidget);
    },
  );

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

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 1/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      expect(find.text('特定の背景を有する患者への注意'), findsOneWidget);
      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.text('小児等'), findsOneWidget]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 2/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      expect(find.byType(DetailAccordion), findsNWidgets(7));
      Object.hashAll([find.text('小児等'), findsOneWidget]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 3/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      expect(find.text('小児等'), findsOneWidget);
      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 4/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.text('小児等'), findsOneWidget]);

      expect(find.text('該当なし'), findsNWidgets(6));
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 5/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.text('小児等'), findsOneWidget]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      expect(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      );

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 6/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.text('小児等'), findsOneWidget]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      expect(
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 7/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.text('小児等'), findsOneWidget]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      );

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 8/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.text('小児等'), findsOneWidget]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      expect(find.text('該当なし'), findsNWidgets(6));
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailCautionTab opens D10 precautions as accordions [assertion 9/9]',
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
            body: SingleChildScrollView(
              child: DrugDetailCautionTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('特定の背景を有する患者への注意'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(7)]);

      Object.hashAll([find.text('小児等'), findsOneWidget]);

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.text(drug.precautionsForSpecificPopulations.first.note),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      ]);

      await tester.tap(find.text('妊婦'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('該当なし'), findsNWidgets(6)]);

      expect(
        find.byKey(const ValueKey<String>('detail-accordion-body')),
        findsOneWidget,
      );
    },
  );
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
