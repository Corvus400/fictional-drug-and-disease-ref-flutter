import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Treatment tab for disease detail.
class DiseaseDetailTreatmentTab extends StatelessWidget {
  /// Creates a treatment tab.
  const DiseaseDetailTreatmentTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDiseaseSectionDifferentialDiagnoses,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        for (final diagnosis in disease.differentialDiagnoses) Text(diagnosis),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDiseaseSectionComplications,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        for (final complication in disease.complications) Text(complication),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDiseaseSectionTreatments,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Text(l10n.detailDiseaseSectionNonPharmacological),
      ],
    );
  }
}
