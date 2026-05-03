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
  String get errorNetwork => 'ネットワークエラーが発生しました';

  @override
  String get errorUnknown => '不明なエラーが発生しました';
}
