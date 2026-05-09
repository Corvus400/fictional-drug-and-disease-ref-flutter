import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
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

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    final valueColor = placeholder ? palette.calcMuted2 : palette.calcInk;

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: typography.labelM.copyWith(
                        color: palette.calcMuted,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.48,
                      ),
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
                    valueText,
                    style: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 36,
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
              if (visualization != null) ...[
                SizedBox(height: spacing.s2),
                visualization!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
