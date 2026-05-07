import 'dart:io';

import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_warn_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Overview tab for drug detail.
class DrugDetailOverviewTab extends StatelessWidget {
  /// Creates an overview tab.
  const DrugDetailOverviewTab({
    required this.drug,
    this.cacheManager,
    super.key,
  });

  /// Drug detail model.
  final Drug drug;

  /// Cache manager for detail hero image loading.
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DrugHero(
          drug: drug,
          l10n: l10n,
          cacheManager: cacheManager ?? DefaultCacheManager(),
        ),
        DetailPanel(
          sectionIndex: 'D3',
          title: l10n.detailDrugSectionWarning,
          child: DetailWarnBanner(
            items: drug.warning
                .map((item) => item.content)
                .toList(
                  growable: false,
                ),
          ),
        ),
        DetailPanel(
          sectionIndex: 'D4',
          title: l10n.detailDrugSectionTherapeuticCategory,
          subIndex: 'ATC 5',
          child: Column(
            children: [
              DetailKvRow(
                label: l10n.detailDrugLabelAtcCode,
                value: drug.atcCode,
                showTopBorder: true,
              ),
              DetailKvRow(
                label: l10n.detailDrugLabelTherapeuticHierarchy,
                value: drug.therapeuticCategoryName,
              ),
              if (drug.yjCode != null)
                DetailKvRow(
                  label: l10n.detailDrugLabelYjCode,
                  value: drug.yjCode!,
                ),
            ],
          ),
        ),
        DetailPanel(
          sectionIndex: 'D5',
          title: l10n.detailDrugSectionComposition,
          showBottomDivider: false,
          child: Column(
            children: [
              DetailKvRow(
                label: l10n.detailDrugLabelActiveIngredient,
                value: _activeIngredientValue(drug.composition),
                showTopBorder: true,
              ),
              DetailKvRow(
                label: l10n.detailDrugLabelInactiveIngredients,
                value: drug.composition.inactiveIngredients.join('、'),
              ),
              DetailKvRow(
                label: l10n.detailDrugLabelAppearance,
                value: drug.composition.appearance,
              ),
              if (drug.composition.identificationCode != null)
                DetailKvRow(
                  label: l10n.detailDrugLabelIdentificationCode,
                  value: drug.composition.identificationCode!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DrugHero extends StatelessWidget {
  const _DrugHero({
    required this.drug,
    required this.l10n,
    required this.cacheManager,
  });

  final Drug drug;
  final AppLocalizations l10n;
  final BaseCacheManager cacheManager;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('drug-detail-hero'),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            key: ValueKey<String>('drug-detail-hero-image-area-${drug.id}'),
            height: DetailConstants.heroImageHeight,
            width: double.infinity,
            child: _DrugHeroImage(
              drug: drug,
              cacheManager: cacheManager,
              colors: colors,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DetailConstants.heroMetaPaddingHorizontal,
              vertical: DetailConstants.heroMetaPaddingVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drug.genericName,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: DetailConstants.heroGenericFontSize,
                  ),
                ),
                const SizedBox(height: DetailConstants.heroBrandTopMargin),
                Text(
                  drug.brandName,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: DetailConstants.heroBrandFontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: DetailConstants.heroBrandTopMargin),
                Text(
                  drug.brandNameKana,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: DetailConstants.heroKanaFontSize,
                  ),
                ),
                DetailBadgeWrap(children: _badges(context)),
                Padding(
                  padding: const EdgeInsets.only(
                    top: DetailConstants.heroRevisedTopMargin,
                  ),
                  child: Text(
                    '${l10n.detailDrugMetaRevisedPrefix} ${drug.revisedAt} · '
                    '${drug.manufacturer} · D1-D2',
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: DetailConstants.heroRevisedFontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _badges(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return [
      for (final value in drug.regulatoryClass)
        DetailBadge(
          label: _regulatoryClassLabel(l10n, value),
          colors: _badgeColors(palette.regulatoryBadgeColors(value)),
        ),
      DetailBadge(
        label: _routeLabel(l10n, drug.routeOfAdministration),
        colors: _foregroundBadgeColors(
          palette,
          palette.chipRouteOfAdmin[drug.routeOfAdministration],
        ),
      ),
      DetailBadge(
        label: _dosageFormLabel(l10n, drug.dosageForm),
        colors: _foregroundBadgeColors(
          palette,
          palette.chipDosageForm[drug.dosageForm],
        ),
      ),
    ];
  }
}

class _DrugHeroImage extends StatefulWidget {
  const _DrugHeroImage({
    required this.drug,
    required this.cacheManager,
    required this.colors,
  });

  final Drug drug;
  final BaseCacheManager cacheManager;
  final DetailColorExtension colors;

  @override
  State<_DrugHeroImage> createState() => _DrugHeroImageState();
}

class _DrugHeroImageState extends State<_DrugHeroImage> {
  late Future<File> _imageFile;
  bool _loggedLoadError = false;
  bool _loggedDecodeError = false;

  @override
  void initState() {
    super.initState();
    _imageFile = _loadImageFile();
  }

  @override
  void didUpdateWidget(covariant _DrugHeroImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.drug.imageUrl != widget.drug.imageUrl ||
        oldWidget.cacheManager != widget.cacheManager) {
      _loggedLoadError = false;
      _loggedDecodeError = false;
      _imageFile = _loadImageFile();
    }
  }

  Future<File> _loadImageFile() async {
    final imageUrl = _drugDetailHeroImageUrl(widget.drug.imageUrl);
    final cachedFile = await widget.cacheManager.getSingleFile(
      imageUrl,
      key: _drugDetailHeroImageCacheKey(widget.drug.imageUrl),
    );
    return File(cachedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.colors.primaryContainer,
            widget.colors.tertiaryContainer,
            widget.colors.surfaceContainer,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: DetailConstants.heroDrugImageRightInset,
          bottom: DetailConstants.heroDrugImageBottomInset,
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            key: ValueKey<String>(
              'drug-detail-hero-image-frame-${widget.drug.id}',
            ),
            width: DetailConstants.heroDrugImageWidth,
            child: AspectRatio(
              aspectRatio: DetailConstants.heroDrugImageAspectRatio,
              child: _DrugHeroImageFrame(
                colors: widget.colors,
                child: FutureBuilder<File>(
                  future: _imageFile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final imageFile = snapshot.requireData;
                      return GestureDetector(
                        key: ValueKey<String>(
                          'drug-detail-hero-image-preview-trigger-'
                          '${widget.drug.id}',
                        ),
                        onTap: () => _openImagePreview(context, imageFile),
                        child: Image.file(
                          imageFile,
                          key: ValueKey<String>(
                            'drug-detail-hero-image-${widget.drug.id}',
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            _logDecodeError(
                              error,
                              stackTrace ?? StackTrace.current,
                            );
                            return _DrugHeroImageFallback(
                              colors: widget.colors,
                            );
                          },
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      _logLoadError(snapshot.error!, snapshot.stackTrace);
                    }
                    return _DrugHeroImageFallback(colors: widget.colors);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
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
      'message': 'failed to load drug detail hero image',
      'drugId': widget.drug.id,
      'dosageForm': widget.drug.dosageForm,
      'imageUrl': _drugDetailHeroImageUrl(widget.drug.imageUrl),
      'cacheKey': _drugDetailHeroImageCacheKey(widget.drug.imageUrl),
    };
  }

  Future<void> _openImagePreview(BuildContext context, File imageFile) {
    return showDialog<void>(
      context: context,
      builder: (context) => _DrugHeroImagePreview(
        drugId: widget.drug.id,
        imageFile: imageFile,
        colors: widget.colors,
      ),
    );
  }
}

class _DrugHeroImagePreview extends StatelessWidget {
  const _DrugHeroImagePreview({
    required this.drugId,
    required this.imageFile,
    required this.colors,
  });

  final String drugId;
  final File imageFile;
  final DetailColorExtension colors;

  @override
  Widget build(BuildContext context) {
    final materialLocalizations = MaterialLocalizations.of(context);
    return Dialog.fullscreen(
      key: ValueKey<String>('drug-detail-hero-image-preview-$drugId'),
      backgroundColor: colors.surface,
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                key: ValueKey<String>(
                  'drug-detail-hero-image-preview-zoom-$drugId',
                ),
                maxScale: DetailConstants.heroImagePreviewMaxScale,
                child: Image.file(
                  imageFile,
                  key: ValueKey<String>(
                    'drug-detail-hero-image-preview-image-$drugId',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            PositionedDirectional(
              top: DetailConstants.heroImagePreviewCloseInset,
              end: DetailConstants.heroImagePreviewCloseInset,
              child: IconButton.filledTonal(
                key: ValueKey<String>(
                  'drug-detail-hero-image-preview-close-$drugId',
                ),
                tooltip: materialLocalizations.closeButtonTooltip,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrugHeroImageFrame extends StatelessWidget {
  const _DrugHeroImageFrame({required this.colors, required this.child});

  final DetailColorExtension colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(DetailConstants.heroImageRadius),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            offset: const Offset(0, DetailConstants.heroImageShadowDy),
            blurRadius: DetailConstants.heroImageShadowBlurRadius,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DetailConstants.heroImageRadius),
        child: child,
      ),
    );
  }
}

class _DrugHeroImageFallback extends StatelessWidget {
  const _DrugHeroImageFallback({required this.colors});

  final DetailColorExtension colors;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.medication_outlined,
      color: colors.onSurfaceVariant,
      size: DetailConstants.heroImageFallbackIconSize,
    );
  }
}

String _drugDetailHeroImageUrl(String imageUrl) {
  final base = Uri.parse(ApiConfig.current.apiBaseUrl);
  final resolved = base.resolve(imageUrl);
  return resolved
      .replace(
        queryParameters: {
          ...resolved.queryParameters,
          'size': DetailConstants.heroDrugImageApiSize,
        },
      )
      .toString();
}

String _drugDetailHeroImageCacheKey(String imageUrl) {
  return 'drug-detail-hero-image-v1::${_drugDetailHeroImageUrl(imageUrl)}';
}

DetailBadgeColors _badgeColors(({Color background, Color foreground}) colors) {
  return DetailBadgeColors(
    background: colors.background,
    foreground: colors.foreground,
  );
}

DetailBadgeColors _foregroundBadgeColors(
  AppPalette palette,
  Color? foreground,
) {
  return DetailBadgeColors(
    background: palette.surface3,
    foreground: foreground ?? palette.ink2,
  );
}

String _activeIngredientValue(CompositionInfo composition) {
  final dose = composition.activeIngredientAmount;
  final per = dose.per == null ? '' : ' / ${dose.per}';
  return '${composition.activeIngredient} ${dose.amount} ${dose.unit}$per';
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
