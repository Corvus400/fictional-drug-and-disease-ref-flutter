import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ja')];

  /// アプリのタイトル
  ///
  /// In ja, this message translates to:
  /// **'医薬品・疾患リファレンス'**
  String get appTitle;

  /// No description provided for @tabSearch.
  ///
  /// In ja, this message translates to:
  /// **'検索'**
  String get tabSearch;

  /// No description provided for @tabBookmarks.
  ///
  /// In ja, this message translates to:
  /// **'ブックマーク'**
  String get tabBookmarks;

  /// No description provided for @tabHistory.
  ///
  /// In ja, this message translates to:
  /// **'閲覧履歴'**
  String get tabHistory;

  /// No description provided for @tabCalc.
  ///
  /// In ja, this message translates to:
  /// **'計算ツール'**
  String get tabCalc;

  /// No description provided for @searchPlaceholder.
  ///
  /// In ja, this message translates to:
  /// **'検索画面（プレースホルダー）'**
  String get searchPlaceholder;

  /// No description provided for @bookmarksPlaceholder.
  ///
  /// In ja, this message translates to:
  /// **'ブックマーク画面（プレースホルダー）'**
  String get bookmarksPlaceholder;

  /// No description provided for @historyPlaceholder.
  ///
  /// In ja, this message translates to:
  /// **'閲覧履歴画面（プレースホルダー）'**
  String get historyPlaceholder;

  /// No description provided for @calcPlaceholder.
  ///
  /// In ja, this message translates to:
  /// **'計算ツール画面（プレースホルダー）'**
  String get calcPlaceholder;

  /// No description provided for @drugDetailTitle.
  ///
  /// In ja, this message translates to:
  /// **'医薬品詳細'**
  String get drugDetailTitle;

  /// No description provided for @diseaseDetailTitle.
  ///
  /// In ja, this message translates to:
  /// **'疾患詳細'**
  String get diseaseDetailTitle;

  /// No description provided for @detailId.
  ///
  /// In ja, this message translates to:
  /// **'ID: {id}'**
  String detailId(String id);

  /// No description provided for @openDrugDetail.
  ///
  /// In ja, this message translates to:
  /// **'医薬品詳細を開く'**
  String get openDrugDetail;

  /// No description provided for @openDiseaseDetail.
  ///
  /// In ja, this message translates to:
  /// **'疾患詳細を開く'**
  String get openDiseaseDetail;

  /// No description provided for @healthLoading.
  ///
  /// In ja, this message translates to:
  /// **'ヘルスチェック中'**
  String get healthLoading;

  /// No description provided for @healthValue.
  ///
  /// In ja, this message translates to:
  /// **'Health: {status}'**
  String healthValue(String status);

  /// No description provided for @healthError.
  ///
  /// In ja, this message translates to:
  /// **'ERROR: {message}'**
  String healthError(String message);

  /// No description provided for @searchTabDrugs.
  ///
  /// In ja, this message translates to:
  /// **'医薬品'**
  String get searchTabDrugs;

  /// No description provided for @searchTabDiseases.
  ///
  /// In ja, this message translates to:
  /// **'疾患'**
  String get searchTabDiseases;

  /// No description provided for @searchHintDrugs.
  ///
  /// In ja, this message translates to:
  /// **'医薬品名・YJ・ATC コード'**
  String get searchHintDrugs;

  /// No description provided for @searchHintDiseases.
  ///
  /// In ja, this message translates to:
  /// **'疾患名・症状・ICD-10'**
  String get searchHintDiseases;

  /// No description provided for @searchActionSearch.
  ///
  /// In ja, this message translates to:
  /// **'検索'**
  String get searchActionSearch;

  /// No description provided for @searchActionCancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get searchActionCancel;

  /// No description provided for @searchHistoryTitle.
  ///
  /// In ja, this message translates to:
  /// **'検索履歴'**
  String get searchHistoryTitle;

  /// No description provided for @searchHistoryClear.
  ///
  /// In ja, this message translates to:
  /// **'すべて削除'**
  String get searchHistoryClear;

  /// No description provided for @searchHistoryClearConfirmTitle.
  ///
  /// In ja, this message translates to:
  /// **'検索履歴を削除しますか？'**
  String get searchHistoryClearConfirmTitle;

  /// No description provided for @searchHistoryClearConfirmDelete.
  ///
  /// In ja, this message translates to:
  /// **'削除'**
  String get searchHistoryClearConfirmDelete;

  /// No description provided for @searchToolbarTotal.
  ///
  /// In ja, this message translates to:
  /// **'合計 {count} 件'**
  String searchToolbarTotal(int count);

  /// No description provided for @searchToolbarLoadMore.
  ///
  /// In ja, this message translates to:
  /// **'さらに読み込む'**
  String get searchToolbarLoadMore;

  /// No description provided for @searchEmptyResultTitle.
  ///
  /// In ja, this message translates to:
  /// **'該当する結果がありません'**
  String get searchEmptyResultTitle;

  /// No description provided for @searchEmptyResetFilter.
  ///
  /// In ja, this message translates to:
  /// **'条件をリセット'**
  String get searchEmptyResetFilter;

  /// No description provided for @searchEmptyRemoveOneFilter.
  ///
  /// In ja, this message translates to:
  /// **'条件を1つ外す'**
  String get searchEmptyRemoveOneFilter;

  /// No description provided for @searchEmptyChangeMatchToPartial.
  ///
  /// In ja, this message translates to:
  /// **'部分一致に変更'**
  String get searchEmptyChangeMatchToPartial;

  /// No description provided for @searchErrorTitle.
  ///
  /// In ja, this message translates to:
  /// **'通信エラー — もう一度'**
  String get searchErrorTitle;

  /// No description provided for @searchErrorRetry.
  ///
  /// In ja, this message translates to:
  /// **'再試行'**
  String get searchErrorRetry;

  /// No description provided for @searchFilterTitle.
  ///
  /// In ja, this message translates to:
  /// **'絞り込み'**
  String get searchFilterTitle;

  /// No description provided for @searchFilterApply.
  ///
  /// In ja, this message translates to:
  /// **'結果を見る'**
  String get searchFilterApply;

  /// No description provided for @searchSortTitle.
  ///
  /// In ja, this message translates to:
  /// **'並び替え'**
  String get searchSortTitle;

  /// No description provided for @searchSortByRevised.
  ///
  /// In ja, this message translates to:
  /// **'更新日 (新しい順)'**
  String get searchSortByRevised;

  /// No description provided for @searchSortByBrandKana.
  ///
  /// In ja, this message translates to:
  /// **'ブランド名カナ'**
  String get searchSortByBrandKana;

  /// No description provided for @searchSortByAtcCode.
  ///
  /// In ja, this message translates to:
  /// **'ATC コード'**
  String get searchSortByAtcCode;

  /// No description provided for @searchSortByTherapeuticCategory.
  ///
  /// In ja, this message translates to:
  /// **'薬効分類名'**
  String get searchSortByTherapeuticCategory;

  /// No description provided for @errorNetwork.
  ///
  /// In ja, this message translates to:
  /// **'ネットワークエラーが発生しました'**
  String get errorNetwork;

  /// No description provided for @errorUnknown.
  ///
  /// In ja, this message translates to:
  /// **'不明なエラーが発生しました'**
  String get errorUnknown;

  /// No description provided for @errNetwork.
  ///
  /// In ja, this message translates to:
  /// **'ネットワークに接続できません'**
  String get errNetwork;

  /// No description provided for @errNetworkRetry.
  ///
  /// In ja, this message translates to:
  /// **'再試行'**
  String get errNetworkRetry;

  /// No description provided for @errServer.
  ///
  /// In ja, this message translates to:
  /// **'サーバーエラーが発生しました。しばらく経ってから再試行してください'**
  String get errServer;

  /// No description provided for @errApi4xx.
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました: {message}'**
  String errApi4xx(String message);

  /// No description provided for @errApiNotFound.
  ///
  /// In ja, this message translates to:
  /// **'お探しの情報が見つかりませんでした'**
  String get errApiNotFound;

  /// No description provided for @errApiBadRequest.
  ///
  /// In ja, this message translates to:
  /// **'リクエストに不備があります'**
  String get errApiBadRequest;

  /// No description provided for @errApiInvalidCategory.
  ///
  /// In ja, this message translates to:
  /// **'指定されたカテゴリが正しくありません'**
  String get errApiInvalidCategory;

  /// No description provided for @errParse.
  ///
  /// In ja, this message translates to:
  /// **'データを読み込めません'**
  String get errParse;

  /// No description provided for @errStorageUnique.
  ///
  /// In ja, this message translates to:
  /// **'既に登録されています'**
  String get errStorageUnique;

  /// No description provided for @errStorageCheck.
  ///
  /// In ja, this message translates to:
  /// **'値が許容範囲外です'**
  String get errStorageCheck;

  /// No description provided for @errStorageGeneric.
  ///
  /// In ja, this message translates to:
  /// **'データの保存に失敗しました'**
  String get errStorageGeneric;

  /// No description provided for @errUnknown.
  ///
  /// In ja, this message translates to:
  /// **'予期しないエラーが発生しました'**
  String get errUnknown;

  /// No description provided for @errBookmarkOfflineBanner.
  ///
  /// In ja, this message translates to:
  /// **'オフライン表示中。最新情報は接続時に取得されます'**
  String get errBookmarkOfflineBanner;

  /// No description provided for @errGoBack.
  ///
  /// In ja, this message translates to:
  /// **'戻る'**
  String get errGoBack;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
