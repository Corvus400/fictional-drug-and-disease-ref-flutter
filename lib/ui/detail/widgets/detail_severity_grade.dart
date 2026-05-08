import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:flutter/material.dart';

/// Severity grading row matching Detail Spec `.grade`.
class DetailSeverityGrade extends StatelessWidget {
  /// Creates a severity grading row.
  const DetailSeverityGrade({
    required this.label,
    required this.criteria,
    required this.recommendedAction,
    this.isFirst = false,
    super.key,
  });

  /// Short grade label shown in the fixed-width left column.
  final String label;

  /// Grade criteria shown as the bold first description line.
  final String criteria;

  /// Recommended action shown as secondary text.
  final String recommendedAction;

  /// Whether this is the first grade in a consecutive group.
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;

    return Container(
      key: const ValueKey<String>('detail-severity-grade'),
      margin: EdgeInsets.only(
        top: isFirst ? 0 : DetailConstants.severityGradeTopMargin,
      ),
      padding: const EdgeInsets.all(DetailConstants.severityGradePadding),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(
          DetailConstants.severityGradeRadius,
        ),
      ),
      child: Row(
        key: const ValueKey<String>('detail-severity-grade-grid'),
        children: [
          SizedBox(
            key: const ValueKey<String>('detail-severity-grade-label-box'),
            width: DetailConstants.severityGradeLabelWidth,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.primary,
                fontSize: DetailConstants.severityGradeLabelFontSize,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: DetailConstants.severityGradeGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: DetailConstants.severityGradeCriteriaBottomMargin,
                  ),
                  child: Text(
                    criteria,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: DetailConstants.severityGradeFontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                DetailMarkdownBody(
                  data: recommendedAction,
                  color: colors.onSurfaceVariant,
                  fontSize: DetailConstants.severityGradeFontSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
