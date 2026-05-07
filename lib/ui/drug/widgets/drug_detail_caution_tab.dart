import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Caution tab for drug detail.
class DrugDetailCautionTab extends StatefulWidget {
  /// Creates a caution tab.
  const DrugDetailCautionTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  State<DrugDetailCautionTab> createState() => _DrugDetailCautionTabState();
}

class _DrugDetailCautionTabState extends State<DrugDetailCautionTab> {
  _InteractionInnerTab _activeInteractionTab = _InteractionInnerTab.prohibited;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDrugSectionPrecautionsForSpecificPopulations,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        for (final precaution in widget.drug.precautionsForSpecificPopulations)
          ExpansionTile(
            title: Text(_precautionCategoryLabel(l10n, precaution.category)),
            children: [
              Padding(
                padding: const EdgeInsets.all(DetailConstants.contentPadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(precaution.note),
                ),
              ),
            ],
          ),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDrugSectionInteractions,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Wrap(
          spacing: DetailConstants.gapS,
          runSpacing: DetailConstants.gapS,
          children: [
            for (final tab in _InteractionInnerTab.values)
              ChoiceChip(
                label: Text(_interactionTabLabel(l10n, tab)),
                selected: _activeInteractionTab == tab,
                onSelected: (_) => setState(() => _activeInteractionTab = tab),
              ),
          ],
        ),
      ],
    );
  }
}

String _precautionCategoryLabel(AppLocalizations l10n, String category) {
  return switch (category) {
    'comorbidity' => l10n.searchDrugPrecautionComorbidity,
    'renal_impairment' => l10n.searchDrugPrecautionRenalImpairment,
    'hepatic_impairment' => l10n.searchDrugPrecautionHepaticImpairment,
    'reproductive_potential' => l10n.searchDrugPrecautionReproductivePotential,
    'pregnant' => l10n.searchDrugPrecautionPregnant,
    'lactating' => l10n.searchDrugPrecautionLactating,
    'pediatric' => l10n.searchDrugPrecautionPediatric,
    'geriatric' => l10n.searchDrugPrecautionGeriatric,
    _ => category,
  };
}

enum _InteractionInnerTab { prohibited, caution }

String _interactionTabLabel(
  AppLocalizations l10n,
  _InteractionInnerTab tab,
) {
  return switch (tab) {
    _InteractionInnerTab.prohibited =>
      l10n.detailDrugSectionInteractionsProhibited,
    _InteractionInnerTab.caution => l10n.detailDrugSectionInteractionsCaution,
  };
}
