import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_warn_banner.dart';
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
        _DrugHero(drug: drug, l10n: l10n),
        DetailPanel(
          sectionIndex: 'D3',
          title: l10n.detailDrugSectionWarning,
          child: DetailWarnBanner(
            items: drug.warning
                .map((item) => item.content)
                .toList(
                  growable: false,
                ),
          ),
        ),
        DetailPanel(
          sectionIndex: 'D4',
          title: l10n.detailDrugSectionTherapeuticCategory,
          subIndex: 'ATC 5',
          child: Column(
            children: [
              DetailKvRow(
                label: l10n.detailDrugLabelAtcCode,
                value: drug.atcCode,
                showTopBorder: true,
              ),
              DetailKvRow(
                label: l10n.detailDrugLabelTherapeuticHierarchy,
                value: drug.therapeuticCategoryName,
              ),
              if (drug.yjCode != null)
                DetailKvRow(
                  label: l10n.detailDrugLabelYjCode,
                  value: drug.yjCode!,
                ),
            ],
          ),
        ),
        DetailPanel(
          sectionIndex: 'D5',
          title: l10n.detailDrugSectionComposition,
          showBottomDivider: false,
          child: Column(
            children: [
              DetailKvRow(
                label: l10n.detailDrugLabelActiveIngredient,
                value: _activeIngredientValue(drug.composition),
                showTopBorder: true,
              ),
              DetailKvRow(
                label: l10n.detailDrugLabelInactiveIngredients,
                value: drug.composition.inactiveIngredients.join('、'),
              ),
              DetailKvRow(
                label: l10n.detailDrugLabelAppearance,
                value: drug.composition.appearance,
              ),
              if (drug.composition.identificationCode != null)
                DetailKvRow(
                  label: l10n.detailDrugLabelIdentificationCode,
                  value: drug.composition.identificationCode!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DrugHero extends StatelessWidget {
  const _DrugHero({required this.drug, required this.l10n});

  final Drug drug;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('drug-detail-hero'),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: DetailConstants.heroImageHeight,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.primaryContainer,
                    colors.tertiaryContainer,
                    colors.surfaceContainer,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DetailConstants.heroMetaPaddingHorizontal,
              vertical: DetailConstants.heroMetaPaddingVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drug.genericName,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: DetailConstants.heroGenericFontSize,
                  ),
                ),
                const SizedBox(height: DetailConstants.heroBrandTopMargin),
                Text(
                  drug.brandName,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: DetailConstants.heroBrandFontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: DetailConstants.heroBrandTopMargin),
                Text(
                  drug.brandNameKana,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: DetailConstants.heroKanaFontSize,
                  ),
                ),
                DetailBadgeWrap(children: _badges(context)),
                Padding(
                  padding: const EdgeInsets.only(
                    top: DetailConstants.heroRevisedTopMargin,
                  ),
                  child: Text(
                    '${l10n.detailDrugMetaRevisedPrefix} ${drug.revisedAt} · '
                    '${drug.manufacturer} · D1-D2',
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: DetailConstants.heroRevisedFontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _badges(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return [
      for (final value in drug.regulatoryClass)
        DetailBadge(
          label: _regulatoryClassLabel(l10n, value),
          colors: _badgeColors(palette.regulatoryBadgeColors(value)),
        ),
      DetailBadge(
        label: _routeLabel(l10n, drug.routeOfAdministration),
        colors: _foregroundBadgeColors(
          palette,
          palette.chipRouteOfAdmin[drug.routeOfAdministration],
        ),
      ),
      DetailBadge(
        label: _dosageFormLabel(l10n, drug.dosageForm),
        colors: _foregroundBadgeColors(
          palette,
          palette.chipDosageForm[drug.dosageForm],
        ),
      ),
    ];
  }
}

DetailBadgeColors _badgeColors(({Color background, Color foreground}) colors) {
  return DetailBadgeColors(
    background: colors.background,
    foreground: colors.foreground,
  );
}

DetailBadgeColors _foregroundBadgeColors(
  AppPalette palette,
  Color? foreground,
) {
  return DetailBadgeColors(
    background: palette.surface3,
    foreground: foreground ?? palette.ink2,
  );
}

String _activeIngredientValue(CompositionInfo composition) {
  final dose = composition.activeIngredientAmount;
  final per = dose.per == null ? '' : ' / ${dose.per}';
  return '${composition.activeIngredient} ${dose.amount} ${dose.unit}$per';
}

String _regulatoryClassLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'poison' => l10n.searchDrugRegulatoryPoison,
    'potent' => l10n.searchDrugRegulatoryPotent,
    'ordinary' => l10n.searchDrugRegulatoryOrdinary,
    'psychotropic_1' => l10n.searchDrugRegulatoryPsychotropic1,
    'psychotropic_2' => l10n.searchDrugRegulatoryPsychotropic2,
    'psychotropic_3' => l10n.searchDrugRegulatoryPsychotropic3,
    'narcotic' => l10n.searchDrugRegulatoryNarcotic,
    'stimulant_precursor' => l10n.searchDrugRegulatoryStimulantPrecursor,
    'biological' => l10n.searchDrugRegulatoryBiological,
    'specified_biological' => l10n.searchDrugRegulatorySpecifiedBiological,
    'prescription_required' => l10n.searchDrugRegulatoryPrescriptionRequired,
    _ => value,
  };
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
