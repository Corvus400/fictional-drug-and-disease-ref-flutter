import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/error_message_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/common/loading/shimmer_skeleton.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/format/relative_time_formatter.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

export 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';

part 'widgets/search_top_chrome.dart';
part 'widgets/search_phase_section.dart';
part 'widgets/search_result_toolbar.dart';
part 'widgets/search_history_dropdown.dart';
part 'widgets/filter/drug_filter_sheet.dart';
part 'widgets/filter/disease_filter_sheet.dart';
part 'widgets/filter/round6_filter_sheet_scaffold.dart';
part 'format/search_label_formatters.dart';
part 'format/search_sort_sheet.dart';

/// Search tab view.
class SearchView extends ConsumerStatefulWidget {
  /// Creates a search view.
  const SearchView({
    super.key,
    this.healthCheck,
    this.currentTime,
    this.debugLogDrugImageErrors = true,
  });

  /// Deprecated compatibility parameter. Search UI no longer performs health
  /// checks from the view layer.
  final Future<String>? healthCheck;

  /// Current time override used to render deterministic history labels in
  /// tests. Production callers leave this null.
  final DateTime? currentTime;

  /// Keeps expected fallback-image golden tests from emitting production logs.
  @visibleForTesting
  final bool debugLogDrugImageErrors;

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> with RouteAware {
  late final ScrollController _drugSearchResultsScrollController;
  late final ScrollController _diseaseSearchResultsScrollController;
  PageRoute<dynamic>? _route;

  @override
  void initState() {
    super.initState();
    _drugSearchResultsScrollController = ScrollController();
    _diseaseSearchResultsScrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute<dynamic> && route != _route) {
      final previousRoute = _route;
      if (previousRoute != null) {
        appRouteObserver.unsubscribe(this);
      }
      _route = route;
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    _drugSearchResultsScrollController.dispose();
    _diseaseSearchResultsScrollController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _clearReturnFocus();
  }

  @override
  void didPushNext() {
    _clearReturnFocus();
  }

  void _clearReturnFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref.read(searchScreenProvider.notifier).closeHistoryDropdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchScreenProvider);
    final drugCardImageCacheManager = ref.watch(
      drugCardImageCacheManagerProvider,
    );
    final notifier = ref.read(searchScreenProvider.notifier);
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppTabHeader(
        tab: AppShellTab.search,
        toolbarHeight: MediaQuery.sizeOf(context).shortestSide >= 600 ? 64 : 56,
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: SearchConstants.searchFilterFabRightOffset - 16,
              bottom: SearchConstants.searchFilterFabBottomOffset - 16,
            ),
            child: FloatingActionButton(
              backgroundColor: palette.filterFabBg,
              foregroundColor: palette.filterFabFg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SearchConstants.searchFilterFabRadius,
                ),
              ),
              onPressed: () async {
                await notifier.loadCategories();
                if (!context.mounted) {
                  return;
                }
                _showFilterSheet(
                  context,
                  ref.read(searchScreenProvider),
                  onApplyDrugFilter: notifier.applyDrugFilter,
                  onApplyDiseaseFilter: notifier.applyDiseaseFilter,
                );
              },
              child: const Icon(Icons.tune),
            ),
          ),
          if (state.appliedChips.count > 0)
            Positioned(
              top: -2,
              right: 0,
              child: _SearchFilterFabBadge(
                count: state.appliedChips.count,
                palette: palette,
              ),
            ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet =
              constraints.maxWidth >= SearchConstants.searchTabletBreakpoint;
          final gutter = isTablet
              ? SearchConstants.searchTabletGutter
              : SearchConstants.searchPhoneGutter;
          final historyTapRegionGroupId = Object();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SearchTopChrome(
                state: state,
                palette: palette,
                gutter: gutter,
                isTablet: isTablet,
                historyTapRegionGroupId: historyTapRegionGroupId,
                onChangeTab: notifier.changeTab,
                onOpenHistory: () {
                  notifier.openHistoryDropdown();
                  unawaited(notifier.loadHistory());
                },
                onChangeQuery: notifier.changeQueryText,
                onClearQuery: notifier.clearQueryText,
                onSubmit: notifier.performSearch,
                onCancel: notifier.closeHistoryDropdown,
              ),
              if (state.historyDropdownOpen)
                Flexible(
                  child: _SearchHistoryDropdown(
                    tapRegionGroupId: historyTapRegionGroupId,
                    entries: state.historyForTab,
                    currentTime: widget.currentTime ?? DateTime.now(),
                    onSelect: notifier.selectHistory,
                    onDelete: notifier.deleteHistory,
                    onClearAll: notifier.clearAllHistory,
                  ),
                ),
              Expanded(
                child: _SearchPhaseSection(
                  state: state,
                  gutter: gutter,
                  drugCardImageCacheManager: drugCardImageCacheManager,
                  resultScrollController: state.tab == SearchTab.drugs
                      ? _drugSearchResultsScrollController
                      : _diseaseSearchResultsScrollController,
                  onRetry: notifier.performSearch,
                  onResetFilter: notifier.resetFilter,
                  onRemoveOneChip: notifier.removeOneChip,
                  onRemoveChipAt: notifier.removeChipAt,
                  onChangeDrugSort: notifier.changeDrugSort,
                  onChangeDiseaseSort: notifier.changeDiseaseSort,
                  onLoadMore: notifier.loadMore,
                  logDrugImageErrors: widget.debugLogDrugImageErrors,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFilterSheet(
    BuildContext context,
    SearchScreenState state, {
    required Future<void> Function({
      String? categoryAtc,
      String? therapeuticCategory,
      List<String>? regulatoryClass,
      List<String>? dosageForm,
      List<String>? route,
      String? adverseReactionKeyword,
      List<String>? precautionCategory,
    })
    onApplyDrugFilter,
    required Future<void> Function({
      List<String>? icd10Chapter,
      List<String>? department,
      List<String>? chronicity,
      bool? infectious,
      String? symptomKeyword,
      List<String>? onsetPattern,
      List<String>? examCategory,
      bool? hasPharmacologicalTreatment,
      bool? hasSeverityGrading,
    })
    onApplyDiseaseFilter,
  }) {
    final theme = Theme.of(context);
    final overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    final sheetHeight =
        (overlayBox?.size.height ?? MediaQuery.sizeOf(context).height) -
        SearchConstants.searchFilterSheetTopOffset;
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withValues(
          alpha: theme.brightness == Brightness.dark
              ? SearchConstants.searchDarkScrimAlpha
              : SearchConstants.searchLightScrimAlpha,
        ),
        constraints: BoxConstraints.tightFor(height: sheetHeight),
        builder: (sheetContext) => Theme(
          data: theme,
          child: _Round6FilterSheetFrame(
            height: sheetHeight,
            child: switch (state.tab) {
              SearchTab.drugs => _DrugFilterSheet(
                state: state,
                onApply:
                    ({
                      required categoryAtc,
                      required therapeuticCategory,
                      required regulatoryClass,
                      required dosageForm,
                      required route,
                      required adverseReactionKeyword,
                      required precautionCategory,
                    }) async {
                      Navigator.of(sheetContext).pop();
                      await onApplyDrugFilter(
                        categoryAtc: categoryAtc,
                        therapeuticCategory: therapeuticCategory,
                        regulatoryClass: regulatoryClass,
                        dosageForm: dosageForm,
                        route: route,
                        adverseReactionKeyword: adverseReactionKeyword,
                        precautionCategory: precautionCategory,
                      );
                    },
              ),
              SearchTab.diseases => _DiseaseFilterSheet(
                state: state,
                onApply:
                    ({
                      required icd10Chapter,
                      required department,
                      required chronicity,
                      required infectious,
                      required symptomKeyword,
                      required onsetPattern,
                      required examCategory,
                      required hasPharmacologicalTreatment,
                      required hasSeverityGrading,
                    }) async {
                      Navigator.of(sheetContext).pop();
                      await onApplyDiseaseFilter(
                        icd10Chapter: icd10Chapter,
                        department: department,
                        chronicity: chronicity,
                        infectious: infectious,
                        symptomKeyword: symptomKeyword,
                        onsetPattern: onsetPattern,
                        examCategory: examCategory,
                        hasPharmacologicalTreatment:
                            hasPharmacologicalTreatment,
                        hasSeverityGrading: hasSeverityGrading,
                      );
                    },
              ),
            },
          ),
        ),
      ),
    );
  }
}

class _SearchFilterFabBadge extends StatelessWidget {
  const _SearchFilterFabBadge({required this.count, required this.palette});

  final int count;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      key: const ValueKey('search-fab-badge'),
      height: 22,
      constraints: const BoxConstraints(minWidth: 24),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: palette.danger,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: palette.background, width: 2),
      ),
      child: Text(
        '+$count',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isDark ? const Color(0xFF3A0907) : Colors.white,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
