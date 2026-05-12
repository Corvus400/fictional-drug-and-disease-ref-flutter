import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/format/relative_time_formatter.dart';

/// Formats a browsing-history viewed timestamp as a relative time string.
String formatRelativeViewedAt(
  DateTime now,
  DateTime viewedAt,
  AppLocalizations l10n,
) {
  return formatRelativeTime(now, viewedAt, l10n);
}
