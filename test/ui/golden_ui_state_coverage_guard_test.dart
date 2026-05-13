import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('golden UI state coverage', () {
    for (final expectation in _expectations) {
      test('${expectation.screen} covers ${expectation.state}', () {
        final source = File(expectation.testFile).readAsStringSync();

        expect(
          source,
          contains(expectation.sourceFragment),
          reason:
              '${expectation.testFile} must define ${expectation.goldenPrefix}',
        );

        for (final theme in const ['light', 'dark']) {
          final baselinePath =
              '${expectation.goldenDir}/${expectation.goldenPrefix}_$theme.png';
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
    state: 'drug results',
    testFile: 'test/ui/search/search_view_golden_test.dart',
    goldenDir: 'test/ui/search/goldens/macos',
    sourceFragment: "name: 's5_drug_results'",
    goldenPrefix: 'search_s5_drug_results',
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
];

final class _GoldenCoverageExpectation {
  const _GoldenCoverageExpectation({
    required this.screen,
    required this.state,
    required this.testFile,
    required this.goldenDir,
    required this.sourceFragment,
    required this.goldenPrefix,
  });

  final String screen;
  final String state;
  final String testFile;
  final String goldenDir;
  final String sourceFragment;
  final String goldenPrefix;
}
