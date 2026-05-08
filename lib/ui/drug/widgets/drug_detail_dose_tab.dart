import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';

/// Dose tab for drug detail.
class DrugDetailDoseTab extends StatefulWidget {
  /// Creates a dose tab.
  const DrugDetailDoseTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  State<DrugDetailDoseTab> createState() => _DrugDetailDoseTabState();
}

class _DrugDetailDoseTabState extends State<DrugDetailDoseTab> {
  _DoseInnerTab _activeTab = _DoseInnerTab.standard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final drug = widget.drug;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'D7',
          title: l10n.detailDrugSectionIndications,
          child: _IndicationList(items: drug.indications),
        ),
        DetailPanel(
          sectionIndex: 'D8',
          title: l10n.detailDrugSectionDosage,
          child: DefaultTabController(
            length: _DoseInnerTab.values.length,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DoseInnerTabBar(
                  activeTab: _activeTab,
                  onSelected: (tab) => setState(() => _activeTab = tab),
                ),
                const SizedBox(height: DetailConstants.gapS),
                AnimatedSwitcher(
                  duration: DetailConstants.innerTabSwitchDuration,
                  child: _doseInnerTabBody(drug, _activeTab),
                ),
              ],
            ),
          ),
        ),
        DetailPanel(
          sectionIndex: 'D9',
          title: l10n.detailDrugSectionDosageRelatedPrecautions,
          showBottomDivider: false,
          child: _NumberedParagraphList(items: drug.dosageRelatedPrecautions),
        ),
      ],
    );
  }
}

enum _DoseInnerTab { standard, pediatric, renal, hepatic }

class _DoseInnerTabBar extends StatelessWidget {
  const _DoseInnerTabBar({
    required this.activeTab,
    required this.onSelected,
  });

  final _DoseInnerTab activeTab;
  final ValueChanged<_DoseInnerTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return TabBar(
      key: const ValueKey<String>('drug-detail-dose-inner-tabs'),
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
      onTap: (index) => onSelected(_DoseInnerTab.values[index]),
      tabs: [
        for (final tab in _DoseInnerTab.values)
          Tab(text: _doseInnerTabLabel(l10n, tab)),
      ],
    );
  }
}

String _doseInnerTabLabel(AppLocalizations l10n, _DoseInnerTab tab) {
  return switch (tab) {
    _DoseInnerTab.standard => l10n.detailDrugSectionDosageStandard,
    _DoseInnerTab.pediatric => l10n.detailDrugSectionDosagePediatric,
    _DoseInnerTab.renal => l10n.detailDrugSectionDosageRenal,
    _DoseInnerTab.hepatic => l10n.detailDrugSectionDosageHepatic,
  };
}

Widget _doseInnerTabBody(Drug drug, _DoseInnerTab tab) {
  return switch (tab) {
    _DoseInnerTab.standard => _DoseBodyText(
      key: const ValueKey<_DoseInnerTab>(_DoseInnerTab.standard),
      text: drug.dosage.standardDosage,
    ),
    _DoseInnerTab.pediatric => _DoseAdjustmentList(
      key: const ValueKey<_DoseInnerTab>(_DoseInnerTab.pediatric),
      items: [
        for (final dose in drug.dosage.ageSpecificDosage)
          '${dose.range.label}: ${dose.dose}',
      ],
    ),
    _DoseInnerTab.renal => _DoseAdjustmentList(
      key: const ValueKey<_DoseInnerTab>(_DoseInnerTab.renal),
      items: [
        for (final dose in drug.dosage.renalAdjustment)
          '${dose.range.label}: ${dose.dose}',
      ],
    ),
    _DoseInnerTab.hepatic => Builder(
      key: const ValueKey<_DoseInnerTab>(_DoseInnerTab.hepatic),
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return _DoseAdjustmentList(
          items: [
            for (final dose in drug.dosage.hepaticAdjustment)
              '${_hepaticSeverityLabel(l10n, dose.severity)}: ${dose.dose}',
          ],
        );
      },
    ),
  };
}

String _hepaticSeverityLabel(AppLocalizations l10n, String severity) {
  return switch (severity) {
    'mild' => l10n.detailDrugHepaticSeverityMild,
    'moderate' => l10n.detailDrugHepaticSeverityModerate,
    'severe' => l10n.detailDrugHepaticSeveritySevere,
    _ => severity,
  };
}

class _IndicationList extends StatelessWidget {
  const _IndicationList({required this.items});

  final List<IndicationItem> items;

  @override
  Widget build(BuildContext context) {
    return _OrderedTextList(
      entries: [for (final item in items) (item.order, item.content)],
    );
  }
}

class _NumberedParagraphList extends StatelessWidget {
  const _NumberedParagraphList({required this.items});

  final List<NumberedParagraph> items;

  @override
  Widget build(BuildContext context) {
    return _OrderedTextList(
      entries: [
        for (final item in items)
          (
            item.subOrder == null
                ? item.order
                : num.parse('${item.order}.${item.subOrder}'),
            item.content,
          ),
      ],
    );
  }
}

class _OrderedTextList extends StatelessWidget {
  const _OrderedTextList({required this.entries});

  final List<(num, String)> entries;

  @override
  Widget build(BuildContext context) {
    final sorted = [...entries]..sort((a, b) => a.$1.compareTo(b.$1));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, text) in sorted)
          _OrderedText(index: index, text: text),
      ],
    );
  }
}

class _OrderedText extends StatelessWidget {
  const _OrderedText({required this.index, required this.text});

  final num index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    final indexText = index is int || index == index.roundToDouble()
        ? index.toInt().toString()
        : index.toString();
    final prefix = Text(
      '$indexText. ',
      style: TextStyle(
        color: colors.onSurface,
        fontSize: DetailConstants.kvFontSize,
        fontWeight: FontWeight.w700,
        height: DetailConstants.bodyTextLineHeight,
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: DetailConstants.gapXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefix,
          Expanded(child: DetailMarkdownBody(data: text)),
        ],
      ),
    );
  }
}

class _DoseBodyText extends StatelessWidget {
  const _DoseBodyText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return DetailMarkdownBody(data: text, color: colors.onSurface);
  }
}

class _DoseAdjustmentList extends StatelessWidget {
  const _DoseAdjustmentList({required this.items, super.key});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [for (final item in items) _DoseBodyText(text: item)],
    );
  }
}
