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
    return NotificationListener<ScrollNotification>(
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
          _SearchResultToolbar(
            state: state,
            gutter: gutter,
            totalCount: view.totalCount,
            onRemoveChipAt: onRemoveChipAt,
            onChangeDrugSort: onChangeDrugSort,
            onChangeDiseaseSort: onChangeDiseaseSort,
            enableSortSheet: enableSortSheet,
          ),
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
                      onTap: () => context.push(AppRoutes.drugDetail(item.id)),
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
    required this.onApplyFilter,
    required this.onChangeDrugSort,
    required this.onChangeDiseaseSort,
  });

  final SearchScreenState state;
  final AppPalette palette;
  final DateTime currentTime;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelectHistory;
  final Future<void> Function() onClearAllHistory;
  final Future<void> Function() onResetFilter;
  final Future<void> Function() onApplyFilter;
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
              tab: state.tab,
              resultCount: _utilityResultCount(state),
              onReset: onResetFilter,
              onApply: onApplyFilter,
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

class _SearchUtilityFilterSection extends StatelessWidget {
  const _SearchUtilityFilterSection({
    required this.tab,
    required this.resultCount,
    required this.onReset,
    required this.onApply,
  });

  final SearchTab tab;
  final int resultCount;
  final Future<void> Function() onReset;
  final Future<void> Function() onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final axes = _utilityFilterAxes(l10n, tab);
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
        for (final axis in axes) _SearchUtilityAxisTile(axis: axis),
        const SizedBox(height: 10),
        Row(
          children: [
            TextButton(
              key: const ValueKey('search-utility-filter-reset'),
              onPressed: () => unawaited(onReset()),
              child: Text(l10n.searchFilterReset),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton(
                key: const ValueKey('search-utility-filter-apply'),
                onPressed: () => unawaited(onApply()),
                child: Text(l10n.searchFilterApplyWithCount(resultCount)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchUtilityAxisTile extends StatelessWidget {
  const _SearchUtilityAxisTile({required this.axis});

  final _UtilityFilterAxis axis;

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
        color: Colors.transparent,
        border: Border.all(color: palette.hairline, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    axis.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              axis.meta,
              style: theme.textTheme.bodySmall?.copyWith(color: palette.muted),
            ),
            const SizedBox(height: 2),
            Text(
              'すべて',
              style: theme.textTheme.bodySmall?.copyWith(
                color: palette.muted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
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
