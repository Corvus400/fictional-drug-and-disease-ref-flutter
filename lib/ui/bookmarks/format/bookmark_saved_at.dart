/// Formats a bookmark saved date as yyyy/MM/dd.
String formatBookmarkSavedAt(DateTime value) {
  final year = value.year.toString().padLeft(4, '0');
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '$year/$month/$day';
}
