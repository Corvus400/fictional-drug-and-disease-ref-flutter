import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Inline indicator shown while a calculation history row is restored.
class CalcHistoryRestoringIndicator extends StatelessWidget {
  /// Creates a restoring indicator.
  const CalcHistoryRestoringIndicator({
    required this.message,
    this.progressValue,
    super.key,
  });

  /// Localized restoring message.
  final String message;

  /// Optional deterministic progress value for static visual tests.
  final double? progressValue;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Column(
      key: const ValueKey<String>('calc-history-restoring-indicator'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 38,
          child: CircularProgressIndicator(
            value: progressValue,
            strokeWidth: 4,
            strokeCap: StrokeCap.round,
            color: palette.calcPrimary,
          ),
        ),
        SizedBox(height: spacing.s2),
        Text(
          message,
          style: typography.bodyS.copyWith(
            color: palette.calcInk,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
      ],
    );
  }
}
