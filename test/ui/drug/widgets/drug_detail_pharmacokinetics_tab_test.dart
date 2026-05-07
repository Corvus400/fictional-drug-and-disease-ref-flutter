import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_pk_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_pharmacokinetics_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DrugDetailPharmacokineticsTab renders D14 and D15', (
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
    expect(find.text('D14'), findsOneWidget);
    expect(find.text('薬物動態'), findsOneWidget);
    expect(find.text('血中濃度'), findsOneWidget);
    expect(
      find.text(drug.pharmacokinetics!.bloodConcentration!),
      findsOneWidget,
    );
    expect(find.byType(DetailPkTable), findsOneWidget);
    expect(find.text('致死濃度到達時間'), findsOneWidget);
    expect(find.text('数分以内'), findsOneWidget);
    expect(find.text('D15'), findsOneWidget);
    expect(find.text('補足情報'), findsOneWidget);
    expect(find.byType(DetailAccordion), findsNWidgets(3));
    expect(find.byType(ExpansionTile), findsNothing);
    expect(find.text('過量投与'), findsOneWidget);

    await tester.ensureVisible(find.text('過量投与'));
    await tester.tap(find.text('過量投与'));
    await tester.pumpAndSettle();

    expect(find.text(drug.overdose!.symptoms), findsOneWidget);
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
