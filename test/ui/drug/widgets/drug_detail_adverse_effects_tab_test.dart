import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
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
    final firstPanelFinder = find.byType(DetailPanel).first;
    final firstCardFinder = find
        .byKey(const ValueKey<String>('detail-serious-card'))
        .first;
    final panelWidth = tester.getSize(firstPanelFinder).width;
    final cardWidth = tester.getSize(firstCardFinder).width;
    final panelLeft = tester.getTopLeft(firstPanelFinder).dx;
    final cardLeft = tester.getTopLeft(firstCardFinder).dx;
    expect(
      cardWidth,
      closeTo(
        panelWidth - DetailConstants.panelPaddingHorizontal * 2,
        0.1,
      ),
    );
    expect(
      cardLeft,
      closeTo(panelLeft + DetailConstants.panelPaddingHorizontal, 0.1),
    );
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

  testWidgets('DrugDetailAdverseEffectsTab localizes serious frequency enums', (
    tester,
  ) async {
    final drug = _drugFixture(
      seriousFrequencies: [
        'over_5_percent',
        'between_1_and_5_percent',
        'under_1_percent',
        'unknown',
      ],
    ).toDomain();

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

    expect(find.textContaining('5%以上 —'), findsOneWidget);
    expect(find.textContaining('1〜5% —'), findsOneWidget);
    expect(find.textContaining('1%未満 —'), findsOneWidget);
    expect(find.textContaining('不明 —'), findsOneWidget);
    expect(find.textContaining('over_5_percent'), findsNothing);
    expect(find.textContaining('between_1_and_5_percent'), findsNothing);
    expect(find.textContaining('under_1_percent'), findsNothing);
  });
}

DrugDto _drugFixture({List<String>? seriousFrequencies}) {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_drugs__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  if (seriousFrequencies != null) {
    final adverseReactions = json['adverse_reactions'] as Map<String, dynamic>;
    final firstSerious =
        (adverseReactions['serious'] as List<dynamic>).first
            as Map<String, dynamic>;
    adverseReactions['serious'] = [
      for (final (index, frequency) in seriousFrequencies.indexed)
        {
          ...firstSerious,
          'name': '重大な副作用 ${index + 1}',
          'frequency': frequency,
        },
    ];
  }
  return DrugDto.fromJson(json);
}
