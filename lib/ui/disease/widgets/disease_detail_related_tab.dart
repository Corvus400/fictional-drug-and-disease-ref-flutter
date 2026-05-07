import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:go_router/go_router.dart';

final FutureProviderFamily<Drug, String> _relatedDrugProvider = FutureProvider
    .autoDispose
    .family<Drug, String>((ref, id) async {
      final result = await ref.watch(drugRepositoryProvider).getDrug(id);
      return switch (result) {
        Ok<Drug>(:final value) => value,
        Err<Drug>(:final error) => throw error,
      };
    });

final FutureProviderFamily<Disease, String> _relatedDiseaseProvider =
    FutureProvider.autoDispose.family<Disease, String>((ref, id) async {
      final result = await ref.watch(diseaseRepositoryProvider).getDisease(id);
      return switch (result) {
        Ok<Disease>(:final value) => value,
        Err<Disease>(:final error) => throw error,
      };
    });

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
                  _RelatedDrugCard(
                    id: id,
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
                      _RelatedDiseaseCard(
                        id: id,
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

class _RelatedDrugCard extends ConsumerWidget {
  const _RelatedDrugCard({required this.id, required this.onTap});

  final String id;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final drug = ref.watch(_relatedDrugProvider(id));
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(DetailConstants.carouselCardRadius),
        onTap: onTap,
        child: drug.when(
          data: (drug) => DetailCarouselCard(
            title: drug.brandName,
            subtitle: drug.id,
            badges: [
              _dosageFormLabel(l10n, drug.dosageForm),
              _routeLabel(l10n, drug.routeOfAdministration),
            ],
          ),
          loading: () => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDrugs,
          ),
          error: (_, _) => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDrugs,
          ),
        ),
      ),
    );
  }
}

class _RelatedDiseaseCard extends ConsumerWidget {
  const _RelatedDiseaseCard({required this.id, required this.onTap});

  final String id;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final disease = ref.watch(_relatedDiseaseProvider(id));
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(DetailConstants.carouselCardRadius),
        onTap: onTap,
        child: disease.when(
          data: (disease) => DetailCarouselCard(
            title: disease.name,
            subtitle: disease.id,
            badges: [_chronicityLabel(l10n, disease.chronicity)],
          ),
          loading: () => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDiseases,
          ),
          error: (_, _) => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDiseases,
          ),
        ),
      ),
    );
  }
}

String _dosageFormLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'tablet' => l10n.searchDrugDosageFormTablet,
    'capsule' => l10n.searchDrugDosageFormCapsule,
    'powder' => l10n.searchDrugDosageFormPowder,
    'granule' => l10n.searchDrugDosageFormGranule,
    'liquid' => l10n.searchDrugDosageFormLiquid,
    'injection_form' => l10n.searchDrugDosageFormInjection,
    'ointment' => l10n.searchDrugDosageFormOintment,
    'cream' => l10n.searchDrugDosageFormCream,
    'patch' => l10n.searchDrugDosageFormPatch,
    'eye_drops' => l10n.searchDrugDosageFormEyeDrops,
    'suppository' => l10n.searchDrugDosageFormSuppository,
    'inhaler' => l10n.searchDrugDosageFormInhaler,
    'nasal_spray' => l10n.searchDrugDosageFormNasalSpray,
    _ => value,
  };
}

String _routeLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'oral' => l10n.searchDrugRouteOral,
    'topical' => l10n.searchDrugRouteTopical,
    'injection_route' => l10n.searchDrugRouteInjection,
    'inhalation' => l10n.searchDrugRouteInhalation,
    'rectal' => l10n.searchDrugRouteRectal,
    'ophthalmic' => l10n.searchDrugRouteOphthalmic,
    'nasal' => l10n.searchDrugRouteNasal,
    'transdermal' => l10n.searchDrugRouteTransdermal,
    _ => value,
  };
}

String _chronicityLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseChronicityAcute,
    'subacute' => l10n.searchDiseaseChronicitySubacute,
    'chronic' => l10n.searchDiseaseChronicityChronic,
    'relapsing' => l10n.searchDiseaseChronicityRelapsing,
    _ => value,
  };
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
