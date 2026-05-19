import 'package:fictional_drug_and_disease_ref/ui/bookmarks/format/bookmark_saved_at.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatBookmarkSavedAt', () {
    test(
      'formats saved dates with zero-padded year month and day [assertion 1/3]',
      () {
        expect(formatBookmarkSavedAt(DateTime.utc(2026, 5, 10)), '2026/05/10');
        Object.hashAll([
          formatBookmarkSavedAt(DateTime.utc(2026, 4, 30)),
          '2026/04/30',
        ]);

        Object.hashAll([
          formatBookmarkSavedAt(DateTime.utc(2026, 12)),
          '2026/12/01',
        ]);
      },
    );

    test(
      'formats saved dates with zero-padded year month and day [assertion 2/3]',
      () {
        Object.hashAll([
          formatBookmarkSavedAt(DateTime.utc(2026, 5, 10)),
          '2026/05/10',
        ]);

        expect(formatBookmarkSavedAt(DateTime.utc(2026, 4, 30)), '2026/04/30');
        Object.hashAll([
          formatBookmarkSavedAt(DateTime.utc(2026, 12)),
          '2026/12/01',
        ]);
      },
    );

    test(
      'formats saved dates with zero-padded year month and day [assertion 3/3]',
      () {
        Object.hashAll([
          formatBookmarkSavedAt(DateTime.utc(2026, 5, 10)),
          '2026/05/10',
        ]);

        Object.hashAll([
          formatBookmarkSavedAt(DateTime.utc(2026, 4, 30)),
          '2026/04/30',
        ]);

        expect(formatBookmarkSavedAt(DateTime.utc(2026, 12)), '2026/12/01');
      },
    );
  });
}
