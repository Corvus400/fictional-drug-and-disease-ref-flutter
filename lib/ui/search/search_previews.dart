// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: public_member_api_docs

import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_data.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_support.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';

@FddScreenPreview(group: 'Search', name: 'Drug results')
Widget previewSearchDrugResults() {
  return _previewSearchView(previewDrugSearchResultsState);
}

@FddScreenPreview(group: 'Search', name: 'Disease results')
Widget previewSearchDiseaseResults() {
  return _previewSearchView(previewDiseaseSearchResultsState);
}

@FddScreenPreview(group: 'Search', name: 'History dropdown')
Widget previewSearchHistoryDropdown() {
  return _previewSearchView(previewSearchHistoryState);
}

@FddScreenPreview(group: 'Search', name: 'Loading')
Widget previewSearchLoading() {
  return _previewSearchView(
    SearchScreenState.initial().copyWith(phase: const SearchPhase.loading()),
  );
}

@FddScreenPreview(group: 'Search', name: 'Loading more')
Widget previewSearchLoadingMore() {
  return _previewSearchView(previewSearchLoadingMoreState);
}

@FddScreenPreview(group: 'Search', name: 'Empty')
Widget previewSearchEmpty() {
  return _previewSearchView(previewSearchEmptyState);
}

@FddScreenPreview(group: 'Search', name: 'Error')
Widget previewSearchError() {
  return _previewSearchView(
    previewDrugSearchResultsState.copyWith(
      phase: const SearchPhase.error(
        error: NetworkException(),
        requestLabel: 'アムロ',
      ),
    ),
  );
}

@FddSheetPreview(group: 'Search', name: 'Drug filter sheet')
Widget previewSearchDrugFilterSheet() {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return Round6FilterSheetFrame(
        height: 720,
        child: Round6FilterSheetScaffold(
          title: l10n.searchFilterTitleForTarget(l10n.searchTabDrugs),
          axisPolicy: l10n.searchFilterAxisPolicy(4),
          expandedAxis: 'dosage_form',
          onToggleAxis: (_) {},
          onReset: () {},
          onApply: () {},
          resultCount: 24,
          axes: [
            FilterAxis(
              id: 'category_atc',
              title: l10n.searchFilterDrugAtc,
              summary: _atcLabel(previewCategories, 'C'),
              selectedCount: 1,
              hint: l10n.searchFilterHintSingleValue(
                previewCategories.atc.length,
              ),
              content: FilterChipGroup(
                values: previewCategories.atc
                    .map((entry) => entry.code)
                    .toList(),
                selected: const {'C'},
                labelFor: (value) => _atcLabel(previewCategories, value),
                onToggle: (_) {},
              ),
            ),
            FilterAxis(
              id: 'dosage_form',
              title: l10n.searchFilterDrugDosageForm,
              summary: '2',
              selectedCount: 2,
              hint: l10n.searchFilterHintMultiValue(
                previewCategories.dosageForm.length,
              ),
              content: FilterChipGroup(
                values: previewCategories.dosageForm,
                selected: const {'tablet', 'injection_form'},
                labelFor: (value) => _dosageFormLabel(l10n, value),
                onToggle: (_) {},
              ),
            ),
            FilterAxis(
              id: 'route',
              title: l10n.searchFilterDrugRoute,
              summary: _routeLabel(l10n, 'oral'),
              selectedCount: 1,
              hint: l10n.searchFilterHintMultiValue(
                previewCategories.routeOfAdministration.length,
              ),
              content: FilterChipGroup(
                values: previewCategories.routeOfAdministration,
                selected: const {'oral'},
                labelFor: (value) => _routeLabel(l10n, value),
                onToggle: (_) {},
              ),
            ),
            FilterAxis(
              id: 'precaution_category',
              title: l10n.searchFilterDrugPrecautionCategory,
              summary: _precautionCategoryLabel(l10n, 'GERIATRIC'),
              selectedCount: 1,
              hint: l10n.searchFilterHintMultiValue(
                DrugPrecautionCategory.values.length,
              ),
              content: FilterChipGroup(
                values: const ['GERIATRIC', 'PREGNANT', 'RENAL_IMPAIRMENT'],
                selected: const {'GERIATRIC'},
                labelFor: (value) => _precautionCategoryLabel(l10n, value),
                onToggle: (_) {},
              ),
            ),
          ],
        ),
      );
    },
  );
}

@FddSheetPreview(group: 'Search', name: 'Disease filter sheet')
Widget previewSearchDiseaseFilterSheet() {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return Round6FilterSheetFrame(
        height: 720,
        child: Round6FilterSheetScaffold(
          title: l10n.searchFilterTitleForTarget(l10n.searchTabDiseases),
          axisPolicy: l10n.searchFilterAxisPolicy(4),
          expandedAxis: 'department',
          onToggleAxis: (_) {},
          onReset: () {},
          onApply: () {},
          resultCount: 8,
          axes: [
            FilterAxis(
              id: 'icd10_chapter',
              title: l10n.searchFilterDiseaseIcd10Chapter,
              summary: _icd10ChapterLabel(previewCategories, 'chapter_ix'),
              selectedCount: 1,
              hint: l10n.searchFilterHintDrillIn(
                previewCategories.icd10Chapters.length,
              ),
              content: FilterChipGroup(
                values: const ['chapter_ix', 'chapter_x', 'chapter_iv'],
                selected: const {'chapter_ix'},
                labelFor: (value) =>
                    _icd10ChapterLabel(previewCategories, value),
                onToggle: (_) {},
              ),
            ),
            FilterAxis(
              id: 'department',
              title: l10n.searchFilterDiseaseDepartment,
              summary: '2',
              selectedCount: 2,
              hint: l10n.searchFilterHintMultiValue(
                previewCategories.medicalDepartments.length,
              ),
              content: FilterChipGroup(
                values: previewCategories.medicalDepartments,
                selected: const {'cardiology', 'internal_medicine'},
                labelFor: (value) => _departmentLabel(l10n, value),
                onToggle: (_) {},
              ),
            ),
            FilterAxis(
              id: 'chronicity',
              title: l10n.searchFilterDiseaseChronicity,
              summary: _chronicityLabel(l10n, 'chronic'),
              selectedCount: 1,
              hint: l10n.searchFilterHintSingleValue(
                _diseaseChronicityValues.length,
              ),
              content: FilterChipGroup(
                values: _diseaseChronicityValues,
                selected: const {'chronic'},
                labelFor: (value) => _chronicityLabel(l10n, value),
                onToggle: (_) {},
              ),
            ),
            FilterAxis(
              id: 'infectious',
              title: l10n.searchFilterDiseaseInfectious,
              summary: l10n.searchDiseaseInfectiousFalse,
              selectedCount: 1,
              hint: l10n.searchFilterHintBool,
              content: BoolChipGroup(
                value: false,
                trueLabel: l10n.searchDiseaseInfectiousTrue,
                falseLabel: l10n.searchDiseaseInfectiousFalse,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
      );
    },
  );
}

@FddSheetPreview(group: 'Search', name: 'Sort sheet')
Widget previewSearchSortSheet() {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      final palette = Theme.of(context).extension<AppPalette>()!;
      final options = <({DrugSort sort, String label, String key})>[
        (
          sort: DrugSort.revisedAtDesc,
          label: l10n.searchSortByRevised,
          key: 'drug-revised',
        ),
        (
          sort: DrugSort.brandNameKana,
          label: l10n.searchSortByBrandKana,
          key: 'drug-brand-kana',
        ),
        (
          sort: DrugSort.atcCode,
          label: l10n.searchSortByAtcCode,
          key: 'drug-atc-code',
        ),
        (
          sort: DrugSort.therapeuticCategoryName,
          label: l10n.searchSortByTherapeuticCategory,
          key: 'drug-therapeutic-category',
        ),
      ];
      return Round6SortSheet(
        palette: palette,
        children: [
          for (var index = 0; index < options.length; index++)
            SortOptionTile(
              label: options[index].label,
              selected: options[index].sort == DrugSort.revisedAtDesc,
              selectedKey: options[index].key,
              isLast: index == options.length - 1,
              palette: palette,
              onTap: () {},
            ),
        ],
      );
    },
  );
}

Widget _previewSearchView(SearchScreenState state) {
  return previewProviderScope(
    overrides: [
      ...previewApiOverrides(),
      drugCardImageCacheManagerProvider.overrideWithValue(
        previewFailingCacheManager,
      ),
      searchPreviewModeProvider.overrideWithValue(true),
      searchScreenProvider.overrideWithBuild((ref, notifier) => state),
    ],
    child: SearchView(
      currentTime: previewNow,
      debugLogDrugImageErrors: false,
    ),
  );
}

String _atcLabel(Categories categories, String value) {
  for (final entry in categories.atc) {
    if (entry.code == value) {
      return '${entry.code} ${entry.label}';
    }
  }
  return value;
}

String _icd10ChapterLabel(Categories categories, String value) {
  for (final entry in categories.icd10Chapters) {
    if ('chapter_${entry.roman.toLowerCase()}' == value) {
      return '${entry.roman} ${entry.label}';
    }
  }
  return value;
}

String _dosageFormLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'tablet' => l10n.searchDrugDosageFormTablet,
    'capsule' => l10n.searchDrugDosageFormCapsule,
    'injection_form' => l10n.searchDrugDosageFormInjection,
    'eye_drops' => l10n.searchDrugDosageFormEyeDrops,
    _ => value,
  };
}

String _routeLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'oral' => l10n.searchDrugRouteOral,
    'topical' => l10n.searchDrugRouteTopical,
    'injection_route' => l10n.searchDrugRouteInjection,
    _ => value,
  };
}

String _precautionCategoryLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'GERIATRIC' => l10n.searchDrugPrecautionGeriatric,
    'PREGNANT' => l10n.searchDrugPrecautionPregnant,
    'RENAL_IMPAIRMENT' => l10n.searchDrugPrecautionRenalImpairment,
    _ => value,
  };
}

String _departmentLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'cardiology' => l10n.searchDiseaseDepartmentCardiology,
    'internal_medicine' => l10n.searchDiseaseDepartmentInternalMedicine,
    'infectious_disease' => l10n.searchDiseaseDepartmentInfectiousDisease,
    _ => value,
  };
}

String _chronicityLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseChronicityAcute,
    'subacute' => l10n.searchDiseaseChronicitySubacute,
    'chronic' => l10n.searchDiseaseChronicityChronic,
    'relapsing' => l10n.searchDiseaseChronicityRelapsing,
    _ => value,
  };
}

const _diseaseChronicityValues = ['acute', 'subacute', 'chronic', 'relapsing'];
