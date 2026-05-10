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
  static const _deleteVerticalBleed = 6.0;
  static const _rowHeight = 38.0;

  late final AnimationController _controller;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      value: widget.deleteRevealed ? 1 : 0,
    );
    _offset = Tween<double>(
      begin: 0,
      end: -_deleteWidth,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
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
            clipBehavior: Clip.none,
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
                        unawaited(_controller.forward());
                      } else {
                        unawaited(_controller.reverse());
                      }
                    }
                  : null,
              child: AnimatedBuilder(
                animation: _offset,
                builder: (context, _) {
                  final revealed = hasDeleteAction && _controller.value > 0;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Transform.translate(
                        offset: Offset(hasDeleteAction ? _offset.value : 0, 0),
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: _HistoryRowContent(
                            dateText: widget.dateText,
                            resultText: widget.resultText,
                            summaryText: widget.summaryText,
                            trailingPaddingFactor: hasDeleteAction
                                ? 1 - _controller.value
                                : 1,
                            showBottomBorder:
                                widget.showBottomBorder &&
                                _controller.value == 0,
                            onTap: widget.onRestore,
                          ),
                        ),
                      ),
                      if (revealed)
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: -_deleteVerticalBleed,
                          child: _DeleteAction(
                            label: widget.deleteLabel!,
                            onDelete: widget.onDelete,
                            width: _deleteWidth,
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
    required this.trailingPaddingFactor,
    required this.showBottomBorder,
    this.onTap,
  });

  final String dateText;
  final String resultText;
  final String summaryText;
  final double trailingPaddingFactor;
  final bool showBottomBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.calcSurface,
          border: showBottomBorder
              ? Border(bottom: BorderSide(color: palette.calcHairline2))
              : null,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: spacing.s3,
            end: spacing.s3 * trailingPaddingFactor,
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
      ),
    );
  }
}

class _DeleteAction extends StatelessWidget {
  const _DeleteAction({
    required this.label,
    required this.width,
    this.onDelete,
  });

  final String label;
  final VoidCallback? onDelete;
  final double width;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;

    return SizedBox(
      key: const ValueKey<String>('history-delete'),
      width: width,
      height: 38,
      child: GestureDetector(
        onTap: onDelete,
        child: DecoratedBox(
          decoration: BoxDecoration(color: palette.calcError),
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
    );
  }
}
