import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec `.panel` section container.
class DetailPanel extends StatelessWidget {
  /// Creates a detail panel.
  const DetailPanel({
    required this.sectionIndex,
    required this.title,
    required this.child,
    this.subIndex,
    this.subtitle,
    this.showBottomDivider = true,
    super.key,
  });

  /// Compact section marker such as `D1` or `E4`.
  final String sectionIndex;

  /// Optional secondary marker rendered after the title.
  final String? subIndex;

  /// Section title.
  final String title;

  /// Optional section subtitle.
  final String? subtitle;

  /// Whether to render the panel bottom divider.
  final bool showBottomDivider;

  /// Panel body content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('detail-panel'),
      padding: const EdgeInsets.fromLTRB(
        DetailConstants.panelPaddingHorizontal,
        DetailConstants.panelPaddingVertical,
        DetailConstants.panelPaddingHorizontal,
        DetailConstants.panelPaddingVertical,
      ),
      decoration: BoxDecoration(
        border: showBottomDivider
            ? Border(bottom: BorderSide(color: colors.outlineVariant))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _DetailPanelHeading(
            colors: colors,
            sectionIndex: sectionIndex,
            subIndex: subIndex,
            title: title,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: DetailConstants.panelSubtitleTopGap),
            Text(
              subtitle!,
              key: const ValueKey<String>('detail-panel-subtitle'),
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: DetailConstants.panelSubtitleFontSize,
              ),
            ),
            const SizedBox(height: DetailConstants.panelSubtitleBottomGap),
          ] else
            const SizedBox(height: DetailConstants.panelTitleBottomGap),
          child,
        ],
      ),
    );
  }
}

class _DetailPanelHeading extends StatelessWidget {
  const _DetailPanelHeading({
    required this.colors,
    required this.sectionIndex,
    required this.title,
    this.subIndex,
  });

  final DetailColorExtension colors;
  final String sectionIndex;
  final String? subIndex;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey<String>('detail-panel-heading'),
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          key: const ValueKey<String>('detail-panel-index-box'),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(
              DetailConstants.panelIndexRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DetailConstants.panelIndexPaddingHorizontal,
              vertical: DetailConstants.panelIndexPaddingVertical,
            ),
            child: Text(
              sectionIndex,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: DetailConstants.panelIndexFontSize,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ),
        const SizedBox(width: DetailConstants.panelTitleGap),
        Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: DetailConstants.panelTitleFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (subIndex != null) ...[
          const SizedBox(width: DetailConstants.panelTitleGap),
          Text(
            subIndex!,
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: DetailConstants.panelSubIndexFontSize,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ],
      ],
    );
  }
}
