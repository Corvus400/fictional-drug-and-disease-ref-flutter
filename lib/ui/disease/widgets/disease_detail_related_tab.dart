import 'dart:io';

import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:go_router/go_router.dart';

final FutureProviderFamily<Drug, String> _relatedDrugProvider = FutureProvider
    .autoDispose
    .family<Drug, String>((ref, id) async {
      final result = await ref.watch(drugRepositoryProvider).getDrug(id);
      return switch (result) {
        Ok<Drug>(:final value) => value,
        Err<Drug>(:final error) => throw error,
      };
    });

final FutureProviderFamily<Disease, String> _relatedDiseaseProvider =
    FutureProvider.autoDispose.family<Disease, String>((ref, id) async {
      final result = await ref.watch(diseaseRepositoryProvider).getDisease(id);
      return switch (result) {
        Ok<Disease>(:final value) => value,
        Err<Disease>(:final error) => throw error,
      };
    });

/// Related entities tab for disease detail.
class DiseaseDetailRelatedTab extends StatelessWidget {
  /// Creates a related tab.
  const DiseaseDetailRelatedTab({
    required this.disease,
    this.cacheManager,
    super.key,
  });

  /// Disease detail model.
  final Disease disease;

  /// Cache manager for related drug thumbnail loading.
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final resolvedCacheManager = cacheManager ?? DefaultCacheManager();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'E15',
          title: l10n.detailDiseaseSectionRelatedDrugs,
          child: SizedBox(
            width: double.infinity,
            child: DetailCarousel(
              children: [
                for (final id in disease.relatedDrugIds)
                  _RelatedDrugCard(
                    id: id,
                    cacheManager: resolvedCacheManager,
                    onTap: () => context.push(AppRoutes.drugDetail(id)),
                  ),
              ],
            ),
          ),
        ),
        DetailPanel(
          sectionIndex: 'E16',
          title: l10n.detailDiseaseSectionRelatedDiseases,
          showBottomDivider: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: DetailCarousel(
                  children: [
                    for (final id in disease.relatedDiseaseIds)
                      _RelatedDiseaseCard(
                        id: id,
                        onTap: () => context.push(AppRoutes.diseaseDetail(id)),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: DetailConstants.heroRevisedTopMargin,
                ),
                child: _RevisedText(revisedAt: disease.revisedAt),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RelatedDrugCard extends ConsumerWidget {
  const _RelatedDrugCard({
    required this.id,
    required this.cacheManager,
    required this.onTap,
  });

  final String id;
  final BaseCacheManager cacheManager;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final drug = ref.watch(_relatedDrugProvider(id));
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(DetailConstants.carouselCardRadius),
        onTap: onTap,
        child: drug.when(
          data: (drug) => _RelatedDrugCarouselCard(
            drug: drug,
            cacheManager: cacheManager,
            dosageFormLabel: _dosageFormLabel(l10n, drug.dosageForm),
            routeLabel: _routeLabel(l10n, drug.routeOfAdministration),
          ),
          loading: () => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDrugs,
          ),
          error: (_, _) => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDrugs,
          ),
        ),
      ),
    );
  }
}

class _RelatedDrugCarouselCard extends StatelessWidget {
  const _RelatedDrugCarouselCard({
    required this.drug,
    required this.cacheManager,
    required this.dosageFormLabel,
    required this.routeLabel,
  });

  final Drug drug;
  final BaseCacheManager cacheManager;
  final String dosageFormLabel;
  final String routeLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    final palette =
        Theme.of(context).extension<AppPalette>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final imageSize =
        MediaQuery.sizeOf(context).width >=
            SearchConstants.searchTabletBreakpoint
        ? SearchConstants.searchTabletDrugImageSize
        : SearchConstants.searchPhoneDrugImageSize;
    final imageCacheWidth = (imageSize * MediaQuery.devicePixelRatioOf(context))
        .round();
    return IntrinsicWidth(
      child: Container(
        key: const ValueKey<String>('detail-related-drug-card'),
        constraints: const BoxConstraints(
          maxWidth: DetailConstants.relatedDrugCardMaxWidth,
        ),
        padding: const EdgeInsets.all(DetailConstants.carouselCardPadding),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(
            DetailConstants.carouselCardRadius,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                DetailConstants.carouselCardImageRadius,
              ),
              child: SizedBox(
                width: imageSize,
                height:
                    imageSize / SearchConstants.searchDrugCardImageAspectRatio,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: palette.surfaceSubtle,
                    border: Border.all(color: palette.hairline),
                  ),
                  child: _RelatedDrugCachedImage(
                    drug: drug,
                    imageCacheWidth: imageCacheWidth,
                    cacheManager: cacheManager,
                    palette: palette,
                  ),
                ),
              ),
            ),
            const SizedBox(
              key: ValueKey<String>('detail-related-drug-image-text-gap'),
              width: DetailConstants.relatedDrugCardImageTextGap,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    drug.brandName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: DetailConstants.carouselCardTitleFontSize,
                      fontWeight: FontWeight.w700,
                      height: DetailConstants.carouselCardTitleLineHeight,
                    ),
                  ),
                  const SizedBox(height: DetailConstants.carouselCardGap),
                  Text(
                    drug.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: DetailConstants.carouselCardSubtitleFontSize,
                    ),
                  ),
                  const SizedBox(
                    height: DetailConstants.carouselBadgeTopMargin,
                  ),
                  Wrap(
                    spacing: DetailConstants.carouselBadgeGap,
                    runSpacing: DetailConstants.carouselBadgeGap,
                    children: [
                      _RelatedCardBadge(
                        label: dosageFormLabel,
                        palette: palette,
                      ),
                      _RelatedCardBadge(label: routeLabel, palette: palette),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RelatedDrugCachedImage extends StatefulWidget {
  const _RelatedDrugCachedImage({
    required this.drug,
    required this.imageCacheWidth,
    required this.cacheManager,
    required this.palette,
  });

  final Drug drug;
  final int imageCacheWidth;
  final BaseCacheManager cacheManager;
  final AppPalette palette;

  @override
  State<_RelatedDrugCachedImage> createState() =>
      _RelatedDrugCachedImageState();
}

class _RelatedDrugCachedImageState extends State<_RelatedDrugCachedImage> {
  late Future<File> _imageFile;
  bool _loggedLoadError = false;
  bool _loggedDecodeError = false;

  @override
  void initState() {
    super.initState();
    _imageFile = _loadImageFile();
  }

  @override
  void didUpdateWidget(covariant _RelatedDrugCachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.drug.imageUrl != widget.drug.imageUrl ||
        oldWidget.cacheManager != widget.cacheManager) {
      _loggedLoadError = false;
      _loggedDecodeError = false;
      _imageFile = _loadImageFile();
    }
  }

  Future<File> _loadImageFile() async {
    final cachedFile = await widget.cacheManager.getSingleFile(
      _relatedDrugCardImageUrl(widget.drug.imageUrl),
      key: _relatedDrugCardImageCacheKey(widget.drug.imageUrl),
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
            key: ValueKey<String>(
              'detail-related-drug-image-${widget.drug.id}',
            ),
            fit: BoxFit.cover,
            cacheWidth: widget.imageCacheWidth,
            errorBuilder: (context, error, stackTrace) {
              _logDecodeError(error, stackTrace ?? StackTrace.current);
              return _RelatedDrugImageFallback(palette: widget.palette);
            },
          );
        }
        if (snapshot.hasError) {
          _logLoadError(snapshot.error!, snapshot.stackTrace);
        }
        return _RelatedDrugImageFallback(palette: widget.palette);
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
      'message': 'failed to load related drug card image',
      'drugId': widget.drug.id,
      'imageUrl': _relatedDrugCardImageUrl(widget.drug.imageUrl),
      'cacheKey': _relatedDrugCardImageCacheKey(widget.drug.imageUrl),
    };
  }
}

class _RelatedDrugImageFallback extends StatelessWidget {
  const _RelatedDrugImageFallback({required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      key: const ValueKey<String>('detail-related-drug-image-fallback'),
      color: palette.surfaceSubtle,
      child: Icon(Icons.medication_outlined, color: palette.ink2, size: 24),
    );
  }
}

class _RelatedDiseaseCard extends ConsumerWidget {
  const _RelatedDiseaseCard({required this.id, required this.onTap});

  final String id;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final disease = ref.watch(_relatedDiseaseProvider(id));
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(DetailConstants.carouselCardRadius),
        onTap: onTap,
        child: disease.when(
          data: (disease) => DetailCarouselCard(
            title: disease.name,
            subtitle: disease.id,
            badges: [_chronicityLabel(l10n, disease.chronicity)],
          ),
          loading: () => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDiseases,
          ),
          error: (_, _) => DetailCarouselCard(
            title: id,
            subtitle: l10n.detailDiseaseSectionRelatedDiseases,
          ),
        ),
      ),
    );
  }
}

String _dosageFormLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'tablet' => l10n.searchDrugDosageFormTablet,
    'capsule' => l10n.searchDrugDosageFormCapsule,
    'powder' => l10n.searchDrugDosageFormPowder,
    'granule' => l10n.searchDrugDosageFormGranule,
    'liquid' => l10n.searchDrugDosageFormLiquid,
    'injection_form' => l10n.searchDrugDosageFormInjection,
    'ointment' => l10n.searchDrugDosageFormOintment,
    'cream' => l10n.searchDrugDosageFormCream,
    'patch' => l10n.searchDrugDosageFormPatch,
    'eye_drops' => l10n.searchDrugDosageFormEyeDrops,
    'suppository' => l10n.searchDrugDosageFormSuppository,
    'inhaler' => l10n.searchDrugDosageFormInhaler,
    'nasal_spray' => l10n.searchDrugDosageFormNasalSpray,
    _ => value,
  };
}

String _routeLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'oral' => l10n.searchDrugRouteOral,
    'topical' => l10n.searchDrugRouteTopical,
    'injection_route' => l10n.searchDrugRouteInjection,
    'inhalation' => l10n.searchDrugRouteInhalation,
    'rectal' => l10n.searchDrugRouteRectal,
    'ophthalmic' => l10n.searchDrugRouteOphthalmic,
    'nasal' => l10n.searchDrugRouteNasal,
    'transdermal' => l10n.searchDrugRouteTransdermal,
    _ => value,
  };
}

String _chronicityLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseChronicityAcute,
    'subacute' => l10n.searchDiseaseChronicitySubacute,
    'chronic' => l10n.searchDiseaseChronicityChronic,
    'relapsing' => l10n.searchDiseaseChronicityRelapsing,
    _ => value,
  };
}

String _relatedDrugCardImageUrl(String imageUrl) {
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

String _relatedDrugCardImageCacheKey(String imageUrl) {
  return 'detail-related-drug-card-image-v1::'
      '${_relatedDrugCardImageUrl(imageUrl)}';
}

class _RelatedCardBadge extends StatelessWidget {
  const _RelatedCardBadge({required this.label, required this.palette});

  final String label;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey<String>('detail-related-card-badge'),
      padding: const EdgeInsets.symmetric(
        horizontal: DetailConstants.carouselBadgePaddingHorizontal,
        vertical: DetailConstants.carouselBadgePaddingVertical,
      ),
      decoration: BoxDecoration(
        color: palette.surface3,
        borderRadius: BorderRadius.circular(
          DetailConstants.carouselBadgeRadius,
        ),
      ),
      child: Text(
        label,
        softWrap: true,
        style: TextStyle(
          color: palette.ink2,
          fontSize: DetailConstants.carouselBadgeFontSize,
          height: DetailConstants.carouselCardTitleLineHeight,
        ),
      ),
    );
  }
}

class _RevisedText extends StatelessWidget {
  const _RevisedText({required this.revisedAt});

  final String revisedAt;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      'E17 最終改訂 $revisedAt',
      style: TextStyle(
        color: colors.onSurfaceVariant,
        fontSize: DetailConstants.heroRevisedFontSize,
      ),
    );
  }
}
