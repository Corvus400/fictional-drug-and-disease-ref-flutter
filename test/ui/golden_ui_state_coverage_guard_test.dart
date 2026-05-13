import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('golden UI state coverage', () {
    test('all UI golden test files are registered in the manifest', () {
      final actualFiles = Directory('test/ui')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .where(
            (file) =>
                file.path != 'test/ui/golden_ui_state_coverage_guard_test.dart',
          )
          .where((file) {
            final source = file.readAsStringSync();
            return source.contains('runGoldenMatrix(') ||
                source.contains('runHistoryGoldenMatrix(') ||
                source.contains('runNavigationBarGolden(') ||
                source.contains('runNavigationBarStateMatrixGolden(') ||
                source.contains('matchesGoldenFile(') ||
                source.contains('goldenTest(');
          })
          .map((file) => file.path)
          .toSet();

      expect(
        actualFiles,
        equals(_goldenTestFiles.toSet()),
        reason: 'Every UI golden test file must be listed in _goldenTestFiles',
      );
    });

    test('all committed UI golden baselines are source-backed', () {
      final manifestSources = {
        for (final testFile in _goldenTestFiles)
          testFile: File(testFile).readAsStringSync(),
      };
      final stateBackedPrefixes = {
        for (final expectation in _expectations) expectation.baselinePrefix,
      };
      final baselineFiles =
          Directory('test/ui')
              .listSync(recursive: true)
              .whereType<File>()
              .where((file) => file.path.contains('/goldens/macos/'))
              .where((file) => file.path.endsWith('.png'))
              .toList()
            ..sort((a, b) => a.path.compareTo(b.path));

      for (final baselineFile in baselineFiles) {
        final stem = _fileStem(baselineFile.path);
        final prefix = _themeStrippedPrefix(stem);
        final isSourceBacked =
            stateBackedPrefixes.contains(prefix) ||
            _isDynamicallySourceBacked(prefix, manifestSources.values) ||
            manifestSources.values.any(
              (source) =>
                  source.contains("'$prefix'") ||
                  source.contains("'$stem'") ||
                  source.contains('$prefix.png') ||
                  source.contains('$stem.png') ||
                  source.contains('"$prefix"') ||
                  source.contains('"$stem"'),
            );

        expect(
          isSourceBacked,
          isTrue,
          reason:
              '${baselineFile.path} must be backed by a golden source entry',
        );
      }
    });

    for (final expectation in _expectations) {
      test('${expectation.screen} covers ${expectation.state}', () {
        final source = File(expectation.testFile).readAsStringSync();

        expect(
          source,
          contains(expectation.sourceFragment),
          reason: '${expectation.testFile} must define ${expectation.state}',
        );

        for (final theme in const ['light', 'dark']) {
          final baselinePath =
              '${expectation.goldenDir}/${expectation.baselinePrefix}_$theme.png';
          expect(
            File(baselinePath).existsSync(),
            isTrue,
            reason: '$baselinePath must be committed as a golden baseline',
          );
        }
      });
    }
  });
}

const _expectations = <_GoldenCoverageExpectation>[
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'idle',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's1_idle'",
    goldenPrefix: 'search_s1_idle',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease idle',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's22_disease_idle'",
    goldenPrefix: 'search_s22_disease_idle',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'history dropdown with entries',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's2_history'",
    goldenPrefix: 'search_s2_history',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease history dropdown with entries',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's23_disease_history'",
    goldenPrefix: 'search_s23_disease_history',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'history dropdown empty',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's16_empty_history'",
    goldenPrefix: 'search_s16_empty_history',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease history dropdown empty',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's24_disease_empty_history'",
    goldenPrefix: 'search_s24_disease_empty_history',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug loading',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's3_loading'",
    goldenPrefix: 'search_s3_loading',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug loading more',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's4_loading_more'",
    goldenPrefix: 'search_s4_loading_more',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug results',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's5_drug_results'",
    goldenPrefix: 'search_s5_drug_results',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug empty',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's6_empty'",
    goldenPrefix: 'search_s6_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug error',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's7_error'",
    goldenPrefix: 'search_s7_error',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug filter sheet',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's8_filter_drugs'",
    goldenPrefix: 'search_s8_filter_drugs',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease filter sheet',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's9_filter_diseases'",
    goldenPrefix: 'search_s9_filter_diseases',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug sort sheet',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's10_sort'",
    goldenPrefix: 'search_s10_sort',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease loading',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's17_disease_loading'",
    goldenPrefix: 'search_s17_disease_loading',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease results',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's11_disease_results'",
    goldenPrefix: 'search_s11_disease_results',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease loading more',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's12_disease_loading_more'",
    goldenPrefix: 'search_s12_disease_loading_more',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease empty',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's13_disease_empty'",
    goldenPrefix: 'search_s13_disease_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease error',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's14_disease_error'",
    goldenPrefix: 'search_s14_disease_error',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease sort sheet',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's15_disease_sort'",
    goldenPrefix: 'search_s15_disease_sort',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug filtered results',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's18_drug_filtered_results'",
    goldenPrefix: 'search_s18_drug_filtered_results',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'drug filtered empty',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's19_drug_filtered_empty'",
    goldenPrefix: 'search_s19_drug_filtered_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease filtered results',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's20_disease_filtered_results'",
    goldenPrefix: 'search_s20_disease_filtered_results',
  ),
  _GoldenCoverageExpectation(
    screen: 'search',
    state: 'disease filtered empty',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's21_disease_filtered_empty'",
    goldenPrefix: 'search_s21_disease_filtered_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'normal all tab',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_normal'",
    goldenPrefix: 'bookmarks_normal',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'normal drug tab',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_drug_tab'",
    goldenPrefix: 'bookmarks_drug_tab',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'normal disease tab',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_disease_tab'",
    goldenPrefix: 'bookmarks_disease_tab',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'empty',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_empty'",
    goldenPrefix: 'bookmarks_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'loading',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_loading'",
    goldenPrefix: 'bookmarks_loading',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'search zero all tab',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_search_zero'",
    goldenPrefix: 'bookmarks_search_zero',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'search zero drug tab',
    testFile: 'test/ui/bookmarks/bookmarks_view_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: 'search miss on drug tab keeps search zero UI',
    goldenPrefix: 'bookmarks_search_zero_drug_tab',
    baselinePrefix: 'bookmarks_search_zero',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'search zero disease tab',
    testFile: 'test/ui/bookmarks/bookmarks_view_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: 'search miss on disease tab keeps search zero UI',
    goldenPrefix: 'bookmarks_search_zero_disease_tab',
    baselinePrefix: 'bookmarks_search_zero',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'swipe delete',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_swipe_delete'",
    goldenPrefix: 'bookmarks_swipe_delete',
  ),
  _GoldenCoverageExpectation(
    screen: 'bookmarks',
    state: 'error',
    testFile: 'test/ui/bookmarks/bookmarks_view_golden_test.dart',
    goldenDir: 'test/ui/bookmarks/goldens/macos',
    sourceFragment: "fileNamePrefix: 'bookmarks_error'",
    goldenPrefix: 'bookmarks_error',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'normal all tab',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_normal'",
    goldenPrefix: 'history_normal',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'normal drug tab',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_drug_tab'",
    goldenPrefix: 'history_drug_tab',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'normal disease tab',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_disease_tab'",
    goldenPrefix: 'history_disease_tab',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'empty',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_empty'",
    goldenPrefix: 'history_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'loading',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_loading'",
    goldenPrefix: 'history_loading',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'swipe delete',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_swipe_delete'",
    goldenPrefix: 'history_swipe_delete',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'bulk delete confirm',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_bulk_delete_confirm'",
    goldenPrefix: 'history_bulk_delete_confirm',
  ),
  _GoldenCoverageExpectation(
    screen: 'history',
    state: 'name fetch fail',
    testFile: 'test/ui/history/history_view_golden_test.dart',
    goldenDir: 'test/ui/history/goldens/macos',
    sourceFragment: "fileNamePrefix: 'history_name_fetch_fail'",
    goldenPrefix: 'history_name_fetch_fail',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'loading',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "fileNamePrefix: 'drug_loading'",
    goldenPrefix: 'drug_loading',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'error',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "fileNamePrefix: 'drug_error'",
    goldenPrefix: 'drug_error',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'overview tab',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "'overview': DrugDetailTab.overview",
    goldenPrefix: 'drug_overview',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'bookmarked overview tab',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "fileNamePrefix: 'drug_overview_bookmarked'",
    goldenPrefix: 'drug_overview_bookmarked',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'dose tab',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "'dose': DrugDetailTab.dose",
    goldenPrefix: 'drug_dose',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'caution tab',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "'caution': DrugDetailTab.caution",
    goldenPrefix: 'drug_caution',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'adverse effects tab',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "'adverse_effects': DrugDetailTab.adverseEffects",
    goldenPrefix: 'drug_adverse_effects',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'pharmacokinetics tab',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "'pharmacokinetics': DrugDetailTab.pharmacokinetics",
    goldenPrefix: 'drug_pharmacokinetics',
  ),
  _GoldenCoverageExpectation(
    screen: 'drug detail',
    state: 'related tab',
    testFile: 'test/ui/drug/drug_detail_view_golden_test.dart',
    goldenDir: 'test/ui/drug/goldens/macos',
    sourceFragment: "'related': DrugDetailTab.related",
    goldenPrefix: 'drug_related',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'loading',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "fileNamePrefix: 'disease_loading'",
    goldenPrefix: 'disease_loading',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'error',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "fileNamePrefix: 'disease_error'",
    goldenPrefix: 'disease_error',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'overview tab',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "'overview': DiseaseDetailTab.overview",
    goldenPrefix: 'disease_overview',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'bookmarked overview tab',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "fileNamePrefix: 'disease_overview_bookmarked'",
    goldenPrefix: 'disease_overview_bookmarked',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'diagnosis tab',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "'diagnosis': DiseaseDetailTab.diagnosis",
    goldenPrefix: 'disease_diagnosis',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'treatment tab',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "'treatment': DiseaseDetailTab.treatment",
    goldenPrefix: 'disease_treatment',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'clinical course tab',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "'clinical_course': DiseaseDetailTab.clinicalCourse",
    goldenPrefix: 'disease_clinical_course',
  ),
  _GoldenCoverageExpectation(
    screen: 'disease detail',
    state: 'related tab',
    testFile: 'test/ui/disease/disease_detail_view_golden_test.dart',
    goldenDir: 'test/ui/disease/goldens/macos',
    sourceFragment: "'related': DiseaseDetailTab.related",
    goldenPrefix: 'disease_related',
  ),
  _GoldenCoverageExpectation(
    screen: 'calc',
    state: 'tool and phase matrix',
    testFile: 'test/ui/calc/calc_view_golden_test.dart',
    goldenDir: 'test/ui/calc/goldens/macos',
    sourceFragment: 'for (final tool in _CalcGoldenTool.values)',
    goldenPrefix: 'calc_bmi_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'calc',
    state: 'history collapsed',
    testFile: 'test/ui/calc/calc_view_golden_test.dart',
    goldenDir: 'test/ui/calc/goldens/macos',
    sourceFragment: '_calcHistoryCollapsedGolden();',
    goldenPrefix: 'calc_history_collapsed',
  ),
  _GoldenCoverageExpectation(
    screen: 'calc',
    state: 'history expanded',
    testFile: 'test/ui/calc/calc_view_golden_test.dart',
    goldenDir: 'test/ui/calc/goldens/macos',
    sourceFragment: '_calcHistoryExpandedGolden();',
    goldenPrefix: 'calc_history_expanded',
  ),
  _GoldenCoverageExpectation(
    screen: 'calc',
    state: 'history empty',
    testFile: 'test/ui/calc/calc_view_golden_test.dart',
    goldenDir: 'test/ui/calc/goldens/macos',
    sourceFragment: '_calcHistoryEmptyGolden();',
    goldenPrefix: 'calc_history_empty',
  ),
  _GoldenCoverageExpectation(
    screen: 'calc',
    state: 'history error same as empty',
    testFile: 'test/ui/calc/calc_view_test.dart',
    goldenDir: 'test/ui/calc/goldens/macos',
    sourceFragment: 'history error renders the same empty history surface',
    goldenPrefix: 'calc_history_error',
    baselinePrefix: 'calc_history_empty',
  ),
];

const _goldenTestFiles = <String>[
  'test/ui/_common/disclaimer_ribbon_golden_test.dart',
  'test/ui/_common/navigation_bar_golden_helpers.dart',
  'test/ui/_common/widgets/disease_result_card_golden_test.dart',
  'test/ui/_common/widgets/drug_result_card_golden_test.dart',
  'test/ui/bookmarks/bookmarks_navigation_bar_golden_test.dart',
  'test/ui/bookmarks/bookmarks_view_golden_test.dart',
  'test/ui/calc/calc_navigation_bar_golden_test.dart',
  'test/ui/calc/calc_tokens_golden_test.dart',
  'test/ui/calc/calc_view_golden_test.dart',
  'test/ui/calc/widgets/calc_chart_atoms_golden_test.dart',
  'test/ui/calc/widgets/calc_history_atoms_golden_test.dart',
  'test/ui/calc/widgets/calc_input_atoms_golden_test.dart',
  'test/ui/calc/widgets/calc_result_atoms_golden_test.dart',
  'test/ui/calc/widgets/calc_segmented_control_atom_card_golden_test.dart',
  'test/ui/detail/widgets/detail_accordion_test.dart',
  'test/ui/detail/widgets/detail_badge_test.dart',
  'test/ui/detail/widgets/detail_bookmark_footer_test.dart',
  'test/ui/detail/widgets/detail_carousel_test.dart',
  'test/ui/detail/widgets/detail_chip_test.dart',
  'test/ui/detail/widgets/detail_dose_calc_button_test.dart',
  'test/ui/detail/widgets/detail_exam_table_test.dart',
  'test/ui/detail/widgets/detail_expand_tile_test.dart',
  'test/ui/detail/widgets/detail_kv_row_test.dart',
  'test/ui/detail/widgets/detail_panel_test.dart',
  'test/ui/detail/widgets/detail_pk_table_test.dart',
  'test/ui/detail/widgets/detail_responsive_layout_test.dart',
  'test/ui/detail/widgets/detail_serious_card_test.dart',
  'test/ui/detail/widgets/detail_severity_grade_test.dart',
  'test/ui/detail/widgets/detail_warn_banner_test.dart',
  'test/ui/disease/disease_detail_view_golden_test.dart',
  'test/ui/disease/disease_navigation_bar_golden_test.dart',
  'test/ui/drug/drug_detail_view_golden_test.dart',
  'test/ui/drug/drug_navigation_bar_golden_test.dart',
  'test/ui/history/history_navigation_bar_golden_test.dart',
  'test/ui/history/history_view_golden_test.dart',
  'test/ui/search/search_navigation_bar_golden_test.dart',
  'test/ui/search/search_view_golden_test.dart',
  'test/ui/shell/app_shell_navigation_bar_golden_test.dart',
  'test/ui/shell/app_tab_header_golden_test.dart',
];

String _fileStem(String path) {
  return path.split(Platform.pathSeparator).last.replaceFirst('.png', '');
}

String _themeStrippedPrefix(String stem) {
  if (stem.endsWith('_light')) {
    return stem.substring(0, stem.length - '_light'.length);
  }
  if (stem.endsWith('_dark')) {
    return stem.substring(0, stem.length - '_dark'.length);
  }
  return stem;
}

bool _isDynamicallySourceBacked(
  String prefix,
  Iterable<String> manifestSources,
) {
  bool sourceContains(String fragment) {
    return manifestSources.any((source) => source.contains(fragment));
  }

  if (prefix.startsWith('disclaimer_ribbon_')) {
    return sourceContains(r"'disclaimer_ribbon_$sizeName'");
  }
  if (prefix.startsWith('disclaimer_shell_')) {
    return sourceContains(r"'disclaimer_shell_$name'");
  }
  if (prefix.startsWith('app_tab_header_')) {
    return sourceContains(r"'app_tab_header_${tab.name}'");
  }
  if (prefix.startsWith('calc_boundary_')) {
    return sourceContains(
      r"'calc_boundary_${boundaryCase.tool.key}_${boundaryCase.key}'",
    );
  }
  if (prefix.startsWith('calc_immediate_error_')) {
    return sourceContains(
      r"'calc_immediate_error_${immediateCase.tool.key}_${immediateCase.key}'",
    );
  }
  if (prefix.startsWith('calc_multi_error_')) {
    return sourceContains(
      r"'calc_multi_error_${multiErrorCase.tool.key}_${multiErrorCase.key}'",
    );
  }
  if (prefix.startsWith('calc_partial_')) {
    return sourceContains(
      r"'calc_partial_${partialCase.tool.key}_${partialCase.key}'",
    );
  }
  if (prefix.startsWith('calc_history_boundary_')) {
    return sourceContains(r"'calc_history_boundary_${mode.key}_$count'");
  }
  if (prefix.startsWith('calc_bmi_') ||
      prefix.startsWith('calc_egfr_') ||
      prefix.startsWith('calc_crcl_')) {
    return sourceContains(r"'calc_${tool.key}_${state.key}'");
  }
  return false;
}

final class _GoldenCoverageExpectation {
  const _GoldenCoverageExpectation({
    required this.screen,
    required this.state,
    required this.testFile,
    required this.goldenDir,
    required this.sourceFragment,
    required this.goldenPrefix,
    String? baselinePrefix,
  }) : baselinePrefix = baselinePrefix ?? goldenPrefix;

  final String screen;
  final String state;
  final String testFile;
  final String goldenDir;
  final String sourceFragment;
  final String goldenPrefix;
  final String baselinePrefix;
}
