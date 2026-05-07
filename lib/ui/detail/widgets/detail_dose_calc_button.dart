import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail footer dose calculation action button.
class DetailDoseCalcButton extends StatelessWidget {
  /// Creates a dose calculation button.
  const DetailDoseCalcButton({
    required this.label,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  /// Button label supplied by l10n at call sites.
  final String label;

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// Whether the button accepts taps.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? onPressed : null,
      child: Container(
        key: const ValueKey<String>('detail-dose-calc-button'),
        constraints: const BoxConstraints.tightFor(
          height: DetailConstants.footerActionHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: DetailConstants.footerActionPaddingHorizontal,
        ),
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(
            DetailConstants.footerActionRadius,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calculate_outlined,
              color: colors.onPrimary,
              size: DetailConstants.footerActionIconSize,
            ),
            const SizedBox(width: DetailConstants.footerActionGap),
            Text(
              label,
              style: TextStyle(
                color: colors.onPrimary,
                fontSize: DetailConstants.footerActionFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
