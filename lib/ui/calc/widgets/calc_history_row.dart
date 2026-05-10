import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

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

class _CalcHistoryRowState extends State<CalcHistoryRow> {
  bool _deleteRevealed = false;

  @override
  Widget build(BuildContext context) {
    final revealed = widget.deleteRevealed || _deleteRevealed;
    if (!revealed) {
      final content = _HistoryRowContent(
        dateText: widget.dateText,
        resultText: widget.resultText,
        summaryText: widget.summaryText,
        showBottomBorder: widget.showBottomBorder,
        onTap: widget.onRestore,
      );

      if (widget.deleteLabel == null || widget.onDelete == null) {
        return content;
      }

      return Dismissible(
        key: ValueKey<String>(
          'history-dismissible-${widget.dateText}-'
          '${widget.resultText}-${widget.summaryText}',
        ),
        direction: DismissDirection.endToStart,
        dismissThresholds: const {DismissDirection.endToStart: 0.4},
        movementDuration: const Duration(milliseconds: 120),
        confirmDismiss: (_) async {
          setState(() => _deleteRevealed = true);
          return false;
        },
        background: Align(
          alignment: Alignment.centerRight,
          child: _DeleteAction(
            label: widget.deleteLabel!,
            onDelete: widget.onDelete,
          ),
        ),
        child: content,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRect(
          child: SizedBox(
            height: 38,
            child: OverflowBox(
              alignment: Alignment.topCenter,
              minHeight: 0,
              maxHeight: double.infinity,
              child: SizedBox(
                width: constraints.maxWidth,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: _DeleteAction(
                        label: widget.deleteLabel!,
                        onDelete: widget.onDelete,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-72, 0),
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: _HistoryRowContent(
                          dateText: widget.dateText,
                          resultText: widget.resultText,
                          summaryText: widget.summaryText,
                          showBottomBorder: widget.showBottomBorder,
                          onTap: widget.onRestore,
                        ),
                      ),
                    ),
                  ],
                ),
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
    this.onTap,
  });

  final String dateText;
  final String resultText;
  final String summaryText;
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
          padding: EdgeInsets.symmetric(
            horizontal: spacing.s3,
            vertical: spacing.s2,
          ),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: typography.labelM.copyWith(
                      color: palette.calcInk,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: dateText,
                        style: typography.monoS.copyWith(
                          color: palette.calcMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '  $resultText',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: ' · $summaryText'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spacing.s2),
              Icon(Symbols.refresh, size: 18, color: palette.calcMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteAction extends StatelessWidget {
  const _DeleteAction({required this.label, this.onDelete});

  final String label;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;

    return SizedBox(
      key: const ValueKey<String>('history-delete'),
      width: 72,
      height: 38,
      child: GestureDetector(
        onTap: onDelete,
        child: DecoratedBox(
          decoration: BoxDecoration(color: palette.calcError),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Symbols.delete, color: Colors.white, size: 18),
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
