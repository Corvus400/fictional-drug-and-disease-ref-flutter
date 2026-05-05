import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/format/relative_time_formatter.dart';
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

  test('returns just-now within 60 seconds', () {
    final now = localTime(2026, 5, 5, 12);
    expect(formatRelativeTime(now, localTime(2026, 5, 5, 12), l10n), 'たった今');
    expect(
      formatRelativeTime(now, localTime(2026, 5, 5, 11, 59, 1), l10n),
      'たった今',
    );
  });

  test('returns minutes-ago between 1 and 59 minutes', () {
    final now = localTime(2026, 5, 5, 12);
    expect(
      formatRelativeTime(now, localTime(2026, 5, 5, 11, 59), l10n),
      '1分前',
    );
    expect(
      formatRelativeTime(now, localTime(2026, 5, 5, 11, 1), l10n),
      '59分前',
    );
  });

  test('returns hours-ago between 1 and 23 hours within same day', () {
    final now = localTime(2026, 5, 5, 23, 30);
    expect(
      formatRelativeTime(now, localTime(2026, 5, 5, 22, 30), l10n),
      '1時間前',
    );
    expect(
      formatRelativeTime(now, localTime(2026, 5, 5, 0, 30), l10n),
      '23時間前',
    );
  });

  test('returns yesterday HH:mm when calendar diff is 1 day', () {
    final now = localTime(2026, 5, 5, 9);
    expect(
      formatRelativeTime(now, localTime(2026, 5, 4, 21, 5), l10n),
      '昨日 21:05',
    );
    expect(
      formatRelativeTime(now, localTime(2026, 5, 4), l10n),
      '昨日 00:00',
    );
  });

  test('returns days-ago between 2 and 6 calendar days', () {
    final now = localTime(2026, 5, 5, 12);
    expect(
      formatRelativeTime(now, localTime(2026, 5, 3, 12), l10n),
      '2日前',
    );
    expect(
      formatRelativeTime(now, localTime(2026, 4, 29, 12), l10n),
      '6日前',
    );
  });

  test('returns yyyy/MM/dd when older than 6 calendar days', () {
    final now = localTime(2026, 5, 5, 12);
    expect(
      formatRelativeTime(now, localTime(2026, 4, 28, 12), l10n),
      '2026/04/28',
    );
    expect(
      formatRelativeTime(now, localTime(2025, 12, 31, 8), l10n),
      '2025/12/31',
    );
  });

  test('returns just-now when past is in the future', () {
    final now = localTime(2026, 5, 5, 12);
    expect(
      formatRelativeTime(now, localTime(2026, 5, 5, 12, 0, 30), l10n),
      'たった今',
    );
  });
}
