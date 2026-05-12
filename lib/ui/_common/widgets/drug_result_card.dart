import 'dart:io';

import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Shared drug result card used by search, bookmarks, and browsing history.
class DrugResultCard extends StatelessWidget {
  /// Creates a drug result card.
  const DrugResultCard({
    required this.item,
    required this.cacheManager,
    super.key,
    this.onTap,
    this.trailingTime,
  });

  /// Drug summary to render.
  final DrugSummary item;

  /// Cache manager for the drug image.
  final BaseCacheManager cacheManager;

  /// Optional tap handler.
  final VoidCallback? onTap;

  /// Optional inline trailing time widget for browsing history rows.
  final Widget? trailingTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
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
        onTap: onTap,
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
                  mainAxisSize: MainAxisSize.min,
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
                    _DrugCardTitleRow(item: item, trailingTime: trailingTime),
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

class _DrugCardTitleRow extends StatelessWidget {
  const _DrugCardTitleRow({required this.item, required this.trailingTime});

  final DrugSummary item;
  final Widget? trailingTime;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      item.brandName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
    );
    final trailing = trailingTime;
    if (trailing == null) {
      return title;
    }
    return Row(
      children: [
        Expanded(child: title),
        const SizedBox(width: 8),
        trailing,
      ],
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
  final AppPalette palette;

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

  final AppPalette palette;

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
  final AppPalette palette;

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

const _drugCardImageCacheKeyVersion = 'v2';

String _drugCardImageUrl(String imageUrl) {
  final base = Uri.parse(ApiConfig.current.apiBaseUrl);
  final resolved = base.resolve(imageUrl);
  return resolved
      .replace(
        queryParameters: {
          ...resolved.queryParameters,
          'size': SearchConstants.searchDrugCardImageApiSize,
        },
      )
      .toString();
}

String _drugCardImageCacheKey(String imageUrl) {
  return 'drug-card-image-$_drugCardImageCacheKeyVersion::'
      '${_drugCardImageUrl(imageUrl)}';
}

String _regulatoryClassLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'poison' => l10n.searchDrugRegulatoryPoison,
    'potent' => l10n.searchDrugRegulatoryPotent,
    'ordinary' => l10n.searchDrugRegulatoryOrdinary,
    'psychotropic_1' => l10n.searchDrugRegulatoryPsychotropic1,
    'psychotropic_2' => l10n.searchDrugRegulatoryPsychotropic2,
    'psychotropic_3' => l10n.searchDrugRegulatoryPsychotropic3,
    'narcotic' => l10n.searchDrugRegulatoryNarcotic,
    'stimulant_precursor' => l10n.searchDrugRegulatoryStimulantPrecursor,
    'biological' => l10n.searchDrugRegulatoryBiological,
    'specified_biological' => l10n.searchDrugRegulatorySpecifiedBiological,
    'prescription_required' => l10n.searchDrugRegulatoryPrescriptionRequired,
    _ => value,
  };
}

String _formatRevisionDate(String value) {
  final parts = value.split('-');
  if (parts.length != 3) {
    return value;
  }
  return '${parts[0]}/${parts[1]}/${parts[2]}';
}
