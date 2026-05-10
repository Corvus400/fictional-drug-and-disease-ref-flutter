import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_restoring_indicator.dart';
import 'package:flutter/material.dart';

/// Result card atom for calc tools.
class CalcResultCard extends StatelessWidget {
  /// Creates a result card.
  const CalcResultCard({
    required this.title,
    required this.formula,
    required this.valueText,
    required this.unit,
    this.placeholder = false,
    this.hintText,
    this.badges = const [],
    this.visualization,
    this.restoringMessage,
    this.restoringProgressValue,
    super.key,
  });

  /// Result title.
  final String title;

  /// Formula label.
  final String formula;

  /// Value text.
  final String valueText;

  /// Unit suffix.
  final String unit;

  /// Whether [valueText] is a placeholder.
  final bool placeholder;

  /// Optional partial-input hint.
  final String? hintText;

  /// Classification badges.
  final List<Widget> badges;

  /// Optional chart/visualization slot, implemented by chart atoms.
  final Widget? visualization;

  /// Message shown in the visualization slot while restoring history.
  final String? restoringMessage;

  /// Optional deterministic progress value for static visual tests.
  final double? restoringProgressValue;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    final valueColor = placeholder ? palette.calcMuted2 : palette.calcInk;
    final largeText = MediaQuery.textScalerOf(context).scale(16) >= 20.8;
    final valueFontSize = largeText ? 54.0 : 36.0;
    final contentOpacity = restoringMessage == null ? 1.0 : 0.42;
    final titleStyle = typography.labelM.copyWith(
      color: palette.calcMuted,
      fontSize: largeText ? 18 : null,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.48,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.calcSurface,
        borderRadius: BorderRadius.circular(radii.card),
        border: Border.all(color: palette.calcHairline),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.04),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 95),
        child: Padding(
          padding: EdgeInsets.all(spacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: contentOpacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          formula,
                          textAlign: TextAlign.end,
                          style: typography.monoS.copyWith(
                            color: palette.calcMuted,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spacing.s2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          key: const ValueKey<String>('calc-result-value'),
                          valueText,
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: valueFontSize,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ).copyWith(color: valueColor),
                        ),
                        SizedBox(width: spacing.s1 + 2),
                        Flexible(
                          child: Text(
                            unit,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'JetBrainsMono',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ).copyWith(color: palette.calcMuted),
                          ),
                        ),
                      ],
                    ),
                    if (hintText != null) ...[
                      SizedBox(height: spacing.s2),
                      Text(
                        hintText!,
                        style: typography.monoS.copyWith(
                          color: palette.calcMuted,
                          fontFamilyFallback: const ['NotoSansJP'],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (badges.isNotEmpty) ...[
                      SizedBox(height: spacing.s2),
                      Wrap(
                        spacing: spacing.s2,
                        runSpacing: spacing.s2,
                        children: badges,
                      ),
                    ],
                  ],
                ),
              ),
              if (visualization != null || restoringMessage != null) ...[
                SizedBox(height: badges.isEmpty ? spacing.s2 : spacing.s8),
                _CalcVisualizationSlot(
                  visualization: visualization,
                  restoringMessage: restoringMessage,
                  restoringProgressValue: restoringProgressValue,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CalcVisualizationSlot extends StatelessWidget {
  const _CalcVisualizationSlot({
    required this.visualization,
    required this.restoringMessage,
    required this.restoringProgressValue,
  });

  final Widget? visualization;
  final String? restoringMessage;
  final double? restoringProgressValue;

  @override
  Widget build(BuildContext context) {
    final hasRestoring = restoringMessage != null;
    return SizedBox(
      height: hasRestoring ? 82 : null,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          if (visualization != null)
            Opacity(
              opacity: hasRestoring ? 0.46 : 1,
              child: visualization,
            ),
          if (hasRestoring)
            Positioned(
              top: -18,
              child: CalcHistoryRestoringIndicator(
                message: restoringMessage!,
                progressValue: restoringProgressValue,
              ),
            ),
        ],
      ),
    );
  }
}
