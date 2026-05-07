import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail badge tone variants from Detail Spec `.badge`.
enum DetailBadgeTone {
  /// Base neutral badge.
  neutral,

  /// Danger badge.
  danger,

  /// Diagnosis/accent badge.
  dx,

  /// Transparent outline badge.
  outline,
}

/// Explicit badge colors, used for per-value enum badge colors.
final class DetailBadgeColors {
  /// Creates badge colors.
  const DetailBadgeColors({
    required this.background,
    required this.foreground,
    this.border,
  });

  /// Badge fill.
  final Color background;

  /// Badge text color.
  final Color foreground;

  /// Optional badge border color.
  final Color? border;
}

/// Detail Spec `.badge` pill.
class DetailBadge extends StatelessWidget {
  /// Creates a detail badge.
  const DetailBadge({
    required this.label,
    this.tone = DetailBadgeTone.neutral,
    this.colors,
    super.key,
  });

  /// Badge label.
  final String label;

  /// Badge tone.
  final DetailBadgeTone tone;

  /// Optional explicit colors for per-value badge palettes.
  final DetailBadgeColors? colors;

  @override
  Widget build(BuildContext context) {
    final resolved = colors ?? _resolveToneColors(context);
    return Container(
      key: const ValueKey<String>('detail-badge'),
      constraints: const BoxConstraints(
        minHeight: DetailConstants.badgeMinHeight,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DetailConstants.badgePaddingHorizontal,
        vertical: DetailConstants.badgePaddingVertical,
      ),
      decoration: BoxDecoration(
        color: resolved.background,
        border: Border.all(color: resolved.border ?? Colors.transparent),
        borderRadius: BorderRadius.circular(DetailConstants.badgeRadius),
      ),
      child: Text(
        label,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: resolved.foreground,
          fontSize: DetailConstants.badgeFontSize,
          fontWeight: FontWeight.w600,
          height: DetailConstants.badgeTextLineHeight,
        ),
      ),
    );
  }

  DetailBadgeColors _resolveToneColors(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final detailColors = Theme.of(context).extension<DetailColorExtension>()!;
    return switch (tone) {
      DetailBadgeTone.neutral => DetailBadgeColors(
        background: palette.surface3,
        foreground: palette.ink2,
      ),
      DetailBadgeTone.danger => DetailBadgeColors(
        background: palette.dangerCont,
        foreground: palette.danger,
      ),
      DetailBadgeTone.dx => DetailBadgeColors(
        background: palette.dxTint,
        foreground: palette.dxInk,
      ),
      DetailBadgeTone.outline => DetailBadgeColors(
        background: Colors.transparent,
        foreground: detailColors.onSurfaceVariant,
        border: detailColors.outline,
      ),
    };
  }
}

/// Detail Spec `.badges` wrap container.
class DetailBadgeWrap extends StatelessWidget {
  /// Creates a detail badge wrap.
  const DetailBadgeWrap({
    required this.children,
    super.key,
  });

  /// Badge children.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey<String>('detail-badge-wrap-margin'),
      padding: const EdgeInsets.only(top: DetailConstants.badgeWrapTopMargin),
      child: Wrap(
        key: const ValueKey<String>('detail-badge-wrap'),
        spacing: DetailConstants.badgeWrapGap,
        runSpacing: DetailConstants.badgeWrapGap,
        children: children,
      ),
    );
  }
}
