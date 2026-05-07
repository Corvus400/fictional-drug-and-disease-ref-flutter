import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Adverse effects tab for drug detail.
class DrugDetailAdverseEffectsTab extends StatelessWidget {
  /// Creates an adverse effects tab.
  const DrugDetailAdverseEffectsTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDrugSectionSeriousAdverseReactions,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        for (final reaction in drug.adverseReactions.serious)
          Padding(
            padding: const EdgeInsets.only(bottom: DetailConstants.gapS),
            child: Text(reaction.name),
          ),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDrugSectionOtherAdverseReactions,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Text(l10n.detailDrugSectionFreqUnknown),
        for (final reaction in drug.adverseReactions.other.frequencyUnknown)
          Padding(
            padding: const EdgeInsets.only(top: DetailConstants.gapXs),
            child: Text(reaction),
          ),
      ],
    );
  }
}
