import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec `.kv` key-value row.
class DetailKvRow extends StatelessWidget {
  /// Creates a key-value row.
  const DetailKvRow({
    required this.label,
    required this.value,
    this.showTopBorder = false,
    super.key,
  });

  /// Key label.
  final String label;

  /// Value text.
  final String value;

  /// Whether to render the top border.
  final bool showTopBorder;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    final borderSide = BorderSide(color: colors.outlineVariant);
    return Container(
      key: const ValueKey<String>('detail-kv-row'),
      decoration: BoxDecoration(
        border: Border(
          top: showTopBorder ? borderSide : BorderSide.none,
          bottom: borderSide,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            key: const ValueKey<String>('detail-kv-label-box'),
            width: DetailConstants.kvLabelWidth,
            child: Padding(
              key: const ValueKey<String>('detail-kv-label-cell'),
              padding: const EdgeInsets.symmetric(
                vertical: DetailConstants.kvPaddingVertical,
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: DetailConstants.kvFontSize,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              key: const ValueKey<String>('detail-kv-value-cell'),
              padding: const EdgeInsets.symmetric(
                vertical: DetailConstants.kvPaddingVertical,
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: DetailConstants.kvFontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
