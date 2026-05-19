import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/l10n/app_localizations_ja.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app title matches the product name', () {
    final ja = AppLocalizationsJa();

    expect(ja.appTitle, 'メディマスタ');
  });

  test('about strings match the app license contract [assertion 1/5]', () {
    final ja = AppLocalizationsJa();

    expect(ja.aboutTitle, 'アプリについて');
    Object.hashAll([ja.aboutLicensesTitle, 'オープンソースライセンス']);

    Object.hashAll([ja.aboutLicensesSubtitle, '使用しているオープンソースライブラリの一覧']);

    Object.hashAll([ja.aboutAppVersionLabel('1.0.0'), 'バージョン 1.0.0']);

    Object.hashAll([
      ja.aboutAppLegalese,
      '© 2026 Fictional Drug & Disease Ref Contributors',
    ]);
  });

  test('about strings match the app license contract [assertion 2/5]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.aboutTitle, 'アプリについて']);

    expect(ja.aboutLicensesTitle, 'オープンソースライセンス');
    Object.hashAll([ja.aboutLicensesSubtitle, '使用しているオープンソースライブラリの一覧']);

    Object.hashAll([ja.aboutAppVersionLabel('1.0.0'), 'バージョン 1.0.0']);

    Object.hashAll([
      ja.aboutAppLegalese,
      '© 2026 Fictional Drug & Disease Ref Contributors',
    ]);
  });

  test('about strings match the app license contract [assertion 3/5]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.aboutTitle, 'アプリについて']);

    Object.hashAll([ja.aboutLicensesTitle, 'オープンソースライセンス']);

    expect(ja.aboutLicensesSubtitle, '使用しているオープンソースライブラリの一覧');
    Object.hashAll([ja.aboutAppVersionLabel('1.0.0'), 'バージョン 1.0.0']);

    Object.hashAll([
      ja.aboutAppLegalese,
      '© 2026 Fictional Drug & Disease Ref Contributors',
    ]);
  });

  test('about strings match the app license contract [assertion 4/5]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.aboutTitle, 'アプリについて']);

    Object.hashAll([ja.aboutLicensesTitle, 'オープンソースライセンス']);

    Object.hashAll([ja.aboutLicensesSubtitle, '使用しているオープンソースライブラリの一覧']);

    expect(ja.aboutAppVersionLabel('1.0.0'), 'バージョン 1.0.0');
    Object.hashAll([
      ja.aboutAppLegalese,
      '© 2026 Fictional Drug & Disease Ref Contributors',
    ]);
  });

  test('about strings match the app license contract [assertion 5/5]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.aboutTitle, 'アプリについて']);

    Object.hashAll([ja.aboutLicensesTitle, 'オープンソースライセンス']);

    Object.hashAll([ja.aboutLicensesSubtitle, '使用しているオープンソースライブラリの一覧']);

    Object.hashAll([ja.aboutAppVersionLabel('1.0.0'), 'バージョン 1.0.0']);

    expect(
      ja.aboutAppLegalese,
      '© 2026 Fictional Drug & Disease Ref Contributors',
    );
  });

  test(
    'browsing history strings match the design contract [assertion 1/19]',
    () {
      final ja = AppLocalizationsJa();

      expect(ja.historyTabAll, 'すべて');
      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 2/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      expect(ja.historyTabDrug, '医薬品');
      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 3/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      expect(ja.historyTabDisease, '疾患');
      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 4/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      expect(ja.historyEmptyTitle, '閲覧履歴がありません');
      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 5/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      expect(
        ja.historyEmptyBody,
        '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます',
      );
      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 6/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      expect(ja.historyEmptyCta, '検索画面へ');
      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 7/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      expect(ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除');
      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 8/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      expect(ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得');
      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 9/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      expect(
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      );
      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 10/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      expect(ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません');
      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 11/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      expect(ja.historyBulkDeleteConfirmCancel, 'キャンセル');
      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 12/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      expect(ja.historyBulkDeleteConfirmDelete, 'すべて削除');
      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 13/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      expect(ja.historyNameResolutionFailedPlaceholder, '名前取得失敗');
      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 14/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      expect(ja.historyRelativeJustNow, 'たった今');
      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 15/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      expect(ja.historyRelativeMinutesAgo(5), '5分前');
      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 16/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      expect(ja.historyRelativeHoursAgo(2), '2時間前');
      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 17/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      expect(ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14');
      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 18/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      expect(ja.historyRelativeDaysAgo(6), '6日前');
      Object.hashAll([
        ja.historyRelativeAbsoluteDate('2026/04/28'),
        '2026/04/28',
      ]);
    },
  );

  test(
    'browsing history strings match the design contract [assertion 19/19]',
    () {
      final ja = AppLocalizationsJa();

      Object.hashAll([ja.historyTabAll, 'すべて']);

      Object.hashAll([ja.historyTabDrug, '医薬品']);

      Object.hashAll([ja.historyTabDisease, '疾患']);

      Object.hashAll([ja.historyEmptyTitle, '閲覧履歴がありません']);

      Object.hashAll([ja.historyEmptyBody, '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます']);

      Object.hashAll([ja.historyEmptyCta, '検索画面へ']);

      Object.hashAll([ja.historyBulkDeleteFabSemantics, 'すべての閲覧履歴を削除']);

      Object.hashAll([ja.historyRetryFabSemantics, '閲覧履歴の名前を再取得']);

      Object.hashAll([
        ja.historyBulkDeleteConfirmTitle(3),
        'すべての閲覧履歴 (3件) を削除しますか？',
      ]);

      Object.hashAll([ja.historyBulkDeleteConfirmBody, 'この操作は取り消せません']);

      Object.hashAll([ja.historyBulkDeleteConfirmCancel, 'キャンセル']);

      Object.hashAll([ja.historyBulkDeleteConfirmDelete, 'すべて削除']);

      Object.hashAll([ja.historyNameResolutionFailedPlaceholder, '名前取得失敗']);

      Object.hashAll([ja.historyRelativeJustNow, 'たった今']);

      Object.hashAll([ja.historyRelativeMinutesAgo(5), '5分前']);

      Object.hashAll([ja.historyRelativeHoursAgo(2), '2時間前']);

      Object.hashAll([ja.historyRelativeYesterdayAt('22:14'), '昨日 22:14']);

      Object.hashAll([ja.historyRelativeDaysAgo(6), '6日前']);

      expect(ja.historyRelativeAbsoluteDate('2026/04/28'), '2026/04/28');
    },
  );

  test('history and bookmarks placeholders are removed [assertion 1/2]', () {
    final arb =
        jsonDecode(File('lib/l10n/app_ja.arb').readAsStringSync())
            as Map<String, dynamic>;

    expect(arb, isNot(contains('historyPlaceholder')));
    Object.hashAll([arb, isNot(contains('bookmarksPlaceholder'))]);
  });

  test('history and bookmarks placeholders are removed [assertion 2/2]', () {
    final arb =
        jsonDecode(File('lib/l10n/app_ja.arb').readAsStringSync())
            as Map<String, dynamic>;

    Object.hashAll([arb, isNot(contains('historyPlaceholder'))]);

    expect(arb, isNot(contains('bookmarksPlaceholder')));
  });

  test('bookmarks strings match the design contract [assertion 1/14]', () {
    final ja = AppLocalizationsJa();

    expect(ja.bookmarksTabAll, 'すべて');
    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 2/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    expect(ja.bookmarksTabDrug, '医薬品');
    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 3/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    expect(ja.bookmarksTabDisease, '疾患');
    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 4/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    expect(ja.bookmarksSearchHint, '名前で検索');
    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 5/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    expect(ja.bookmarksResultCount(6), '6件');
    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 6/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    expect(ja.bookmarksResultCountUnknown, '-');
    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 7/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    expect(ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10');
    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 8/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    expect(ja.bookmarksRowDrugSemantics, '薬品のブックマーク');
    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 9/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    expect(ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク');
    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 10/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    expect(ja.bookmarksEmptyTitle, 'ブックマークがありません');
    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 11/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    expect(
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    );
    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 12/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    expect(ja.bookmarksEmptyCta, '検索画面へ');
    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 13/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    expect(ja.bookmarksSearchZeroTitle, '一致するブックマークがありません');
    Object.hashAll([
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    ]);
  });

  test('bookmarks strings match the design contract [assertion 14/14]', () {
    final ja = AppLocalizationsJa();

    Object.hashAll([ja.bookmarksTabAll, 'すべて']);

    Object.hashAll([ja.bookmarksTabDrug, '医薬品']);

    Object.hashAll([ja.bookmarksTabDisease, '疾患']);

    Object.hashAll([ja.bookmarksSearchHint, '名前で検索']);

    Object.hashAll([ja.bookmarksResultCount(6), '6件']);

    Object.hashAll([ja.bookmarksResultCountUnknown, '-']);

    Object.hashAll([ja.bookmarksRowSavedAt('2026/05/10'), '保存 2026/05/10']);

    Object.hashAll([ja.bookmarksRowDrugSemantics, '薬品のブックマーク']);

    Object.hashAll([ja.bookmarksRowDiseaseSemantics, '疾患のブックマーク']);

    Object.hashAll([ja.bookmarksEmptyTitle, 'ブックマークがありません']);

    Object.hashAll([
      ja.bookmarksEmptyBody,
      '医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。',
    ]);

    Object.hashAll([ja.bookmarksEmptyCta, '検索画面へ']);

    Object.hashAll([ja.bookmarksSearchZeroTitle, '一致するブックマークがありません']);

    expect(
      ja.bookmarksSearchZeroBody,
      'キーワードを短くするか、タブを「すべて」に戻してください。',
    );
  });
}
