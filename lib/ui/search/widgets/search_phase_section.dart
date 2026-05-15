part of '../search_view.dart';

class _SearchPhaseSection extends StatelessWidget {
  const _SearchPhaseSection({
    required this.state,
    required this.gutter,
    required this.drugCardImageCacheManager,
    required this.resultScrollController,
    required this.onRetry,
    required this.onResetFilter,
    required this.onRemoveOneChip,
    required this.onRemoveChipAt,
    required this.onChangeDrugSort,
    required this.onChangeDiseaseSort,
    required this.onLoadMore,
    required this.enableSortSheet,
    required this.showIdleMasterState,
    required this.logDrugImageErrors,
  });

  final SearchScreenState state;
  final double gutter;
  final BaseCacheManager drugCardImageCacheManager;
  final ScrollController resultScrollController;
  final Future<void> Function() onRetry;
  final Future<void> Function() onResetFilter;
  final Future<void> Function() onRemoveOneChip;
  final Future<void> Function(int index) onRemoveChipAt;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;
  final Future<void> Function(DiseaseSort sort) onChangeDiseaseSort;
  final Future<void> Function() onLoadMore;
  final bool enableSortSheet;
  final bool showIdleMasterState;
  final bool logDrugImageErrors;

  @override
  Widget build(BuildContext context) {
    final phase = state.phase;
    final l10n = AppLocalizations.of(context)!;
    if (phase is SearchPhaseLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: gutter),
        child: ShimmerSkeleton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                key: const ValueKey('search-loading-toolbar'),
                height: SearchConstants.searchResultToolbarHeight,
                child: Row(
                  children: [
                    ShimmerSkeletonShapes.compactBar(width: 96, height: 16),
                    const Spacer(),
                    ShimmerSkeletonShapes.compactBar(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  key: const PageStorageKey<String>('searchResultsSkeleton'),
                  itemCount: SearchConstants.searchShimmerSkeletonCount,
                  itemBuilder: (context, index) => const Card(
                    key: ValueKey('search-loading-skeleton-card'),
                    child: SizedBox(height: 72),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (phase is SearchPhaseEmpty) {
      final theme = Theme.of(context);
      final palette =
          theme.extension<AppPalette>() ??
          (theme.brightness == Brightness.dark
              ? AppPalette.dark
              : AppPalette.light);
      return Column(
        children: [
          _SearchResultToolbar(
            state: state,
            gutter: gutter,
            totalCount: 0,
            onRemoveChipAt: onRemoveChipAt,
            onChangeDrugSort: onChangeDrugSort,
            onChangeDiseaseSort: onChangeDiseaseSort,
            enableSortSheet: enableSortSheet,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Semantics(
                          label: l10n.searchEmptyResultTitle,
                          child: Container(
                            key: const ValueKey('search-empty-icon'),
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: palette.surface3,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.search_off,
                              size: 28,
                              color: palette.muted,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.searchEmptyResultTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.searchEmptyResultSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: palette.muted,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: SearchConstants.searchEmptyCtaHeight,
                        child: FilledButton(
                          key: const ValueKey('search-empty-reset-cta'),
                          onPressed: () => unawaited(onResetFilter()),
                          style: FilledButton.styleFrom(
                            backgroundColor: palette.searchPrimaryActionBg,
                            foregroundColor: palette.searchPrimaryActionFg,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                SearchConstants.searchEmptyCtaRadius,
                              ),
                            ),
                          ),
                          child: Text(
                            l10n.searchEmptyResetFilter,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: SearchConstants.searchEmptyCtaHeight,
                        child: OutlinedButton(
                          key: const ValueKey('search-empty-remove-one-cta'),
                          onPressed: () => unawaited(onRemoveOneChip()),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: palette.primary,
                            side: BorderSide(color: palette.primaryRing),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                SearchConstants.searchEmptyCtaRadius,
                              ),
                            ),
                          ),
                          child: Text(
                            l10n.searchEmptyRemoveOneFilter,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (phase is SearchPhaseError) {
      final theme = Theme.of(context);
      final palette =
          theme.extension<AppPalette>() ??
          (theme.brightness == Brightness.dark
              ? AppPalette.dark
              : AppPalette.light);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: gutter),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      key: const ValueKey('search-error-icon'),
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: palette.dangerCont,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: palette.danger,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _searchErrorTitle(l10n, phase.error),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _searchErrorBody(l10n, phase.error),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.6,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: SearchConstants.searchErrorCtaHeight,
                    child: FilledButton.icon(
                      key: const ValueKey('search-error-retry-cta'),
                      onPressed: () => unawaited(onRetry()),
                      style: FilledButton.styleFrom(
                        backgroundColor: palette.searchPrimaryActionBg,
                        foregroundColor: palette.searchPrimaryActionFg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            SearchConstants.searchErrorCtaRadius,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.refresh, size: 16),
                      label: Text(
                        l10n.searchErrorRetry,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  DecoratedBox(
                    key: const ValueKey('search-error-diagnostics-box'),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: palette.hairline, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final line in _diagnosticLines(
                            l10n,
                            phase.error,
                          ))
                            Text(
                              line,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 11,
                                height: 1.65,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    final isLoadingMore = phase is SearchPhaseLoadingMore;
    final view = switch (phase) {
      SearchPhaseResults(:final view) => view,
      SearchPhaseLoadingMore(:final previous) => previous,
      _ => null,
    };
    if (view == null) {
      if (showIdleMasterState && phase is SearchPhaseIdle) {
        return _SearchUtilityIdleMasterState(
          emptyHistory: state.historyForTab.isEmpty,
        );
      }
      if (state.historyDropdownOpen) {
        return const SizedBox.shrink();
      }
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SearchResultToolbar(
          state: state,
          gutter: gutter,
          totalCount: view.totalCount,
          onRemoveChipAt: onRemoveChipAt,
          onChangeDrugSort: onChangeDrugSort,
          onChangeDiseaseSort: onChangeDiseaseSort,
          enableSortSheet: enableSortSheet,
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is! ScrollUpdateNotification) {
                return false;
              }
              final metrics = notification.metrics;
              final nearEnd =
                  metrics.maxScrollExtent > 0 &&
                  metrics.pixels >= metrics.maxScrollExtent - 80;
              if (view.canLoadMore && nearEnd) {
                unawaited(onLoadMore());
              }
              return false;
            },
            child: ListView(
              key: state.tab == SearchTab.drugs
                  ? const PageStorageKey<String>('drugSearchResults')
                  : const PageStorageKey<String>('diseaseSearchResults'),
              controller: resultScrollController,
              primary: false,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                switch (view) {
                  DrugSearchResultsView(:final items) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final item in items)
                          DrugResultCard(
                            item: item,
                            cacheManager: drugCardImageCacheManager,
                            logImageErrors: logDrugImageErrors,
                            onTap: () =>
                                context.push(AppRoutes.drugDetail(item.id)),
                          ),
                      ],
                    ),
                  ),
                  DiseaseSearchResultsView(:final items) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final item in items)
                          DiseaseResultCard(
                            item: item,
                            onTap: () =>
                                context.push(AppRoutes.diseaseDetail(item.id)),
                          ),
                      ],
                    ),
                  ),
                },
                if (view.canLoadMore)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: isLoadingMore
                        ? Center(
                            child: DecoratedBox(
                              key: const ValueKey('search-load-more-footer'),
                              decoration: BoxDecoration(
                                color: palette.surface,
                                border: Border.all(
                                  color: palette.hairline,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                child: ShimmerSkeleton(
                                  child: ShimmerSkeletonShapes.compactBar(
                                    width: 120,
                                    height: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(child: Text(l10n.searchToolbarLoadMore)),
                  ),
                const SizedBox(
                  key: ValueKey('search-results-bottom-padding'),
                  height: SearchConstants.searchListBottomPadding,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _searchErrorTitle(AppLocalizations l10n, AppException error) {
  return switch (_searchErrorCategory(error)) {
    _SearchErrorCategory.network => l10n.searchErrorTitleNetwork,
    _SearchErrorCategory.server => l10n.searchErrorTitleServer,
    _SearchErrorCategory.business => l10n.searchErrorTitleBusiness,
    _SearchErrorCategory.parse => l10n.searchErrorTitleParse,
    _SearchErrorCategory.storage => l10n.searchErrorTitleStorage,
    _SearchErrorCategory.auth => l10n.searchErrorTitleAuth,
    _SearchErrorCategory.unknown => l10n.searchErrorTitleUnknown,
  };
}

String _searchErrorBody(AppLocalizations l10n, AppException error) {
  return switch (_searchErrorCategory(error)) {
    _SearchErrorCategory.network => l10n.searchErrorBodyNetwork,
    _SearchErrorCategory.server => l10n.searchErrorBodyServer,
    _SearchErrorCategory.business => l10n.searchErrorBodyBusiness,
    _SearchErrorCategory.parse => l10n.searchErrorBodyParse(
      _errorMessage(error),
    ),
    _SearchErrorCategory.storage => l10n.searchErrorBodyStorage(
      _errorMessage(error),
    ),
    _SearchErrorCategory.auth => l10n.searchErrorBodyAuth(_errorMessage(error)),
    _SearchErrorCategory.unknown => l10n.searchErrorBodyUnknown(
      _errorMessage(error),
    ),
  };
}

_SearchErrorCategory _searchErrorCategory(AppException error) {
  if (error case ApiException(statusCode: 401 || 403)) {
    return _SearchErrorCategory.auth;
  }

  return switch (errorKeyFor(error)) {
    'errNetwork' => _SearchErrorCategory.network,
    'errServer' => _SearchErrorCategory.server,
    'errApiNotFound' ||
    'errApiBadRequest' ||
    'errApiInvalidCategory' => _SearchErrorCategory.business,
    'errParse' => _SearchErrorCategory.parse,
    'errStorageUnique' ||
    'errStorageCheck' ||
    'errStorageGeneric' => _SearchErrorCategory.storage,
    _ => _SearchErrorCategory.unknown,
  };
}

String _errorMessage(AppException error) {
  return switch (error) {
    ApiException(:final message) when message.isNotEmpty => message,
    ServerException(:final statusCode) => 'HTTP $statusCode',
    StorageException(:final kind) => kind.name,
    _ => error.toString(),
  };
}

enum _SearchErrorCategory {
  network,
  server,
  business,
  parse,
  storage,
  auth,
  unknown,
}

List<String> _diagnosticLines(AppLocalizations l10n, AppException error) {
  return switch (error) {
    NetworkException() => [
      l10n.searchErrorDiagnosticsType('NetworkException'),
    ],
    ServerException(:final statusCode) => [
      l10n.searchErrorDiagnosticsType('ServerException'),
      l10n.searchErrorDiagnosticsStatus(statusCode),
    ],
    ApiException(
      :final statusCode,
      :final code,
      :final message,
      :final details,
    ) =>
      [
        l10n.searchErrorDiagnosticsType('ApiException'),
        l10n.searchErrorDiagnosticsStatus(statusCode),
        l10n.searchErrorDiagnosticsCode(code),
        l10n.searchErrorDiagnosticsMessage(message),
        if (details != null) l10n.searchErrorDiagnosticsDetails(details),
      ],
    ParseException() => [
      l10n.searchErrorDiagnosticsType('ParseException'),
    ],
    StorageException(:final kind) => [
      l10n.searchErrorDiagnosticsType('StorageException'),
      l10n.searchErrorDiagnosticsStorageKind(kind.name),
    ],
    UnknownException() => [
      l10n.searchErrorDiagnosticsType('UnknownException'),
    ],
  };
}

class _NoSearchHistoryState extends StatelessWidget {
  const _NoSearchHistoryState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: palette.surfaceSubtle,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.history, size: 22),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            l10n.searchHistoryEmptyTitle,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.searchHistoryEmptyDescription,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchUtilityIdleMasterState extends StatelessWidget {
  const _SearchUtilityIdleMasterState({required this.emptyHistory});

  final bool emptyHistory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return Center(
      key: const ValueKey('search-utility-idle-master-state'),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.surfaceSubtle,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: Icon(Icons.search, size: 28, color: palette.muted),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '検索キーワードを入力',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: palette.muted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                emptyHistory
                    ? '履歴はまだありません。検索すると右パネルに記録されます。'
                    : '履歴やフィルタからも始められます。',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: palette.muted,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchUtilityPane extends StatelessWidget {
  const _SearchUtilityPane({
    required this.state,
    required this.palette,
    required this.currentTime,
    required this.onSelectHistory,
    required this.onClearAllHistory,
    required this.onResetFilter,
    required this.onApplyDrugFilter,
    required this.onApplyDiseaseFilter,
    required this.onChangeDrugSort,
    required this.onChangeDiseaseSort,
  });

  final SearchScreenState state;
  final AppPalette palette;
  final DateTime currentTime;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelectHistory;
  final Future<void> Function() onClearAllHistory;
  final Future<void> Function() onResetFilter;
  final Future<void> Function({
    String? categoryAtc,
    String? therapeuticCategory,
    List<String>? regulatoryClass,
    List<String>? dosageForm,
    List<String>? route,
    String? adverseReactionKeyword,
    List<String>? precautionCategory,
  })
  onApplyDrugFilter;
  final Future<void> Function({
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
  onApplyDiseaseFilter;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;
  final Future<void> Function(DiseaseSort sort) onChangeDiseaseSort;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return DecoratedBox(
      key: const ValueKey('search-utility-pane'),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(left: BorderSide(color: palette.hairline)),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
        children: [
          _SearchUtilityCard(
            key: const ValueKey('search-utility-history-section'),
            title: l10n.searchHistoryTitle,
            child: _SearchUtilityHistorySection(
              entries: state.historyForTab,
              currentTime: currentTime,
              palette: palette,
              onSelect: onSelectHistory,
              onClearAll: onClearAllHistory,
            ),
          ),
          const SizedBox(height: 12),
          _SearchUtilityCard(
            key: const ValueKey('search-utility-filter-section'),
            title: l10n.searchFilterTitle,
            child: _SearchUtilityFilterSection(
              state: state,
              resultCount: _utilityResultCount(state),
              onReset: onResetFilter,
              onApplyDrugFilter: onApplyDrugFilter,
              onApplyDiseaseFilter: onApplyDiseaseFilter,
            ),
          ),
          const SizedBox(height: 12),
          _SearchUtilityCard(
            key: const ValueKey('search-utility-sort-section'),
            title: l10n.searchSortTitle,
            child: _SearchUtilitySortSection(
              state: state,
              palette: palette,
              onChangeDrugSort: onChangeDrugSort,
              onChangeDiseaseSort: onChangeDiseaseSort,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchUtilityCard extends StatelessWidget {
  const _SearchUtilityCard({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.surfaceSubtle,
        border: Border.all(color: palette.hairline, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _SearchUtilityHistorySection extends StatelessWidget {
  const _SearchUtilityHistorySection({
    required this.entries,
    required this.currentTime,
    required this.palette,
    required this.onSelect,
    required this.onClearAll,
  });

  final List<SearchHistoryEnvelope> entries;
  final DateTime currentTime;
  final AppPalette palette;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;
  final Future<void> Function() onClearAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final visibleEntries = entries.take(SearchConstants.searchHistoryMaxItems);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (entries.isEmpty)
          const _NoSearchHistoryState()
        else
          Column(
            key: const ValueKey('search-utility-history-list'),
            children: [
              for (final entry in visibleEntries)
                _SearchUtilityHistoryRow(
                  entry: entry,
                  currentTime: currentTime,
                  palette: palette,
                  onSelect: onSelect,
                ),
            ],
          ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            key: const ValueKey('search-utility-history-clear'),
            onPressed: entries.isEmpty ? null : () => unawaited(onClearAll()),
            child: Text(l10n.searchHistoryClear),
          ),
        ),
      ],
    );
  }
}

class _SearchUtilityHistoryRow extends StatelessWidget {
  const _SearchUtilityHistoryRow({
    required this.entry,
    required this.currentTime,
    required this.palette,
    required this.onSelect,
  });

  final SearchHistoryEnvelope entry;
  final DateTime currentTime;
  final AppPalette palette;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return InkWell(
      key: ValueKey('search-utility-history-row-${entry.id}'),
      onTap: () => unawaited(onSelect(entry)),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.queryText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 3),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(l10n.searchToolbarTotal(entry.totalCount)),
                Text(formatRelativeTime(currentTime, entry.searchedAt, l10n)),
                if (entry.filterCount > 0)
                  Container(
                    padding: const EdgeInsets.fromLTRB(7, 2, 8, 2),
                    decoration: BoxDecoration(
                      color: palette.primarySoft,
                      border: Border.all(
                        color: palette.primaryRing,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      l10n.searchHistoryFilterCount(entry.filterCount),
                      style: TextStyle(
                        color: palette.rxInk,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchUtilityFilterSection extends ConsumerStatefulWidget {
  const _SearchUtilityFilterSection({
    required this.state,
    required this.resultCount,
    required this.onReset,
    required this.onApplyDrugFilter,
    required this.onApplyDiseaseFilter,
  });

  final SearchScreenState state;
  final int resultCount;
  final Future<void> Function() onReset;
  final Future<void> Function({
    String? categoryAtc,
    String? therapeuticCategory,
    List<String>? regulatoryClass,
    List<String>? dosageForm,
    List<String>? route,
    String? adverseReactionKeyword,
    List<String>? precautionCategory,
  })
  onApplyDrugFilter;
  final Future<void> Function({
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
  onApplyDiseaseFilter;

  @override
  ConsumerState<_SearchUtilityFilterSection> createState() =>
      _SearchUtilityFilterSectionState();
}

class _SearchUtilityFilterSectionState
    extends ConsumerState<_SearchUtilityFilterSection> {
  late Set<String> _categoryAtc;
  late Set<String> _therapeuticCategory;
  late Set<String> _regulatoryClass;
  late Set<String> _dosageForm;
  late Set<String> _route;
  late Set<String> _precautionCategory;
  late TextEditingController _adverseReactionKeywordController;
  late Set<String> _icd10Chapter;
  late Set<String> _department;
  late Set<String> _chronicity;
  late Set<String> _onsetPattern;
  late Set<String> _examCategory;
  late TextEditingController _symptomKeywordController;
  late bool? _infectious;
  late bool? _hasPharmacologicalTreatment;
  late bool? _hasSeverityGrading;
  var _expandedAxis = '';
  Timer? _previewDebounce;
  int? _previewCount;

  @override
  void initState() {
    super.initState();
    _syncFromState(widget.state);
  }

  @override
  void didUpdateWidget(covariant _SearchUtilityFilterSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.tab != widget.state.tab ||
        oldWidget.state.drugParams != widget.state.drugParams ||
        oldWidget.state.diseaseParams != widget.state.diseaseParams) {
      _disposeControllers();
      _syncFromState(widget.state);
    }
  }

  @override
  void dispose() {
    _previewDebounce?.cancel();
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _adverseReactionKeywordController.dispose();
    _symptomKeywordController.dispose();
  }

  void _syncFromState(SearchScreenState state) {
    _categoryAtc = {?state.drugParams.categoryAtc};
    _therapeuticCategory = {?state.drugParams.therapeuticCategory};
    _regulatoryClass = {...?state.drugParams.regulatoryClass};
    _dosageForm = {...?state.drugParams.dosageForm};
    _route = {...?state.drugParams.route};
    _precautionCategory = {...?state.drugParams.precautionCategory};
    _adverseReactionKeywordController = TextEditingController(
      text: state.drugParams.adverseReactionKeyword,
    );
    _icd10Chapter = {...?state.diseaseParams.icd10Chapter};
    _department = {...?state.diseaseParams.department};
    _chronicity = {...?state.diseaseParams.chronicity};
    _onsetPattern = {...?state.diseaseParams.onsetPattern};
    _examCategory = {...?state.diseaseParams.examCategory};
    _symptomKeywordController = TextEditingController(
      text: state.diseaseParams.symptomKeyword,
    );
    _infectious = state.diseaseParams.infectious;
    _hasPharmacologicalTreatment =
        state.diseaseParams.hasPharmacologicalTreatment;
    _hasSeverityGrading = state.diseaseParams.hasSeverityGrading;
    _expandedAxis = state.tab == SearchTab.drugs
        ? 'regulatory_class'
        : 'icd10_chapter';
    _previewCount = null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final axes = _utilityFilterAxesForState(l10n, widget.state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${axes.length} 軸 · 軸内 OR / 軸間 AND',
          key: const ValueKey('search-utility-filter-policy'),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        for (final axis in axes)
          _SearchUtilityAxisTile(
            axis: axis,
            expanded: _expandedAxis == axis.id,
            onTap: () => setState(() {
              _expandedAxis = _expandedAxis == axis.id ? '' : axis.id;
            }),
          ),
        const SizedBox(height: 10),
        Row(
          children: [
            TextButton(
              key: const ValueKey('search-utility-filter-reset'),
              onPressed: () {
                setState(() {
                  _categoryAtc.clear();
                  _therapeuticCategory.clear();
                  _regulatoryClass.clear();
                  _dosageForm.clear();
                  _route.clear();
                  _precautionCategory.clear();
                  _adverseReactionKeywordController.clear();
                  _icd10Chapter.clear();
                  _department.clear();
                  _chronicity.clear();
                  _onsetPattern.clear();
                  _examCategory.clear();
                  _symptomKeywordController.clear();
                  _infectious = null;
                  _hasPharmacologicalTreatment = null;
                  _hasSeverityGrading = null;
                  _schedulePreview();
                });
                unawaited(widget.onReset());
              },
              child: Text(l10n.searchFilterReset),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton(
                key: const ValueKey('search-utility-filter-apply'),
                onPressed: _apply,
                child: Text(
                  l10n.searchFilterApplyWithCount(
                    _previewCount ?? widget.resultCount,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _apply() {
    if (widget.state.tab == SearchTab.drugs) {
      unawaited(
        widget.onApplyDrugFilter(
          categoryAtc: _singleValue(_categoryAtc),
          therapeuticCategory: _singleValue(_therapeuticCategory),
          regulatoryClass: _regulatoryClass.toList(),
          dosageForm: _dosageForm.toList(),
          route: _route.toList(),
          adverseReactionKeyword: _emptyToNull(
            _adverseReactionKeywordController.text.trim(),
          ),
          precautionCategory: _precautionCategory.toList(),
        ),
      );
      return;
    }
    unawaited(
      widget.onApplyDiseaseFilter(
        icd10Chapter: _icd10Chapter.toList(),
        department: _department.toList(),
        chronicity: _chronicity.toList(),
        infectious: _infectious,
        symptomKeyword: _emptyToNull(_symptomKeywordController.text.trim()),
        onsetPattern: _onsetPattern.toList(),
        examCategory: _examCategory.toList(),
        hasPharmacologicalTreatment: _hasPharmacologicalTreatment,
        hasSeverityGrading: _hasSeverityGrading,
      ),
    );
  }

  void _schedulePreview() {
    _previewDebounce?.cancel();
    _previewDebounce = Timer(const Duration(milliseconds: 200), () {
      unawaited(_loadPreviewCount());
    });
  }

  Future<void> _loadPreviewCount() async {
    final notifier = ref.read(searchScreenProvider.notifier);
    final count = switch (widget.state.tab) {
      SearchTab.drugs => await notifier.previewDrugCount(_drugPreviewParams()),
      SearchTab.diseases => await notifier.previewDiseaseCount(
        _diseasePreviewParams(),
      ),
    };
    if (!mounted || count == null) {
      return;
    }
    setState(() => _previewCount = count);
  }

  DrugSearchParams _drugPreviewParams() {
    return DrugSearchParams(
      page: 1,
      pageSize: 1,
      categoryAtc: _singleValue(_categoryAtc),
      therapeuticCategory: _singleValue(_therapeuticCategory),
      regulatoryClass: _emptyListToNull(_regulatoryClass.toList()),
      dosageForm: _emptyListToNull(_dosageForm.toList()),
      route: _emptyListToNull(_route.toList()),
      keyword: widget.state.queryText,
      keywordMatch: widget.state.drugParams.keywordMatch,
      keywordTarget: widget.state.drugParams.keywordTarget,
      adverseReactionKeyword: _emptyToNull(
        _adverseReactionKeywordController.text.trim(),
      ),
      precautionCategory: _emptyListToNull(_precautionCategory.toList()),
      sort: widget.state.drugParams.sort,
    );
  }

  DiseaseSearchParams _diseasePreviewParams() {
    return DiseaseSearchParams(
      page: 1,
      pageSize: 1,
      icd10Chapter: _emptyListToNull(_icd10Chapter.toList()),
      department: _emptyListToNull(_department.toList()),
      chronicity: _emptyListToNull(_chronicity.toList()),
      infectious: _infectious,
      keyword: widget.state.queryText,
      keywordMatch: widget.state.diseaseParams.keywordMatch,
      keywordTarget: widget.state.diseaseParams.keywordTarget,
      symptomKeyword: _emptyToNull(_symptomKeywordController.text.trim()),
      onsetPattern: _emptyListToNull(_onsetPattern.toList()),
      examCategory: _emptyListToNull(_examCategory.toList()),
      hasPharmacologicalTreatment: _hasPharmacologicalTreatment,
      hasSeverityGrading: _hasSeverityGrading,
      sort: widget.state.diseaseParams.sort,
    );
  }

  void _toggle(Set<String> target, String value) {
    if (!target.add(value)) {
      target.remove(value);
    }
  }

  void _toggleSingle(Set<String> target, String value) {
    if (target.contains(value)) {
      target.clear();
      return;
    }
    target
      ..clear()
      ..add(value);
  }

  String? _singleValue(Set<String> target) {
    if (target.isEmpty) {
      return null;
    }
    return target.first;
  }

  List<_FilterAxis> _utilityFilterAxesForState(
    AppLocalizations l10n,
    SearchScreenState state,
  ) {
    final categories = state.categories;
    if (categories == null) {
      return _utilityFilterAxes(l10n, state.tab)
          .map(
            (axis) => _FilterAxis(
              id: axis.id,
              title: axis.label,
              summary: 'すべて',
              selectedCount: 0,
              hint: axis.meta,
              content: const SizedBox.shrink(),
            ),
          )
          .toList();
    }
    return switch (state.tab) {
      SearchTab.drugs => [
        _FilterAxis(
          id: 'regulatory_class',
          title: l10n.searchFilterDrugRegulatoryClass,
          summary: _selectedSummary(
            l10n,
            _regulatoryClass,
            (value) => _regulatoryClassLabel(l10n, value),
          ),
          selectedCount: _regulatoryClass.length,
          hint: l10n.searchFilterHintMultiValue(
            categories.regulatoryClass.length,
          ),
          content: _FilterChipGroup(
            values: categories.regulatoryClass,
            selected: _regulatoryClass,
            labelFor: (value) => _regulatoryClassLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggle(_regulatoryClass, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'dosage_form',
          title: l10n.searchFilterDrugDosageForm,
          summary: _selectedSummary(
            l10n,
            _dosageForm,
            (value) => _dosageFormLabel(l10n, value),
          ),
          selectedCount: _dosageForm.length,
          hint: l10n.searchFilterHintMultiValue(categories.dosageForm.length),
          content: _FilterChipGroup(
            values: categories.dosageForm,
            selected: _dosageForm,
            labelFor: (value) => _dosageFormLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggle(_dosageForm, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'route',
          title: l10n.searchFilterDrugRoute,
          summary: _selectedSummary(
            l10n,
            _route,
            (value) => _routeLabel(l10n, value),
          ),
          selectedCount: _route.length,
          hint: l10n.searchFilterHintMultiValue(
            categories.routeOfAdministration.length,
          ),
          content: _FilterChipGroup(
            values: categories.routeOfAdministration,
            selected: _route,
            labelFor: (value) => _routeLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggle(_route, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'atc',
          title: l10n.searchFilterDrugAtc,
          summary: _selectedSummary(
            l10n,
            _categoryAtc,
            (value) => _atcLabel(categories, value),
          ),
          selectedCount: _categoryAtc.length,
          hint: l10n.searchFilterHintSingleValue(categories.atc.length),
          content: _FilterChipGroup(
            values: categories.atc.map((entry) => entry.code).toList(),
            selected: _categoryAtc,
            labelFor: (value) => _atcLabel(categories, value),
            onToggle: (value) => setState(() {
              _toggleSingle(_categoryAtc, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'therapeutic_category',
          title: l10n.searchFilterDrugTherapeuticCategory,
          summary: _selectedSummary(
            l10n,
            _therapeuticCategory,
            (value) => _therapeuticCategoryLabel(categories, value),
          ),
          selectedCount: _therapeuticCategory.length,
          hint: l10n.searchFilterHintHierarchy,
          content: _FilterChipGroup(
            values: categories.therapeuticCategories
                .map((entry) => entry.id)
                .toList(),
            selected: _therapeuticCategory,
            labelFor: (value) => _therapeuticCategoryLabel(categories, value),
            onToggle: (value) => setState(() {
              _toggleSingle(_therapeuticCategory, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'adverse_reaction',
          title: l10n.searchFilterDrugAdverseReactionKeyword,
          summary: _textSummary(
            l10n,
            _adverseReactionKeywordController.text.trim(),
          ),
          selectedCount:
              _emptyToNull(_adverseReactionKeywordController.text.trim()) ==
                  null
              ? 0
              : 1,
          hint: l10n.searchFilterHintPartialMatch,
          content: TextField(
            key: const ValueKey('drug-filter-adverse-reaction'),
            controller: _adverseReactionKeywordController,
            onChanged: (_) => setState(_schedulePreview),
            decoration: InputDecoration(
              labelText: l10n.searchFilterDrugAdverseReactionKeyword,
            ),
          ),
        ),
        _FilterAxis(
          id: 'precaution_category',
          title: l10n.searchFilterDrugPrecautionCategory,
          summary: _selectedSummary(
            l10n,
            _precautionCategory,
            (value) => _precautionCategoryLabel(l10n, value),
          ),
          selectedCount: _precautionCategory.length,
          hint: l10n.searchFilterHintMultiValue(
            DrugPrecautionCategory.values.length,
          ),
          content: _FilterChipGroup(
            values: DrugPrecautionCategory.values
                .map((category) => category.wireValue)
                .toList(),
            selected: _precautionCategory,
            labelFor: (value) => _precautionCategoryLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggle(_precautionCategory, value);
              _schedulePreview();
            }),
          ),
        ),
      ],
      SearchTab.diseases => [
        _FilterAxis(
          id: 'icd10_chapter',
          title: l10n.searchFilterDiseaseIcd10Chapter,
          summary: _selectedSummary(
            l10n,
            _icd10Chapter,
            (value) => _icd10ChapterLabel(categories, value),
          ),
          selectedCount: _icd10Chapter.length,
          hint: l10n.searchFilterHintDrillIn(categories.icd10Chapters.length),
          content: _FilterChipGroup(
            values: categories.icd10Chapters.map(_icd10ChapterValue).toList(),
            selected: _icd10Chapter,
            labelFor: (value) => _icd10ChapterLabel(categories, value),
            onToggle: (value) => setState(() {
              _toggle(_icd10Chapter, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'department',
          title: l10n.searchFilterDiseaseDepartment,
          summary: _selectedSummary(
            l10n,
            _department,
            (value) => _departmentLabel(l10n, value),
          ),
          selectedCount: _department.length,
          hint: l10n.searchFilterHintMultiValue(
            categories.medicalDepartments.length,
          ),
          content: _FilterChipGroup(
            values: categories.medicalDepartments,
            selected: _department,
            labelFor: (value) => _departmentLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggle(_department, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'chronicity',
          title: l10n.searchFilterDiseaseChronicity,
          summary: _selectedSummary(
            l10n,
            _chronicity,
            (value) => _chronicityLabel(l10n, value),
          ),
          selectedCount: _chronicity.length,
          hint: l10n.searchFilterHintSingleValue(
            _diseaseChronicityValues.length,
          ),
          content: _FilterChipGroup(
            values: _diseaseChronicityValues,
            selected: _chronicity,
            labelFor: (value) => _chronicityLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggleSingle(_chronicity, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'infectious',
          title: l10n.searchFilterDiseaseInfectious,
          summary: _boolSummary(l10n, _infectious),
          selectedCount: _infectious == null ? 0 : 1,
          hint: l10n.searchFilterHintBool,
          content: _BoolChipGroup(
            value: _infectious,
            trueLabel: l10n.searchDiseaseInfectiousTrue,
            falseLabel: l10n.searchDiseaseInfectiousFalse,
            onChanged: (value) => setState(() {
              _infectious = value;
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'symptom_keyword',
          title: l10n.searchFilterDiseaseSymptomKeyword,
          summary: _textSummary(l10n, _symptomKeywordController.text.trim()),
          selectedCount:
              _emptyToNull(_symptomKeywordController.text.trim()) == null
              ? 0
              : 1,
          hint: l10n.searchFilterHintPartialMatch,
          content: TextField(
            key: const ValueKey('disease-filter-symptom-keyword'),
            controller: _symptomKeywordController,
            onChanged: (_) => setState(_schedulePreview),
            decoration: InputDecoration(
              labelText: l10n.searchFilterDiseaseSymptomKeyword,
            ),
          ),
        ),
        _FilterAxis(
          id: 'onset_pattern',
          title: l10n.searchFilterDiseaseOnsetPattern,
          summary: _selectedSummary(
            l10n,
            _onsetPattern,
            (value) => _onsetPatternLabel(l10n, value),
          ),
          selectedCount: _onsetPattern.length,
          hint: l10n.searchFilterHintMultiValue(
            _diseaseOnsetPatternValues.length,
          ),
          content: _FilterChipGroup(
            values: _diseaseOnsetPatternValues,
            selected: _onsetPattern,
            labelFor: (value) => _onsetPatternLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggle(_onsetPattern, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'exam_category',
          title: l10n.searchFilterDiseaseExamCategory,
          summary: _selectedSummary(
            l10n,
            _examCategory,
            (value) => _examCategoryLabel(l10n, value),
          ),
          selectedCount: _examCategory.length,
          hint: l10n.searchFilterHintMultiValue(
            _diseaseExamCategoryValues.length,
          ),
          content: _FilterChipGroup(
            values: _diseaseExamCategoryValues,
            selected: _examCategory,
            labelFor: (value) => _examCategoryLabel(l10n, value),
            onToggle: (value) => setState(() {
              _toggle(_examCategory, value);
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'has_pharmacological_treatment',
          title: l10n.searchFilterDiseaseHasPharmacologicalTreatment,
          summary: _boolSummary(l10n, _hasPharmacologicalTreatment),
          selectedCount: _hasPharmacologicalTreatment == null ? 0 : 1,
          hint: l10n.searchFilterHintBool,
          content: _BoolChipGroup(
            value: _hasPharmacologicalTreatment,
            trueLabel: l10n.searchDiseaseBoolTrue,
            falseLabel: l10n.searchDiseaseBoolFalse,
            onChanged: (value) => setState(() {
              _hasPharmacologicalTreatment = value;
              _schedulePreview();
            }),
          ),
        ),
        _FilterAxis(
          id: 'has_severity_grading',
          title: l10n.searchFilterDiseaseHasSeverityGrading,
          summary: _boolSummary(l10n, _hasSeverityGrading),
          selectedCount: _hasSeverityGrading == null ? 0 : 1,
          hint: l10n.searchFilterHintBool,
          content: _BoolChipGroup(
            value: _hasSeverityGrading,
            trueLabel: l10n.searchDiseaseBoolTrue,
            falseLabel: l10n.searchDiseaseBoolFalse,
            onChanged: (value) => setState(() {
              _hasSeverityGrading = value;
              _schedulePreview();
            }),
          ),
        ),
      ],
    };
  }
}

class _SearchUtilityAxisTile extends StatelessWidget {
  const _SearchUtilityAxisTile({
    required this.axis,
    required this.expanded,
    required this.onTap,
  });

  final _FilterAxis axis;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return DecoratedBox(
      key: ValueKey('search-utility-filter-axis-${axis.id}'),
      decoration: BoxDecoration(
        color: expanded ? palette.surfaceSubtle : Colors.transparent,
        border: Border.all(color: palette.hairline, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      axis.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (axis.selectedCount > 0) ...[
                    const SizedBox(width: 6),
                    _FilterCountPill(count: axis.selectedCount),
                  ],
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 120),
                    child: const Icon(Icons.chevron_right, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                axis.hint,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: palette.muted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                axis.summary,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: palette.muted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (expanded) ...[
                const SizedBox(height: 8),
                KeyedSubtree(
                  key: ValueKey('search-utility-filter-axis-values-${axis.id}'),
                  child: axis.content,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchUtilitySortSection extends StatelessWidget {
  const _SearchUtilitySortSection({
    required this.state,
    required this.palette,
    required this.onChangeDrugSort,
    required this.onChangeDiseaseSort,
  });

  final SearchScreenState state;
  final AppPalette palette;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;
  final Future<void> Function(DiseaseSort sort) onChangeDiseaseSort;

  @override
  Widget build(BuildContext context) {
    final options = _utilitySortOptions(AppLocalizations.of(context)!, state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final option in options)
          _SearchUtilitySortOptionTile(
            option: option,
            palette: palette,
            onTap: () {
              switch (option.value) {
                case final DrugSort sort:
                  unawaited(onChangeDrugSort(sort));
                case final DiseaseSort sort:
                  unawaited(onChangeDiseaseSort(sort));
              }
            },
          ),
      ],
    );
  }
}

class _SearchUtilitySortOptionTile extends StatelessWidget {
  const _SearchUtilitySortOptionTile({
    required this.option,
    required this.palette,
    required this.onTap,
  });

  final _UtilitySortOption option;
  final AppPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      key: ValueKey('search-utility-sort-${option.keySuffix}'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: option.selected ? palette.primarySoft : Colors.transparent,
          border: Border.all(
            color: option.selected ? palette.primaryRing : palette.hairline,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: option.selected ? palette.primary : null,
                    fontWeight: option.selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
              Container(
                key: option.selected
                    ? const ValueKey('search-utility-sort-radio-selected')
                    : null,
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: palette.primary, width: 1.5),
                ),
                child: option.selected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: palette.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<_UtilityFilterAxis> _utilityFilterAxes(
  AppLocalizations l10n,
  SearchTab tab,
) {
  return switch (tab) {
    SearchTab.drugs => [
      _UtilityFilterAxis(
        id: 'regulatory_class',
        label: l10n.searchFilterDrugRegulatoryClass,
        meta: '11 値・複数選択 OR',
      ),
      _UtilityFilterAxis(
        id: 'dosage_form',
        label: l10n.searchFilterDrugDosageForm,
        meta: '13 値・複数選択 OR',
      ),
      _UtilityFilterAxis(
        id: 'route',
        label: l10n.searchFilterDrugRoute,
        meta: '8 値・複数選択 OR',
      ),
      _UtilityFilterAxis(
        id: 'atc',
        label: l10n.searchFilterDrugAtc,
        meta: '14 値・単一選択',
      ),
      _UtilityFilterAxis(
        id: 'therapeutic_category',
        label: l10n.searchFilterDrugTherapeuticCategory,
        meta: '階層選択',
      ),
      _UtilityFilterAxis(
        id: 'adverse_reaction_keyword',
        label: l10n.searchFilterDrugAdverseReactionKeyword,
        meta: '部分一致',
      ),
      _UtilityFilterAxis(
        id: 'precaution_category',
        label: l10n.searchFilterDrugPrecautionCategory,
        meta: '8 値・複数選択 OR',
      ),
    ],
    SearchTab.diseases => [
      _UtilityFilterAxis(
        id: 'icd10_chapter',
        label: l10n.searchFilterDiseaseIcd10Chapter,
        meta: '22 値・複数選択 OR',
      ),
      _UtilityFilterAxis(
        id: 'department',
        label: l10n.searchFilterDiseaseDepartment,
        meta: '診療科・複数選択 OR',
      ),
      _UtilityFilterAxis(
        id: 'chronicity',
        label: l10n.searchFilterDiseaseChronicity,
        meta: '急性 / 慢性',
      ),
      _UtilityFilterAxis(
        id: 'infectious',
        label: l10n.searchFilterDiseaseInfectious,
        meta: '真偽値',
      ),
      _UtilityFilterAxis(
        id: 'symptom_keyword',
        label: l10n.searchFilterDiseaseSymptomKeyword,
        meta: '部分一致',
      ),
      _UtilityFilterAxis(
        id: 'onset_pattern',
        label: l10n.searchFilterDiseaseOnsetPattern,
        meta: '複数選択 OR',
      ),
      _UtilityFilterAxis(
        id: 'exam_category',
        label: l10n.searchFilterDiseaseExamCategory,
        meta: '複数選択 OR',
      ),
      _UtilityFilterAxis(
        id: 'has_pharmacological_treatment',
        label: l10n.searchFilterDiseaseHasPharmacologicalTreatment,
        meta: '真偽値',
      ),
      _UtilityFilterAxis(
        id: 'has_severity_grading',
        label: l10n.searchFilterDiseaseHasSeverityGrading,
        meta: '真偽値',
      ),
    ],
  };
}

List<_UtilitySortOption> _utilitySortOptions(
  AppLocalizations l10n,
  SearchScreenState state,
) {
  return switch (state.tab) {
    SearchTab.drugs => [
      for (final sort in DrugSort.values)
        _UtilitySortOption(
          label: _drugSortLabel(l10n, sort),
          wireValue: sort.serialName,
          selected: (state.drugParams.sort ?? DrugSort.revisedAtDesc) == sort,
          value: sort,
        ),
    ],
    SearchTab.diseases => [
      for (final sort in DiseaseSort.values)
        _UtilitySortOption(
          label: _diseaseSortLabel(l10n, sort),
          wireValue: sort.serialName,
          selected:
              (state.diseaseParams.sort ?? DiseaseSort.revisedAtDesc) == sort,
          value: sort,
        ),
    ],
  };
}

int _utilityResultCount(SearchScreenState state) {
  return switch (state.phase) {
    SearchPhaseResults(:final view) => view.totalCount,
    SearchPhaseLoadingMore(:final previous) => previous.totalCount,
    SearchPhaseEmpty() => 0,
    _ => 0,
  };
}

final class _UtilityFilterAxis {
  const _UtilityFilterAxis({
    required this.id,
    required this.label,
    required this.meta,
  });

  final String id;
  final String label;
  final String meta;
}

final class _UtilitySortOption {
  const _UtilitySortOption({
    required this.label,
    required this.wireValue,
    required this.selected,
    required this.value,
  });

  final String label;
  final String wireValue;
  final bool selected;
  final Object value;

  String get keySuffix => wireValue.replaceFirst(RegExp('^-'), '');
}
