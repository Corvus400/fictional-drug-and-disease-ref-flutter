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
  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 1/17]',
    (
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
      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 2/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      expect(find.textContaining(disease.id), findsOneWidget);
      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 3/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      expect(find.text(disease.name), findsOneWidget);
      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 4/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      expect(find.textContaining(disease.nameKana), findsOneWidget);
      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 5/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      expect(find.byType(DetailBadge), findsWidgets);
      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 6/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      expect(find.byType(DetailPanel), findsNWidgets(3));
      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 7/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      expect(find.text('E3'), findsOneWidget);
      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 8/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      expect(find.text('同義語'), findsOneWidget);
      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 9/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      expect(find.text(disease.synonyms.first), findsOneWidget);
      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 10/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      expect(find.text('E4'), findsOneWidget);
      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 11/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      expect(find.text('概要'), findsOneWidget);
      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 12/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      expect(find.byType(DetailMarkdownBody), findsOneWidget);
      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 13/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      expect(find.text('E5'), findsOneWidget);
      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 14/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      expect(find.text('疫学'), findsOneWidget);
      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 15/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      expect(find.byType(DetailKvRow), findsWidgets);
      Object.hashAll([find.text('有病率'), findsOneWidget]);

      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 16/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      expect(find.text('有病率'), findsOneWidget);
      Object.hashAll([
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      ]);
    },
  );

  testWidgets(
    'DiseaseDetailOverviewTab renders E1-E5 Detail Spec sections [assertion 17/17]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('disease-detail-hero')),
        findsOneWidget,
      ]);

      Object.hashAll([find.textContaining(disease.id), findsOneWidget]);

      Object.hashAll([find.text(disease.name), findsOneWidget]);

      Object.hashAll([find.textContaining(disease.nameKana), findsOneWidget]);

      Object.hashAll([find.byType(DetailBadge), findsWidgets]);

      Object.hashAll([find.byType(DetailPanel), findsNWidgets(3)]);

      Object.hashAll([find.text('E3'), findsOneWidget]);

      Object.hashAll([find.text('同義語'), findsOneWidget]);

      Object.hashAll([find.text(disease.synonyms.first), findsOneWidget]);

      Object.hashAll([find.text('E4'), findsOneWidget]);

      Object.hashAll([find.text('概要'), findsOneWidget]);

      Object.hashAll([find.byType(DetailMarkdownBody), findsOneWidget]);

      Object.hashAll([find.text('E5'), findsOneWidget]);

      Object.hashAll([find.text('疫学'), findsOneWidget]);

      Object.hashAll([find.byType(DetailKvRow), findsWidgets]);

      Object.hashAll([find.text('有病率'), findsOneWidget]);

      expect(
        find.text(disease.epidemiology!.prevalence!.label),
        findsOneWidget,
      );
    },
  );
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
