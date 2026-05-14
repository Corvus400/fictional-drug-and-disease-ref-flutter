// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: public_member_api_docs

part of 'calc_view.dart';

@FddScreenPreview(group: 'Calc', name: 'BMI result with history')
Widget previewCalcBmiResult() {
  return _previewCalcView(previewBmiResultState);
}

@FddScreenPreview(group: 'Calc', name: 'eGFR result')
Widget previewCalcEgfrResult() {
  return _previewCalcView(previewEgfrResultState);
}

@FddScreenPreview(group: 'Calc', name: 'CrCl result')
Widget previewCalcCrClResult() {
  return _previewCalcView(previewCrClResultState);
}

@FddScreenPreview(group: 'Calc', name: 'Partial input')
Widget previewCalcPartialInput() {
  return _previewCalcView(previewCalcPartialState);
}

@FddScreenPreview(group: 'Calc', name: 'Out of range')
Widget previewCalcOutOfRange() {
  return _previewCalcView(previewCalcOutOfRangeState);
}

@FddTabletPreview(group: 'Calc', name: 'Tablet split layout')
Widget previewCalcTabletSplitLayout() {
  return _previewCalcView(previewBmiResultState);
}

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

Widget _previewCalcView(CalcScreenState state) {
  return previewProviderScope(
    overrides: [
      calcScreenProvider.overrideWithBuild((ref, notifier) => state),
    ],
    child: const CalcView(
      debugRestoringProgressValue: 0.7,
    ),
  );
}
