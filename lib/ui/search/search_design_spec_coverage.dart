/// Source-backed coverage map for Search Screen Spec representative frames.
///
/// Visual SSOT: design-blueprint
/// `fictional-drug-and-disease-ref-flutter/検索画面/Search Screen Spec.html`.
/// This file tracks Flutter-side coverage only; it must not redefine design
/// requirements or API/domain contracts.
final searchDesignSpecFrameCoverage = <SearchDesignSpecFrameCoverage>[
  for (final theme in _themes)
    for (final state in _phoneStates)
      SearchDesignSpecFrameCoverage(
        device: 'iPhone',
        theme: theme,
        state: state,
        coverage: [
          _coverage(
            'test/ui/search/search_view_golden_test.dart',
            _goldenStateFragments[state]!,
          ),
          _coverage(
            'test/ui/search/search_view_design_contract_test.dart',
            _phoneContractFragments[state] ?? 'SearchView initial phone chrome',
          ),
        ],
      ),
  for (final device in _utilityDevices)
    for (final theme in _themes)
      for (final state in _utilityStates)
        SearchDesignSpecFrameCoverage(
          device: device,
          theme: theme,
          state: state,
          coverage: [
            _coverage(
              'test/ui/search/search_view_golden_test.dart',
              _goldenStateFragments[state]!,
            ),
            _coverage(
              'test/ui/search/search_view_design_contract_test.dart',
              _utilityDeviceFragments[device]!,
            ),
            _coverage(
              'test/ui/shell/app_shell_adaptive_navigation_test.dart',
              'landscape shell uses icon-only rail for all tabs',
            ),
          ],
        ),
];

const _themes = ['Light', 'Dark'];

const _phoneStates = [
  'idle',
  'idle-empty-history',
  'loading',
  'results',
  'loading-more',
  'empty',
  'error',
  'filter-open',
  'sort-open',
];

const _utilityStates = [
  'idle',
  'idle-empty-history',
  'loading',
  'results',
  'loading-more',
  'empty',
  'error',
];

const _utilityDevices = [
  'iPhone landscape',
  'iPad',
  'iPad landscape',
  'iPad Split View',
];

const _goldenStateFragments = {
  'idle': "name: 's1_idle'",
  'idle-empty-history': "name: 's16_empty_history'",
  'loading': "name: 's3_loading'",
  'results': "name: 's5_drug_results'",
  'loading-more': "name: 's4_loading_more'",
  'empty': "name: 's6_empty'",
  'error': "name: 's7_error'",
  'filter-open': "name: 's8_filter_drugs'",
  'sort-open': "name: 's10_sort'",
};

const _phoneContractFragments = {
  'idle': 'SearchView initial phone chrome',
  'idle-empty-history': 'inline history follows Round6 divider',
  'loading': 'loading-more footer uses Round6 shimmer placeholder',
  'results': 'SearchView result toolbar follows Round6 phone metrics',
  'loading-more': 'loading-more footer uses Round6 shimmer placeholder',
  'empty': 'empty recovery CTAs use Round6 sizes',
  'error': 'error retry CTA uses Round6 primary palette',
  'filter-open': 'SearchView filter sheet follows Round6 phone geometry',
  'sort-open': 'SearchView sort sheet follows Round6 selector surface contract',
};

const _utilityDeviceFragments = {
  'iPhone landscape': 'SearchView keeps filter FAB phone-only',
  'iPad': 'SearchView tablet renders utility pane',
  'iPad landscape': 'SearchView tablet renders utility pane',
  'iPad Split View': 'SearchView tablet renders utility pane',
};

SearchDesignSpecCoverage _coverage(String source, String sourceFragment) =>
    SearchDesignSpecCoverage(source: source, sourceFragment: sourceFragment);

/// One representative Search Screen Spec frame.
final class SearchDesignSpecFrameCoverage {
  /// Creates a frame coverage entry.
  const SearchDesignSpecFrameCoverage({
    required this.device,
    required this.theme,
    required this.state,
    required this.coverage,
  });

  /// Device class label from `data-frame-label`.
  final String device;

  /// `Light` or `Dark`.
  final String theme;

  /// Representative UI state label from `data-frame-label`.
  final String state;

  /// Flutter-side tests or golden sources that cover this frame.
  final List<SearchDesignSpecCoverage> coverage;

  /// Full label matching the HTML `data-frame-label`.
  String get label => '$device × $theme × $state';
}

/// Flutter-side source artifact that backs a design frame.
final class SearchDesignSpecCoverage {
  /// Creates a source-backed coverage marker.
  const SearchDesignSpecCoverage({
    required this.source,
    required this.sourceFragment,
  });

  /// Repository-relative path to the test/golden source.
  final String source;

  /// Source fragment that must stay present in [source].
  final String sourceFragment;
}
