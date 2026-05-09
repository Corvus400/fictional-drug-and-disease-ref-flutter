import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Empty history list atom.
class CalcHistoryEmptyState extends StatelessWidget {
  /// Creates an empty history state.
  const CalcHistoryEmptyState({required this.message, super.key});

  /// Empty-state message.
  final String message;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.calcSurface,
        border: Border.all(color: palette.calcHairline),
        borderRadius: BorderRadius.circular(radii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Symbols.history_toggle_off,
              size: 36,
              color: palette.calcMuted2,
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: typography.labelM.copyWith(
                  color: palette.calcMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
