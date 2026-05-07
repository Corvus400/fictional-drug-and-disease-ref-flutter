import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec `.acc` disclosure block.
class DetailAccordion extends StatefulWidget {
  /// Creates a detail accordion.
  const DetailAccordion({
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
    super.key,
  });

  /// Summary title.
  final String title;

  /// Body content shown while expanded.
  final Widget child;

  /// Whether the accordion starts open.
  final bool initiallyExpanded;

  @override
  State<DetailAccordion> createState() => _DetailAccordionState();
}

class _DetailAccordionState extends State<DetailAccordion> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        key: const ValueKey<String>('detail-accordion'),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _expanded
              ? colors.surfaceContainer
              : colors.surfaceContainerLow,
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(DetailConstants.accordionRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              key: const ValueKey<String>('detail-accordion-summary'),
              padding: const EdgeInsets.symmetric(
                horizontal: DetailConstants.accordionSummaryPaddingHorizontal,
                vertical: DetailConstants.accordionSummaryPaddingVertical,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: DetailConstants.accordionTitleFontSize,
                        fontWeight: FontWeight.w600,
                        height: DetailConstants.accordionTitleLineHeight,
                      ),
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(width: DetailConstants.accordionSummaryGap),
                  AnimatedRotation(
                    key: const ValueKey<String>('detail-accordion-chevron'),
                    turns: _expanded ? 0.5 : 0,
                    duration: DetailConstants.accordionChevronDuration,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: colors.onSurfaceVariant,
                      size: DetailConstants.gapL,
                    ),
                  ),
                ],
              ),
            ),
            if (_expanded)
              Padding(
                key: const ValueKey<String>('detail-accordion-body'),
                padding: const EdgeInsets.fromLTRB(
                  DetailConstants.accordionBodyPaddingHorizontal,
                  0,
                  DetailConstants.accordionBodyPaddingHorizontal,
                  DetailConstants.accordionBodyPaddingBottom,
                ),
                child: DefaultTextStyle.merge(
                  key: const ValueKey<String>(
                    'detail-accordion-body-text-style',
                  ),
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: DetailConstants.accordionBodyFontSize,
                    height: DetailConstants.accordionBodyLineHeight,
                  ),
                  child: widget.child,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
