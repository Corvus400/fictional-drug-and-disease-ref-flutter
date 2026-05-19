import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_pk_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_pharmacokinetics_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 1/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      expect(find.byType(DetailPanel), findsNWidgets(2));
      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 2/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      expect(find.text('D14'), findsNWidgets(2));
      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 3/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      expect(find.text('薬物動態'), findsOneWidget);
      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 4/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      expect(find.text('血中濃度'), findsOneWidget);
      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 5/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      expect(
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      );
      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 6/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      expect(find.byType(DetailPkTable), findsOneWidget);
      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 7/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      expect(find.text('PK パラメータ'), findsOneWidget);
      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 8/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      expect(find.text('致死濃度到達時間'), findsOneWidget);
      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 9/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      expect(find.text('数分以内'), findsOneWidget);
      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 10/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      expect(find.text('D15'), findsOneWidget);
      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 11/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      expect(find.text('補足情報'), findsOneWidget);
      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 12/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      expect(find.byType(DetailAccordion), findsNWidgets(6));
      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 13/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      expect(find.byType(ExpansionTile), findsNothing);
      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 14/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      expect(find.text('過量投与'), findsOneWidget);
      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 15/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      expect(find.text('有効成分に関する理化学的知見'), findsOneWidget);
      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 16/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      expect(find.text('臨床検査結果に及ぼす影響'), findsOneWidget);
      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 17/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      expect(find.text('その他の注意'), findsOneWidget);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 18/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      expect(find.byType(DetailMarkdownBody), findsWidgets);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 19/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      expect(
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      );

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 20/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      expect(find.text('一般名英語'), findsOneWidget);
      Object.hashAll([
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DrugDetailPharmacokineticsTab renders D14 and D15 [assertion 21/21]',
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
              child: DrugDetailPharmacokineticsTab(drug: drug),
            ),
          ),
        ),
      );

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(2)]);

      Object.hashAll([find.text('D14'), findsNWidgets(2)]);

      Object.hashAll([find.text('薬物動態'), findsOneWidget]);

      Object.hashAll([find.text('血中濃度'), findsOneWidget]);

      Object.hashAll([
        find.text(drug.pharmacokinetics!.bloodConcentration!),
        findsOneWidget,
      ]);

      Object.hashAll([find.byType(DetailPkTable), findsOneWidget]);

      Object.hashAll([find.text('PK パラメータ'), findsOneWidget]);

      Object.hashAll([find.text('致死濃度到達時間'), findsOneWidget]);

      Object.hashAll([find.text('数分以内'), findsOneWidget]);

      Object.hashAll([find.text('D15'), findsOneWidget]);

      Object.hashAll([find.text('補足情報'), findsOneWidget]);

      Object.hashAll([find.byType(DetailAccordion), findsNWidgets(6)]);

      Object.hashAll([find.byType(ExpansionTile), findsNothing]);

      Object.hashAll([find.text('過量投与'), findsOneWidget]);

      Object.hashAll([find.text('有効成分に関する理化学的知見'), findsOneWidget]);

      Object.hashAll([find.text('臨床検査結果に及ぼす影響'), findsOneWidget]);

      Object.hashAll([find.text('その他の注意'), findsOneWidget]);

      await tester.tap(find.text('臨床成績'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(DetailMarkdownBody), findsWidgets]);

      await tester.ensureVisible(find.text('過量投与'));
      await tester.tap(find.text('過量投与'));
      await tester.pumpAndSettle();

      final markdownBodies = tester
          .widgetList<DetailMarkdownBody>(find.byType(DetailMarkdownBody))
          .toList();
      Object.hashAll([
        markdownBodies.any((body) => body.data == drug.overdose!.symptoms),
        isTrue,
      ]);

      await tester.ensureVisible(find.text('有効成分に関する理化学的知見'));
      await tester.tap(find.text('有効成分に関する理化学的知見'));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('一般名英語'), findsOneWidget]);

      expect(
        find.text(drug.physicochemicalProperties!.genericNameEnglish),
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
