import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/l10n/app_localizations_ja.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app title matches the product name', () {
    final ja = AppLocalizationsJa();

    expect(ja.appTitle, 'メディマスタ');
  });

  test('browsing history strings match the design contract', () {
    final ja = AppLocalizationsJa();

    expect(ja.historyTabAll, 'すべて');
    expect(ja.historyTabDrug, '医薬品');
    expect(ja.historyTabDisease, '疾患');
    expect(ja.historyEmptyTitle, '閲覧履歴がありません');
    expect(
      ja.historyEmptyBody,
      '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます',
    );
    expect(ja.historyEmptyCta, '検索画面へ');
    expect(ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除');
    expect(ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得');
    expect(
      ja.historyBulkDeleteConfirmTitle(3),
      'すべての閲覧履歴 (3件) を削除しますか？',
    );
    expect(ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません');
    expect(ja.historyBulkDeleteConfirmCancel, 'キャンセル');
    expect(ja.historyBulkDeleteConfirmDelete, 'すべて削除');
    expect(ja.historyNameResolutionFailedPlaceholder, '名前取得失敗');
    expect(ja.historyRelativeJustNow, 'たった今');
    expect(ja.historyRelativeMinutesAgo(5), '5分前');
    expect(ja.historyRelativeHoursAgo(2), '2時間前');
    expect(ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14');
    expect(ja.historyRelativeDaysAgo(6), '6日前');
    expect(ja.historyRelativeAbsoluteDate('2026/04/28'), '2026/04/28');
  });

  test('history and bookmarks placeholders are removed', () {
    final arb =
        jsonDecode(File('lib/l10n/app_ja.arb').readAsStringSync())
            as Map<String, dynamic>;

    expect(arb, isNot(contains('historyPlaceholder')));
    expect(arb, isNot(contains('bookmarksPlaceholder')));
  });

  test('bookmarks strings match the design contract', () {
    final ja = AppLocalizationsJa();

    expect(ja.bookmarksTabAll, 'すべて');
    expect(ja.bookmarksTabDrug, '医薬品');
    expect(ja.bookmarksTabDisease, '疾患');
    expect(ja.bookmarksSearchHint, '名前で検索');
    expect(ja.bookmarksResultCount(6), '6件');
    expect(ja.bookmarksResultCountUnknown, '-');
    expect(ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10');
    expect(ja.bookmarksRowDrugSemantics, '薬品のブックマーク');
    expect(ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク');
    expect(ja.bookmarksEmptyTitle, 'ブックマークがありません');
    expect(
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    );
    expect(ja.bookmarksEmptyCta, '検索画面へ');
    expect(ja.bookmarksSearchZeroTitle, '一致するブックマークがありません');
    expect(
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    );
  });
}
