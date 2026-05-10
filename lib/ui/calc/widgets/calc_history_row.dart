import 'dart:async';

import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// History row atom for calculation history.
class CalcHistoryRow extends StatefulWidget {
  /// Creates a history row.
  const CalcHistoryRow({
    required this.dateText,
    required this.resultText,
    required this.summaryText,
    this.deleteLabel,
    this.deleteRevealed = false,
    this.showBottomBorder = true,
    this.borderRadius = BorderRadius.zero,
    this.onRestore,
    this.onDelete,
    super.key,
  }) : assert(
         !deleteRevealed || deleteLabel != null,
         'deleteLabel is required when deleteRevealed is true.',
       );

  /// Date label.
  final String dateText;

  /// Result label.
  final String resultText;

  /// Input summary.
  final String summaryText;

  /// Delete action label supplied by the caller's localization layer.
  final String? deleteLabel;

  /// Whether the delete action is visible.
  final bool deleteRevealed;

  /// Whether to draw the row separator line.
  final bool showBottomBorder;

  /// Radius applied to the row's exposed right edge.
  final BorderRadius borderRadius;

  /// Restore callback.
  final VoidCallback? onRestore;

  /// Delete callback.
  final VoidCallback? onDelete;

  @override
  State<CalcHistoryRow> createState() => _CalcHistoryRowState();
}

class _CalcHistoryRowState extends State<CalcHistoryRow>
    with SingleTickerProviderStateMixin {
  static const _deleteWidth = 72.0;
  static const _deleteColor = Color(0xFFB3261E);
  static const _rowHeight = 38.0;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      value: widget.deleteRevealed ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(covariant CalcHistoryRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.deleteRevealed == oldWidget.deleteRevealed) {
      return;
    }
    if (widget.deleteRevealed) {
      _controller.value = 1;
    } else {
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasDeleteAction = widget.deleteLabel != null;
    final canDrag = hasDeleteAction && widget.onDelete != null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: _rowHeight,
          child: ClipRect(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragUpdate: canDrag
                  ? (details) {
                      final delta = details.primaryDelta ?? 0;
                      final nextValue =
                          (_controller.value - delta / _deleteWidth).clamp(
                            0.0,
                            1.0,
                          );
                      _controller.value = nextValue;
                    }
                  : null,
              onHorizontalDragEnd: canDrag
                  ? (_) {
                      if (_controller.value >= 0.4) {
                        unawaited(
                          _controller.animateTo(
                            1,
                            curve: Curves.easeOutCubic,
                          ),
                        );
                      } else {
                        unawaited(
                          _controller.animateTo(
                            0,
                            curve: Curves.easeOutCubic,
                          ),
                        );
                      }
                    }
                  : null,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final revealValue = hasDeleteAction ? _controller.value : 0.0;
                  final rowOffset = hasDeleteAction
                      ? -_deleteWidth * revealValue
                      : 0.0;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      if (hasDeleteAction)
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRect(
                            key: const ValueKey<String>(
                              'history-delete-reveal',
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              widthFactor: revealValue,
                              child: _DeleteAction(
                                label: widget.deleteLabel!,
                                onDelete: widget.onDelete,
                                width: _deleteWidth,
                                color: _deleteColor,
                                borderRadius: widget.borderRadius,
                              ),
                            ),
                          ),
                        ),
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(rowOffset, 0),
                          child: SizedBox(
                            width: constraints.maxWidth,
                            child: _HistoryRowContent(
                              dateText: widget.dateText,
                              resultText: widget.resultText,
                              summaryText: widget.summaryText,
                              showBottomBorder: widget.showBottomBorder,
                              borderRadius: widget.borderRadius,
                              onTap: widget.onRestore,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HistoryRowContent extends StatelessWidget {
  const _HistoryRowContent({
    required this.dateText,
    required this.resultText,
    required this.summaryText,
    required this.showBottomBorder,
    required this.borderRadius,
    this.onTap,
  });

  final String dateText;
  final String resultText;
  final String summaryText;
  final bool showBottomBorder;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return ClipRRect(
      key: const ValueKey<String>('history-row-clip'),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              key: const ValueKey<String>('history-row-surface'),
              decoration: BoxDecoration(color: palette.calcSurface),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: spacing.s3,
                end: spacing.s3,
                top: spacing.s2,
                bottom: spacing.s2,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: typography.labelM
                            .copyWith(color: palette.calcInk)
                            .withVariableWeight(FontWeight.w500),
                        children: [
                          TextSpan(
                            text: dateText,
                            style: typography.monoS
                                .copyWith(color: palette.calcMuted)
                                .withVariableWeight(FontWeight.w600),
                          ),
                          TextSpan(
                            text: '  $resultText',
                            style: const TextStyle().withVariableWeight(
                              FontWeight.w700,
                            ),
                          ),
                          TextSpan(text: ' · $summaryText'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spacing.s2),
                  Icon(Icons.refresh, size: 18, color: palette.calcMuted),
                ],
              ),
            ),
            if (showBottomBorder)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 1,
                child: ColoredBox(color: palette.calcHairline2),
              ),
          ],
        ),
      ),
    );
  }
}

class _DeleteAction extends StatelessWidget {
  const _DeleteAction({
    required this.label,
    required this.width,
    required this.color,
    required this.borderRadius,
    this.onDelete,
  });

  final String label;
  final VoidCallback? onDelete;
  final double width;
  final Color color;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: const ValueKey<String>('history-delete'),
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: _CalcHistoryRowState._rowHeight,
        child: GestureDetector(
          onTap: onDelete,
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete_outline, color: Colors.white, size: 18),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'NotoSansJP',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
