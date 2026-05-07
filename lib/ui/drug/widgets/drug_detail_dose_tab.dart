import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Dose tab for drug detail.
class DrugDetailDoseTab extends StatefulWidget {
  /// Creates a dose tab.
  const DrugDetailDoseTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  State<DrugDetailDoseTab> createState() => _DrugDetailDoseTabState();
}

class _DrugDetailDoseTabState extends State<DrugDetailDoseTab> {
  _DoseInnerTab _activeTab = _DoseInnerTab.standard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDrugSectionDosage,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Wrap(
          spacing: DetailConstants.gapS,
          runSpacing: DetailConstants.gapS,
          children: [
            for (final tab in _DoseInnerTab.values)
              ChoiceChip(
                label: Text(_doseInnerTabLabel(l10n, tab)),
                selected: _activeTab == tab,
                onSelected: (_) => setState(() => _activeTab = tab),
              ),
          ],
        ),
        const SizedBox(height: DetailConstants.gapS),
        AnimatedSwitcher(
          duration: DetailConstants.innerTabSwitchDuration,
          child: _doseInnerTabBody(widget.drug, _activeTab),
        ),
      ],
    );
  }
}

enum _DoseInnerTab { standard, pediatric, renal, hepatic }

String _doseInnerTabLabel(AppLocalizations l10n, _DoseInnerTab tab) {
  return switch (tab) {
    _DoseInnerTab.standard => l10n.detailDrugSectionDosageStandard,
    _DoseInnerTab.pediatric => l10n.detailDrugSectionDosagePediatric,
    _DoseInnerTab.renal => l10n.detailDrugSectionDosageRenal,
    _DoseInnerTab.hepatic => l10n.detailDrugSectionDosageHepatic,
  };
}

Widget _doseInnerTabBody(Drug drug, _DoseInnerTab tab) {
  return switch (tab) {
    _DoseInnerTab.standard => Text(
      drug.dosage.standardDosage,
      key: const ValueKey(_DoseInnerTab.standard),
    ),
    _DoseInnerTab.pediatric => Column(
      key: const ValueKey(_DoseInnerTab.pediatric),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final dose in drug.dosage.ageSpecificDosage) Text(dose.dose),
      ],
    ),
    _DoseInnerTab.renal => Column(
      key: const ValueKey(_DoseInnerTab.renal),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final dose in drug.dosage.renalAdjustment) Text(dose.dose),
      ],
    ),
    _DoseInnerTab.hepatic => Column(
      key: const ValueKey(_DoseInnerTab.hepatic),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final dose in drug.dosage.hepaticAdjustment) Text(dose.dose),
      ],
    ),
  };
}
