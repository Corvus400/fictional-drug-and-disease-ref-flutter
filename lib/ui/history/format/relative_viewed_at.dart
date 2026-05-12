import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';

/// Formats a browsing-history viewed timestamp as a relative time string.
String formatRelativeViewedAt(
  DateTime now,
  DateTime viewedAt,
  AppLocalizations l10n,
) {
  final diff = now.difference(viewedAt);
  if (diff.inSeconds < 60) {
    return l10n.historyRelativeJustNow;
  }
  if (diff.inMinutes < 60) {
    return l10n.historyRelativeMinutesAgo(diff.inMinutes);
  }

  final nowLocal = now.toLocal();
  final viewedAtLocal = viewedAt.toLocal();
  final nowDate = DateTime(nowLocal.year, nowLocal.month, nowLocal.day);
  final viewedAtDate = DateTime(
    viewedAtLocal.year,
    viewedAtLocal.month,
    viewedAtLocal.day,
  );
  final dayDiff = nowDate.difference(viewedAtDate).inDays;

  if (dayDiff == 0) {
    return l10n.historyRelativeHoursAgo(diff.inHours);
  }
  if (dayDiff == 1) {
    final hh = viewedAtLocal.hour.toString().padLeft(2, '0');
    final mm = viewedAtLocal.minute.toString().padLeft(2, '0');
    return l10n.historyRelativeYesterdayAt('$hh:$mm');
  }
  if (dayDiff < 7) {
    return l10n.historyRelativeDaysAgo(dayDiff);
  }

  final year = viewedAtLocal.year.toString().padLeft(4, '0');
  final month = viewedAtLocal.month.toString().padLeft(2, '0');
  final day = viewedAtLocal.day.toString().padLeft(2, '0');
  return l10n.historyRelativeAbsoluteDate('$year/$month/$day');
}
