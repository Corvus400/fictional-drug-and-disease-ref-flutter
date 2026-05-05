part of '../../search_view.dart';

class _DrugFilterSheet extends ConsumerStatefulWidget {
  const _DrugFilterSheet({
    required this.state,
    required this.onApply,
  });

  final SearchScreenState state;
  final Future<void> Function({
    required String? categoryAtc,
    required String? therapeuticCategory,
    required List<String> regulatoryClass,
    required List<String> dosageForm,
    required List<String> route,
    required String? adverseReactionKeyword,
    required List<String> precautionCategory,
  })
  onApply;

  @override
  ConsumerState<_DrugFilterSheet> createState() => _DrugFilterSheetState();
}

class _DrugFilterSheetState extends ConsumerState<_DrugFilterSheet> {
  late final Set<String> _categoryAtc = {
    ?widget.state.drugParams.categoryAtc,
  };
  late final Set<String> _therapeuticCategory = {
    ?widget.state.drugParams.therapeuticCategory,
  };
  late final Set<String> _regulatoryClass = {
    ...?widget.state.drugParams.regulatoryClass,
  };
  late final Set<String> _dosageForm = {...?widget.state.drugParams.dosageForm};
  late final Set<String> _route = {...?widget.state.drugParams.route};
  late final Set<String> _precautionCategory = {
    ...?widget.state.drugParams.precautionCategory,
  };
  late final TextEditingController _adverseReactionKeywordController =
      TextEditingController(
        text: widget.state.drugParams.adverseReactionKeyword,
      );
  String _expandedAxis = 'regulatory_class';
  Timer? _previewDebounce;
  int? _previewCount;

  @override
  void dispose() {
    _previewDebounce?.cancel();
    _adverseReactionKeywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = widget.state.categories;
    final axes = categories == null
        ? <_FilterAxis>[]
        : [
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
              hint: l10n.searchFilterHintMultiValue(
                categories.dosageForm.length,
              ),
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
              hint: l10n.searchFilterHintMultiValue(categories.atc.length),
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
                labelFor: (value) =>
                    _therapeuticCategoryLabel(categories, value),
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
                  _emptyToNull(
                        _adverseReactionKeywordController.text.trim(),
                      ) ==
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
          ];
    return _Round6FilterSheetScaffold(
      title: l10n.searchFilterTitleForTarget(l10n.searchTabDrugs),
      axisPolicy: l10n.searchFilterAxisPolicy(axes.length),
      axes: axes,
      expandedAxis: _expandedAxis,
      onToggleAxis: (axis) => setState(() {
        _expandedAxis = _expandedAxis == axis ? '' : axis;
      }),
      onReset: () => setState(() {
        _categoryAtc.clear();
        _therapeuticCategory.clear();
        _regulatoryClass.clear();
        _dosageForm.clear();
        _route.clear();
        _precautionCategory.clear();
        _adverseReactionKeywordController.clear();
        _schedulePreview();
      }),
      onApply: () => unawaited(
        widget.onApply(
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
      ),
      resultCount: _previewCount ?? _resultCount(widget.state.phase),
    );
  }

  void _schedulePreview() {
    _previewDebounce?.cancel();
    _previewDebounce = Timer(const Duration(milliseconds: 200), () {
      unawaited(_loadPreviewCount());
    });
  }

  Future<void> _loadPreviewCount() async {
    final count = await ref
        .read(searchScreenProvider.notifier)
        .previewDrugCount(_previewParams());
    if (!mounted || count == null) {
      return;
    }
    setState(() => _previewCount = count);
  }

  DrugSearchParams _previewParams() {
    return DrugSearchParams(
      page: 1,
      pageSize: 1,
      categoryAtc: _singleValue(_categoryAtc),
      therapeuticCategory: _singleValue(_therapeuticCategory),
      regulatoryClass: _regulatoryClass.toList(),
      dosageForm: _dosageForm.toList(),
      route: _route.toList(),
      keyword: widget.state.drugParams.keyword,
      keywordMatch: widget.state.drugParams.keywordMatch,
      keywordTarget: widget.state.drugParams.keywordTarget,
      adverseReactionKeyword: _emptyToNull(
        _adverseReactionKeywordController.text.trim(),
      ),
      precautionCategory: _precautionCategory.toList(),
      sort: widget.state.drugParams.sort,
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

  String? _emptyToNull(String value) {
    if (value.isEmpty) {
      return null;
    }
    return value;
  }
}
