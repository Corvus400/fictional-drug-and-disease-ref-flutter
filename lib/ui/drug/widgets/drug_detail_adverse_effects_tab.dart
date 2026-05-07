import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_serious_card.dart';
import 'package:flutter/material.dart';

/// Adverse effects tab for drug detail.
class DrugDetailAdverseEffectsTab extends StatelessWidget {
  /// Creates an adverse effects tab.
  const DrugDetailAdverseEffectsTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reactions = drug.adverseReactions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'D12',
          title: l10n.detailDrugSectionSeriousAdverseReactions,
          child: Column(
            children: [
              for (final reaction in reactions.serious)
                DetailSeriousCard(
                  name: reaction.name,
                  description:
                      '${_frequencyLabel(l10n, reaction.frequency)} — '
                      '${reaction.symptom}',
                  meta: [
                    _seriousMetaLabel(
                      l10n.detailDrugInitialSigns,
                      reaction.initialSigns,
                    ),
                    _seriousMetaLabel(
                      l10n.detailDrugCountermeasure,
                      reaction.countermeasure,
                    ),
                  ],
                ),
            ],
          ),
        ),
        DetailPanel(
          sectionIndex: 'D13',
          title: l10n.detailDrugSectionOtherAdverseReactions,
          showBottomDivider: false,
          child: _FrequencyRows(other: reactions.other),
        ),
      ],
    );
  }
}

class _FrequencyRows extends StatelessWidget {
  const _FrequencyRows({required this.other});

  final AdverseReactionByFrequency other;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _FrequencyRow(
          label: l10n.detailDrugSectionFreqOver5,
          values: other.over5Percent,
        ),
        _FrequencyRow(
          label: l10n.detailDrugSectionFreq1to5,
          values: other.between1And5Percent,
        ),
        _FrequencyRow(
          label: l10n.detailDrugSectionFreqUnder1,
          values: other.under1Percent,
        ),
        _FrequencyRow(
          label: l10n.detailDrugSectionFreqUnknown,
          values: other.frequencyUnknown,
        ),
      ],
    );
  }
}

class _FrequencyRow extends StatelessWidget {
  const _FrequencyRow({required this.label, required this.values});

  final String label;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('drug-detail-frequency-row'),
      padding: const EdgeInsets.symmetric(
        vertical: DetailConstants.frequencyRowPaddingVertical,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colors.outlineVariant),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: DetailConstants.frequencyLabelWidth,
            child: Text(
              label,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: DetailConstants.kvFontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: DetailConstants.frequencyRowGap),
          Expanded(
            child: Wrap(
              spacing: DetailConstants.frequencyValueGap,
              runSpacing: DetailConstants.frequencyValueGap,
              children: [
                for (final value in values)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(
                        DetailConstants.frequencyValueRadius,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            DetailConstants.frequencyValuePaddingHorizontal,
                        vertical: DetailConstants.frequencyValuePaddingVertical,
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: DetailConstants.kvFontSize,
                          height: DetailConstants.bodyTextLineHeight,
                        ),
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
}

String _frequencyLabel(AppLocalizations l10n, String frequency) {
  return switch (frequency) {
    'over_5_percent' => l10n.detailDrugSectionFreqOver5,
    'between_1_and_5_percent' => l10n.detailDrugSectionFreq1to5,
    'under_1_percent' => l10n.detailDrugSectionFreqUnder1,
    'unknown' => l10n.detailDrugSectionFreqUnknown,
    _ => frequency,
  };
}

String _seriousMetaLabel(String label, String value) => '$label $value';
