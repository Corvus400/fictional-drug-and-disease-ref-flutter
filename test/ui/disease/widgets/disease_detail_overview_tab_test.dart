import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_overview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections', (
    tester,
  ) async {
    final disease = _diseaseFixture().toDomain();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: DiseaseDetailOverviewTab(disease: disease),
          ),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey<String>('disease-detail-hero')),
      findsOneWidget,
    );
    expect(find.textContaining(disease.id), findsOneWidget);
    expect(find.text(disease.name), findsOneWidget);
    expect(find.textContaining(disease.nameKana), findsOneWidget);
    expect(find.byType(DetailBadge), findsWidgets);
    expect(find.byType(DetailPanel), findsNWidgets(3));
    expect(find.text('E3'), findsOneWidget);
    expect(find.text('同義語'), findsOneWidget);
    expect(find.text(disease.synonyms.first), findsOneWidget);
    expect(find.text('E4'), findsOneWidget);
    expect(find.text('概要'), findsOneWidget);
    expect(find.byType(DetailMarkdownBody), findsOneWidget);
    expect(find.text('E5'), findsOneWidget);
    expect(find.text('疫学'), findsOneWidget);
    expect(find.byType(DetailKvRow), findsWidgets);
    expect(find.text('有病率'), findsOneWidget);
    expect(find.text(disease.epidemiology!.prevalence!.label), findsOneWidget);
  });
}

DiseaseDto _diseaseFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_diseases__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}
