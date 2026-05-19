part of '../search_view.dart';

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
    required this.keyboardBottomInset,
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
  final double keyboardBottomInset;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DecoratedBox(
      key: const ValueKey('search-utility-pane'),
      decoration: BoxDecoration(
        color: palette.surface2,
        border: Border(left: BorderSide(color: palette.hairline, width: 0.5)),
      ),
      child: Listener(
        onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          key: const ValueKey('search-utility-pane-scroll'),
          padding: EdgeInsets.fromLTRB(14, 12, 14, 20 + keyboardBottomInset),
          children: [
            _SearchUtilityCard(
              key: const ValueKey('search-utility-history-section'),
              title: l10n.searchHistoryRecentTitle,
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
        color: palette.surface,
        border: Border.all(color: palette.hairline, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: palette.ink,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.02,
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
