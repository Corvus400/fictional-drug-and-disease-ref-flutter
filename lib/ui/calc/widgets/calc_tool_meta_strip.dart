import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Formula and metadata strip shown above calc forms.
class CalcToolMetaStrip extends StatelessWidget {
  /// Creates a tool metadata strip.
  const CalcToolMetaStrip({
    required this.label,
    required this.formula,
    super.key,
  });

  /// Tool label.
  final String label;

  /// Formula text.
  final String formula;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: typography.monoS
              .copyWith(color: palette.calcMuted, letterSpacing: 0.44)
              .withVariableWeight(FontWeight.w600),
        ),
        const Spacer(),
        Flexible(
          flex: 4,
          child: Text(
            formula,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: typography.monoS
                .copyWith(color: palette.calcInk2, letterSpacing: 0)
                .withVariableWeight(FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
