part of '../search_view.dart';

class _DrugResultCard extends StatelessWidget {
  const _DrugResultCard({required this.item, required this.cacheManager});

  final DrugSummary item;
  final BaseCacheManager cacheManager;

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
    final imageUrl = _drugCardImageUrl(item.imageUrl);
    final imageCacheKey = _drugCardImageCacheKey(item.imageUrl);
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
                  child: _DrugCardCachedImage(
                    item: item,
                    imageUrl: imageUrl,
                    imageCacheKey: imageCacheKey,
                    imageCacheWidth: imageCacheWidth,
                    cacheManager: cacheManager,
                    palette: palette,
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

class _DrugCardCachedImage extends StatefulWidget {
  const _DrugCardCachedImage({
    required this.item,
    required this.imageUrl,
    required this.imageCacheKey,
    required this.imageCacheWidth,
    required this.cacheManager,
    required this.palette,
  });

  final DrugSummary item;
  final String imageUrl;
  final String imageCacheKey;
  final int imageCacheWidth;
  final BaseCacheManager cacheManager;
  final SearchPalette palette;

  @override
  State<_DrugCardCachedImage> createState() => _DrugCardCachedImageState();
}

class _DrugCardCachedImageState extends State<_DrugCardCachedImage> {
  late Future<File> _imageFile;
  bool _loggedLoadError = false;
  bool _loggedDecodeError = false;

  @override
  void initState() {
    super.initState();
    _imageFile = _loadImageFile();
  }

  @override
  void didUpdateWidget(covariant _DrugCardCachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl ||
        oldWidget.imageCacheKey != widget.imageCacheKey ||
        oldWidget.cacheManager != widget.cacheManager) {
      _loggedLoadError = false;
      _loggedDecodeError = false;
      _imageFile = _loadImageFile();
    }
  }

  Future<File> _loadImageFile() async {
    final cachedFile = await widget.cacheManager.getSingleFile(
      widget.imageUrl,
      key: widget.imageCacheKey,
    );
    return File(cachedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.file(
            snapshot.requireData,
            key: ValueKey('drug-image-${widget.item.id}'),
            fit: BoxFit.cover,
            cacheWidth: widget.imageCacheWidth,
            errorBuilder: (context, error, stackTrace) {
              _logDecodeError(error, stackTrace ?? StackTrace.current);
              return KeyedSubtree(
                key: ValueKey('drug-image-${widget.item.id}'),
                child: _DrugImageFallback(palette: widget.palette),
              );
            },
          );
        }
        if (snapshot.hasError) {
          _logLoadError(snapshot.error!, snapshot.stackTrace);
        }
        return KeyedSubtree(
          key: ValueKey('drug-image-${widget.item.id}'),
          child: _DrugImageFallback(palette: widget.palette),
        );
      },
    );
  }

  void _logLoadError(Object error, StackTrace? stackTrace) {
    if (_loggedLoadError) {
      return;
    }
    _loggedLoadError = true;
    appLogger.w(
      _logPayload(),
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }

  void _logDecodeError(Object error, StackTrace stackTrace) {
    if (_loggedDecodeError) {
      return;
    }
    _loggedDecodeError = true;
    appLogger.w(_logPayload(), error: error, stackTrace: stackTrace);
  }

  Map<String, Object?> _logPayload() {
    return {
      'message': 'failed to load drug card image',
      'drugId': widget.item.id,
      'dosageForm': widget.item.dosageForm,
      'imageUrl': widget.imageUrl,
      'cacheKey': widget.imageCacheKey,
    };
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
    final colors = palette.regulatoryBadgeColors(value);
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
