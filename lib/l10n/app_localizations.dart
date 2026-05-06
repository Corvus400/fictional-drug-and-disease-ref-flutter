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

  /// No description provided for @searchHistoryEmptyTitle.
  ///
  /// In ja, this message translates to:
  /// **'検索履歴はまだありません'**
  String get searchHistoryEmptyTitle;

  /// No description provided for @searchHistoryEmptyDescription.
  ///
  /// In ja, this message translates to:
  /// **'検索すると履歴が最大 5 件まで残ります。\n履歴は端末内にのみ保存されます。'**
  String get searchHistoryEmptyDescription;

  /// No description provided for @searchHistoryClear.
  ///
  /// In ja, this message translates to:
  /// **'すべて消す'**
  String get searchHistoryClear;

  /// No description provided for @searchHistoryPrivacyNote.
  ///
  /// In ja, this message translates to:
  /// **'最新 5 件まで表示。履歴は端末内にのみ保存されます'**
  String get searchHistoryPrivacyNote;

  /// No description provided for @searchHistoryFilterCount.
  ///
  /// In ja, this message translates to:
  /// **'絞り込み +{count}'**
  String searchHistoryFilterCount(int count);

  /// No description provided for @searchHistoryRxBadge.
  ///
  /// In ja, this message translates to:
  /// **'Rx'**
  String get searchHistoryRxBadge;

  /// No description provided for @searchHistoryDxBadge.
  ///
  /// In ja, this message translates to:
  /// **'Dx'**
  String get searchHistoryDxBadge;

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

  /// No description provided for @searchToolbarApplied.
  ///
  /// In ja, this message translates to:
  /// **'適用中'**
  String get searchToolbarApplied;

  /// No description provided for @searchToolbarLoadMore.
  ///
  /// In ja, this message translates to:
  /// **'さらに読み込む'**
  String get searchToolbarLoadMore;

  /// No description provided for @searchToolbarLoadMoreWithProgress.
  ///
  /// In ja, this message translates to:
  /// **'さらに読み込む · {currentPage} / {totalPages}'**
  String searchToolbarLoadMoreWithProgress(int currentPage, int totalPages);

  /// No description provided for @searchEmptyResultTitle.
  ///
  /// In ja, this message translates to:
  /// **'該当する結果がありません'**
  String get searchEmptyResultTitle;

  /// No description provided for @searchEmptyResultSubtitle.
  ///
  /// In ja, this message translates to:
  /// **'検索キーワードや絞り込みを\n見直してください。'**
  String get searchEmptyResultSubtitle;

  /// No description provided for @searchEmptyResetFilter.
  ///
  /// In ja, this message translates to:
  /// **'条件をリセット'**
  String get searchEmptyResetFilter;

  /// No description provided for @searchEmptyRemoveOneFilter.
  ///
  /// In ja, this message translates to:
  /// **'絞り込みを 1 つずつ外す'**
  String get searchEmptyRemoveOneFilter;

  /// No description provided for @searchErrorTitle.
  ///
  /// In ja, this message translates to:
  /// **'通信エラー — もう一度'**
  String get searchErrorTitle;

  /// No description provided for @searchErrorBody.
  ///
  /// In ja, this message translates to:
  /// **'サーバーに接続できませんでした。\n通信環境を確認してから再試行してください。'**
  String get searchErrorBody;

  /// No description provided for @searchErrorTitleNetwork.
  ///
  /// In ja, this message translates to:
  /// **'通信エラー — もう一度'**
  String get searchErrorTitleNetwork;

  /// No description provided for @searchErrorBodyNetwork.
  ///
  /// In ja, this message translates to:
  /// **'もう一度試してください。'**
  String get searchErrorBodyNetwork;

  /// No description provided for @searchErrorTitleServer.
  ///
  /// In ja, this message translates to:
  /// **'サーバーエラー'**
  String get searchErrorTitleServer;

  /// No description provided for @searchErrorBodyServer.
  ///
  /// In ja, this message translates to:
  /// **'しばらく経ってから再試行してください。'**
  String get searchErrorBodyServer;

  /// No description provided for @searchErrorTitleBusiness.
  ///
  /// In ja, this message translates to:
  /// **'条件に問題があります'**
  String get searchErrorTitleBusiness;

  /// No description provided for @searchErrorBodyBusiness.
  ///
  /// In ja, this message translates to:
  /// **'指定された条件をご確認ください。'**
  String get searchErrorBodyBusiness;

  /// No description provided for @searchErrorTitleParse.
  ///
  /// In ja, this message translates to:
  /// **'データを読み込めません'**
  String get searchErrorTitleParse;

  /// No description provided for @searchErrorBodyParse.
  ///
  /// In ja, this message translates to:
  /// **'{message}'**
  String searchErrorBodyParse(Object message);

  /// No description provided for @searchErrorTitleStorage.
  ///
  /// In ja, this message translates to:
  /// **'保存に失敗しました'**
  String get searchErrorTitleStorage;

  /// No description provided for @searchErrorBodyStorage.
  ///
  /// In ja, this message translates to:
  /// **'{message}'**
  String searchErrorBodyStorage(Object message);

  /// No description provided for @searchErrorTitleAuth.
  ///
  /// In ja, this message translates to:
  /// **'権限がありません'**
  String get searchErrorTitleAuth;

  /// No description provided for @searchErrorBodyAuth.
  ///
  /// In ja, this message translates to:
  /// **'{message}'**
  String searchErrorBodyAuth(Object message);

  /// No description provided for @searchErrorTitleUnknown.
  ///
  /// In ja, this message translates to:
  /// **'予期しないエラー'**
  String get searchErrorTitleUnknown;

  /// No description provided for @searchErrorBodyUnknown.
  ///
  /// In ja, this message translates to:
  /// **'{message}'**
  String searchErrorBodyUnknown(Object message);

  /// No description provided for @searchErrorRetry.
  ///
  /// In ja, this message translates to:
  /// **'再試行'**
  String get searchErrorRetry;

  /// No description provided for @searchErrorDiagnosticsType.
  ///
  /// In ja, this message translates to:
  /// **'Type: {type}'**
  String searchErrorDiagnosticsType(Object type);

  /// No description provided for @searchErrorDiagnosticsStatus.
  ///
  /// In ja, this message translates to:
  /// **'Status: {statusCode}'**
  String searchErrorDiagnosticsStatus(int statusCode);

  /// No description provided for @searchErrorDiagnosticsCode.
  ///
  /// In ja, this message translates to:
  /// **'Code: {code}'**
  String searchErrorDiagnosticsCode(Object code);

  /// No description provided for @searchErrorDiagnosticsMessage.
  ///
  /// In ja, this message translates to:
  /// **'Message: {message}'**
  String searchErrorDiagnosticsMessage(Object message);

  /// No description provided for @searchErrorDiagnosticsDetails.
  ///
  /// In ja, this message translates to:
  /// **'Details: {details}'**
  String searchErrorDiagnosticsDetails(Object details);

  /// No description provided for @searchErrorDiagnosticsStorageKind.
  ///
  /// In ja, this message translates to:
  /// **'Storage kind: {kind}'**
  String searchErrorDiagnosticsStorageKind(Object kind);

  /// No description provided for @searchFilterTitle.
  ///
  /// In ja, this message translates to:
  /// **'絞り込み'**
  String get searchFilterTitle;

  /// No description provided for @searchFilterTitleForTarget.
  ///
  /// In ja, this message translates to:
  /// **'絞り込み（{target}）'**
  String searchFilterTitleForTarget(String target);

  /// No description provided for @searchFilterApply.
  ///
  /// In ja, this message translates to:
  /// **'結果を見る'**
  String get searchFilterApply;

  /// No description provided for @searchFilterApplyWithCount.
  ///
  /// In ja, this message translates to:
  /// **'結果を見る ({count} 件)'**
  String searchFilterApplyWithCount(int count);

  /// No description provided for @searchFilterReset.
  ///
  /// In ja, this message translates to:
  /// **'リセット'**
  String get searchFilterReset;

  /// No description provided for @searchFilterAxisPolicy.
  ///
  /// In ja, this message translates to:
  /// **'{count} 軸 · 軸内 OR / 軸間 AND'**
  String searchFilterAxisPolicy(int count);

  /// No description provided for @searchFilterSummaryAll.
  ///
  /// In ja, this message translates to:
  /// **'すべて'**
  String get searchFilterSummaryAll;

  /// No description provided for @searchFilterSummaryUnspecified.
  ///
  /// In ja, this message translates to:
  /// **'未指定'**
  String get searchFilterSummaryUnspecified;

  /// No description provided for @searchFilterHintMultiValue.
  ///
  /// In ja, this message translates to:
  /// **'{count} 値・複数選択 OR'**
  String searchFilterHintMultiValue(int count);

  /// No description provided for @searchFilterHintSingleValue.
  ///
  /// In ja, this message translates to:
  /// **'{count} 値・単一選択'**
  String searchFilterHintSingleValue(int count);

  /// No description provided for @searchFilterHintBool.
  ///
  /// In ja, this message translates to:
  /// **'bool'**
  String get searchFilterHintBool;

  /// No description provided for @searchFilterHintPartialMatch.
  ///
  /// In ja, this message translates to:
  /// **'部分一致'**
  String get searchFilterHintPartialMatch;

  /// No description provided for @searchFilterHintHierarchy.
  ///
  /// In ja, this message translates to:
  /// **'階層選択'**
  String get searchFilterHintHierarchy;

  /// No description provided for @searchFilterHintDrillIn.
  ///
  /// In ja, this message translates to:
  /// **'{count} 章・ドリルイン'**
  String searchFilterHintDrillIn(int count);

  /// No description provided for @searchFilterDrugRegulatoryClass.
  ///
  /// In ja, this message translates to:
  /// **'規制区分'**
  String get searchFilterDrugRegulatoryClass;

  /// No description provided for @searchFilterDrugDosageForm.
  ///
  /// In ja, this message translates to:
  /// **'剤形'**
  String get searchFilterDrugDosageForm;

  /// No description provided for @searchFilterDrugRoute.
  ///
  /// In ja, this message translates to:
  /// **'投与経路'**
  String get searchFilterDrugRoute;

  /// No description provided for @searchFilterDrugAtc.
  ///
  /// In ja, this message translates to:
  /// **'ATC 第 1 階層'**
  String get searchFilterDrugAtc;

  /// No description provided for @searchFilterDrugTherapeuticCategory.
  ///
  /// In ja, this message translates to:
  /// **'薬効分類'**
  String get searchFilterDrugTherapeuticCategory;

  /// No description provided for @searchFilterDrugAdverseReactionKeyword.
  ///
  /// In ja, this message translates to:
  /// **'副作用キーワード'**
  String get searchFilterDrugAdverseReactionKeyword;

  /// No description provided for @searchFilterDrugPrecautionCategory.
  ///
  /// In ja, this message translates to:
  /// **'患者背景'**
  String get searchFilterDrugPrecautionCategory;

  /// No description provided for @searchFilterDiseaseIcd10Chapter.
  ///
  /// In ja, this message translates to:
  /// **'ICD-10 章'**
  String get searchFilterDiseaseIcd10Chapter;

  /// No description provided for @searchFilterDiseaseDepartment.
  ///
  /// In ja, this message translates to:
  /// **'診療科'**
  String get searchFilterDiseaseDepartment;

  /// No description provided for @searchFilterDiseaseChronicity.
  ///
  /// In ja, this message translates to:
  /// **'慢性度'**
  String get searchFilterDiseaseChronicity;

  /// No description provided for @searchFilterDiseaseInfectious.
  ///
  /// In ja, this message translates to:
  /// **'感染性'**
  String get searchFilterDiseaseInfectious;

  /// No description provided for @searchFilterDiseaseSymptomKeyword.
  ///
  /// In ja, this message translates to:
  /// **'症状キーワード'**
  String get searchFilterDiseaseSymptomKeyword;

  /// No description provided for @searchFilterDiseaseOnsetPattern.
  ///
  /// In ja, this message translates to:
  /// **'発症パターン'**
  String get searchFilterDiseaseOnsetPattern;

  /// No description provided for @searchFilterDiseaseExamCategory.
  ///
  /// In ja, this message translates to:
  /// **'検査区分'**
  String get searchFilterDiseaseExamCategory;

  /// No description provided for @searchFilterDiseaseHasPharmacologicalTreatment.
  ///
  /// In ja, this message translates to:
  /// **'薬物治療あり'**
  String get searchFilterDiseaseHasPharmacologicalTreatment;

  /// No description provided for @searchFilterDiseaseHasSeverityGrading.
  ///
  /// In ja, this message translates to:
  /// **'重症度評価あり'**
  String get searchFilterDiseaseHasSeverityGrading;

  /// No description provided for @searchDiseasePharmacologicalTreatmentTrue.
  ///
  /// In ja, this message translates to:
  /// **'薬物治療あり'**
  String get searchDiseasePharmacologicalTreatmentTrue;

  /// No description provided for @searchDiseasePharmacologicalTreatmentFalse.
  ///
  /// In ja, this message translates to:
  /// **'薬物治療なし'**
  String get searchDiseasePharmacologicalTreatmentFalse;

  /// No description provided for @searchDiseaseSeverityGradingTrue.
  ///
  /// In ja, this message translates to:
  /// **'重症度評価あり'**
  String get searchDiseaseSeverityGradingTrue;

  /// No description provided for @searchDiseaseSeverityGradingFalse.
  ///
  /// In ja, this message translates to:
  /// **'重症度評価なし'**
  String get searchDiseaseSeverityGradingFalse;

  /// No description provided for @searchSortTitle.
  ///
  /// In ja, this message translates to:
  /// **'並び替え'**
  String get searchSortTitle;

  /// No description provided for @searchLoadingTotalPlaceholder.
  ///
  /// In ja, this message translates to:
  /// **'合計 — 件'**
  String get searchLoadingTotalPlaceholder;

  /// No description provided for @searchLoadingCaption.
  ///
  /// In ja, this message translates to:
  /// **'検索中…'**
  String get searchLoadingCaption;

  /// No description provided for @searchSortByRevised.
  ///
  /// In ja, this message translates to:
  /// **'更新日(新しい順)'**
  String get searchSortByRevised;

  /// No description provided for @searchSortDiseaseRevisedAt.
  ///
  /// In ja, this message translates to:
  /// **'改訂日'**
  String get searchSortDiseaseRevisedAt;

  /// No description provided for @searchSortDiseaseName.
  ///
  /// In ja, this message translates to:
  /// **'名称'**
  String get searchSortDiseaseName;

  /// No description provided for @searchSortDiseaseIcd10.
  ///
  /// In ja, this message translates to:
  /// **'ICD-10'**
  String get searchSortDiseaseIcd10;

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

  /// No description provided for @searchDrugRegulatoryPoison.
  ///
  /// In ja, this message translates to:
  /// **'毒薬'**
  String get searchDrugRegulatoryPoison;

  /// No description provided for @searchDrugRegulatoryPotent.
  ///
  /// In ja, this message translates to:
  /// **'劇薬'**
  String get searchDrugRegulatoryPotent;

  /// No description provided for @searchDrugRegulatoryPrescriptionRequired.
  ///
  /// In ja, this message translates to:
  /// **'処方箋医薬品'**
  String get searchDrugRegulatoryPrescriptionRequired;

  /// No description provided for @searchDrugRegulatoryOrdinary.
  ///
  /// In ja, this message translates to:
  /// **'普通薬'**
  String get searchDrugRegulatoryOrdinary;

  /// No description provided for @searchDrugRegulatoryPsychotropic1.
  ///
  /// In ja, this message translates to:
  /// **'向精神薬第1種'**
  String get searchDrugRegulatoryPsychotropic1;

  /// No description provided for @searchDrugRegulatoryPsychotropic2.
  ///
  /// In ja, this message translates to:
  /// **'向精神薬第2種'**
  String get searchDrugRegulatoryPsychotropic2;

  /// No description provided for @searchDrugRegulatoryPsychotropic3.
  ///
  /// In ja, this message translates to:
  /// **'向精神薬第3種'**
  String get searchDrugRegulatoryPsychotropic3;

  /// No description provided for @searchDrugRegulatoryNarcotic.
  ///
  /// In ja, this message translates to:
  /// **'麻薬'**
  String get searchDrugRegulatoryNarcotic;

  /// No description provided for @searchDrugRegulatoryStimulantPrecursor.
  ///
  /// In ja, this message translates to:
  /// **'覚醒剤原料'**
  String get searchDrugRegulatoryStimulantPrecursor;

  /// No description provided for @searchDrugRegulatoryBiological.
  ///
  /// In ja, this message translates to:
  /// **'生物由来製品'**
  String get searchDrugRegulatoryBiological;

  /// No description provided for @searchDrugRegulatorySpecifiedBiological.
  ///
  /// In ja, this message translates to:
  /// **'特定生物由来製品'**
  String get searchDrugRegulatorySpecifiedBiological;

  /// No description provided for @searchDrugDosageFormTablet.
  ///
  /// In ja, this message translates to:
  /// **'錠剤'**
  String get searchDrugDosageFormTablet;

  /// No description provided for @searchDrugDosageFormCapsule.
  ///
  /// In ja, this message translates to:
  /// **'カプセル'**
  String get searchDrugDosageFormCapsule;

  /// No description provided for @searchDrugDosageFormPowder.
  ///
  /// In ja, this message translates to:
  /// **'散剤'**
  String get searchDrugDosageFormPowder;

  /// No description provided for @searchDrugDosageFormGranule.
  ///
  /// In ja, this message translates to:
  /// **'顆粒剤'**
  String get searchDrugDosageFormGranule;

  /// No description provided for @searchDrugDosageFormLiquid.
  ///
  /// In ja, this message translates to:
  /// **'液剤'**
  String get searchDrugDosageFormLiquid;

  /// No description provided for @searchDrugDosageFormInjection.
  ///
  /// In ja, this message translates to:
  /// **'注射剤'**
  String get searchDrugDosageFormInjection;

  /// No description provided for @searchDrugDosageFormOintment.
  ///
  /// In ja, this message translates to:
  /// **'軟膏'**
  String get searchDrugDosageFormOintment;

  /// No description provided for @searchDrugDosageFormCream.
  ///
  /// In ja, this message translates to:
  /// **'クリーム'**
  String get searchDrugDosageFormCream;

  /// No description provided for @searchDrugDosageFormPatch.
  ///
  /// In ja, this message translates to:
  /// **'貼付剤'**
  String get searchDrugDosageFormPatch;

  /// No description provided for @searchDrugDosageFormEyeDrops.
  ///
  /// In ja, this message translates to:
  /// **'点眼剤'**
  String get searchDrugDosageFormEyeDrops;

  /// No description provided for @searchDrugDosageFormSuppository.
  ///
  /// In ja, this message translates to:
  /// **'坐剤'**
  String get searchDrugDosageFormSuppository;

  /// No description provided for @searchDrugDosageFormInhaler.
  ///
  /// In ja, this message translates to:
  /// **'吸入剤'**
  String get searchDrugDosageFormInhaler;

  /// No description provided for @searchDrugDosageFormNasalSpray.
  ///
  /// In ja, this message translates to:
  /// **'点鼻剤'**
  String get searchDrugDosageFormNasalSpray;

  /// No description provided for @searchDrugRouteOral.
  ///
  /// In ja, this message translates to:
  /// **'経口'**
  String get searchDrugRouteOral;

  /// No description provided for @searchDrugRouteTopical.
  ///
  /// In ja, this message translates to:
  /// **'外用'**
  String get searchDrugRouteTopical;

  /// No description provided for @searchDrugRouteInjection.
  ///
  /// In ja, this message translates to:
  /// **'注射'**
  String get searchDrugRouteInjection;

  /// No description provided for @searchDrugRouteInhalation.
  ///
  /// In ja, this message translates to:
  /// **'吸入'**
  String get searchDrugRouteInhalation;

  /// No description provided for @searchDrugRouteRectal.
  ///
  /// In ja, this message translates to:
  /// **'直腸'**
  String get searchDrugRouteRectal;

  /// No description provided for @searchDrugRouteOphthalmic.
  ///
  /// In ja, this message translates to:
  /// **'眼科'**
  String get searchDrugRouteOphthalmic;

  /// No description provided for @searchDrugRouteNasal.
  ///
  /// In ja, this message translates to:
  /// **'鼻腔'**
  String get searchDrugRouteNasal;

  /// No description provided for @searchDrugRouteTransdermal.
  ///
  /// In ja, this message translates to:
  /// **'経皮'**
  String get searchDrugRouteTransdermal;

  /// No description provided for @searchDrugPrecautionComorbidity.
  ///
  /// In ja, this message translates to:
  /// **'合併症'**
  String get searchDrugPrecautionComorbidity;

  /// No description provided for @searchDrugPrecautionRenalImpairment.
  ///
  /// In ja, this message translates to:
  /// **'腎機能障害'**
  String get searchDrugPrecautionRenalImpairment;

  /// No description provided for @searchDrugPrecautionHepaticImpairment.
  ///
  /// In ja, this message translates to:
  /// **'肝機能障害'**
  String get searchDrugPrecautionHepaticImpairment;

  /// No description provided for @searchDrugPrecautionReproductivePotential.
  ///
  /// In ja, this message translates to:
  /// **'生殖能を有する患者'**
  String get searchDrugPrecautionReproductivePotential;

  /// No description provided for @searchDrugPrecautionPregnant.
  ///
  /// In ja, this message translates to:
  /// **'妊婦'**
  String get searchDrugPrecautionPregnant;

  /// No description provided for @searchDrugPrecautionLactating.
  ///
  /// In ja, this message translates to:
  /// **'授乳婦'**
  String get searchDrugPrecautionLactating;

  /// No description provided for @searchDrugPrecautionPediatric.
  ///
  /// In ja, this message translates to:
  /// **'小児等'**
  String get searchDrugPrecautionPediatric;

  /// No description provided for @searchDrugPrecautionGeriatric.
  ///
  /// In ja, this message translates to:
  /// **'高齢者'**
  String get searchDrugPrecautionGeriatric;

  /// No description provided for @searchDiseaseDepartmentInternalMedicine.
  ///
  /// In ja, this message translates to:
  /// **'内科'**
  String get searchDiseaseDepartmentInternalMedicine;

  /// No description provided for @searchDiseaseDepartmentCardiology.
  ///
  /// In ja, this message translates to:
  /// **'循環器内科'**
  String get searchDiseaseDepartmentCardiology;

  /// No description provided for @searchDiseaseDepartmentGastroenterology.
  ///
  /// In ja, this message translates to:
  /// **'消化器内科'**
  String get searchDiseaseDepartmentGastroenterology;

  /// No description provided for @searchDiseaseDepartmentEndocrinology.
  ///
  /// In ja, this message translates to:
  /// **'内分泌内科'**
  String get searchDiseaseDepartmentEndocrinology;

  /// No description provided for @searchDiseaseDepartmentNeurology.
  ///
  /// In ja, this message translates to:
  /// **'神経内科'**
  String get searchDiseaseDepartmentNeurology;

  /// No description provided for @searchDiseaseDepartmentPsychiatry.
  ///
  /// In ja, this message translates to:
  /// **'精神科'**
  String get searchDiseaseDepartmentPsychiatry;

  /// No description provided for @searchDiseaseDepartmentSurgery.
  ///
  /// In ja, this message translates to:
  /// **'外科'**
  String get searchDiseaseDepartmentSurgery;

  /// No description provided for @searchDiseaseDepartmentOrthopedics.
  ///
  /// In ja, this message translates to:
  /// **'整形外科'**
  String get searchDiseaseDepartmentOrthopedics;

  /// No description provided for @searchDiseaseDepartmentDermatology.
  ///
  /// In ja, this message translates to:
  /// **'皮膚科'**
  String get searchDiseaseDepartmentDermatology;

  /// No description provided for @searchDiseaseDepartmentOphthalmology.
  ///
  /// In ja, this message translates to:
  /// **'眼科'**
  String get searchDiseaseDepartmentOphthalmology;

  /// No description provided for @searchDiseaseDepartmentOtolaryngology.
  ///
  /// In ja, this message translates to:
  /// **'耳鼻咽喉科'**
  String get searchDiseaseDepartmentOtolaryngology;

  /// No description provided for @searchDiseaseDepartmentUrology.
  ///
  /// In ja, this message translates to:
  /// **'泌尿器科'**
  String get searchDiseaseDepartmentUrology;

  /// No description provided for @searchDiseaseDepartmentGynecology.
  ///
  /// In ja, this message translates to:
  /// **'婦人科'**
  String get searchDiseaseDepartmentGynecology;

  /// No description provided for @searchDiseaseDepartmentPediatrics.
  ///
  /// In ja, this message translates to:
  /// **'小児科'**
  String get searchDiseaseDepartmentPediatrics;

  /// No description provided for @searchDiseaseDepartmentEmergency.
  ///
  /// In ja, this message translates to:
  /// **'救急科'**
  String get searchDiseaseDepartmentEmergency;

  /// No description provided for @searchDiseaseDepartmentInfectiousDisease.
  ///
  /// In ja, this message translates to:
  /// **'感染症科'**
  String get searchDiseaseDepartmentInfectiousDisease;

  /// No description provided for @searchDiseaseChronicityAcute.
  ///
  /// In ja, this message translates to:
  /// **'急性'**
  String get searchDiseaseChronicityAcute;

  /// No description provided for @searchDiseaseChronicitySubacute.
  ///
  /// In ja, this message translates to:
  /// **'亜急性'**
  String get searchDiseaseChronicitySubacute;

  /// No description provided for @searchDiseaseChronicityChronic.
  ///
  /// In ja, this message translates to:
  /// **'慢性'**
  String get searchDiseaseChronicityChronic;

  /// No description provided for @searchDiseaseChronicityRelapsing.
  ///
  /// In ja, this message translates to:
  /// **'再発性'**
  String get searchDiseaseChronicityRelapsing;

  /// No description provided for @searchDiseaseInfectiousTrue.
  ///
  /// In ja, this message translates to:
  /// **'感染性'**
  String get searchDiseaseInfectiousTrue;

  /// No description provided for @searchDiseaseInfectiousFalse.
  ///
  /// In ja, this message translates to:
  /// **'非感染性'**
  String get searchDiseaseInfectiousFalse;

  /// No description provided for @searchDiseaseOnsetPatternAcute.
  ///
  /// In ja, this message translates to:
  /// **'急性発症'**
  String get searchDiseaseOnsetPatternAcute;

  /// No description provided for @searchDiseaseOnsetPatternSubacute.
  ///
  /// In ja, this message translates to:
  /// **'亜急性発症'**
  String get searchDiseaseOnsetPatternSubacute;

  /// No description provided for @searchDiseaseOnsetPatternChronic.
  ///
  /// In ja, this message translates to:
  /// **'慢性経過'**
  String get searchDiseaseOnsetPatternChronic;

  /// No description provided for @searchDiseaseOnsetPatternIntermittent.
  ///
  /// In ja, this message translates to:
  /// **'間欠性'**
  String get searchDiseaseOnsetPatternIntermittent;

  /// No description provided for @searchDiseaseOnsetPatternRelapsing.
  ///
  /// In ja, this message translates to:
  /// **'再発性'**
  String get searchDiseaseOnsetPatternRelapsing;

  /// No description provided for @searchDiseaseExamCategoryBloodTest.
  ///
  /// In ja, this message translates to:
  /// **'血液検査'**
  String get searchDiseaseExamCategoryBloodTest;

  /// No description provided for @searchDiseaseExamCategoryImaging.
  ///
  /// In ja, this message translates to:
  /// **'画像検査'**
  String get searchDiseaseExamCategoryImaging;

  /// No description provided for @searchDiseaseExamCategoryPhysiological.
  ///
  /// In ja, this message translates to:
  /// **'生理検査'**
  String get searchDiseaseExamCategoryPhysiological;

  /// No description provided for @searchDiseaseExamCategoryPathology.
  ///
  /// In ja, this message translates to:
  /// **'病理検査'**
  String get searchDiseaseExamCategoryPathology;

  /// No description provided for @searchDiseaseExamCategoryInterview.
  ///
  /// In ja, this message translates to:
  /// **'問診'**
  String get searchDiseaseExamCategoryInterview;

  /// No description provided for @searchDiseaseBoolTrue.
  ///
  /// In ja, this message translates to:
  /// **'あり'**
  String get searchDiseaseBoolTrue;

  /// No description provided for @searchDiseaseBoolFalse.
  ///
  /// In ja, this message translates to:
  /// **'なし'**
  String get searchDiseaseBoolFalse;

  /// No description provided for @searchDiseaseIcd10ChapterI.
  ///
  /// In ja, this message translates to:
  /// **'I 感染症および寄生虫症'**
  String get searchDiseaseIcd10ChapterI;

  /// No description provided for @searchDiseaseIcd10ChapterII.
  ///
  /// In ja, this message translates to:
  /// **'II 新生物'**
  String get searchDiseaseIcd10ChapterII;

  /// No description provided for @searchDiseaseIcd10ChapterIII.
  ///
  /// In ja, this message translates to:
  /// **'III 血液および造血器の疾患ならびに免疫機構の障害'**
  String get searchDiseaseIcd10ChapterIII;

  /// No description provided for @searchDiseaseIcd10ChapterIV.
  ///
  /// In ja, this message translates to:
  /// **'IV 内分泌、栄養および代謝疾患'**
  String get searchDiseaseIcd10ChapterIV;

  /// No description provided for @searchDiseaseIcd10ChapterV.
  ///
  /// In ja, this message translates to:
  /// **'V 精神および行動の障害'**
  String get searchDiseaseIcd10ChapterV;

  /// No description provided for @searchDiseaseIcd10ChapterVI.
  ///
  /// In ja, this message translates to:
  /// **'VI 神経系の疾患'**
  String get searchDiseaseIcd10ChapterVI;

  /// No description provided for @searchDiseaseIcd10ChapterVII.
  ///
  /// In ja, this message translates to:
  /// **'VII 眼および付属器の疾患'**
  String get searchDiseaseIcd10ChapterVII;

  /// No description provided for @searchDiseaseIcd10ChapterVIII.
  ///
  /// In ja, this message translates to:
  /// **'VIII 耳および乳様突起の疾患'**
  String get searchDiseaseIcd10ChapterVIII;

  /// No description provided for @searchDiseaseIcd10ChapterIX.
  ///
  /// In ja, this message translates to:
  /// **'IX 循環器系の疾患'**
  String get searchDiseaseIcd10ChapterIX;

  /// No description provided for @searchDiseaseIcd10ChapterX.
  ///
  /// In ja, this message translates to:
  /// **'X 呼吸器系の疾患'**
  String get searchDiseaseIcd10ChapterX;

  /// No description provided for @searchDiseaseIcd10ChapterXI.
  ///
  /// In ja, this message translates to:
  /// **'XI 消化器系の疾患'**
  String get searchDiseaseIcd10ChapterXI;

  /// No description provided for @searchDiseaseIcd10ChapterXII.
  ///
  /// In ja, this message translates to:
  /// **'XII 皮膚および皮下組織の疾患'**
  String get searchDiseaseIcd10ChapterXII;

  /// No description provided for @searchDiseaseIcd10ChapterXIII.
  ///
  /// In ja, this message translates to:
  /// **'XIII 筋骨格系および結合組織の疾患'**
  String get searchDiseaseIcd10ChapterXIII;

  /// No description provided for @searchDiseaseIcd10ChapterXIV.
  ///
  /// In ja, this message translates to:
  /// **'XIV 腎尿路生殖器系の疾患'**
  String get searchDiseaseIcd10ChapterXIV;

  /// No description provided for @searchDiseaseIcd10ChapterXV.
  ///
  /// In ja, this message translates to:
  /// **'XV 妊娠、分娩および産褥'**
  String get searchDiseaseIcd10ChapterXV;

  /// No description provided for @searchDiseaseIcd10ChapterXVI.
  ///
  /// In ja, this message translates to:
  /// **'XVI 周産期に発生した病態'**
  String get searchDiseaseIcd10ChapterXVI;

  /// No description provided for @searchDiseaseIcd10ChapterXVII.
  ///
  /// In ja, this message translates to:
  /// **'XVII 先天奇形、変形および染色体異常'**
  String get searchDiseaseIcd10ChapterXVII;

  /// No description provided for @searchDiseaseIcd10ChapterXVIII.
  ///
  /// In ja, this message translates to:
  /// **'XVIII 症状、徴候および異常臨床所見・異常検査所見で他に分類されないもの'**
  String get searchDiseaseIcd10ChapterXVIII;

  /// No description provided for @searchDiseaseIcd10ChapterXIX.
  ///
  /// In ja, this message translates to:
  /// **'XIX 損傷、中毒およびその他の外因の影響'**
  String get searchDiseaseIcd10ChapterXIX;

  /// No description provided for @searchDiseaseIcd10ChapterXX.
  ///
  /// In ja, this message translates to:
  /// **'XX 傷病および死亡の外因'**
  String get searchDiseaseIcd10ChapterXX;

  /// No description provided for @searchDiseaseIcd10ChapterXXI.
  ///
  /// In ja, this message translates to:
  /// **'XXI 健康状態に影響を及ぼす要因および保健サービスの利用'**
  String get searchDiseaseIcd10ChapterXXI;

  /// No description provided for @searchDiseaseIcd10ChapterXXII.
  ///
  /// In ja, this message translates to:
  /// **'XXII 特殊目的用コード'**
  String get searchDiseaseIcd10ChapterXXII;

  /// No description provided for @searchDiseaseMetaIcd10.
  ///
  /// In ja, this message translates to:
  /// **'ICD-10: {chapter}'**
  String searchDiseaseMetaIcd10(String chapter);

  /// No description provided for @searchDiseaseMetaRevised.
  ///
  /// In ja, this message translates to:
  /// **'改訂 {date}'**
  String searchDiseaseMetaRevised(String date);

  /// No description provided for @searchDrugMetaAtc.
  ///
  /// In ja, this message translates to:
  /// **'ATC: {code}'**
  String searchDrugMetaAtc(String code);

  /// No description provided for @searchDrugMetaRevised.
  ///
  /// In ja, this message translates to:
  /// **'改訂 {date}'**
  String searchDrugMetaRevised(String date);

  /// No description provided for @searchHistoryTimeJustNow.
  ///
  /// In ja, this message translates to:
  /// **'たった今'**
  String get searchHistoryTimeJustNow;

  /// No description provided for @searchHistoryTimeMinutesAgo.
  ///
  /// In ja, this message translates to:
  /// **'{minutes}分前'**
  String searchHistoryTimeMinutesAgo(int minutes);

  /// No description provided for @searchHistoryTimeHoursAgo.
  ///
  /// In ja, this message translates to:
  /// **'{hours}時間前'**
  String searchHistoryTimeHoursAgo(int hours);

  /// No description provided for @searchHistoryTimeYesterday.
  ///
  /// In ja, this message translates to:
  /// **'昨日 {time}'**
  String searchHistoryTimeYesterday(String time);

  /// No description provided for @searchHistoryTimeDaysAgo.
  ///
  /// In ja, this message translates to:
  /// **'{days}日前'**
  String searchHistoryTimeDaysAgo(int days);

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
