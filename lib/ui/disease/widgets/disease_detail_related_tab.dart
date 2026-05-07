import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
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
        DetailPanel(
          sectionIndex: 'E15',
          title: l10n.detailDiseaseSectionRelatedDrugs,
          child: SizedBox(
            width: double.infinity,
            child: DetailCarousel(
              children: [
                for (final id in disease.relatedDrugIds)
                  _RelatedCard(
                    title: id,
                    subtitle: l10n.detailDiseaseSectionRelatedDrugs,
                    onTap: () => context.push(AppRoutes.drugDetail(id)),
                  ),
              ],
            ),
          ),
        ),
        DetailPanel(
          sectionIndex: 'E16',
          title: l10n.detailDiseaseSectionRelatedDiseases,
          showBottomDivider: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: DetailCarousel(
                  children: [
                    for (final id in disease.relatedDiseaseIds)
                      _RelatedCard(
                        title: id,
                        subtitle: l10n.detailDiseaseSectionRelatedDiseases,
                        onTap: () => context.push(AppRoutes.diseaseDetail(id)),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: DetailConstants.heroRevisedTopMargin,
                ),
                child: _RevisedText(revisedAt: disease.revisedAt),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RelatedCard extends StatelessWidget {
  const _RelatedCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(DetailConstants.carouselCardRadius),
        onTap: onTap,
        child: DetailCarouselCard(title: title, subtitle: subtitle),
      ),
    );
  }
}

class _RevisedText extends StatelessWidget {
  const _RevisedText({required this.revisedAt});

  final String revisedAt;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      'E17 最終改訂 $revisedAt',
      style: TextStyle(
        color: colors.onSurfaceVariant,
        fontSize: DetailConstants.heroRevisedFontSize,
      ),
    );
  }
}
