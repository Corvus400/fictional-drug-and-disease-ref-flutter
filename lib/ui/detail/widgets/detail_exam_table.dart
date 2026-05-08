import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:flutter/material.dart';

/// A required-exam table row.
class DetailExamRow {
  /// Creates a required-exam table row.
  const DetailExamRow({
    required this.name,
    required this.category,
    required this.finding,
  });

  /// Exam name.
  final String name;

  /// Exam category displayed as a small pill.
  final String category;

  /// Typical finding.
  final String finding;
}

/// Required-exam table matching Detail Spec `.exam`.
class DetailExamTable extends StatelessWidget {
  /// Creates a required-exam table.
  const DetailExamTable({
    required this.rows,
    this.nameHeader = '検査',
    this.categoryHeader = '区分',
    this.findingHeader = '所見',
    this.categoryAsPill = true,
    this.nameAsMarkdown = false,
    this.categoryAsMarkdown = false,
    this.findingAsMarkdown = false,
    super.key,
  });

  /// Exam rows.
  final List<DetailExamRow> rows;

  /// First column header.
  final String nameHeader;

  /// Second column header.
  final String categoryHeader;

  /// Third column header.
  final String findingHeader;

  /// Whether the second column body is rendered as a compact pill.
  final bool categoryAsPill;

  /// Whether the first column body is Markdown.
  final bool nameAsMarkdown;

  /// Whether the second column body is Markdown.
  final bool categoryAsMarkdown;

  /// Whether the third column body is Markdown.
  final bool findingAsMarkdown;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final rowBorder = Border(bottom: BorderSide(color: colors.outlineVariant));

    return SizedBox(
      width: double.infinity,
      child: Table(
        key: const ValueKey<String>('detail-exam-table'),
        children: [
          TableRow(
            decoration: BoxDecoration(border: rowBorder),
            children: [
              _DetailExamTextCell(
                text: nameHeader.toUpperCase(),
                style: _headerStyle(colors),
              ),
              _DetailExamTextCell(
                text: categoryHeader.toUpperCase(),
                style: _headerStyle(colors),
              ),
              _DetailExamTextCell(
                text: findingHeader.toUpperCase(),
                style: _headerStyle(colors),
              ),
            ],
          ),
          for (final (index, row) in rows.indexed)
            TableRow(
              decoration: BoxDecoration(border: rowBorder),
              children: [
                _DetailExamTextCell(
                  cellKey: ValueKey<String>('detail-exam-cell-name-$index'),
                  text: row.name,
                  style: _bodyStyle(colors),
                  asMarkdown: nameAsMarkdown,
                ),
                if (categoryAsPill)
                  _DetailExamCategoryPillCell(
                    index: index,
                    text: row.category,
                    palette: palette,
                  )
                else
                  _DetailExamTextCell(
                    cellKey: ValueKey<String>(
                      'detail-exam-cell-category-$index',
                    ),
                    text: row.category,
                    style: _bodyStyle(colors),
                    asMarkdown: categoryAsMarkdown,
                  ),
                _DetailExamTextCell(
                  text: row.finding,
                  style: _bodyStyle(colors),
                  asMarkdown: findingAsMarkdown,
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

class _DetailExamTextCell extends StatelessWidget {
  const _DetailExamTextCell({
    required this.text,
    required this.style,
    this.cellKey,
    this.asMarkdown = false,
  });

  final String text;
  final TextStyle style;
  final Key? cellKey;
  final bool asMarkdown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: cellKey,
      padding: const EdgeInsets.all(DetailConstants.examTableCellPadding),
      child: asMarkdown
          ? DetailMarkdownBody(
              data: text,
              color: style.color,
              fontSize: style.fontSize,
            )
          : Text(text, style: style),
    );
  }
}

class _DetailExamCategoryPillCell extends StatelessWidget {
  const _DetailExamCategoryPillCell({
    required this.index,
    required this.text,
    required this.palette,
  });

  final int index;
  final String text;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DetailConstants.examTableCellPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          key: ValueKey<String>('detail-exam-category-pill-$index'),
          padding: const EdgeInsets.symmetric(
            horizontal: DetailConstants.examTablePillPaddingHorizontal,
            vertical: DetailConstants.examTablePillPaddingVertical,
          ),
          decoration: BoxDecoration(
            color: palette.surface3,
            borderRadius: BorderRadius.circular(
              DetailConstants.examTablePillRadius,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: palette.ink2,
              fontSize: DetailConstants.examTablePillFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
