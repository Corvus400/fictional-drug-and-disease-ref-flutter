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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  key: const ValueKey(
                                    'search-load-more-spinner',
                                  ),
                                  strokeWidth: 2,
                                  color: palette.primary,
                                  backgroundColor: palette.surface3,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                l10n.searchToolbarLoadMoreWithProgress(
                                  view.page,
                                  view.totalPages,
                                ),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: palette.muted,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
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
