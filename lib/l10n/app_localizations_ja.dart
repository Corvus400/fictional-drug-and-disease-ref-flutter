// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '医薬品・疾患リファレンス';

  @override
  String get tabSearch => '検索';

  @override
  String get tabBookmarks => 'ブックマーク';

  @override
  String get tabHistory => '閲覧履歴';

  @override
  String get tabCalc => '計算ツール';

  @override
  String get searchPlaceholder => '検索画面（プレースホルダー）';

  @override
  String get bookmarksPlaceholder => 'ブックマーク画面（プレースホルダー）';

  @override
  String get historyPlaceholder => '閲覧履歴画面（プレースホルダー）';

  @override
  String get calcPlaceholder => '計算ツール画面（プレースホルダー）';

  @override
  String get drugDetailTitle => '医薬品詳細';

  @override
  String get diseaseDetailTitle => '疾患詳細';

  @override
  String detailId(String id) {
    return 'ID: $id';
  }

  @override
  String get openDrugDetail => '医薬品詳細を開く';

  @override
  String get openDiseaseDetail => '疾患詳細を開く';

  @override
  String get healthLoading => 'ヘルスチェック中';

  @override
  String healthValue(String status) {
    return 'Health: $status';
  }

  @override
  String healthError(String message) {
    return 'ERROR: $message';
  }

  @override
  String get searchTabDrugs => '医薬品';

  @override
  String get searchTabDiseases => '疾患';

  @override
  String get searchHintDrugs => '医薬品名・YJ・ATC コード';

  @override
  String get searchHintDiseases => '疾患名・症状・ICD-10';

  @override
  String get searchActionSearch => '検索';

  @override
  String get searchActionCancel => 'キャンセル';

  @override
  String get searchHistoryTitle => '検索履歴';

  @override
  String get searchHistoryClear => 'すべて削除';

  @override
  String get searchHistoryClearConfirmTitle => '検索履歴を削除しますか？';

  @override
  String get searchHistoryClearConfirmDelete => '削除';

  @override
  String searchToolbarTotal(int count) {
    return '合計 $count 件';
  }

  @override
  String get searchToolbarLoadMore => 'さらに読み込む';

  @override
  String get searchEmptyResultTitle => '該当する結果がありません';

  @override
  String get searchEmptyResetFilter => '条件をリセット';

  @override
  String get searchEmptyRemoveOneFilter => '条件を1つ外す';

  @override
  String get searchEmptyChangeMatchToPartial => '部分一致に変更';

  @override
  String get searchErrorTitle => '通信エラー — もう一度';

  @override
  String get searchErrorRetry => '再試行';

  @override
  String get searchFilterTitle => '絞り込み';

  @override
  String get searchFilterApply => '結果を見る';

  @override
  String get searchSortTitle => '並び替え';

  @override
  String get searchSortByRevised => '更新日 (新しい順)';

  @override
  String get searchSortByBrandKana => 'ブランド名カナ';

  @override
  String get searchSortByAtcCode => 'ATC コード';

  @override
  String get searchSortByTherapeuticCategory => '薬効分類名';

  @override
  String get errorNetwork => 'ネットワークエラーが発生しました';

  @override
  String get errorUnknown => '不明なエラーが発生しました';

  @override
  String get errNetwork => 'ネットワークに接続できません';

  @override
  String get errNetworkRetry => '再試行';

  @override
  String get errServer => 'サーバーエラーが発生しました。しばらく経ってから再試行してください';

  @override
  String errApi4xx(String message) {
    return 'エラーが発生しました: $message';
  }

  @override
  String get errApiNotFound => 'お探しの情報が見つかりませんでした';

  @override
  String get errApiBadRequest => 'リクエストに不備があります';

  @override
  String get errApiInvalidCategory => '指定されたカテゴリが正しくありません';

  @override
  String get errParse => 'データを読み込めません';

  @override
  String get errStorageUnique => '既に登録されています';

  @override
  String get errStorageCheck => '値が許容範囲外です';

  @override
  String get errStorageGeneric => 'データの保存に失敗しました';

  @override
  String get errUnknown => '予期しないエラーが発生しました';

  @override
  String get errBookmarkOfflineBanner => 'オフライン表示中。最新情報は接続時に取得されます';

  @override
  String get errGoBack => '戻る';
}
