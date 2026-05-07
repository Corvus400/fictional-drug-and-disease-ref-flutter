import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_warn_banner.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_overview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailOverviewTab renders D1-D2 hero from domain data', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(_overviewTab(drug));

    expect(find.byKey(const ValueKey<String>('drug-detail-hero')), findsOne);
    expect(find.text(drug.genericName), findsWidgets);
    expect(find.text(drug.brandName), findsWidgets);
    expect(find.text(drug.brandNameKana), findsWidgets);
    expect(find.textContaining(drug.revisedAt), findsOneWidget);
    expect(find.textContaining(drug.manufacturer), findsOneWidget);
    expect(find.text('毒薬'), findsOneWidget);
    expect(find.text('処方箋医薬品'), findsOneWidget);
    expect(find.text('内服'), findsOneWidget);
    expect(find.text('液剤'), findsOneWidget);
    expect(find.byType(DetailBadgeWrap), findsOneWidget);
  });

  testWidgets('DrugDetailOverviewTab renders warning section from D3', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(_overviewTab(drug));

    expect(find.text('警告'), findsOneWidget);
    expect(find.textContaining(drug.warning.first.content), findsOneWidget);
    expect(find.byType(DetailWarnBanner), findsOneWidget);
    expect(find.byType(DetailPanel), findsWidgets);
  });

  testWidgets('DrugDetailOverviewTab renders therapeutic category from D4', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(_overviewTab(drug));

    expect(find.text('薬効分類'), findsOneWidget);
    expect(find.text(drug.atcCode), findsOneWidget);
    expect(find.text(drug.therapeuticCategoryName), findsOneWidget);
    expect(find.text(drug.yjCode!), findsOneWidget);
    expect(find.text('ATC コード'), findsOneWidget);
    expect(find.text('YJ コード'), findsOneWidget);
    expect(find.byType(DetailKvRow), findsWidgets);
  });

  testWidgets('DrugDetailOverviewTab renders composition from D5', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();

    await tester.pumpWidget(_overviewTab(drug));

    expect(find.text('組成・性状'), findsOneWidget);
    expect(find.text(drug.composition.activeIngredient), findsWidgets);
    expect(find.text(drug.composition.appearance), findsOneWidget);
    expect(find.text(drug.composition.identificationCode!), findsOneWidget);
    expect(find.text('有効成分'), findsOneWidget);
    expect(find.text('添加物'), findsOneWidget);
    expect(find.text('外観'), findsOneWidget);
    expect(find.text('識別コード'), findsOneWidget);
  });
}

Widget _overviewTab(Drug drug) {
  return MaterialApp(
    theme: AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: SingleChildScrollView(child: DrugDetailOverviewTab(drug: drug)),
    ),
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
