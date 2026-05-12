import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/format/relative_viewed_at.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';

/// Browsing-history row rendered with the shared result-card visuals.
class HistoryRowTile extends StatelessWidget {
  /// Creates a history row tile.
  const HistoryRowTile({
    required this.row,
    required this.now,
    required this.drugImageCacheManager,
    super.key,
  });

  /// Row view model.
  final HistoryRow row;

  /// Reference time used to format [HistoryRow.viewedAt].
  final DateTime now;

  /// Cache manager for drug card images.
  final BaseCacheManager drugImageCacheManager;

  @override
  Widget build(BuildContext context) {
    return switch (row) {
      HistoryDrugRow(:final summary) => Semantics(
        label: '薬品の閲覧履歴',
        child: DrugResultCard(
          item: summary,
          cacheManager: drugImageCacheManager,
          trailingTime: _HistoryRowTime(now: now, row: row),
          onTap: () => context.push(AppRoutes.drugDetail(row.id)),
        ),
      ),
      HistoryDiseaseRow(:final summary) => Semantics(
        label: '疾患の閲覧履歴',
        child: DiseaseResultCard(
          item: summary,
          trailingTime: _HistoryRowTime(now: now, row: row),
          onTap: () => context.push(AppRoutes.diseaseDetail(row.id)),
        ),
      ),
      HistoryUnresolvedRow() => const SizedBox.shrink(),
    };
  }
}

class _HistoryRowTime extends StatelessWidget {
  const _HistoryRowTime({required this.now, required this.row});

  final DateTime now;
  final HistoryRow row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Text(
      formatRelativeViewedAt(now, row.viewedAt, l10n),
      key: ValueKey('history-row-time-${row.id}'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: palette.muted,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
