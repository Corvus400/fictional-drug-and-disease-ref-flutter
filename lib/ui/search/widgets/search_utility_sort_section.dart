part of '../search_view.dart';

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
    return DecoratedBox(
      key: const ValueKey('search-utility-sort-options'),
      decoration: BoxDecoration(
        color: palette.hairline2,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (index, option) in options.indexed) ...[
              if (index > 0)
                SizedBox(
                  height: 1,
                  child: ColoredBox(color: palette.hairline2),
                ),
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
          ],
        ),
      ),
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
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: option.selected ? palette.primarySoft : palette.surface,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: option.selected ? palette.primary : palette.ink,
                      fontSize: 12.5,
                      fontWeight: option.selected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  key: ValueKey(
                    'search-utility-sort-radio-${option.keySuffix}',
                  ),
                  constraints: const BoxConstraints.tightFor(
                    width: 18,
                    height: 18,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: option.selected ? palette.primary : palette.muted2,
                      width: 1.5,
                    ),
                  ),
                  child: option.selected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
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
        meta: l10n.searchFilterHintMultiValue(11),
      ),
      _UtilityFilterAxis(
        id: 'dosage_form',
        label: l10n.searchFilterDrugDosageForm,
        meta: l10n.searchFilterHintMultiValue(13),
      ),
      _UtilityFilterAxis(
        id: 'route',
        label: l10n.searchFilterDrugRoute,
        meta: l10n.searchFilterHintMultiValue(8),
      ),
      _UtilityFilterAxis(
        id: 'atc',
        label: l10n.searchFilterDrugAtc,
        meta: l10n.searchFilterHintSingleValue(14),
      ),
      _UtilityFilterAxis(
        id: 'therapeutic_category',
        label: l10n.searchFilterDrugTherapeuticCategory,
        meta: l10n.searchFilterHintHierarchy,
      ),
      _UtilityFilterAxis(
        id: 'adverse_reaction_keyword',
        label: l10n.searchFilterDrugAdverseReactionKeyword,
        meta: l10n.searchFilterHintPartialMatch,
      ),
      _UtilityFilterAxis(
        id: 'precaution_category',
        label: l10n.searchFilterDrugPrecautionCategory,
        meta: l10n.searchFilterHintMultiValue(8),
      ),
    ],
    SearchTab.diseases => [
      _UtilityFilterAxis(
        id: 'icd10_chapter',
        label: l10n.searchFilterDiseaseIcd10Chapter,
        meta: l10n.searchFilterHintMultiValue(22),
      ),
      _UtilityFilterAxis(
        id: 'department',
        label: l10n.searchFilterDiseaseDepartment,
        meta: l10n.searchFilterHintMedicalDepartment,
      ),
      _UtilityFilterAxis(
        id: 'chronicity',
        label: l10n.searchFilterDiseaseChronicity,
        meta: l10n.searchFilterHintChronicity,
      ),
      _UtilityFilterAxis(
        id: 'infectious',
        label: l10n.searchFilterDiseaseInfectious,
        meta: l10n.searchFilterHintBool,
      ),
      _UtilityFilterAxis(
        id: 'symptom_keyword',
        label: l10n.searchFilterDiseaseSymptomKeyword,
        meta: l10n.searchFilterHintPartialMatch,
      ),
      _UtilityFilterAxis(
        id: 'onset_pattern',
        label: l10n.searchFilterDiseaseOnsetPattern,
        meta: l10n.searchFilterHintMultiSelectOr,
      ),
      _UtilityFilterAxis(
        id: 'exam_category',
        label: l10n.searchFilterDiseaseExamCategory,
        meta: l10n.searchFilterHintMultiSelectOr,
      ),
      _UtilityFilterAxis(
        id: 'has_pharmacological_treatment',
        label: l10n.searchFilterDiseaseHasPharmacologicalTreatment,
        meta: l10n.searchFilterHintBool,
      ),
      _UtilityFilterAxis(
        id: 'has_severity_grading',
        label: l10n.searchFilterDiseaseHasSeverityGrading,
        meta: l10n.searchFilterHintBool,
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
