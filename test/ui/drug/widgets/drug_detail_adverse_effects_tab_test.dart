import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_serious_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_adverse_effects_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailAdverseEffectsTab renders D12 and D13', (
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
            child: DrugDetailAdverseEffectsTab(drug: drug),
          ),
        ),
      ),
    );

    expect(find.byType(DetailPanel), findsNWidgets(2));
    expect(find.text('D12'), findsOneWidget);
    expect(find.text('重大な副作用'), findsOneWidget);
    expect(find.byType(DetailSeriousCard), findsNWidgets(2));
    expect(find.text(drug.adverseReactions.serious.first.name), findsOneWidget);
    expect(
      find.textContaining(drug.adverseReactions.serious.first.symptom),
      findsOneWidget,
    );
    expect(find.textContaining('初期症状'), findsNWidgets(2));
    expect(find.textContaining('対応'), findsNWidgets(2));
    expect(find.text('D13'), findsOneWidget);
    expect(find.text('その他副作用'), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('drug-detail-frequency-row')),
      findsNWidgets(4),
    );
    expect(find.text('5%以上'), findsOneWidget);
    expect(find.text('1〜5%'), findsOneWidget);
    expect(find.text('1%未満'), findsOneWidget);
    expect(find.text('不明'), findsOneWidget);
    expect(
      find.text(drug.adverseReactions.other.frequencyUnknown.first),
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
