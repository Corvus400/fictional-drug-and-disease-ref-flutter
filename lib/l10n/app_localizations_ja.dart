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
  String get searchHistoryEmptyTitle => '検索履歴はまだありません';

  @override
  String get searchHistoryEmptyDescription =>
      '検索すると履歴が最大 5 件まで残ります。\n履歴は端末内にのみ保存されます。';

  @override
  String get searchHistoryClear => 'すべて消す';

  @override
  String get searchHistoryPrivacyNote => '最新 5 件まで表示。履歴は端末内にのみ保存されます';

  @override
  String searchHistoryFilterCount(int count) {
    return '絞り込み +$count';
  }

  @override
  String get searchHistoryRxBadge => 'Rx';

  @override
  String get searchHistoryDxBadge => 'Dx';

  @override
  String get searchHistoryClearConfirmTitle => '検索履歴を削除しますか？';

  @override
  String get searchHistoryClearConfirmDelete => '削除';

  @override
  String searchToolbarTotal(int count) {
    return '合計 $count 件';
  }

  @override
  String get searchToolbarApplied => '適用中';

  @override
  String get searchToolbarLoadMore => 'さらに読み込む';

  @override
  String searchToolbarLoadMoreWithProgress(int currentPage, int totalPages) {
    return 'さらに読み込む · $currentPage / $totalPages';
  }

  @override
  String get searchEmptyResultTitle => '該当する結果がありません';

  @override
  String get searchEmptyResultSubtitle => '検索キーワードや絞り込みを\n見直してください。';

  @override
  String get searchEmptyResetFilter => '条件をリセット';

  @override
  String get searchEmptyRemoveOneFilter => '絞り込みを 1 つずつ外す';

  @override
  String get searchErrorTitle => '通信エラー';

  @override
  String get searchErrorBody => 'サーバーに接続できませんでした。\n通信環境を確認してから再試行してください。';

  @override
  String get searchErrorTitleNetwork => '通信エラー';

  @override
  String get searchErrorBodyNetwork => 'もう一度試してください。';

  @override
  String get searchErrorTitleServer => 'サーバーエラー';

  @override
  String get searchErrorBodyServer => 'しばらく経ってから再試行してください。';

  @override
  String get searchErrorTitleBusiness => '条件に問題があります';

  @override
  String get searchErrorBodyBusiness => '指定された条件をご確認ください。';

  @override
  String get searchErrorTitleParse => 'データを読み込めません';

  @override
  String searchErrorBodyParse(Object message) {
    return '$message';
  }

  @override
  String get searchErrorTitleStorage => '保存に失敗しました';

  @override
  String searchErrorBodyStorage(Object message) {
    return '$message';
  }

  @override
  String get searchErrorTitleAuth => '権限がありません';

  @override
  String searchErrorBodyAuth(Object message) {
    return '$message';
  }

  @override
  String get searchErrorTitleUnknown => '予期しないエラー';

  @override
  String searchErrorBodyUnknown(Object message) {
    return '$message';
  }

  @override
  String get searchErrorRetry => '再試行';

  @override
  String searchErrorDiagnosticsType(Object type) {
    return 'Type: $type';
  }

  @override
  String searchErrorDiagnosticsStatus(int statusCode) {
    return 'Status: $statusCode';
  }

  @override
  String searchErrorDiagnosticsCode(Object code) {
    return 'Code: $code';
  }

  @override
  String searchErrorDiagnosticsMessage(Object message) {
    return 'Message: $message';
  }

  @override
  String searchErrorDiagnosticsDetails(Object details) {
    return 'Details: $details';
  }

  @override
  String searchErrorDiagnosticsStorageKind(Object kind) {
    return 'Storage kind: $kind';
  }

  @override
  String get searchFilterTitle => '絞り込み';

  @override
  String searchFilterTitleForTarget(String target) {
    return '絞り込み（$target）';
  }

  @override
  String get searchFilterApply => '結果を見る';

  @override
  String searchFilterApplyWithCount(int count) {
    return '結果を見る ($count 件)';
  }

  @override
  String get searchFilterReset => 'リセット';

  @override
  String searchFilterAxisPolicy(int count) {
    return '$count 軸 · 軸内 OR / 軸間 AND';
  }

  @override
  String get searchFilterSummaryAll => 'すべて';

  @override
  String get searchFilterSummaryUnspecified => '未指定';

  @override
  String searchFilterHintMultiValue(int count) {
    return '$count 値・複数選択 OR';
  }

  @override
  String searchFilterHintSingleValue(int count) {
    return '$count 値・単一選択';
  }

  @override
  String get searchFilterHintBool => 'bool';

  @override
  String get searchFilterHintPartialMatch => '部分一致';

  @override
  String get searchFilterHintHierarchy => '階層選択';

  @override
  String searchFilterHintDrillIn(int count) {
    return '$count 章・ドリルイン';
  }

  @override
  String get searchFilterDrugRegulatoryClass => '規制区分';

  @override
  String get searchFilterDrugDosageForm => '剤形';

  @override
  String get searchFilterDrugRoute => '投与経路';

  @override
  String get searchFilterDrugAtc => 'ATC 第 1 階層';

  @override
  String get searchFilterDrugTherapeuticCategory => '薬効分類';

  @override
  String get searchFilterDrugAdverseReactionKeyword => '副作用キーワード';

  @override
  String get searchFilterDrugPrecautionCategory => '患者背景';

  @override
  String get searchFilterDiseaseIcd10Chapter => 'ICD-10 章';

  @override
  String get searchFilterDiseaseDepartment => '診療科';

  @override
  String get searchFilterDiseaseChronicity => '慢性度';

  @override
  String get searchFilterDiseaseInfectious => '感染性';

  @override
  String get searchFilterDiseaseSymptomKeyword => '症状キーワード';

  @override
  String get searchFilterDiseaseOnsetPattern => '発症パターン';

  @override
  String get searchFilterDiseaseExamCategory => '検査区分';

  @override
  String get searchFilterDiseaseHasPharmacologicalTreatment => '薬物治療あり';

  @override
  String get searchFilterDiseaseHasSeverityGrading => '重症度評価あり';

  @override
  String get searchDiseasePharmacologicalTreatmentTrue => '薬物治療あり';

  @override
  String get searchDiseasePharmacologicalTreatmentFalse => '薬物治療なし';

  @override
  String get searchDiseaseSeverityGradingTrue => '重症度評価あり';

  @override
  String get searchDiseaseSeverityGradingFalse => '重症度評価なし';

  @override
  String get searchSortTitle => '並び替え';

  @override
  String get searchLoadingTotalPlaceholder => '合計 — 件';

  @override
  String get searchLoadingCaption => '検索中…';

  @override
  String get searchSortByRevised => '更新日(新しい順)';

  @override
  String get searchSortDiseaseRevisedAt => '改訂日';

  @override
  String get searchSortDiseaseName => '名称';

  @override
  String get searchSortDiseaseIcd10 => 'ICD-10';

  @override
  String get searchSortByBrandKana => 'ブランド名カナ';

  @override
  String get searchSortByAtcCode => 'ATC コード';

  @override
  String get searchSortByTherapeuticCategory => '薬効分類名';

  @override
  String get searchDrugRegulatoryPoison => '毒薬';

  @override
  String get searchDrugRegulatoryPotent => '劇薬';

  @override
  String get searchDrugRegulatoryPrescriptionRequired => '処方箋医薬品';

  @override
  String get searchDrugRegulatoryOrdinary => '普通薬';

  @override
  String get searchDrugRegulatoryPsychotropic1 => '向精神薬第1種';

  @override
  String get searchDrugRegulatoryPsychotropic2 => '向精神薬第2種';

  @override
  String get searchDrugRegulatoryPsychotropic3 => '向精神薬第3種';

  @override
  String get searchDrugRegulatoryNarcotic => '麻薬';

  @override
  String get searchDrugRegulatoryStimulantPrecursor => '覚醒剤原料';

  @override
  String get searchDrugRegulatoryBiological => '生物由来製品';

  @override
  String get searchDrugRegulatorySpecifiedBiological => '特定生物由来製品';

  @override
  String get searchDrugDosageFormTablet => '錠剤';

  @override
  String get searchDrugDosageFormCapsule => 'カプセル';

  @override
  String get searchDrugDosageFormPowder => '散剤';

  @override
  String get searchDrugDosageFormGranule => '顆粒';

  @override
  String get searchDrugDosageFormLiquid => '液剤';

  @override
  String get searchDrugDosageFormInjection => '注射剤';

  @override
  String get searchDrugDosageFormOintment => '軟膏';

  @override
  String get searchDrugDosageFormCream => 'クリーム';

  @override
  String get searchDrugDosageFormPatch => '貼付剤';

  @override
  String get searchDrugDosageFormEyeDrops => '点眼液';

  @override
  String get searchDrugDosageFormSuppository => '坐剤';

  @override
  String get searchDrugDosageFormInhaler => '吸入剤';

  @override
  String get searchDrugDosageFormNasalSpray => '点鼻液';

  @override
  String get searchDrugRouteOral => '内服';

  @override
  String get searchDrugRouteTopical => '外用';

  @override
  String get searchDrugRouteInjection => '注射';

  @override
  String get searchDrugRouteInhalation => '吸入';

  @override
  String get searchDrugRouteRectal => '坐剤';

  @override
  String get searchDrugRouteOphthalmic => '点眼';

  @override
  String get searchDrugRouteNasal => '点鼻';

  @override
  String get searchDrugRouteTransdermal => '貼付';

  @override
  String get searchDrugPrecautionComorbidity => '合併症';

  @override
  String get searchDrugPrecautionRenalImpairment => '腎機能障害';

  @override
  String get searchDrugPrecautionHepaticImpairment => '肝機能障害';

  @override
  String get searchDrugPrecautionReproductivePotential => '生殖能を有する患者';

  @override
  String get searchDrugPrecautionPregnant => '妊婦';

  @override
  String get searchDrugPrecautionLactating => '授乳婦';

  @override
  String get searchDrugPrecautionPediatric => '小児等';

  @override
  String get searchDrugPrecautionGeriatric => '高齢者';

  @override
  String get searchDiseaseDepartmentInternalMedicine => '内科';

  @override
  String get searchDiseaseDepartmentCardiology => '循環器内科';

  @override
  String get searchDiseaseDepartmentGastroenterology => '消化器内科';

  @override
  String get searchDiseaseDepartmentEndocrinology => '内分泌内科';

  @override
  String get searchDiseaseDepartmentNeurology => '神経内科';

  @override
  String get searchDiseaseDepartmentPsychiatry => '精神科';

  @override
  String get searchDiseaseDepartmentSurgery => '外科';

  @override
  String get searchDiseaseDepartmentOrthopedics => '整形外科';

  @override
  String get searchDiseaseDepartmentDermatology => '皮膚科';

  @override
  String get searchDiseaseDepartmentOphthalmology => '眼科';

  @override
  String get searchDiseaseDepartmentOtolaryngology => '耳鼻咽喉科';

  @override
  String get searchDiseaseDepartmentUrology => '泌尿器科';

  @override
  String get searchDiseaseDepartmentGynecology => '婦人科';

  @override
  String get searchDiseaseDepartmentPediatrics => '小児科';

  @override
  String get searchDiseaseDepartmentEmergency => '救急科';

  @override
  String get searchDiseaseDepartmentInfectiousDisease => '感染症科';

  @override
  String get searchDiseaseChronicityAcute => '急性';

  @override
  String get searchDiseaseChronicitySubacute => '亜急性';

  @override
  String get searchDiseaseChronicityChronic => '慢性';

  @override
  String get searchDiseaseChronicityRelapsing => '再発性';

  @override
  String get searchDiseaseInfectiousTrue => '感染性';

  @override
  String get searchDiseaseInfectiousFalse => '非感染性';

  @override
  String get searchDiseaseOnsetPatternAcute => '急性発症';

  @override
  String get searchDiseaseOnsetPatternSubacute => '亜急性発症';

  @override
  String get searchDiseaseOnsetPatternChronic => '慢性経過';

  @override
  String get searchDiseaseOnsetPatternIntermittent => '間欠性';

  @override
  String get searchDiseaseOnsetPatternRelapsing => '再発性';

  @override
  String get searchDiseaseExamCategoryBloodTest => '血液検査';

  @override
  String get searchDiseaseExamCategoryImaging => '画像検査';

  @override
  String get searchDiseaseExamCategoryPhysiological => '生理検査';

  @override
  String get searchDiseaseExamCategoryPathology => '病理検査';

  @override
  String get searchDiseaseExamCategoryInterview => '問診';

  @override
  String get searchDiseaseBoolTrue => 'あり';

  @override
  String get searchDiseaseBoolFalse => 'なし';

  @override
  String get searchDiseaseIcd10ChapterI => 'I 感染症および寄生虫症';

  @override
  String get searchDiseaseIcd10ChapterII => 'II 新生物';

  @override
  String get searchDiseaseIcd10ChapterIII => 'III 血液および造血器の疾患ならびに免疫機構の障害';

  @override
  String get searchDiseaseIcd10ChapterIV => 'IV 内分泌、栄養および代謝疾患';

  @override
  String get searchDiseaseIcd10ChapterV => 'V 精神および行動の障害';

  @override
  String get searchDiseaseIcd10ChapterVI => 'VI 神経系の疾患';

  @override
  String get searchDiseaseIcd10ChapterVII => 'VII 眼および付属器の疾患';

  @override
  String get searchDiseaseIcd10ChapterVIII => 'VIII 耳および乳様突起の疾患';

  @override
  String get searchDiseaseIcd10ChapterIX => 'IX 循環器系の疾患';

  @override
  String get searchDiseaseIcd10ChapterX => 'X 呼吸器系の疾患';

  @override
  String get searchDiseaseIcd10ChapterXI => 'XI 消化器系の疾患';

  @override
  String get searchDiseaseIcd10ChapterXII => 'XII 皮膚および皮下組織の疾患';

  @override
  String get searchDiseaseIcd10ChapterXIII => 'XIII 筋骨格系および結合組織の疾患';

  @override
  String get searchDiseaseIcd10ChapterXIV => 'XIV 腎尿路生殖器系の疾患';

  @override
  String get searchDiseaseIcd10ChapterXV => 'XV 妊娠、分娩および産褥';

  @override
  String get searchDiseaseIcd10ChapterXVI => 'XVI 周産期に発生した病態';

  @override
  String get searchDiseaseIcd10ChapterXVII => 'XVII 先天奇形、変形および染色体異常';

  @override
  String get searchDiseaseIcd10ChapterXVIII =>
      'XVIII 症状、徴候および異常臨床所見・異常検査所見で他に分類されないもの';

  @override
  String get searchDiseaseIcd10ChapterXIX => 'XIX 損傷、中毒およびその他の外因の影響';

  @override
  String get searchDiseaseIcd10ChapterXX => 'XX 傷病および死亡の外因';

  @override
  String get searchDiseaseIcd10ChapterXXI => 'XXI 健康状態に影響を及ぼす要因および保健サービスの利用';

  @override
  String get searchDiseaseIcd10ChapterXXII => 'XXII 特殊目的用コード';

  @override
  String searchDiseaseMetaIcd10(String chapter) {
    return 'ICD-10: $chapter';
  }

  @override
  String searchDiseaseMetaRevised(String date) {
    return '改訂 $date';
  }

  @override
  String searchDrugMetaAtc(String code) {
    return 'ATC: $code';
  }

  @override
  String searchDrugMetaRevised(String date) {
    return '改訂 $date';
  }

  @override
  String get searchHistoryTimeJustNow => 'たった今';

  @override
  String searchHistoryTimeMinutesAgo(int minutes) {
    return '$minutes分前';
  }

  @override
  String searchHistoryTimeHoursAgo(int hours) {
    return '$hours時間前';
  }

  @override
  String searchHistoryTimeYesterday(String time) {
    return '昨日 $time';
  }

  @override
  String searchHistoryTimeDaysAgo(int days) {
    return '$days日前';
  }

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
