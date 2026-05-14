// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: public_member_api_docs

import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_category_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/bmi_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/crcl_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/egfr_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_support.dart';
import 'package:flutter/material.dart';

@FddComponentPreview(group: 'Calc', name: 'Result card with charts')
Widget previewCalcResultCardGallery() {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalcResultCard(
              title: l10n.calcToolBmi,
              formula: l10n.calcFormulaBmi,
              valueText: '22.5',
              unit: l10n.calcResultBmiUnit,
              badges: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: l10n.calcBmiCategoryNormal,
                ),
              ],
              visualization: const BmiChart(value: 22.5, label: '22.5'),
            ),
            const SizedBox(height: 16),
            CalcResultCard(
              title: l10n.calcToolEgfr,
              formula: l10n.calcFormulaEgfr,
              valueText: '39.8',
              unit: l10n.calcResultEgfrUnit,
              badges: [
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: l10n.calcCkdStageG3b,
                ),
              ],
              visualization: const EgfrChart(value: 39.8, label: 'G3b'),
            ),
          ],
        ),
      );
    },
  );
}

@FddComponentPreview(group: 'Calc', name: 'CrCl chart')
Widget previewCalcCrClChart() {
  return const CrClChart(value: 35.8);
}

@FddComponentPreview(group: 'Calc', name: 'History row')
Widget previewCalcHistoryRow() {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return CalcHistoryRow(
        dateText: '2026/05/14 08:50',
        resultText: 'BMI 22.5',
        summaryText: '170 cm / 65 kg',
        deleteLabel: l10n.calcHistoryActionDelete,
        deleteRevealed: true,
        onRestore: () {},
        onDelete: () {},
      );
    },
  );
}
