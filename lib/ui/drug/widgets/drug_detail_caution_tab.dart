import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';

/// Caution tab for drug detail.
class DrugDetailCautionTab extends StatefulWidget {
  /// Creates a caution tab.
  const DrugDetailCautionTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  State<DrugDetailCautionTab> createState() => _DrugDetailCautionTabState();
}

class _DrugDetailCautionTabState extends State<DrugDetailCautionTab> {
  _InteractionInnerTab _activeInteractionTab = _InteractionInnerTab.prohibited;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final drug = widget.drug;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'D6',
          title: l10n.detailDrugSectionContraindications,
          child: _NumberedParagraphList(items: drug.contraindications),
        ),
        DetailPanel(
          sectionIndex: 'D10',
          title: l10n.detailDrugSectionPrecautionsForSpecificPopulations,
          child: _PrecautionAccordions(
            items: drug.precautionsForSpecificPopulations,
          ),
        ),
        DetailPanel(
          sectionIndex: 'D11',
          title: l10n.detailDrugSectionInteractions,
          showBottomDivider: false,
          child: DefaultTabController(
            length: _InteractionInnerTab.values.length,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _InteractionTabBar(
                  activeTab: _activeInteractionTab,
                  interactions: drug.interactions,
                  onSelected: (tab) =>
                      setState(() => _activeInteractionTab = tab),
                ),
                const SizedBox(height: DetailConstants.gapS),
                AnimatedSwitcher(
                  duration: DetailConstants.innerTabSwitchDuration,
                  child: _interactionTabBody(
                    context,
                    drug.interactions,
                    _activeInteractionTab,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PrecautionAccordions extends StatelessWidget {
  const _PrecautionAccordions({required this.items});

  final List<PrecautionPopulation> items;

  @override
  Widget build(BuildContext context) {
    final byCategory = {for (final item in items) item.category: item.note};
    final firstPopulatedCategory = _precautionCategoryOrder
        .where((category) => byCategory[category]?.trim().isNotEmpty ?? false)
        .firstOrNull;
    return Column(
      children: [
        for (final category in _precautionCategoryOrder) ...[
          _PrecautionAccordion(
            category: category,
            note: byCategory[category],
            initiallyExpanded: category == firstPopulatedCategory,
          ),
          if (category != _precautionCategoryOrder.last)
            const SizedBox(height: DetailConstants.gapS),
        ],
      ],
    );
  }
}

class _PrecautionAccordion extends StatelessWidget {
  const _PrecautionAccordion({
    required this.category,
    required this.note,
    required this.initiallyExpanded,
  });

  final String category;
  final String? note;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = note?.trim();
    final hasNote = text != null && text.isNotEmpty;
    return DetailAccordion(
      title: _precautionCategoryLabel(l10n, category),
      statusLabel: hasNote ? null : l10n.detailNoData,
      enabled: hasNote,
      initiallyExpanded: initiallyExpanded,
      child: DetailMarkdownBody(data: text ?? ''),
    );
  }
}

const _precautionCategoryOrder = [
  'comorbidity',
  'renal_impairment',
  'hepatic_impairment',
  'pregnant',
  'lactating',
  'pediatric',
  'geriatric',
];

String _precautionCategoryLabel(AppLocalizations l10n, String category) {
  return switch (category) {
    'comorbidity' => l10n.searchDrugPrecautionComorbidity,
    'renal_impairment' => l10n.searchDrugPrecautionRenalImpairment,
    'hepatic_impairment' => l10n.searchDrugPrecautionHepaticImpairment,
    'reproductive_potential' => l10n.searchDrugPrecautionReproductivePotential,
    'pregnant' => l10n.searchDrugPrecautionPregnant,
    'lactating' => l10n.searchDrugPrecautionLactating,
    'pediatric' => l10n.searchDrugPrecautionPediatric,
    'geriatric' => l10n.searchDrugPrecautionGeriatric,
    _ => category,
  };
}

enum _InteractionInnerTab { prohibited, caution }

class _InteractionTabBar extends StatelessWidget {
  const _InteractionTabBar({
    required this.activeTab,
    required this.interactions,
    required this.onSelected,
  });

  final _InteractionInnerTab activeTab;
  final InteractionInfo? interactions;
  final ValueChanged<_InteractionInnerTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return TabBar(
      key: const ValueKey<String>('drug-detail-interaction-inner-tabs'),
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: colors.primary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicatorColor: colors.primary,
      dividerColor: colors.outlineVariant,
      labelStyle: const TextStyle(
        fontSize: DetailConstants.kvFontSize,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: DetailConstants.kvFontSize,
        fontWeight: FontWeight.w600,
      ),
      onTap: (index) => onSelected(_InteractionInnerTab.values[index]),
      tabs: [
        for (final tab in _InteractionInnerTab.values)
          Tab(text: _interactionTabLabel(context, interactions, tab)),
      ],
    );
  }
}

String _interactionTabLabel(
  BuildContext context,
  InteractionInfo? interactions,
  _InteractionInnerTab tab,
) {
  final l10n = AppLocalizations.of(context)!;
  final count = _interactionEntries(interactions, tab).length;
  return switch (tab) {
    _InteractionInnerTab.prohibited =>
      '${l10n.detailDrugSectionInteractionsProhibited}（$count）',
    _InteractionInnerTab.caution =>
      '${l10n.detailDrugSectionInteractionsCaution}（$count）',
  };
}

Widget _interactionTabBody(
  BuildContext context,
  InteractionInfo? interactions,
  _InteractionInnerTab tab,
) {
  final entries = _interactionEntries(interactions, tab);
  if (entries.isEmpty) {
    return _CautionBodyText(
      key: ValueKey<_InteractionInnerTab>(tab),
      text: AppLocalizations.of(context)!.detailDrugNoInteractions,
      muted: true,
    );
  }
  return Column(
    key: ValueKey<_InteractionInnerTab>(tab),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final entry in entries) _InteractionEntryCard(entry: entry),
    ],
  );
}

List<InteractionEntry> _interactionEntries(
  InteractionInfo? interactions,
  _InteractionInnerTab tab,
) {
  return switch (tab) {
    _InteractionInnerTab.prohibited =>
      interactions?.combinationProhibited ?? const [],
    _InteractionInnerTab.caution =>
      interactions?.combinationCaution ?? const [],
  };
}

class _InteractionEntryCard extends StatelessWidget {
  const _InteractionEntryCard({required this.entry});

  final InteractionEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      margin: const EdgeInsets.only(bottom: DetailConstants.gapS),
      padding: const EdgeInsets.all(DetailConstants.gapS),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(DetailConstants.accordionRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CautionBodyText(text: entry.displayName),
          const SizedBox(height: DetailConstants.gapXs),
          _CautionBodyText(text: entry.clinicalSymptom, muted: true),
          const SizedBox(height: DetailConstants.gapXs),
          _CautionBodyText(text: entry.mechanism, muted: true),
        ],
      ),
    );
  }
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

String _paragraphIndex(NumberedParagraph item) {
  if (item.subOrder == null) {
    return item.order.toString();
  }
  return '${item.order}.${item.subOrder}';
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

class _CautionBodyText extends StatelessWidget {
  const _CautionBodyText({
    required this.text,
    this.muted = false,
    super.key,
  });

  final String text;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      text,
      style: TextStyle(
        color: muted ? colors.onSurfaceVariant : colors.onSurface,
        fontSize: DetailConstants.kvFontSize,
        height: DetailConstants.bodyTextLineHeight,
      ),
    );
  }
}
