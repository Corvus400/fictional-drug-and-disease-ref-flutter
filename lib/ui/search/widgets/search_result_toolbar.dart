part of '../search_view.dart';

class _SearchResultToolbar extends StatefulWidget {
  const _SearchResultToolbar({
    required this.state,
    required this.gutter,
    required this.totalCount,
    required this.onRemoveChipAt,
    required this.onOpenSortSheet,
    required this.onChangeDrugSort,
    required this.onChangeDiseaseSort,
    required this.enableSortSheet,
  });

  final SearchScreenState state;
  final double gutter;
  final int totalCount;
  final Future<void> Function(int index) onRemoveChipAt;
  final VoidCallback onOpenSortSheet;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;
  final Future<void> Function(DiseaseSort sort) onChangeDiseaseSort;
  final bool enableSortSheet;

  @override
  State<_SearchResultToolbar> createState() => _SearchResultToolbarState();
}

class _SearchResultToolbarState extends State<_SearchResultToolbar> {
  late final ScrollController _chipScrollController;
  var _chipRailScrollable = false;

  @override
  void initState() {
    super.initState();
    _chipScrollController = ScrollController()..addListener(_syncScrollable);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncScrollable());
  }

  @override
  void didUpdateWidget(covariant _SearchResultToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncScrollable());
  }

  @override
  void dispose() {
    _chipScrollController
      ..removeListener(_syncScrollable)
      ..dispose();
    super.dispose();
  }

  void _syncScrollable() {
    if (!mounted || !_chipScrollController.hasClients) {
      return;
    }
    final next = _chipScrollController.position.maxScrollExtent > 0;
    if (next != _chipRailScrollable) {
      setState(() {
        _chipRailScrollable = next;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.state.appliedChips.count > 0)
          DecoratedBox(
            key: const ValueKey('search-applied-filter-bar'),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(top: BorderSide(color: palette.hairline)),
            ),
            child: SizedBox(
              height: SearchConstants.searchAppliedChipBarHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      controller: _chipScrollController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(
                        16,
                        8,
                        _chipRailScrollable ? 36 : 16,
                        10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            l10n.searchToolbarApplied,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: palette.muted,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          for (
                            var i = 0;
                            i < widget.state.appliedChips.items.length;
                            i++
                          ) ...[
                            _AppliedFilterChip(
                              label: _appliedChipLabel(
                                l10n,
                                widget.state.categories,
                                widget.state.appliedChips.items[i],
                              ),
                              palette: palette,
                              onTap: () => widget.onRemoveChipAt(i),
                            ),
                            const SizedBox(width: 6),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (_chipRailScrollable) ...[
                    Positioned(
                      key: const ValueKey('search-applied-filter-fade'),
                      top: 0,
                      right: 0,
                      bottom: 0,
                      width: 30,
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.surface.withValues(alpha: 0),
                                theme.colorScheme.surface,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      key: const ValueKey('search-applied-filter-chevron'),
                      top: 14,
                      right: 4,
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: palette.surfaceSubtle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(Icons.chevron_right, size: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.gutter),
          child: SizedBox(
            key: const ValueKey('search-results-toolbar'),
            height: SearchConstants.searchResultToolbarHeight,
            child: Row(
              children: [
                Text(l10n.searchToolbarTotal(widget.totalCount)),
                const SizedBox(width: 8),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: widget.enableSortSheet
                          ? widget.onOpenSortSheet
                          : null,
                      child: Text(
                        _sortToolbarLabel(l10n, widget.state),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: palette.primary,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _sortToolbarLabel(AppLocalizations l10n, SearchScreenState state) {
  final axis = switch (state.tab) {
    SearchTab.drugs => _drugSortLabel(
      l10n,
      state.drugParams.sort ?? DrugSort.revisedAtDesc,
    ),
    SearchTab.diseases => _diseaseSortLabel(
      l10n,
      state.diseaseParams.sort ?? DiseaseSort.revisedAtDesc,
    ),
  };
  final direction = switch (state.tab) {
    SearchTab.drugs => _drugSortDirection(
      state.drugParams.sort ?? DrugSort.revisedAtDesc,
    ),
    SearchTab.diseases => _diseaseSortDirection(
      state.diseaseParams.sort ?? DiseaseSort.revisedAtDesc,
    ),
  };
  return '${l10n.searchSortTitle}： $axis $direction ▾';
}

String _drugSortLabel(AppLocalizations l10n, DrugSort sort) {
  return switch (sort) {
    DrugSort.revisedAtDesc => l10n.searchSortByRevised,
    DrugSort.brandNameKana => l10n.searchSortByBrandKana,
    DrugSort.atcCode => l10n.searchSortByAtcCode,
    DrugSort.therapeuticCategoryName => l10n.searchSortByTherapeuticCategory,
  };
}

String _diseaseSortLabel(AppLocalizations l10n, DiseaseSort sort) {
  return switch (sort) {
    DiseaseSort.revisedAtDesc => l10n.searchSortDiseaseRevisedAt,
    DiseaseSort.nameKana => l10n.searchSortDiseaseName,
    DiseaseSort.icd10Chapter => l10n.searchSortDiseaseIcd10,
  };
}

String _drugSortDirection(DrugSort sort) {
  return switch (sort) {
    DrugSort.revisedAtDesc => '↓',
    DrugSort.brandNameKana ||
    DrugSort.atcCode ||
    DrugSort.therapeuticCategoryName => '↑',
  };
}

String _diseaseSortDirection(DiseaseSort sort) {
  return switch (sort) {
    DiseaseSort.revisedAtDesc => '↓',
    DiseaseSort.nameKana || DiseaseSort.icd10Chapter => '↑',
  };
}

class _AppliedFilterChip extends StatelessWidget {
  const _AppliedFilterChip({
    required this.label,
    required this.palette,
    required this.onTap,
  });

  final String label;
  final AppPalette palette;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final closeColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0x389ECAFF)
        : const Color(0x2E007AFF);
    return InkWell(
      onTap: () => unawaited(onTap()),
      borderRadius: BorderRadius.circular(14),
      child: DecoratedBox(
        key: ValueKey('search-applied-filter-chip-$label'),
        decoration: BoxDecoration(
          color: palette.primarySoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: palette.primaryRing, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 8, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: palette.rxInk,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 5),
              DecoratedBox(
                key: ValueKey('search-applied-filter-close-$label'),
                decoration: BoxDecoration(
                  color: closeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: Icon(Icons.close, size: 10, color: palette.rxInk),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
