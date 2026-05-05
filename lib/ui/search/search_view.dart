import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Search tab view.
class SearchView extends ConsumerWidget {
  /// Creates a search view.
  const SearchView({super.key, this.healthCheck});

  /// Deprecated compatibility parameter. Search UI no longer performs health
  /// checks from the view layer.
  final Future<String>? healthCheck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchScreenProvider);
    final notifier = ref.read(searchScreenProvider.notifier);
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);

    return Scaffold(
      backgroundColor: palette.background,
      floatingActionButton: Badge(
        isLabelVisible: state.appliedChips.count > 0,
        label: Text('+${state.appliedChips.count}'),
        child: Padding(
          padding: const EdgeInsets.only(
            right: SearchConstants.searchFilterFabRightOffset - 16,
            bottom: SearchConstants.searchFilterFabBottomOffset - 16,
          ),
          child: FloatingActionButton(
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
      ),
      body: SafeArea(
        child: LayoutBuilder(
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
                  _SearchHistoryDropdown(
                    tapRegionGroupId: historyTapRegionGroupId,
                    entries: state.historyForTab,
                    onDelete: notifier.deleteHistory,
                    onClearAll: notifier.clearAllHistory,
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    child: _SearchPhaseSection(
                      state: state,
                      onRetry: notifier.performSearch,
                      onResetFilter: notifier.resetFilter,
                      onRemoveOneChip: notifier.removeOneChip,
                      onChangeMatchToPartial: notifier.changeMatchToPartial,
                      onChangeDrugSort: notifier.changeDrugSort,
                      onLoadMore: notifier.loadMore,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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

class _Round6FilterSheetFrame extends StatelessWidget {
  const _Round6FilterSheetFrame({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      key: const ValueKey('search-round6-filter-sheet'),
      width: double.infinity,
      height: height,
      child: Material(
        key: const ValueKey('search-round6-filter-sheet-material'),
        color: theme.colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(SearchConstants.searchFilterSheetTopRadius),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(top: false, child: child),
      ),
    );
  }
}

class _DrugFilterSheet extends StatefulWidget {
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
  State<_DrugFilterSheet> createState() => _DrugFilterSheetState();
}

class _DrugFilterSheetState extends State<_DrugFilterSheet> {
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

  @override
  void dispose() {
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
                onToggle: (value) =>
                    setState(() => _toggle(_regulatoryClass, value)),
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
                onToggle: (value) =>
                    setState(() => _toggle(_dosageForm, value)),
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
                onToggle: (value) => setState(() => _toggle(_route, value)),
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
                onToggle: (value) =>
                    setState(() => _toggleSingle(_categoryAtc, value)),
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
                onToggle: (value) =>
                    setState(() => _toggleSingle(_therapeuticCategory, value)),
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
                onChanged: (_) => setState(() {}),
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
                onToggle: (value) =>
                    setState(() => _toggle(_precautionCategory, value)),
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
      resultCount: _resultCount(widget.state.phase),
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

class _DiseaseFilterSheet extends StatefulWidget {
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
  State<_DiseaseFilterSheet> createState() => _DiseaseFilterSheetState();
}

class _DiseaseFilterSheetState extends State<_DiseaseFilterSheet> {
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

  @override
  void dispose() {
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
                onToggle: (value) =>
                    setState(() => _toggle(_icd10Chapter, value)),
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
                onToggle: (value) =>
                    setState(() => _toggle(_department, value)),
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
                onToggle: (value) =>
                    setState(() => _toggleSingle(_chronicity, value)),
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
                onChanged: (value) => setState(() => _infectious = value),
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
                onChanged: (_) => setState(() {}),
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
                onToggle: (value) =>
                    setState(() => _toggle(_onsetPattern, value)),
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
                onToggle: (value) =>
                    setState(() => _toggle(_examCategory, value)),
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
                onChanged: (value) =>
                    setState(() => _hasPharmacologicalTreatment = value),
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
                onChanged: (value) =>
                    setState(() => _hasSeverityGrading = value),
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
      resultCount: _resultCount(widget.state.phase),
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

final class _FilterAxis {
  const _FilterAxis({
    required this.id,
    required this.title,
    required this.summary,
    required this.selectedCount,
    required this.hint,
    required this.content,
  });

  final String id;
  final String title;
  final String summary;
  final int selectedCount;
  final String hint;
  final Widget content;
}

class _Round6FilterSheetScaffold extends StatelessWidget {
  const _Round6FilterSheetScaffold({
    required this.title,
    required this.axisPolicy,
    required this.axes,
    required this.expandedAxis,
    required this.onToggleAxis,
    required this.onReset,
    required this.onApply,
    required this.resultCount,
  });

  final String title;
  final String axisPolicy;
  final List<_FilterAxis> axes;
  final String expandedAxis;
  final ValueChanged<String> onToggleAxis;
  final VoidCallback onReset;
  final VoidCallback onApply;
  final int resultCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet =
            constraints.maxWidth >= SearchConstants.searchTabletBreakpoint;
        final gutter = isTablet
            ? SearchConstants.searchTabletGutter
            : SearchConstants.searchPhoneGutter;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.hairline,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const SizedBox(
                  key: ValueKey('search-filter-handle'),
                  width: 40,
                  height: 4,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: palette.hairline)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(gutter, 4, gutter, 12),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: onReset,
                              child: Text(l10n.searchFilterReset),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          axisPolicy,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Column(
                      children: [
                        for (final axis in axes)
                          _FilterAxisRow(
                            axis: axis,
                            expanded: expandedAxis == axis.id,
                            gutter: gutter,
                            onTap: () => onToggleAxis(axis.id),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(top: BorderSide(color: palette.hairline)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(gutter, 12, gutter, 28),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: onApply,
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          l10n.searchFilterApplyWithCount(resultCount),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterAxisRow extends StatelessWidget {
  const _FilterAxisRow({
    required this.axis,
    required this.expanded,
    required this.gutter,
    required this.onTap,
  });

  final _FilterAxis axis;
  final bool expanded;
  final double gutter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: expanded ? palette.surfaceSubtle : theme.colorScheme.surface,
        border: Border(bottom: BorderSide(color: palette.hairline)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                axis.title,
                                style: theme.textTheme.bodySmall?.copyWith(
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
                        const SizedBox(height: 3),
                        Text(
                          axis.summary,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          axis.hint,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 120),
                    child: const Icon(Icons.chevron_right, size: 18),
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 0, gutter, 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: axis.content,
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterCountPill extends StatelessWidget {
  const _FilterCountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          '$count',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _FilterChipGroup extends StatelessWidget {
  const _FilterChipGroup({
    required this.values,
    required this.selected,
    required this.labelFor,
    required this.onToggle,
  });

  final List<String> values;
  final Set<String> selected;
  final String Function(String value) labelFor;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final value in values)
          FilterChip(
            label: Text(labelFor(value)),
            selected: selected.contains(value),
            onSelected: (_) => onToggle(value),
          ),
      ],
    );
  }
}

class _BoolChipGroup extends StatelessWidget {
  const _BoolChipGroup({
    required this.value,
    required this.trueLabel,
    required this.falseLabel,
    required this.onChanged,
  });

  final bool? value;
  final String trueLabel;
  final String falseLabel;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        FilterChip(
          label: Text(trueLabel),
          selected: value == true,
          onSelected: (_) => onChanged(value == true ? null : true),
        ),
        const SizedBox(width: 6),
        FilterChip(
          label: Text(falseLabel),
          selected: value == false,
          onSelected: (_) => onChanged(value == false ? null : false),
        ),
      ],
    );
  }
}

class _SearchTopChrome extends StatelessWidget {
  const _SearchTopChrome({
    required this.state,
    required this.palette,
    required this.gutter,
    required this.isTablet,
    required this.historyTapRegionGroupId,
    required this.onChangeTab,
    required this.onOpenHistory,
    required this.onChangeQuery,
    required this.onClearQuery,
    required this.onSubmit,
    required this.onCancel,
  });

  final SearchScreenState state;
  final SearchPalette palette;
  final double gutter;
  final bool isTablet;
  final Object historyTapRegionGroupId;
  final Future<void> Function(SearchTab tab) onChangeTab;
  final VoidCallback onOpenHistory;
  final ValueChanged<String> onChangeQuery;
  final VoidCallback onClearQuery;
  final Future<void> Function() onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final fieldHeight = isTablet
        ? SearchConstants.searchTabletFieldHeight
        : SearchConstants.searchPhoneFieldHeight;
    return Material(
      key: const ValueKey('search-round6-top-chrome'),
      color: theme.colorScheme.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: palette.hairline)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            (isTablet ? 0 : SearchConstants.searchPhoneTopChromeStatusPadding) +
                10,
            gutter,
            10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.tabSearch,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: isTablet
                      ? SearchConstants.searchTabletTitleFontSize
                      : SearchConstants.searchPhoneTitleFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _Round6SegmentedControl(
                selected: state.tab,
                palette: palette,
                onChanged: (tab) => unawaited(onChangeTab(tab)),
              ),
              const SizedBox(height: 10),
              Row(
                key: const ValueKey('search-round6-input-row'),
                children: [
                  Expanded(
                    child: SizedBox(
                      height: fieldHeight,
                      child: _SearchField(
                        queryText: state.queryText,
                        hintText: state.tab == SearchTab.drugs
                            ? l10n.searchHintDrugs
                            : l10n.searchHintDiseases,
                        palette: palette,
                        tapRegionGroupId: historyTapRegionGroupId,
                        onTap: onOpenHistory,
                        onChanged: onChangeQuery,
                        onClear: onClearQuery,
                        onSubmit: onSubmit,
                        onCancel: onCancel,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (state.historyDropdownOpen)
                    TextButton(
                      onPressed: onCancel,
                      child: Text(l10n.searchActionCancel),
                    )
                  else
                    SizedBox(
                      height: fieldHeight,
                      child: FilledButton(
                        onPressed: () => unawaited(onSubmit()),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SearchConstants.searchButtonRadius,
                            ),
                          ),
                        ),
                        child: Text(l10n.searchActionSearch),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    required this.queryText,
    required this.hintText,
    required this.palette,
    required this.tapRegionGroupId,
    required this.onTap,
    required this.onChanged,
    required this.onClear,
    required this.onSubmit,
    required this.onCancel,
  });

  final String queryText;
  final String hintText;
  final SearchPalette palette;
  final Object tapRegionGroupId;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final Future<void> Function() onSubmit;
  final VoidCallback onCancel;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.queryText);
  }

  @override
  void didUpdateWidget(covariant _SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.queryText != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.queryText,
        selection: TextSelection.collapsed(offset: widget.queryText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const ValueKey('search-field'),
      controller: _controller,
      groupId: widget.tapRegionGroupId,
      onTap: widget.onTap,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        widget.onCancel();
      },
      onChanged: widget.onChanged,
      onSubmitted: (_) => unawaited(widget.onSubmit()),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: widget.queryText.isEmpty
            ? null
            : IconButton(
                key: const ValueKey('search-query-clear-button'),
                onPressed: widget.onClear,
                icon: const Icon(Icons.cancel),
              ),
        filled: true,
        fillColor: widget.palette.surfaceSubtle,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SearchConstants.searchFieldRadius,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SearchConstants.searchFieldRadius,
          ),
          borderSide: BorderSide(color: widget.palette.primaryRing),
        ),
      ),
    );
  }
}

class _Round6SegmentedControl extends StatelessWidget {
  const _Round6SegmentedControl({
    required this.selected,
    required this.palette,
    required this.onChanged,
  });

  final SearchTab selected;
  final SearchPalette palette;
  final ValueChanged<SearchTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      key: const ValueKey('search-round6-segmented'),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: palette.surfaceSubtle,
        borderRadius: BorderRadius.circular(
          SearchConstants.searchSegmentedRadius,
        ),
      ),
      child: Row(
        children: [
          _Round6SegmentButton(
            label: l10n.searchTabDrugs,
            selected: selected == SearchTab.drugs,
            theme: theme,
            onPressed: () => onChanged(SearchTab.drugs),
          ),
          _Round6SegmentButton(
            label: l10n.searchTabDiseases,
            selected: selected == SearchTab.diseases,
            theme: theme,
            onPressed: () => onChanged(SearchTab.diseases),
          ),
        ],
      ),
    );
  }
}

class _Round6SegmentButton extends StatelessWidget {
  const _Round6SegmentButton({
    required this.label,
    required this.selected,
    required this.theme,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final ThemeData theme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(
          SearchConstants.searchSelectedSegmentRadius,
        ),
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: selected ? theme.colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SearchConstants.searchSelectedSegmentRadius,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.06),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: selected
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchPhaseSection extends StatelessWidget {
  const _SearchPhaseSection({
    required this.state,
    required this.onRetry,
    required this.onResetFilter,
    required this.onRemoveOneChip,
    required this.onChangeMatchToPartial,
    required this.onChangeDrugSort,
    required this.onLoadMore,
  });

  final SearchScreenState state;
  final Future<void> Function() onRetry;
  final Future<void> Function() onResetFilter;
  final Future<void> Function() onRemoveOneChip;
  final Future<void> Function() onChangeMatchToPartial;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;
  final Future<void> Function() onLoadMore;

  @override
  Widget build(BuildContext context) {
    final phase = state.phase;
    final l10n = AppLocalizations.of(context)!;
    if (phase is SearchPhaseLoading) {
      return Skeletonizer(
        child: ListView.builder(
          itemCount: SearchConstants.searchShimmerSkeletonCount,
          itemBuilder: (context, index) => const Card(
            key: ValueKey('search-loading-skeleton-card'),
            child: SizedBox(height: 72),
          ),
        ),
      );
    }
    if (phase is SearchPhaseEmpty) {
      return Column(
        children: [
          _SearchResultToolbar(
            state: state,
            totalCount: 0,
            onChangeDrugSort: onChangeDrugSort,
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
                      Icon(
                        Icons.manage_search,
                        size: 48,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.searchEmptyResultTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => unawaited(onResetFilter()),
                        child: Text(l10n.searchEmptyResetFilter),
                      ),
                      OutlinedButton(
                        onPressed: () => unawaited(onRemoveOneChip()),
                        child: Text(l10n.searchEmptyRemoveOneFilter),
                      ),
                      TextButton(
                        onPressed: () => unawaited(onChangeMatchToPartial()),
                        child: Text(l10n.searchEmptyChangeMatchToPartial),
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
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.searchErrorTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => unawaited(onRetry()),
              child: Text(l10n.searchErrorRetry),
            ),
          ],
        ),
      );
    }
    final view = switch (phase) {
      SearchPhaseResults(:final view) => view,
      SearchPhaseLoadingMore(:final previous) => previous,
      _ => null,
    };
    if (view == null) {
      if (state.historyDropdownOpen) {
        return const SizedBox.shrink();
      }
      if (state.queryText.isEmpty && state.historyForTab.isEmpty) {
        return const _NoSearchHistoryState();
      }
      return const SizedBox.shrink();
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is! ScrollUpdateNotification ||
            notification.dragDetails == null) {
          return false;
        }
        final metrics = notification.metrics;
        final nearEnd =
            metrics.maxScrollExtent > 0 &&
            metrics.pixels >= metrics.maxScrollExtent - 200;
        if (view.canLoadMore && nearEnd) {
          unawaited(onLoadMore());
        }
        return false;
      },
      child: ListView(
        key: const ValueKey('search-results-list'),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          _SearchResultToolbar(
            state: state,
            totalCount: view.totalCount,
            onChangeDrugSort: onChangeDrugSort,
          ),
          switch (view) {
            DrugSearchResultsView(:final items) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final item in items) _DrugResultCard(item: item),
              ],
            ),
            DiseaseSearchResultsView(:final items) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final item in items) _DiseaseResultCard(item: item),
              ],
            ),
          },
          if (view.canLoadMore)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text(l10n.searchToolbarLoadMore)),
            ),
        ],
      ),
    );
  }
}

class _NoSearchHistoryState extends StatelessWidget {
  const _NoSearchHistoryState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
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

class _SearchResultToolbar extends StatelessWidget {
  const _SearchResultToolbar({
    required this.state,
    required this.totalCount,
    required this.onChangeDrugSort,
  });

  final SearchScreenState state;
  final int totalCount;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.appliedChips.count > 0)
          DecoratedBox(
            key: const ValueKey('search-applied-filter-bar'),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(top: BorderSide(color: palette.hairline)),
            ),
            child: SizedBox(
              height: 36,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          const SizedBox(width: 2),
                          Text(
                            l10n.searchToolbarApplied,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          for (final chip in state.appliedChips.items) ...[
                            _AppliedFilterChip(
                              label: _appliedChipLabel(l10n, chip),
                              palette: palette,
                            ),
                            const SizedBox(width: 6),
                          ],
                        ],
                      ),
                    ),
                  ),
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
                    top: 8,
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
              ),
            ),
          ),
        SizedBox(
          key: const ValueKey('search-results-toolbar'),
          height: SearchConstants.searchResultToolbarHeight,
          child: Row(
            children: [
              Text(l10n.searchToolbarTotal(totalCount)),
              const Spacer(),
              TextButton(
                onPressed: () => _showSortSheet(
                  context,
                  state.tab,
                  onChangeDrugSort: onChangeDrugSort,
                ),
                child: Text(l10n.searchSortTitle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppliedFilterChip extends StatelessWidget {
  const _AppliedFilterChip({required this.label, required this.palette});

  final String label;
  final SearchPalette palette;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
                color: palette.drugInk,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Icon(Icons.close, size: 12, color: palette.drugInk),
          ],
        ),
      ),
    );
  }
}

class _DiseaseResultCard extends StatelessWidget {
  const _DiseaseResultCard({required this.item});

  final DiseaseSummary item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return Card(
      key: ValueKey('disease-card-${item.id}'),
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SearchConstants.searchCardRadius),
        side: BorderSide(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 4,
              children: [
                _DiseaseBadge(
                  label: _chronicityLabel(l10n, item.chronicity),
                  palette: palette,
                ),
                _DiseaseBadge(
                  label: item.infectious
                      ? l10n.searchDiseaseInfectiousTrue
                      : l10n.searchDiseaseInfectiousFalse,
                  palette: palette,
                ),
                for (final department in item.medicalDepartment)
                  _DiseaseBadge(
                    label: _departmentLabel(l10n, department),
                    palette: palette,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.nameKana,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 12,
              children: [
                Text(
                  l10n.searchDiseaseMetaIcd10(
                    _diseaseIcd10ChapterLabel(l10n, item.icd10Chapter),
                  ),
                  style: theme.textTheme.labelSmall,
                ),
                Text(
                  l10n.searchDiseaseMetaRevised(
                    _formatRevisionDate(item.revisedAt),
                  ),
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DiseaseBadge extends StatelessWidget {
  const _DiseaseBadge({required this.label, required this.palette});

  final String label;
  final SearchPalette palette;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.diseaseTint,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: palette.diseaseInk,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _DrugResultCard extends StatelessWidget {
  const _DrugResultCard({required this.item});

  final DrugSummary item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    final imageSize =
        MediaQuery.sizeOf(context).width >=
            SearchConstants.searchTabletBreakpoint
        ? SearchConstants.searchTabletDrugImageSize
        : SearchConstants.searchPhoneDrugImageSize;
    return Card(
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SearchConstants.searchCardRadius),
        side: BorderSide(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox.square(
                dimension: imageSize,
                child: Image.network(
                  _drugCardImageUrl(item.imageUrl),
                  key: ValueKey('drug-image-${item.id}'),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => DecoratedBox(
                    decoration: BoxDecoration(
                      color: palette.surfaceSubtle,
                      border: Border.all(color: palette.hairline),
                    ),
                    child: const Icon(Icons.medication_outlined),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 5,
                    runSpacing: 4,
                    children: [
                      for (final regulatoryClass in item.regulatoryClass)
                        _DrugBadge(
                          value: regulatoryClass,
                          label: _regulatoryClassLabel(l10n, regulatoryClass),
                          palette: palette,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.brandName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.genericName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 12,
                    children: [
                      Text(
                        l10n.searchDrugMetaAtc(item.atcCode),
                        style: theme.textTheme.labelSmall,
                      ),
                      Text(
                        l10n.searchDrugMetaRevised(
                          _formatRevisionDate(item.revisedAt),
                        ),
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrugBadge extends StatelessWidget {
  const _DrugBadge({
    required this.value,
    required this.label,
    required this.palette,
  });

  final String value;
  final String label;
  final SearchPalette palette;

  @override
  Widget build(BuildContext context) {
    final colors = _regulatoryBadgeColors(palette, value);
    return DecoratedBox(
      key: ValueKey('drug-regulatory-badge-$value'),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

({Color background, Color foreground}) _regulatoryBadgeColors(
  SearchPalette palette,
  String value,
) {
  final color = switch (value) {
    'poison' => palette.danger,
    'potent' => const Color(0xFFB45309),
    'prescription_required' => palette.drugInk,
    'psychotropic_1' || 'psychotropic_2' || 'psychotropic_3' => const Color(
      0xFF7C3AED,
    ),
    'narcotic' => const Color(0xFF9333EA),
    'stimulant_precursor' => const Color(0xFFEA580C),
    'biological' || 'specified_biological' => const Color(0xFF0F766E),
    'ordinary' => const Color(0xFF4B5563),
    _ => palette.drugInk,
  };
  return (
    background: color.withValues(alpha: 0.12),
    foreground: color,
  );
}

String _drugCardImageUrl(String imageUrl) {
  final base = Uri.parse(ApiConfig.current.apiBaseUrl);
  final resolved = base.resolve(imageUrl);
  return resolved
      .replace(
        queryParameters: {
          ...resolved.queryParameters,
          'size': SearchConstants.searchDrugCardImageApiSize,
        },
      )
      .toString();
}

String _regulatoryClassLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'poison' => l10n.searchDrugRegulatoryPoison,
    'potent' => l10n.searchDrugRegulatoryPotent,
    'ordinary' => l10n.searchDrugRegulatoryOrdinary,
    'psychotropic_1' => l10n.searchDrugRegulatoryPsychotropic1,
    'psychotropic_2' => l10n.searchDrugRegulatoryPsychotropic2,
    'psychotropic_3' => l10n.searchDrugRegulatoryPsychotropic3,
    'narcotic' => l10n.searchDrugRegulatoryNarcotic,
    'stimulant_precursor' => l10n.searchDrugRegulatoryStimulantPrecursor,
    'biological' => l10n.searchDrugRegulatoryBiological,
    'specified_biological' => l10n.searchDrugRegulatorySpecifiedBiological,
    'prescription_required' => l10n.searchDrugRegulatoryPrescriptionRequired,
    _ => value,
  };
}

String _dosageFormLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'tablet' => l10n.searchDrugDosageFormTablet,
    'capsule' => l10n.searchDrugDosageFormCapsule,
    'powder' => l10n.searchDrugDosageFormPowder,
    'granule' => l10n.searchDrugDosageFormGranule,
    'liquid' => l10n.searchDrugDosageFormLiquid,
    'injection_form' => l10n.searchDrugDosageFormInjection,
    'ointment' => l10n.searchDrugDosageFormOintment,
    'cream' => l10n.searchDrugDosageFormCream,
    'patch' => l10n.searchDrugDosageFormPatch,
    'eye_drops' => l10n.searchDrugDosageFormEyeDrops,
    'suppository' => l10n.searchDrugDosageFormSuppository,
    'inhaler' => l10n.searchDrugDosageFormInhaler,
    'nasal_spray' => l10n.searchDrugDosageFormNasalSpray,
    _ => value,
  };
}

String _atcLabel(Categories categories, String value) {
  for (final entry in categories.atc) {
    if (entry.code == value) {
      return '${entry.code} ${entry.label}';
    }
  }
  return value;
}

String _therapeuticCategoryLabel(Categories categories, String value) {
  for (final entry in categories.therapeuticCategories) {
    if (entry.id == value) {
      return entry.label;
    }
  }
  return value;
}

String _icd10ChapterValue(Icd10ChapterEntry entry) {
  return 'chapter_${entry.roman.toLowerCase()}';
}

String _icd10ChapterLabel(Categories categories, String value) {
  for (final entry in categories.icd10Chapters) {
    if (_icd10ChapterValue(entry) == value) {
      return '${entry.roman} ${entry.label}';
    }
  }
  return value;
}

String _diseaseIcd10ChapterLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'chapter_i' => l10n.searchDiseaseIcd10ChapterI,
    'chapter_ii' => l10n.searchDiseaseIcd10ChapterII,
    'chapter_iii' => l10n.searchDiseaseIcd10ChapterIII,
    'chapter_iv' => l10n.searchDiseaseIcd10ChapterIV,
    'chapter_v' => l10n.searchDiseaseIcd10ChapterV,
    'chapter_vi' => l10n.searchDiseaseIcd10ChapterVI,
    'chapter_vii' => l10n.searchDiseaseIcd10ChapterVII,
    'chapter_viii' => l10n.searchDiseaseIcd10ChapterVIII,
    'chapter_ix' => l10n.searchDiseaseIcd10ChapterIX,
    'chapter_x' => l10n.searchDiseaseIcd10ChapterX,
    'chapter_xi' => l10n.searchDiseaseIcd10ChapterXI,
    'chapter_xii' => l10n.searchDiseaseIcd10ChapterXII,
    'chapter_xiii' => l10n.searchDiseaseIcd10ChapterXIII,
    'chapter_xiv' => l10n.searchDiseaseIcd10ChapterXIV,
    'chapter_xv' => l10n.searchDiseaseIcd10ChapterXV,
    'chapter_xvi' => l10n.searchDiseaseIcd10ChapterXVI,
    'chapter_xvii' => l10n.searchDiseaseIcd10ChapterXVII,
    'chapter_xviii' => l10n.searchDiseaseIcd10ChapterXVIII,
    'chapter_xix' => l10n.searchDiseaseIcd10ChapterXIX,
    'chapter_xx' => l10n.searchDiseaseIcd10ChapterXX,
    'chapter_xxi' => l10n.searchDiseaseIcd10ChapterXXI,
    'chapter_xxii' => l10n.searchDiseaseIcd10ChapterXXII,
    _ => value,
  };
}

String _departmentLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'internal_medicine' => l10n.searchDiseaseDepartmentInternalMedicine,
    'cardiology' => l10n.searchDiseaseDepartmentCardiology,
    'gastroenterology' => l10n.searchDiseaseDepartmentGastroenterology,
    'endocrinology' => l10n.searchDiseaseDepartmentEndocrinology,
    'neurology' => l10n.searchDiseaseDepartmentNeurology,
    'psychiatry' => l10n.searchDiseaseDepartmentPsychiatry,
    'surgery' => l10n.searchDiseaseDepartmentSurgery,
    'orthopedics' => l10n.searchDiseaseDepartmentOrthopedics,
    'dermatology' => l10n.searchDiseaseDepartmentDermatology,
    'ophthalmology' => l10n.searchDiseaseDepartmentOphthalmology,
    'otolaryngology' => l10n.searchDiseaseDepartmentOtolaryngology,
    'urology' => l10n.searchDiseaseDepartmentUrology,
    'gynecology' => l10n.searchDiseaseDepartmentGynecology,
    'pediatrics' => l10n.searchDiseaseDepartmentPediatrics,
    'emergency' => l10n.searchDiseaseDepartmentEmergency,
    'infectious_disease' => l10n.searchDiseaseDepartmentInfectiousDisease,
    _ => value,
  };
}

String _routeLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'oral' => l10n.searchDrugRouteOral,
    'topical' => l10n.searchDrugRouteTopical,
    'injection_route' => l10n.searchDrugRouteInjection,
    'inhalation' => l10n.searchDrugRouteInhalation,
    'rectal' => l10n.searchDrugRouteRectal,
    'ophthalmic' => l10n.searchDrugRouteOphthalmic,
    'nasal' => l10n.searchDrugRouteNasal,
    'transdermal' => l10n.searchDrugRouteTransdermal,
    _ => value,
  };
}

String _precautionCategoryLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'COMORBIDITY' => l10n.searchDrugPrecautionComorbidity,
    'RENAL_IMPAIRMENT' => l10n.searchDrugPrecautionRenalImpairment,
    'HEPATIC_IMPAIRMENT' => l10n.searchDrugPrecautionHepaticImpairment,
    'REPRODUCTIVE_POTENTIAL' => l10n.searchDrugPrecautionReproductivePotential,
    'PREGNANT' => l10n.searchDrugPrecautionPregnant,
    'LACTATING' => l10n.searchDrugPrecautionLactating,
    'PEDIATRIC' => l10n.searchDrugPrecautionPediatric,
    'GERIATRIC' => l10n.searchDrugPrecautionGeriatric,
    _ => value,
  };
}

const _diseaseChronicityValues = ['acute', 'subacute', 'chronic', 'recurrent'];

const _diseaseOnsetPatternValues = [
  'sudden',
  'gradual',
  'episodic',
  'progressive',
  'congenital',
];

const _diseaseExamCategoryValues = [
  'blood',
  'imaging',
  'physiological',
  'pathological',
  'genetic',
];

String _chronicityLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseChronicityAcute,
    'subacute' => l10n.searchDiseaseChronicitySubacute,
    'chronic' => l10n.searchDiseaseChronicityChronic,
    'recurrent' => l10n.searchDiseaseChronicityRecurrent,
    _ => value,
  };
}

String _onsetPatternLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'sudden' => l10n.searchDiseaseOnsetPatternSudden,
    'gradual' => l10n.searchDiseaseOnsetPatternGradual,
    'episodic' => l10n.searchDiseaseOnsetPatternEpisodic,
    'progressive' => l10n.searchDiseaseOnsetPatternProgressive,
    'congenital' => l10n.searchDiseaseOnsetPatternCongenital,
    _ => value,
  };
}

String _examCategoryLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'blood' => l10n.searchDiseaseExamCategoryBlood,
    'imaging' => l10n.searchDiseaseExamCategoryImaging,
    'physiological' => l10n.searchDiseaseExamCategoryPhysiological,
    'pathological' => l10n.searchDiseaseExamCategoryPathological,
    'genetic' => l10n.searchDiseaseExamCategoryGenetic,
    _ => value,
  };
}

String _appliedChipLabel(AppLocalizations l10n, AppliedChip chip) {
  return switch (chip.axis) {
    'regulatoryClass' => _regulatoryClassLabel(l10n, chip.label),
    'dosageForm' => _dosageFormLabel(l10n, chip.label),
    'route' => _routeLabel(l10n, chip.label),
    'precautionCategory' => _precautionCategoryLabel(l10n, chip.label),
    'icd10Chapter' => _diseaseIcd10ChapterLabel(l10n, chip.label),
    'department' => _departmentLabel(l10n, chip.label),
    'chronicity' => _chronicityLabel(l10n, chip.label),
    'onsetPattern' => _onsetPatternLabel(l10n, chip.label),
    'examCategory' => _examCategoryLabel(l10n, chip.label),
    'infectious' =>
      chip.label == 'true'
          ? l10n.searchDiseaseInfectiousTrue
          : l10n.searchDiseaseInfectiousFalse,
    'hasPharmacologicalTreatment' =>
      chip.label == 'true'
          ? l10n.searchDiseasePharmacologicalTreatmentTrue
          : l10n.searchDiseasePharmacologicalTreatmentFalse,
    'hasSeverityGrading' =>
      chip.label == 'true'
          ? l10n.searchDiseaseSeverityGradingTrue
          : l10n.searchDiseaseSeverityGradingFalse,
    _ => chip.label,
  };
}

String _selectedSummary(
  AppLocalizations l10n,
  Set<String> selected,
  String Function(String value) labelFor,
) {
  if (selected.isEmpty) {
    return l10n.searchFilterSummaryAll;
  }
  return selected.map(labelFor).join(', ');
}

String _textSummary(AppLocalizations l10n, String value) {
  return value.isEmpty ? l10n.searchFilterSummaryUnspecified : value;
}

String _boolSummary(AppLocalizations l10n, bool? value) {
  return switch (value) {
    true => l10n.searchDiseaseBoolTrue,
    false => l10n.searchDiseaseBoolFalse,
    null => l10n.searchFilterSummaryAll,
  };
}

String? _emptyToNull(String value) => value.isEmpty ? null : value;

int _resultCount(SearchPhase phase) {
  return switch (phase) {
    SearchPhaseResults(:final view) => view.totalCount,
    SearchPhaseLoadingMore(:final previous) => previous.totalCount,
    _ => 0,
  };
}

String _formatRevisionDate(String value) => value.replaceAll('-', '/');

void _showSortSheet(
  BuildContext context,
  SearchTab tab, {
  required Future<void> Function(DrugSort sort) onChangeDrugSort,
}) {
  final l10n = AppLocalizations.of(context)!;
  final drugLabels = {
    DrugSort.revisedAtDesc: l10n.searchSortByRevised,
    DrugSort.brandNameKana: l10n.searchSortByBrandKana,
    DrugSort.atcCode: l10n.searchSortByAtcCode,
    DrugSort.therapeuticCategoryName: l10n.searchSortByTherapeuticCategory,
  };
  unawaited(
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (tab == SearchTab.drugs)
              for (final entry in drugLabels.entries)
                ListTile(
                  title: Text(entry.value),
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(onChangeDrugSort(entry.key));
                  },
                )
            else
              ListTile(
                title: Text(l10n.searchSortByRevised),
                onTap: () => Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
    ),
  );
}

class _SearchHistoryDropdown extends StatelessWidget {
  const _SearchHistoryDropdown({
    required this.tapRegionGroupId,
    required this.entries,
    required this.onDelete,
    required this.onClearAll,
  });

  final Object tapRegionGroupId;
  final List<SearchHistoryEnvelope> entries;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function() onClearAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return TapRegion(
      groupId: tapRegionGroupId,
      child: Material(
        color: theme.colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SearchConstants.searchPhoneGutter,
                10,
                SearchConstants.searchPhoneGutter,
                6,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.searchHistoryTitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    key: const ValueKey('clear-history-button'),
                    onPressed: () => unawaited(_confirmClearHistory(context)),
                    child: Text(l10n.searchHistoryClear),
                  ),
                ],
              ),
            ),
            for (final entry in entries)
              _SearchHistoryRow(
                entry: entry,
                palette: palette,
                onDelete: onDelete,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SearchConstants.searchPhoneGutter,
                8,
                SearchConstants.searchPhoneGutter,
                10,
              ),
              child: Text(
                l10n.searchHistoryPrivacyNote,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmClearHistory(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.searchHistoryClearConfirmTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.searchActionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.searchHistoryClearConfirmDelete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await onClearAll();
    }
  }
}

class _SearchHistoryRow extends StatelessWidget {
  const _SearchHistoryRow({
    required this.entry,
    required this.palette,
    required this.onDelete,
  });

  final SearchHistoryEnvelope entry;
  final SearchPalette palette;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      leading: const Icon(Icons.history, size: 16),
      title: Text(
        entry.queryText,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(l10n.searchToolbarTotal(entry.totalCount)),
          if (entry.filterCount > 0)
            Text(
              l10n.searchHistoryFilterCount(entry.filterCount),
              style: TextStyle(color: palette.drugInk),
            ),
        ],
      ),
      trailing: IconButton(
        key: ValueKey('delete-history-${entry.id}'),
        onPressed: () => unawaited(onDelete(entry.id)),
        icon: const Icon(Icons.close),
      ),
    );
  }
}
