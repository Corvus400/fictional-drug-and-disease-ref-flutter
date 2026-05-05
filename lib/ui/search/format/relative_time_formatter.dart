import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';

/// Formats a search-history timestamp as a relative time string.
String formatRelativeTime(DateTime now, DateTime past, AppLocalizations l10n) {
  final diff = now.difference(past);
  if (diff.inSeconds < 60) {
    return l10n.searchHistoryTimeJustNow;
  }
  if (diff.inMinutes < 60) {
    return l10n.searchHistoryTimeMinutesAgo(diff.inMinutes);
  }

  final nowLocal = now.toLocal();
  final pastLocal = past.toLocal();
  final nowDate = DateTime(nowLocal.year, nowLocal.month, nowLocal.day);
  final pastDate = DateTime(pastLocal.year, pastLocal.month, pastLocal.day);
  final dayDiff = nowDate.difference(pastDate).inDays;

  if (dayDiff == 0) {
    return l10n.searchHistoryTimeHoursAgo(diff.inHours);
  }
  if (dayDiff == 1) {
    final hh = pastLocal.hour.toString().padLeft(2, '0');
    final mm = pastLocal.minute.toString().padLeft(2, '0');
    return l10n.searchHistoryTimeYesterday('$hh:$mm');
  }
  if (dayDiff < 7) {
    return l10n.searchHistoryTimeDaysAgo(dayDiff);
  }

  final year = pastLocal.year.toString().padLeft(4, '0');
  final month = pastLocal.month.toString().padLeft(2, '0');
  final day = pastLocal.day.toString().padLeft(2, '0');
  return '$year/$month/$day';
}
