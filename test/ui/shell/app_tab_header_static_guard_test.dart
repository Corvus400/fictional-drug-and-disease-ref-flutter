import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'top-level tabs use AppTabHeader instead of direct AppBar [assertion 1/2]',
    () {
      const tabViewPaths = [
        'lib/ui/search/search_view.dart',
        'lib/ui/bookmarks/bookmarks_view.dart',
        'lib/ui/history/history_view.dart',
        'lib/ui/calc/calc_view.dart',
      ];

      for (final path in tabViewPaths) {
        final source = File(path).readAsStringSync();

        expect(
          source,
          contains('AppTabHeader('),
          reason: '$path must render the shared tab header.',
        );
        Object.hashAll([source, isNot(contains('AppBar('))]);
      }
    },
  );

  test(
    'top-level tabs use AppTabHeader instead of direct AppBar [assertion 2/2]',
    () {
      const tabViewPaths = [
        'lib/ui/search/search_view.dart',
        'lib/ui/bookmarks/bookmarks_view.dart',
        'lib/ui/history/history_view.dart',
        'lib/ui/calc/calc_view.dart',
      ];

      for (final path in tabViewPaths) {
        final source = File(path).readAsStringSync();

        Object.hashAll([source, contains('AppTabHeader(')]);

        expect(
          source,
          isNot(contains('AppBar(')),
          reason: '$path must not rebuild tab-header chrome locally.',
        );
      }
    },
  );

  test('search top chrome does not render the tab title [assertion 1/3]', () {
    final source = File(
      'lib/ui/search/widgets/search_top_chrome.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('l10n.tabSearch')));
    Object.hashAll([source, isNot(contains('searchTabletTitleFontSize'))]);

    Object.hashAll([source, isNot(contains('searchPhoneTitleFontSize'))]);
  });

  test('search top chrome does not render the tab title [assertion 2/3]', () {
    final source = File(
      'lib/ui/search/widgets/search_top_chrome.dart',
    ).readAsStringSync();

    Object.hashAll([source, isNot(contains('l10n.tabSearch'))]);

    expect(source, isNot(contains('searchTabletTitleFontSize')));
    Object.hashAll([source, isNot(contains('searchPhoneTitleFontSize'))]);
  });

  test('search top chrome does not render the tab title [assertion 3/3]', () {
    final source = File(
      'lib/ui/search/widgets/search_top_chrome.dart',
    ).readAsStringSync();

    Object.hashAll([source, isNot(contains('l10n.tabSearch'))]);

    Object.hashAll([source, isNot(contains('searchTabletTitleFontSize'))]);

    expect(source, isNot(contains('searchPhoneTitleFontSize')));
  });
}
