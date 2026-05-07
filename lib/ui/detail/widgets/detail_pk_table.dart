import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// A pharmacokinetic parameter row.
class DetailPkParameter {
  /// Creates a PK table row.
  const DetailPkParameter({required this.name, required this.value});

  /// Parameter name.
  final String name;

  /// Parameter value.
  final String value;
}

/// PK parameter table matching Detail Spec `.exam`.
class DetailPkTable extends StatelessWidget {
  /// Creates a PK parameter table.
  const DetailPkTable({
    required this.itemHeader,
    required this.valueHeader,
    required this.rows,
    super.key,
  });

  /// First column header.
  final String itemHeader;

  /// Second column header.
  final String valueHeader;

  /// Parameter rows.
  final List<DetailPkParameter> rows;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    final rowBorder = Border(bottom: BorderSide(color: colors.outlineVariant));

    return SizedBox(
      width: double.infinity,
      child: Table(
        key: const ValueKey<String>('detail-pk-table'),
        children: [
          TableRow(
            decoration: BoxDecoration(border: rowBorder),
            children: [
              _DetailPkCell(
                text: itemHeader.toUpperCase(),
                style: _headerStyle(colors),
              ),
              _DetailPkCell(
                text: valueHeader.toUpperCase(),
                style: _headerStyle(colors),
              ),
            ],
          ),
          for (final (index, row) in rows.indexed)
            TableRow(
              decoration: BoxDecoration(border: rowBorder),
              children: [
                _DetailPkCell(
                  cellKey: ValueKey<String>('detail-pk-cell-name-$index'),
                  text: row.name,
                  style: _bodyStyle(colors),
                ),
                _DetailPkCell(
                  cellKey: ValueKey<String>('detail-pk-cell-value-$index'),
                  text: row.value,
                  style: _bodyStyle(colors),
                ),
              ],
            ),
        ],
      ),
    );
  }

  TextStyle _headerStyle(DetailColorExtension colors) {
    return TextStyle(
      color: colors.onSurfaceVariant,
      fontSize: DetailConstants.examTableHeaderFontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: DetailConstants.examTableHeaderLetterSpacing,
    );
  }

  TextStyle _bodyStyle(DetailColorExtension colors) {
    return TextStyle(
      color: colors.onSurface,
      fontSize: DetailConstants.examTableBodyFontSize,
    );
  }
}

class _DetailPkCell extends StatelessWidget {
  const _DetailPkCell({required this.text, required this.style, this.cellKey});

  final String text;
  final TextStyle style;
  final Key? cellKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: cellKey,
      padding: const EdgeInsets.all(DetailConstants.examTableCellPadding),
      child: Text(text, style: style),
    );
  }
}
