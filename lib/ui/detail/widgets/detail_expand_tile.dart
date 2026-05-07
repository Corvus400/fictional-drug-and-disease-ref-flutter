import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec `.ref-row` plain-text expansion tile.
class DetailExpandTile extends StatelessWidget {
  /// Creates a reference expansion tile.
  const DetailExpandTile({
    required this.title,
    required this.body,
    this.initiallyExpanded = false,
    super.key,
  });

  /// Summary title.
  final String title;

  /// Plain text body.
  final String body;

  /// Whether the tile starts expanded.
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('detail-expand-tile'),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme: const ExpansionTileThemeData(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            expandedAlignment: Alignment.centerLeft,
            expansionAnimationStyle: AnimationStyle(
              duration: DetailConstants.expandTileDuration,
            ),
          ),
        ),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          title: Padding(
            key: const ValueKey<String>('detail-expand-tile-summary'),
            padding: const EdgeInsets.symmetric(
              vertical: DetailConstants.expandTileSummaryPaddingVertical,
            ),
            child: Text(
              title,
              softWrap: true,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: DetailConstants.expandTileTitleFontSize,
              ),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: DetailConstants.expandTileBodyPaddingBottom,
              ),
              child: Text(
                body,
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: DetailConstants.expandTileBodyFontSize,
                  height: DetailConstants.expandTileBodyLineHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
