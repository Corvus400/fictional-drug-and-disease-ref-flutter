import 'package:fictional_drug_and_disease_ref/l10n/app_localizations_ja.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('searchToolbarLoadMoreWithProgress formats current and total pages', () {
    final ja = AppLocalizationsJa();

    expect(ja.searchToolbarLoadMoreWithProgress(2, 5), 'さらに読み込む · 2 / 5');
  });
}
