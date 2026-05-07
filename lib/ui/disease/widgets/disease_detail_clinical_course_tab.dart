import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Clinical course tab for disease detail.
class DiseaseDetailClinicalCourseTab extends StatelessWidget {
  /// Creates a clinical course tab.
  const DiseaseDetailClinicalCourseTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDiseaseSectionPrognosis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (disease.prognosis != null) Text(disease.prognosis!),
        const SizedBox(height: DetailConstants.gapM),
        Text(
          l10n.detailDiseaseSectionPrevention,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        for (final item in disease.prevention) Text(item),
      ],
    );
  }
}
