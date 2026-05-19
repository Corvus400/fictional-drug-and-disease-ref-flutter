part of '../search_view.dart';

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
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final axes = _utilityFilterAxesForState(l10n, widget.state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.searchFilterAxisPolicy(axes.length),
          key: const ValueKey('search-utility-filter-policy'),
          style: theme.textTheme.bodySmall?.copyWith(
            color: palette.muted,
            fontSize: 11,
            fontWeight: FontWeight.w500,
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
        LayoutBuilder(
          key: const ValueKey('search-utility-filter-actions'),
          builder: (context, constraints) {
            final resetButton = _buildResetButton(l10n, theme, palette);
            final useRailColumn = constraints.maxWidth < 230;
            final applyButton = _buildApplyButton(
              l10n,
              theme,
              palette,
              compact: useRailColumn,
            );
            if (useRailColumn) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(alignment: Alignment.centerRight, child: resetButton),
                  const SizedBox(height: 4),
                  applyButton,
                ],
              );
            }
            return Row(
              children: [
                resetButton,
                const SizedBox(width: 8),
                Expanded(child: applyButton),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildResetButton(
    AppLocalizations l10n,
    ThemeData theme,
    AppPalette palette,
  ) {
    return TextButton(
      key: const ValueKey('search-utility-filter-reset'),
      style: TextButton.styleFrom(
        foregroundColor: palette.primary,
        minimumSize: const Size(0, 32),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        textStyle: theme.textTheme.labelMedium?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
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
      child: Text(
        l10n.searchFilterReset,
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: theme.textTheme.labelMedium?.copyWith(
          color: palette.primary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildApplyButton(
    AppLocalizations l10n,
    ThemeData theme,
    AppPalette palette, {
    required bool compact,
  }) {
    return FilledButton(
      key: const ValueKey('search-utility-filter-apply'),
      style: FilledButton.styleFrom(
        backgroundColor: palette.primaryCont,
        foregroundColor: palette.onPrimaryCont,
        minimumSize: Size.fromHeight(compact ? 36 : 44),
        padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 14),
        textStyle: theme.textTheme.labelMedium?.copyWith(
          fontSize: compact ? 12 : 13,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: _apply,
      child: Text(
        l10n.searchFilterApplyWithCount(_previewCount ?? widget.resultCount),
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
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
    final int? count;
    try {
      count = switch (widget.state.tab) {
        SearchTab.drugs => await notifier.previewDrugCount(
          _drugPreviewParams(),
        ),
        SearchTab.diseases => await notifier.previewDiseaseCount(
          _diseasePreviewParams(),
        ),
      };
    } on Exception {
      return;
    }
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
              summary: l10n.searchFilterSummaryAll,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
            values: categories.therapeuticCategories
                .map((entry) => entry.queryValue)
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
            compact: true,
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
        color: expanded ? palette.surface : palette.surface2,
        border: Border.all(
          color: expanded ? palette.primaryRing : palette.hairline2,
        ),
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
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            axis.title,
                            key: ValueKey(
                              'search-utility-filter-axis-title-${axis.id}',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: palette.ink,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (axis.selectedCount > 0) ...[
                          const SizedBox(width: 6),
                          _FilterCountPill(count: axis.selectedCount),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    axis.hint,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: palette.muted,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                axis.summary,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: palette.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (expanded) ...[
                const SizedBox(height: 6),
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
