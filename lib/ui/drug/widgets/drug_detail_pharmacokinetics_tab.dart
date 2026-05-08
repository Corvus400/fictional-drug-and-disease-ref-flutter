import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
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
          valueAsMarkdown: true,
        ),
      if (pk.absorption != null)
        DetailKvRow(
          label: l10n.detailDrugSectionAbsorption,
          value: pk.absorption!,
          valueAsMarkdown: true,
        ),
      if (pk.distribution != null)
        DetailKvRow(
          label: l10n.detailDrugSectionDistribution,
          value: pk.distribution!,
          valueAsMarkdown: true,
        ),
      if (pk.metabolism != null)
        DetailKvRow(
          label: l10n.detailDrugSectionMetabolism,
          value: pk.metabolism!,
          valueAsMarkdown: true,
        ),
      if (pk.excretion != null)
        DetailKvRow(
          label: l10n.detailDrugSectionExcretion,
          value: pk.excretion!,
          valueAsMarkdown: true,
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...rows,
        if (pk.parameters.isNotEmpty) ...[
          const SizedBox(height: DetailConstants.panelSubsectionTopMargin),
          DetailSectionHeading(
            colors: Theme.of(context).extension<DetailColorExtension>()!,
            sectionIndex: 'D14',
            title: l10n.detailDrugSectionParameters,
          ),
          const SizedBox(height: DetailConstants.panelTitleBottomGap),
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
    final accordions = <Widget>[
      if (drug.clinicalResults.isNotEmpty)
        DetailAccordion(
          title: l10n.detailDrugSectionClinicalResults,
          child: _ClinicalResultsBody(sections: drug.clinicalResults),
        ),
      if (drug.pharmacology != null)
        DetailAccordion(
          title: l10n.detailDrugSectionPharmacology,
          child: _PharmacologyBody(pharmacology: drug.pharmacology),
        ),
      if (drug.overdose != null)
        DetailAccordion(
          title: l10n.detailDrugSectionOverdose,
          child: _OverdoseBody(overdose: drug.overdose),
        ),
      if (drug.physicochemicalProperties != null)
        DetailAccordion(
          title: l10n.detailDrugSectionPhysicochemical,
          child: _PhysicochemicalBody(info: drug.physicochemicalProperties),
        ),
      if (drug.effectsOnLabTests.isNotEmpty)
        DetailAccordion(
          title: l10n.detailDrugSectionEffectsOnLabTests,
          child: _NumberedParagraphList(items: drug.effectsOnLabTests),
        ),
      if (drug.otherPrecautions.isNotEmpty)
        DetailAccordion(
          title: l10n.detailDrugSectionOtherPrecautions,
          child: _NumberedParagraphList(items: drug.otherPrecautions),
        ),
    ];
    return Column(
      children: [
        for (final (index, accordion) in accordions.indexed) ...[
          if (index > 0) const SizedBox(height: DetailConstants.gapS),
          accordion,
        ],
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
          DetailMarkdownBody(data: section.content),
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
        DetailMarkdownBody(data: info.mechanism),
        const SizedBox(height: DetailConstants.gapXs),
        DetailMarkdownBody(data: info.effect),
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
        DetailMarkdownBody(data: info.symptoms),
        const SizedBox(height: DetailConstants.gapXs),
        DetailMarkdownBody(data: info.management),
      ],
    );
  }
}

class _PhysicochemicalBody extends StatelessWidget {
  const _PhysicochemicalBody({required this.info});

  final PhysicochemicalInfo? info;

  @override
  Widget build(BuildContext context) {
    final value = info;
    if (value == null) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailKvRow(
          label: l10n.detailDrugPhysicochemicalGenericNameEnglish,
          value: value.genericNameEnglish,
          showTopBorder: true,
        ),
        DetailKvRow(
          label: l10n.detailDrugPhysicochemicalMolecularFormula,
          value: value.molecularFormula,
        ),
        if (value.molecularWeight != null)
          DetailKvRow(
            label: l10n.detailDrugPhysicochemicalMolecularWeight,
            value: _formatMolecularWeight(value.molecularWeight!),
          ),
        const SizedBox(height: DetailConstants.gapS),
        _BodyText(
          text: l10n.detailDrugPhysicochemicalDescription,
          emphasized: true,
        ),
        const SizedBox(height: DetailConstants.gapXs),
        DetailMarkdownBody(data: value.description),
      ],
    );
  }
}

String _formatMolecularWeight(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toString();
}

class _NumberedParagraphList extends StatelessWidget {
  const _NumberedParagraphList({required this.items});

  final List<NumberedParagraph> items;

  @override
  Widget build(BuildContext context) {
    final sorted = [...items]
      ..sort((a, b) {
        final order = a.order.compareTo(b.order);
        if (order != 0) {
          return order;
        }
        return (a.subOrder ?? 0).compareTo(b.subOrder ?? 0);
      });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in sorted)
          _NumberedMarkdownParagraph(index: _paragraphIndex(item), item: item),
      ],
    );
  }
}

class _NumberedMarkdownParagraph extends StatelessWidget {
  const _NumberedMarkdownParagraph({required this.index, required this.item});

  final String index;
  final NumberedParagraph item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: DetailConstants.gapXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. ',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: DetailConstants.kvFontSize,
              fontWeight: FontWeight.w700,
              height: DetailConstants.bodyTextLineHeight,
            ),
          ),
          Expanded(child: DetailMarkdownBody(data: item.content)),
        ],
      ),
    );
  }
}

String _paragraphIndex(NumberedParagraph item) {
  if (item.subOrder == null) {
    return item.order.toString();
  }
  return '${item.order}.${item.subOrder}';
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
