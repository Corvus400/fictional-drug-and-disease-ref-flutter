part of '../../search_view.dart';

class _DiseaseFilterSheet extends ConsumerStatefulWidget {
  const _DiseaseFilterSheet({
    required this.state,
    required this.onApply,
  });

  final SearchScreenState state;
  final Future<void> Function({
    required List<String> icd10Chapter,
    required List<String> department,
    required List<String> chronicity,
    required bool? infectious,
    required String? symptomKeyword,
    required List<String> onsetPattern,
    required List<String> examCategory,
    required bool? hasPharmacologicalTreatment,
    required bool? hasSeverityGrading,
  })
  onApply;

  @override
  ConsumerState<_DiseaseFilterSheet> createState() =>
      _DiseaseFilterSheetState();
}

class _DiseaseFilterSheetState extends ConsumerState<_DiseaseFilterSheet> {
  late final Set<String> _icd10Chapter = {
    ...?widget.state.diseaseParams.icd10Chapter,
  };
  late final Set<String> _department = {
    ...?widget.state.diseaseParams.department,
  };
  late final Set<String> _chronicity = {
    ...?widget.state.diseaseParams.chronicity,
  };
  late final Set<String> _onsetPattern = {
    ...?widget.state.diseaseParams.onsetPattern,
  };
  late final Set<String> _examCategory = {
    ...?widget.state.diseaseParams.examCategory,
  };
  late final TextEditingController _symptomKeywordController =
      TextEditingController(text: widget.state.diseaseParams.symptomKeyword);
  late bool? _infectious = widget.state.diseaseParams.infectious;
  late bool? _hasPharmacologicalTreatment =
      widget.state.diseaseParams.hasPharmacologicalTreatment;
  late bool? _hasSeverityGrading =
      widget.state.diseaseParams.hasSeverityGrading;
  String _expandedAxis = 'icd10_chapter';
  Timer? _previewDebounce;
  int? _previewCount;

  @override
  void dispose() {
    _previewDebounce?.cancel();
    _symptomKeywordController.dispose();
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
              id: 'icd10_chapter',
              title: l10n.searchFilterDiseaseIcd10Chapter,
              summary: _selectedSummary(
                l10n,
                _icd10Chapter,
                (value) => _icd10ChapterLabel(categories, value),
              ),
              selectedCount: _icd10Chapter.length,
              hint: l10n.searchFilterHintDrillIn(
                categories.icd10Chapters.length,
              ),
              content: _FilterChipGroup(
                values: categories.icd10Chapters
                    .map(_icd10ChapterValue)
                    .toList(),
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
              summary: _textSummary(
                l10n,
                _symptomKeywordController.text.trim(),
              ),
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
          ];
    return _Round6FilterSheetScaffold(
      title: l10n.searchFilterTitleForTarget(l10n.searchTabDiseases),
      axisPolicy: l10n.searchFilterAxisPolicy(axes.length),
      axes: axes,
      expandedAxis: _expandedAxis,
      onToggleAxis: (axis) => setState(() {
        _expandedAxis = _expandedAxis == axis ? '' : axis;
      }),
      onReset: () => setState(() {
        _icd10Chapter.clear();
        _department.clear();
        _chronicity.clear();
        _onsetPattern.clear();
        _examCategory.clear();
        _infectious = null;
        _hasPharmacologicalTreatment = null;
        _hasSeverityGrading = null;
        _symptomKeywordController.clear();
        _schedulePreview();
      }),
      onApply: () => unawaited(
        widget.onApply(
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
        .previewDiseaseCount(_previewParams());
    if (!mounted || count == null) {
      return;
    }
    setState(() => _previewCount = count);
  }

  DiseaseSearchParams _previewParams() {
    return DiseaseSearchParams(
      page: 1,
      pageSize: 1,
      icd10Chapter: _icd10Chapter.toList(),
      department: _department.toList(),
      chronicity: _chronicity.toList(),
      infectious: _infectious,
      keyword: widget.state.diseaseParams.keyword,
      keywordMatch: widget.state.diseaseParams.keywordMatch,
      keywordTarget: widget.state.diseaseParams.keywordTarget,
      symptomKeyword: _emptyToNull(_symptomKeywordController.text.trim()),
      onsetPattern: _onsetPattern.toList(),
      examCategory: _examCategory.toList(),
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
}
