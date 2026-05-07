import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec `.warn-banner` alert block.
class DetailWarnBanner extends StatelessWidget {
  /// Creates a warning banner.
  const DetailWarnBanner({
    required this.items,
    super.key,
  });

  /// Warning lines rendered as a numbered list.
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Container(
      key: const ValueKey<String>('detail-warn-banner'),
      padding: const EdgeInsets.symmetric(
        horizontal: DetailConstants.warnBannerPaddingHorizontal,
        vertical: DetailConstants.warnBannerPaddingVertical,
      ),
      decoration: BoxDecoration(
        color: palette.dangerCont,
        border: Border.all(
          color: palette.danger,
          width: DetailConstants.warnBannerBorderWidth,
        ),
        borderRadius: BorderRadius.circular(DetailConstants.warnBannerRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            key: const ValueKey<String>('detail-warn-banner-dot'),
            constraints: const BoxConstraints.tightFor(
              width: DetailConstants.warnBannerDotSize,
              height: DetailConstants.warnBannerDotSize,
            ),
            margin: const EdgeInsets.only(
              top: DetailConstants.warnBannerDotTopMargin,
            ),
            decoration: BoxDecoration(
              color: palette.danger,
              borderRadius: BorderRadius.circular(
                DetailConstants.warnBannerDotSize / 2,
              ),
            ),
            child: Center(
              child: Text(
                '!',
                style: TextStyle(
                  color: palette.brightness == Brightness.dark
                      ? palette.dangerCont
                      : palette.onPrimary,
                  fontSize: DetailConstants.warnBannerDotFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: DetailConstants.warnBannerGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final (index, item) in items.indexed)
                  Text(
                    '${index + 1}. $item',
                    style: TextStyle(
                      color: palette.danger,
                      fontSize: DetailConstants.warnBannerFontSize,
                      height: DetailConstants.warnBannerLineHeight,
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
