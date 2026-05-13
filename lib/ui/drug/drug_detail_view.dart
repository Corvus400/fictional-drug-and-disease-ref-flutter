import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/error_message_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/ui/common/loading/shimmer_skeleton.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_bookmark_footer.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_dose_calc_button.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_responsive_layout.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_tab_button.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_adverse_effects_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_caution_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_dose_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_overview_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_pharmacokinetics_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_related_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Cache manager for drug detail hero images.
final drugDetailHeroImageCacheManagerProvider = Provider<BaseCacheManager>(
  (ref) => DefaultCacheManager(),
);

/// Drug detail placeholder.
class DrugDetailView extends ConsumerWidget {
  /// Creates a drug detail view.
  const DrugDetailView({required this.id, super.key});

  /// Drug identifier.
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(drugDetailScreenProvider(id));
    final notifier = ref.read(drugDetailScreenProvider(id).notifier);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: DetailConstants.appBarHeight,
        centerTitle: true,
        title: Text(l10n.drugDetailTitle),
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          color: colors.onSurface,
          fontSize: DetailConstants.appBarTitleFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: switch (state.phase) {
        DrugDetailLoadingPhase() => const _DrugDetailLoadingView(),
        DrugDetailErrorPhase(:final error) => _DetailErrorView(
          error: error,
          onRetry: notifier.retry,
        ),
        DrugDetailLoadedPhase(:final drug) => _DrugLoadedView(
          state: state,
          drug: drug,
          cacheManager: ref.watch(drugDetailHeroImageCacheManagerProvider),
          onSelectTab: notifier.selectTab,
          onToggleBookmark: notifier.toggleBookmark,
          onClearBookmarkError: notifier.clearBookmarkError,
        ),
      },
    );
  }
}

class _DrugDetailLoadingView extends StatelessWidget {
  const _DrugDetailLoadingView();

  @override
  Widget build(BuildContext context) {
    return ShimmerSkeleton(
      child: DetailResponsiveLayout(
        tabs: [
          for (var index = 0; index < DrugDetailTab.values.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DetailConstants.loadingTabPaddingHorizontal,
                vertical: DetailConstants.loadingTabPaddingVertical,
              ),
              child: ShimmerSkeletonShapes.compactBar(
                width: DetailConstants.loadingTabPlaceholderWidth,
                height: DetailConstants.loadingTabPlaceholderHeight,
              ),
            ),
        ],
        activeBody: Padding(
          padding: const EdgeInsets.all(DetailConstants.contentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShimmerSkeletonShapes.detailBlock(
                height: DetailConstants.loadingPrimaryBlockHeight,
              ),
              const SizedBox(height: DetailConstants.loadingBlockGap),
              ShimmerSkeletonShapes.detailBlock(),
              const SizedBox(height: DetailConstants.loadingBlockGap),
              ShimmerSkeletonShapes.detailBlock(),
            ],
          ),
        ),
        footer: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DetailConstants.footerPaddingHorizontal,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ShimmerSkeletonShapes.compactBar(
              width: DetailConstants.loadingFooterPlaceholderWidth,
              height: DetailConstants.loadingFooterPlaceholderHeight,
            ),
          ),
        ),
      ),
    );
  }
}

class _DrugLoadedView extends StatelessWidget {
  const _DrugLoadedView({
    required this.state,
    required this.drug,
    required this.cacheManager,
    required this.onSelectTab,
    required this.onToggleBookmark,
    required this.onClearBookmarkError,
  });

  final DrugDetailScreenState state;
  final Drug drug;
  final BaseCacheManager cacheManager;
  final ValueChanged<DrugDetailTab> onSelectTab;
  final VoidCallback onToggleBookmark;
  final VoidCallback onClearBookmarkError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DetailResponsiveLayout(
      tabs: [
        for (final (index, tab) in DrugDetailTab.values.indexed)
          DetailTabButton(
            label: _drugTabLabel(l10n, tab),
            selected: state.activeTab == tab,
            sectionNumber: index + 1,
            onPressed: () => onSelectTab(tab),
          ),
      ],
      activeBody: AnimatedSwitcher(
        key: const ValueKey('drug-detail-active-tab-switcher'),
        duration: DetailConstants.tabSwitchDuration,
        child: _activeDrugTabBody(l10n, drug, state.activeTab, cacheManager),
      ),
      footer: DetailBookmarkFooter(
        isBookmarked: state.isBookmarked,
        isBusy: state.isBookmarkBusy,
        bookmarkError: state.bookmarkError,
        onToggleBookmark: onToggleBookmark,
        onClearBookmarkError: onClearBookmarkError,
        trailing: DetailDoseCalcButton(
          label: l10n.detailDoseCalculatorLabel,
          onPressed: () => context.go(AppRoutes.calc),
        ),
      ),
    );
  }
}

class _DetailErrorView extends StatelessWidget {
  const _DetailErrorView({
    required this.error,
    required this.onRetry,
  });

  final AppException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: DetailConstants.errorIconSize,
          ),
          const SizedBox(height: DetailConstants.gapM),
          Text(_detailErrorMessage(l10n, error), textAlign: TextAlign.center),
          const SizedBox(height: DetailConstants.gapL),
          SizedBox(
            width: DetailConstants.retryButtonWidth,
            child: FilledButton(
              onPressed: onRetry,
              child: Text(l10n.detailRetry),
            ),
          ),
        ],
      ),
    );
  }
}

String _detailErrorMessage(AppLocalizations l10n, AppException error) {
  return switch (errorKeyFor(error)) {
    'errNetwork' => l10n.errNetwork,
    'errServer' => l10n.errServer,
    'errApiNotFound' => l10n.errApiNotFound,
    'errApiBadRequest' => l10n.errApiBadRequest,
    'errApiInvalidCategory' => l10n.errApiInvalidCategory,
    'errParse' => l10n.errParse,
    'errStorageUnique' => l10n.errStorageUnique,
    'errStorageCheck' => l10n.errStorageCheck,
    'errStorageGeneric' => l10n.errStorageGeneric,
    'errApi4xx' => l10n.errApi4xx(error is ApiException ? error.message : ''),
    _ => l10n.errUnknown,
  };
}

String _drugTabLabel(AppLocalizations l10n, DrugDetailTab tab) {
  return switch (tab) {
    DrugDetailTab.overview => l10n.detailDrugTabOverview,
    DrugDetailTab.dose => l10n.detailDrugTabDose,
    DrugDetailTab.caution => l10n.detailDrugTabCaution,
    DrugDetailTab.adverseEffects => l10n.detailDrugTabAdverseEffects,
    DrugDetailTab.pharmacokinetics => l10n.detailDrugTabPharmacokinetics,
    DrugDetailTab.related => l10n.detailDrugTabRelated,
  };
}

Widget _activeDrugTabBody(
  AppLocalizations l10n,
  Drug drug,
  DrugDetailTab activeTab,
  BaseCacheManager cacheManager,
) {
  return switch (activeTab) {
    DrugDetailTab.overview => DrugDetailOverviewTab(
      key: const ValueKey('drug-detail-active-tab-body'),
      drug: drug,
      cacheManager: cacheManager,
    ),
    DrugDetailTab.dose => DrugDetailDoseTab(
      key: const ValueKey('drug-detail-active-tab-body'),
      drug: drug,
    ),
    DrugDetailTab.caution => DrugDetailCautionTab(
      key: const ValueKey('drug-detail-active-tab-body'),
      drug: drug,
    ),
    DrugDetailTab.adverseEffects => DrugDetailAdverseEffectsTab(
      key: const ValueKey('drug-detail-active-tab-body'),
      drug: drug,
    ),
    DrugDetailTab.pharmacokinetics => DrugDetailPharmacokineticsTab(
      key: const ValueKey('drug-detail-active-tab-body'),
      drug: drug,
    ),
    DrugDetailTab.related => DrugDetailRelatedTab(
      key: const ValueKey('drug-detail-active-tab-body'),
      drug: drug,
    ),
  };
}
