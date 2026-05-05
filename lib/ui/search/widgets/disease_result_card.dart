part of '../search_view.dart';

class _DiseaseResultCard extends StatelessWidget {
  const _DiseaseResultCard({required this.item});

  final DiseaseSummary item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return Card(
      key: ValueKey('disease-card-${item.id}'),
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SearchConstants.searchCardRadius),
        side: BorderSide(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 4,
              children: [
                _DiseaseBadge(
                  label: _chronicityLabel(l10n, item.chronicity),
                  palette: palette,
                ),
                _DiseaseBadge(
                  label: item.infectious
                      ? l10n.searchDiseaseInfectiousTrue
                      : l10n.searchDiseaseInfectiousFalse,
                  palette: palette,
                ),
                for (final department in item.medicalDepartment)
                  _DiseaseBadge(
                    label: _departmentLabel(l10n, department),
                    palette: palette,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.nameKana,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 12,
              children: [
                Text(
                  l10n.searchDiseaseMetaIcd10(
                    _diseaseIcd10ChapterLabel(l10n, item.icd10Chapter),
                  ),
                  style: theme.textTheme.labelSmall,
                ),
                Text(
                  l10n.searchDiseaseMetaRevised(
                    _formatRevisionDate(item.revisedAt),
                  ),
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DiseaseBadge extends StatelessWidget {
  const _DiseaseBadge({required this.label, required this.palette});

  final String label;
  final SearchPalette palette;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.diseaseTint,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: palette.diseaseInk,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
