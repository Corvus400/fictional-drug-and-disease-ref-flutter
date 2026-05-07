import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Overview tab for drug detail.
class DrugDetailOverviewTab extends StatelessWidget {
  /// Creates an overview tab.
  const DrugDetailOverviewTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDrugSectionWarning,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        for (final paragraph in drug.warning)
          Padding(
            padding: const EdgeInsets.only(bottom: DetailConstants.gapXs),
            child: Text(paragraph.content),
          ),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDrugSectionTherapeuticCategory,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Text(drug.atcCode),
        Text(drug.therapeuticCategoryName),
        if (drug.yjCode != null) Text(drug.yjCode!),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDrugSectionComposition,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Text(drug.composition.activeIngredient),
        Text(drug.composition.appearance),
        if (drug.composition.identificationCode != null)
          Text(drug.composition.identificationCode!),
      ],
    );
  }
}
