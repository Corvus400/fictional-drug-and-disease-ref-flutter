import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/format/relative_viewed_at.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppLocalizations l10n;

  setUpAll(() async {
    l10n = await AppLocalizations.delegate.load(const Locale('ja'));
  });

  DateTime localTime(
    int year,
    int month,
    int day, [
    int hour = 0,
    int minute = 0,
    int second = 0,
  ]) => DateTime(year, month, day, hour, minute, second);

  test('formats viewedAt using the browsing-history six branch contract', () {
    final now = localTime(2026, 5, 5, 12);

    expect(
      formatRelativeViewedAt(now, localTime(2026, 5, 5, 11, 59, 1), l10n),
      'たった今',
    );
    expect(
      formatRelativeViewedAt(now, localTime(2026, 5, 5, 11, 59), l10n),
      '1分前',
    );
    expect(
      formatRelativeViewedAt(now, localTime(2026, 5, 5, 11, 1), l10n),
      '59分前',
    );
    expect(
      formatRelativeViewedAt(now, localTime(2026, 5, 5, 10), l10n),
      '2時間前',
    );
    expect(
      formatRelativeViewedAt(now, localTime(2026, 5, 4, 22, 14), l10n),
      '昨日 22:14',
    );
    expect(formatRelativeViewedAt(now, localTime(2026, 5, 3, 12), l10n), '2日前');
    expect(
      formatRelativeViewedAt(now, localTime(2026, 4, 29, 12), l10n),
      '6日前',
    );
    expect(
      formatRelativeViewedAt(now, localTime(2026, 4, 28, 12), l10n),
      '2026/04/28',
    );
  });
}
