import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:flutter/material.dart';

/// Shows the all-history delete confirmation dialog.
Future<bool?> showBulkDeleteConfirmDialog({
  required BuildContext context,
  required int count,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => BulkDeleteConfirmDialog(count: count),
  );
}

/// Confirmation dialog for deleting all browsing history rows.
class BulkDeleteConfirmDialog extends StatelessWidget {
  /// Creates a bulk delete confirmation dialog.
  const BulkDeleteConfirmDialog({required this.count, super.key});

  /// Number of rows that will be deleted.
  final int count;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: BulkDeleteConfirmDialogCard(count: count),
    );
  }
}

/// Material card body for the bulk-delete confirmation dialog.
class BulkDeleteConfirmDialogCard extends StatelessWidget {
  /// Creates a bulk delete confirmation card.
  const BulkDeleteConfirmDialogCard({required this.count, super.key});

  /// Number of rows that will be deleted.
  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final textTheme = Theme.of(context).textTheme;
    final maxHeight = (MediaQuery.sizeOf(context).height - 48).clamp(
      160.0,
      560.0,
    );
    return Material(
      key: const ValueKey('history-bulk-delete-confirm-dialog'),
      color: palette.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 320, maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.historyBulkDeleteConfirmTitle(count),
                        key: const ValueKey(
                          'history-bulk-delete-confirm-title',
                        ),
                        style: textTheme.titleMedium?.copyWith(
                          color: palette.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.historyBulkDeleteConfirmBody,
                        key: const ValueKey(
                          'history-bulk-delete-confirm-body',
                        ),
                        style: textTheme.bodyMedium?.copyWith(
                          color: palette.ink2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _DialogButton(
                      key: const ValueKey(
                        'history-bulk-delete-confirm-cancel',
                      ),
                      label: l10n.historyBulkDeleteConfirmCancel,
                      foregroundColor: palette.primary,
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _DialogButton(
                      key: const ValueKey(
                        'history-bulk-delete-confirm-delete',
                      ),
                      label: l10n.historyBulkDeleteConfirmDelete,
                      foregroundColor: palette.danger,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.foregroundColor,
    required this.onPressed,
    super.key,
  });

  final String label;
  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, maxLines: 1),
        ),
      ),
    );
  }
}
