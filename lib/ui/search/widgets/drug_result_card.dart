part of '../search_view.dart';

class _DrugResultCard extends StatelessWidget {
  const _DrugResultCard({required this.item, this.cacheManager});

  final DrugSummary item;
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    final imageSize =
        MediaQuery.sizeOf(context).width >=
            SearchConstants.searchTabletBreakpoint
        ? SearchConstants.searchTabletDrugImageSize
        : SearchConstants.searchPhoneDrugImageSize;
    final imageCacheWidth = (imageSize * MediaQuery.devicePixelRatioOf(context))
        .round();
    return Card(
      key: ValueKey('drug-card-${item.id}'),
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SearchConstants.searchCardRadius),
        side: BorderSide(color: palette.hairline),
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.drugDetail(item.id)),
        borderRadius: BorderRadius.circular(SearchConstants.searchCardRadius),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: imageSize,
                  height:
                      imageSize /
                      SearchConstants.searchDrugCardImageAspectRatio,
                  child: CachedNetworkImage(
                    key: ValueKey('drug-image-${item.id}'),
                    imageUrl: _drugCardImageUrl(item.imageUrl),
                    cacheManager: cacheManager ?? DefaultCacheManager(),
                    fit: BoxFit.cover,
                    memCacheWidth: imageCacheWidth,
                    placeholder: (context, url) => _DrugImageFallback(
                      palette: palette,
                    ),
                    errorWidget: (context, url, error) => _DrugImageFallback(
                      palette: palette,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 5,
                      runSpacing: 4,
                      children: [
                        for (final regulatoryClass in item.regulatoryClass)
                          _DrugBadge(
                            value: regulatoryClass,
                            label: _regulatoryClassLabel(l10n, regulatoryClass),
                            palette: palette,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.brandName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.genericName,
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
                          l10n.searchDrugMetaAtc(item.atcCode),
                          style: theme.textTheme.labelSmall,
                        ),
                        Text(
                          l10n.searchDrugMetaRevised(
                            _formatRevisionDate(item.revisedAt),
                          ),
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrugImageFallback extends StatelessWidget {
  const _DrugImageFallback({required this.palette});

  final SearchPalette palette;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.surfaceSubtle,
        border: Border.all(color: palette.hairline),
      ),
      child: const Icon(Icons.medication_outlined),
    );
  }
}

class _DrugBadge extends StatelessWidget {
  const _DrugBadge({
    required this.value,
    required this.label,
    required this.palette,
  });

  final String value;
  final String label;
  final SearchPalette palette;

  @override
  Widget build(BuildContext context) {
    final colors = _regulatoryBadgeColors(palette, value);
    return DecoratedBox(
      key: ValueKey('drug-regulatory-badge-$value'),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

({Color background, Color foreground}) _regulatoryBadgeColors(
  SearchPalette palette,
  String value,
) {
  final color = switch (value) {
    'poison' => palette.danger,
    'potent' => const Color(0xFFB45309),
    'prescription_required' => palette.drugInk,
    'psychotropic_1' || 'psychotropic_2' || 'psychotropic_3' => const Color(
      0xFF7C3AED,
    ),
    'narcotic' => const Color(0xFF9333EA),
    'stimulant_precursor' => const Color(0xFFEA580C),
    'biological' || 'specified_biological' => const Color(0xFF0F766E),
    'ordinary' => const Color(0xFF4B5563),
    _ => palette.drugInk,
  };
  return (
    background: color.withValues(alpha: 0.12),
    foreground: color,
  );
}
