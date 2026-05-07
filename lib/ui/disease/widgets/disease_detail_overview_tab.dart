import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Overview tab for disease detail.
class DiseaseDetailOverviewTab extends StatelessWidget {
  /// Creates an overview tab.
  const DiseaseDetailOverviewTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDiseaseSectionSynonyms,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Wrap(
          spacing: DetailConstants.gapS,
          runSpacing: DetailConstants.gapS,
          children: [
            for (final synonym in disease.synonyms) Chip(label: Text(synonym)),
          ],
        ),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDiseaseSectionSummary,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        Text(disease.summary),
      ],
    );
  }
}
