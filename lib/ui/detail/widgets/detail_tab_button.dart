import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Top-level detail tab control for phone tab bar and tablet navigation pane.
class DetailTabButton extends StatelessWidget {
  /// Creates a detail tab control.
  const DetailTabButton({
    required this.label,
    required this.selected,
    required this.onPressed,
    this.sectionNumber,
    super.key,
  });

  /// Display label.
  final String label;

  /// Whether this tab is selected.
  final bool selected;

  /// Selects this tab.
  final VoidCallback onPressed;

  /// Tablet navigation section number.
  final int? sectionNumber;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTabletPane = constraints.maxWidth.isFinite;
        return isTabletPane ? _buildTablet(context) : _buildPhone(context);
      },
    );
  }

  Widget _buildPhone(BuildContext context) {
    final colors = _detailColors(context);
    return InkWell(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? colors.primary : Colors.transparent,
              width: DetailConstants.phoneTabIndicatorHeight,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DetailConstants.phoneTabPaddingHorizontal,
            vertical: DetailConstants.phoneTabPaddingVertical,
          ),
          child: Text(
            label,
            maxLines: DetailConstants.singleLineTextMaxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected ? colors.primary : colors.onSurfaceVariant,
              fontSize: DetailConstants.detailTabFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTablet(BuildContext context) {
    final colors = _detailColors(context);
    return Material(
      color: selected ? colors.primaryContainer : colors.surfaceContainerLow,
      child: InkWell(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: selected ? colors.primary : Colors.transparent,
                width: DetailConstants.tabletNavIndicatorWidth,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DetailConstants.tabletNavItemPaddingHorizontal,
              vertical: DetailConstants.tabletNavItemPaddingVertical,
            ),
            child: Row(
              children: [
                if (sectionNumber != null) ...[
                  _TabletNavIndex(number: sectionNumber!),
                  const SizedBox(width: DetailConstants.tabletNavIndexGap),
                ],
                Expanded(
                  child: Text(
                    label,
                    maxLines: DetailConstants.singleLineTextMaxLines,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? colors.onPrimaryContainer
                          : colors.onSurfaceVariant,
                      fontSize: DetailConstants.tabletNavItemFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabletNavIndex extends StatelessWidget {
  const _TabletNavIndex({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final colors = _detailColors(context);
    return DecoratedBox(
      key: const ValueKey<String>('detail-tablet-nav-index-box'),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(
          DetailConstants.tabletNavIndexRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DetailConstants.tabletNavIndexPaddingHorizontal,
          vertical: DetailConstants.tabletNavIndexPaddingVertical,
        ),
        child: Text(
          number.toString(),
          key: const ValueKey<String>('detail-tablet-nav-index'),
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: DetailConstants.tabletNavIndexFontSize,
            fontWeight: FontWeight.w700,
            height: DetailConstants.panelCompactLabelLineHeight,
          ),
        ),
      ),
    );
  }
}

DetailColorExtension _detailColors(BuildContext context) {
  final theme = Theme.of(context);
  final extension = theme.extension<DetailColorExtension>();
  if (extension != null) {
    return extension;
  }
  return theme.brightness == Brightness.dark
      ? DetailColorExtension.dark
      : DetailColorExtension.light;
}
