import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Related diseases tab for drug detail.
class DrugDetailRelatedTab extends StatelessWidget {
  /// Creates a related diseases tab.
  const DrugDetailRelatedTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDrugSectionRelatedDiseases,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        SizedBox(
          height: DetailConstants.relatedCarouselHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: drug.relatedDiseaseIds.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: DetailConstants.gapS),
            itemBuilder: (context, index) {
              final id = drug.relatedDiseaseIds[index];
              return SizedBox(
                width: DetailConstants.relatedCarouselItemWidth,
                child: OutlinedButton(
                  onPressed: () => context.push(AppRoutes.diseaseDetail(id)),
                  child: Text(id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
