import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec chip tone variants.
enum DetailChipTone {
  /// Neutral search-chip tone.
  neutral,

  /// Danger search-chip tone.
  danger,

  /// Diagnosis/accent search-chip tone.
  dx,
}

/// Search-screen chip analogue used inside detail screens.
class DetailChip extends StatelessWidget {
  /// Creates a detail chip.
  const DetailChip({
    required this.label,
    this.tone = DetailChipTone.neutral,
    super.key,
  });

  /// User-visible label from l10n or domain data.
  final String label;

  /// Chip tone.
  final DetailChipTone tone;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final colors = _resolveColors(palette);
    return Container(
      key: const ValueKey<String>('detail-chip-wrapper'),
      padding: const EdgeInsets.symmetric(
        horizontal: DetailConstants.chipHostPaddingHorizontal,
        vertical: DetailConstants.chipHostPaddingVertical,
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(
          color: palette.hairline,
          width: DetailConstants.chipHostBorderWidth,
        ),
        borderRadius: BorderRadius.circular(DetailConstants.chipHostRadius),
      ),
      child: Align(
        key: const ValueKey<String>('detail-chip-host-align'),
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          key: const ValueKey<String>('detail-chip'),
          constraints: const BoxConstraints(
            minHeight: DetailConstants.chipMinHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DetailConstants.chipPaddingHorizontal,
            vertical: DetailConstants.chipPaddingVertical,
          ),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(DetailConstants.chipRadius),
          ),
          child: Text(
            label,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.foreground,
              fontSize: DetailConstants.chipFontSize,
              fontWeight: FontWeight.w600,
              height: DetailConstants.chipTextHeight,
            ),
          ),
        ),
      ),
    );
  }

  ({Color background, Color foreground}) _resolveColors(AppPalette palette) {
    return switch (tone) {
      DetailChipTone.neutral => (
        background: palette.surface3,
        foreground: palette.ink2,
      ),
      DetailChipTone.danger => (
        background: palette.dangerCont,
        foreground: palette.danger,
      ),
      DetailChipTone.dx => (
        background: palette.dxTint,
        foreground: palette.dxInk,
      ),
    };
  }
}
