import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Pharmacokinetics tab for drug detail.
class DrugDetailPharmacokineticsTab extends StatelessWidget {
  /// Creates a pharmacokinetics tab.
  const DrugDetailPharmacokineticsTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDrugSectionAdditionalInfo,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        if (drug.clinicalResults.isNotEmpty)
          ExpansionTile(
            title: Text(l10n.detailDrugSectionClinicalResults),
            children: [
              for (final section in drug.clinicalResults)
                Padding(
                  padding: const EdgeInsets.all(DetailConstants.contentPadding),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(section.content),
                  ),
                ),
            ],
          ),
        if (drug.pharmacology != null)
          ExpansionTile(
            title: Text(l10n.detailDrugSectionPharmacology),
            children: [
              Padding(
                padding: const EdgeInsets.all(DetailConstants.contentPadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(drug.pharmacology!.mechanism),
                ),
              ),
            ],
          ),
        if (drug.overdose != null)
          ExpansionTile(
            title: Text(l10n.detailDrugSectionOverdose),
            children: [
              Padding(
                padding: const EdgeInsets.all(DetailConstants.contentPadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(drug.overdose!.symptoms),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
