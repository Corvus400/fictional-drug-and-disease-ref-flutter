import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Related entities tab for disease detail.
class DiseaseDetailRelatedTab extends StatelessWidget {
  /// Creates a related tab.
  const DiseaseDetailRelatedTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detailDiseaseSectionRelatedDrugs,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DetailConstants.gapS),
        SizedBox(
          height: DetailConstants.relatedCarouselHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: disease.relatedDrugIds.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: DetailConstants.gapS),
            itemBuilder: (context, index) {
              final id = disease.relatedDrugIds[index];
              return SizedBox(
                width: DetailConstants.relatedCarouselItemWidth,
                child: OutlinedButton(
                  onPressed: () => context.push(AppRoutes.drugDetail(id)),
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
