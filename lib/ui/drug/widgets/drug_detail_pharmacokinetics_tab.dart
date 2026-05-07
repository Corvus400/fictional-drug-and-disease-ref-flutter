import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_pk_table.dart';
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
    final pk = drug.pharmacokinetics;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'D14',
          title: l10n.detailDrugSectionPharmacokinetics,
          child: _PharmacokineticsBody(pharmacokinetics: pk),
        ),
        DetailPanel(
          sectionIndex: 'D15',
          title: l10n.detailDrugSectionAdditionalInfo,
          showBottomDivider: false,
          child: _AdditionalInfoAccordions(drug: drug),
        ),
      ],
    );
  }
}

class _PharmacokineticsBody extends StatelessWidget {
  const _PharmacokineticsBody({required this.pharmacokinetics});

  final PharmacokineticsInfo? pharmacokinetics;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pk = pharmacokinetics;
    if (pk == null) {
      return const SizedBox.shrink();
    }
    final rows = <Widget>[
      if (pk.bloodConcentration != null)
        DetailKvRow(
          label: l10n.detailDrugSectionBloodConcentration,
          value: pk.bloodConcentration!,
        ),
      if (pk.absorption != null)
        DetailKvRow(
          label: l10n.detailDrugSectionAbsorption,
          value: pk.absorption!,
        ),
      if (pk.distribution != null)
        DetailKvRow(
          label: l10n.detailDrugSectionDistribution,
          value: pk.distribution!,
        ),
      if (pk.metabolism != null)
        DetailKvRow(
          label: l10n.detailDrugSectionMetabolism,
          value: pk.metabolism!,
        ),
      if (pk.excretion != null)
        DetailKvRow(
          label: l10n.detailDrugSectionExcretion,
          value: pk.excretion!,
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...rows,
        if (pk.parameters.isNotEmpty) ...[
          const SizedBox(height: DetailConstants.gapM),
          _SubsectionTitle(title: l10n.detailDrugSectionParameters),
          const SizedBox(height: DetailConstants.gapS),
          DetailPkTable(
            itemHeader: l10n.detailDrugPkTableItemHeader,
            valueHeader: l10n.detailDrugPkTableValueHeader,
            rows: [
              for (final parameter in pk.parameters)
                DetailPkParameter(
                  name: parameter.name,
                  value: parameter.value,
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _AdditionalInfoAccordions extends StatelessWidget {
  const _AdditionalInfoAccordions({required this.drug});

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        DetailAccordion(
          title: l10n.detailDrugSectionClinicalResults,
          child: _ClinicalResultsBody(sections: drug.clinicalResults),
        ),
        const SizedBox(height: DetailConstants.gapS),
        DetailAccordion(
          title: l10n.detailDrugSectionPharmacology,
          child: _PharmacologyBody(pharmacology: drug.pharmacology),
        ),
        const SizedBox(height: DetailConstants.gapS),
        DetailAccordion(
          title: l10n.detailDrugSectionOverdose,
          child: _OverdoseBody(overdose: drug.overdose),
        ),
      ],
    );
  }
}

class _ClinicalResultsBody extends StatelessWidget {
  const _ClinicalResultsBody({required this.sections});

  final List<ClinicalResultSection> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final section in sections) ...[
          _BodyText(text: section.heading, emphasized: true),
          const SizedBox(height: DetailConstants.gapXs),
          _BodyText(text: section.content),
          if (section != sections.last)
            const SizedBox(height: DetailConstants.gapS),
        ],
      ],
    );
  }
}

class _PharmacologyBody extends StatelessWidget {
  const _PharmacologyBody({required this.pharmacology});

  final PharmacologyInfo? pharmacology;

  @override
  Widget build(BuildContext context) {
    final info = pharmacology;
    if (info == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BodyText(text: info.mechanism),
        const SizedBox(height: DetailConstants.gapXs),
        _BodyText(text: info.effect),
      ],
    );
  }
}

class _OverdoseBody extends StatelessWidget {
  const _OverdoseBody({required this.overdose});

  final OverdoseInfo? overdose;

  @override
  Widget build(BuildContext context) {
    final info = overdose;
    if (info == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BodyText(text: info.symptoms),
        const SizedBox(height: DetailConstants.gapXs),
        _BodyText(text: info.management),
      ],
    );
  }
}

class _SubsectionTitle extends StatelessWidget {
  const _SubsectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      title,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: DetailConstants.panelTitleFontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText({required this.text, this.emphasized = false});

  final String text;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      text,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: DetailConstants.kvFontSize,
        fontWeight: emphasized ? FontWeight.w700 : FontWeight.w400,
        height: DetailConstants.bodyTextLineHeight,
      ),
    );
  }
}
