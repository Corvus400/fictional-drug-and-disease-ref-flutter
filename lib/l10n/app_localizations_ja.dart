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
  String get historyTabAll => 'すべて';

  @override
  String get historyTabDrugs => '医薬品';

  @override
  String get historyTabDiseases => '疾患';

  @override
  String get historyEmptyTitle => '閲覧履歴がありません';

  @override
  String get historyEmptyBody => '検索して薬品・疾患を閲覧すると、ここに履歴が表示されます';

  @override
  String get historyEmptyCta => '検索画面へ';

  @override
  String get historyBulkDeleteFabSemantics => 'すべての閲覧履歴を削除';

  @override
  String historyBulkDeleteConfirmTitle(int count) {
    return 'すべての閲覧履歴 ($count件) を削除しますか？';
  }

  @override
  String get historyBulkDeleteConfirmBody => 'この操作は取り消せません';

  @override
  String get historyBulkDeleteConfirmCancel => 'キャンセル';

  @override
  String get historyBulkDeleteConfirmDelete => 'すべて削除';

  @override
  String get historySwipeDeleteAction => '削除';

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
  String get searchDrugPrecautionReproductivePotential => '生殖能有する患者';

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
  String get searchDiseaseDepartmentEndocrinology => '内分泌代謝科';

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

  @override
  String get detailDrugTabOverview => '概要';

  @override
  String get detailDrugTabDose => '用法・用量';

  @override
  String get detailDrugTabCaution => '注意・併用';

  @override
  String get detailDrugTabAdverseEffects => '副作用';

  @override
  String get detailDrugTabPharmacokinetics => '薬物動態';

  @override
  String get detailDrugTabRelated => '関連';

  @override
  String get detailDrugSectionWarning => '警告';

  @override
  String get detailDrugSectionTherapeuticCategory => '薬効分類';

  @override
  String get detailDrugSectionComposition => '組成・性状';

  @override
  String get detailDrugSectionContraindications => '禁忌';

  @override
  String get detailDrugSectionIndications => '効能・効果';

  @override
  String get detailDrugSectionDosage => '用法・用量';

  @override
  String get detailDrugSectionDosageStandard => '標準';

  @override
  String get detailDrugSectionDosagePediatric => '年齢別';

  @override
  String get detailDrugSectionDosageRenal => '腎機能';

  @override
  String get detailDrugSectionDosageHepatic => '肝機能';

  @override
  String get detailDrugSectionDosageRelatedPrecautions => '用法・用量に関連する注意';

  @override
  String get detailDrugSectionImportantPrecautions => '重要な基本的注意';

  @override
  String get detailDrugSectionPrecautionsForSpecificPopulations =>
      '特定の背景を有する患者への注意';

  @override
  String get detailDrugSectionInteractions => '相互作用';

  @override
  String get detailDrugSectionInteractionsProhibited => '併用禁忌';

  @override
  String get detailDrugSectionInteractionsCaution => '併用注意';

  @override
  String get detailDrugNoInteractions => '該当する薬剤はありません。';

  @override
  String get detailDrugSectionSeriousAdverseReactions => '重大な副作用';

  @override
  String get detailDrugSectionOtherAdverseReactions => 'その他副作用';

  @override
  String get detailDrugInitialSigns => '初期症状';

  @override
  String get detailDrugCountermeasure => '対応';

  @override
  String get detailDrugSectionFreqOver5 => '5%以上';

  @override
  String get detailDrugSectionFreq1to5 => '1〜5%';

  @override
  String get detailDrugSectionFreqUnder1 => '1%未満';

  @override
  String get detailDrugSectionFreqUnknown => '不明';

  @override
  String get detailDrugSectionPharmacokinetics => '薬物動態';

  @override
  String get detailDrugSectionBloodConcentration => '血中濃度';

  @override
  String get detailDrugSectionAbsorption => '吸収';

  @override
  String get detailDrugSectionDistribution => '分布';

  @override
  String get detailDrugSectionMetabolism => '代謝';

  @override
  String get detailDrugSectionExcretion => '排泄';

  @override
  String get detailDrugSectionParameters => 'PK パラメータ';

  @override
  String get detailDrugPkTableItemHeader => '項目';

  @override
  String get detailDrugPkTableValueHeader => '値';

  @override
  String get detailDrugSectionAdditionalInfo => '補足情報';

  @override
  String get detailDrugSectionClinicalResults => '臨床成績';

  @override
  String get detailDrugSectionPharmacology => '薬効薬理';

  @override
  String get detailDrugSectionOverdose => '過量投与';

  @override
  String get detailDrugSectionEffectsOnLabTests => '臨床検査結果に及ぼす影響';

  @override
  String get detailDrugSectionOtherPrecautions => 'その他の注意';

  @override
  String get detailDrugSectionPhysicochemical => '有効成分に関する理化学的知見';

  @override
  String get detailDrugPhysicochemicalGenericNameEnglish => '一般名英語';

  @override
  String get detailDrugPhysicochemicalMolecularFormula => '分子式';

  @override
  String get detailDrugPhysicochemicalMolecularWeight => '分子量';

  @override
  String get detailDrugPhysicochemicalDescription => '性状';

  @override
  String get detailDrugSectionHandlingPackagesInsurance => '取扱い・包装・保険';

  @override
  String get detailDrugSectionApprovalReferences => '承認条件・参考文献';

  @override
  String get detailDrugSectionPackages => '包装';

  @override
  String get detailDrugSectionHandlingPrecautions => '取扱い上の注意';

  @override
  String get detailDrugSectionInsuranceNotes => '保険給付上の注意';

  @override
  String get detailDrugSectionApprovalConditions => '承認条件';

  @override
  String get detailDrugSectionReferences => '主要文献';

  @override
  String get detailDrugPackageSizeHeader => 'サイズ';

  @override
  String get detailDrugPackageStorageHeader => '保存';

  @override
  String get detailDrugPackageExpirationHeader => '有効期間';

  @override
  String get detailDrugStorageRoomTemperature => '室温';

  @override
  String get detailDrugStorageCold => '冷所';

  @override
  String get detailDrugStorageFrozen => '冷凍';

  @override
  String get detailDrugStorageLightProtection => '遮光';

  @override
  String get detailDrugStorageMoistureProtection => '防湿';

  @override
  String get detailDrugHepaticSeverityMild => '軽度';

  @override
  String get detailDrugHepaticSeverityModerate => '中等度';

  @override
  String get detailDrugHepaticSeveritySevere => '重度';

  @override
  String get detailDrugExpirationMonthsSuffix => 'か月';

  @override
  String get detailDrugSectionRevisedAt => '改訂日';

  @override
  String get detailDrugSectionManufacturer => '製造販売元';

  @override
  String get detailDrugMetaRevisedPrefix => '改訂';

  @override
  String get detailDrugLabelAtcCode => 'ATC コード';

  @override
  String get detailDrugLabelTherapeuticHierarchy => '階層';

  @override
  String get detailDrugLabelYjCode => 'YJ コード';

  @override
  String get detailDrugLabelActiveIngredient => '有効成分';

  @override
  String get detailDrugLabelInactiveIngredients => '添加物';

  @override
  String get detailDrugLabelAppearance => '外観';

  @override
  String get detailDrugLabelIdentificationCode => '識別コード';

  @override
  String get detailDrugSectionRelatedDiseases => '関連疾患';

  @override
  String get detailDiseaseTabOverview => '概要';

  @override
  String get detailDiseaseTabDiagnosis => '診断';

  @override
  String get detailDiseaseTabTreatment => '治療';

  @override
  String get detailDiseaseTabClinicalCourse => '経過';

  @override
  String get detailDiseaseTabRelated => '関連';

  @override
  String get detailDiseaseSectionSynonyms => '同義語';

  @override
  String get detailDiseaseSectionSummary => '概要';

  @override
  String get detailDiseaseSectionEpidemiology => '疫学';

  @override
  String get detailDiseaseSectionPrevalence => '有病率';

  @override
  String get detailDiseaseSectionOnsetAge => '発症年齢';

  @override
  String get detailDiseaseSectionSexRatio => '性別';

  @override
  String get detailDiseaseSectionRiskFactors => 'リスク因子';

  @override
  String get detailDiseaseSectionEtiology => '原因・病態';

  @override
  String get detailDiseaseSectionSymptoms => '症状';

  @override
  String get detailDiseaseSectionMainSymptoms => '主症状';

  @override
  String get detailDiseaseSectionAssociatedSymptoms => '随伴症状';

  @override
  String get detailDiseaseSectionOnsetPattern => '発症パターン';

  @override
  String get detailDiseaseSectionDiagnosticCriteria => '診断基準';

  @override
  String get detailDiseaseSectionRequired => '必須';

  @override
  String get detailDiseaseSectionSupporting => '補助';

  @override
  String get detailDiseaseSectionNotes => '備考';

  @override
  String get detailDiseaseSectionRequiredExams => '必須検査';

  @override
  String get detailDiseaseSectionSeverityGrading => '重症度分類';

  @override
  String get detailDiseaseSectionGradingSystem => '体系';

  @override
  String get detailDiseaseSectionDifferentialDiagnoses => '鑑別';

  @override
  String get detailDiseaseSectionComplications => '合併症';

  @override
  String get detailDiseaseSectionTreatments => '治療';

  @override
  String get detailDiseaseSectionPharmacological => '薬物療法';

  @override
  String get detailDiseaseSectionNonPharmacological => '非薬物療法';

  @override
  String get detailDiseaseSectionAcutePhaseProtocol => '急性期プロトコル';

  @override
  String get detailDiseaseSectionPrognosis => '予後';

  @override
  String get detailDiseaseSectionPrevention => '予防';

  @override
  String get detailDiseaseSectionRelatedDrugs => '関連医薬品';

  @override
  String get detailDiseaseSectionRelatedDiseases => '関連疾患';

  @override
  String get detailDiseaseSectionRevisedAt => '改訂日';

  @override
  String get detailBookmarkLabel => 'ブックマーク';

  @override
  String get detailBookmarkedLabel => 'ブックマーク済み';

  @override
  String get detailBookmarkAdd => 'ブックマークに追加';

  @override
  String get detailBookmarkRemove => 'ブックマークを解除';

  @override
  String get detailBookmarkToggleSemantics => 'ブックマーク状態を切り替え';

  @override
  String get detailBookmarkErrorMessage => 'ブックマークの更新に失敗しました';

  @override
  String get detailDoseCalculatorLabel => '用量計算';

  @override
  String get detailNoData => '該当なし';

  @override
  String get detailRetry => '再試行';

  @override
  String get calcAppBarTitle => '計算ツール';

  @override
  String get calcToolBmi => 'BMI';

  @override
  String get calcToolEgfr => 'eGFR';

  @override
  String get calcToolCrcl => 'CrCl';

  @override
  String get calcFormulaBmi => 'BMI = w / h²';

  @override
  String get calcFormulaEgfr =>
      'eGFR = 194 × Cr⁻¹·⁰⁹⁴ × age⁻⁰·²⁸⁷ ×(0.739 if F)';

  @override
  String get calcFormulaCrcl =>
      'CrCl = (140 - age) × w / (72 × Cr) ×(0.85 if F)';

  @override
  String get calcInputHeight => '身長';

  @override
  String get calcInputWeight => '体重';

  @override
  String get calcInputAge => '年齢';

  @override
  String get calcInputCreatinine => '血清クレアチニン';

  @override
  String get calcInputSex => '性別';

  @override
  String get calcSexMale => '男性';

  @override
  String get calcSexFemale => '女性';

  @override
  String get calcActionCalculate => '計算する';

  @override
  String get calcActionHistory => '履歴';

  @override
  String get calcActionClear => 'クリア';

  @override
  String get calcActionClose => '閉じる';

  @override
  String get calcUnitCm => 'cm';

  @override
  String get calcUnitKg => 'kg';

  @override
  String get calcUnitYear => '歳';

  @override
  String get calcUnitMgDl => 'mg/dL';

  @override
  String get calcResultTitle => '結果';

  @override
  String get calcResultClassification => '分類';

  @override
  String get calcResultBmiUnit => 'kg/m²';

  @override
  String get calcResultEgfrUnit => 'mL/min/1.73m²';

  @override
  String get calcResultCrclUnit => 'mL/min';

  @override
  String get calcResultPlaceholder => '--';

  @override
  String get calcResultHint => 'すべての項目を入力してください';

  @override
  String get calcRangeErrorHeight => '範囲外: 50.0〜250.0 cm';

  @override
  String get calcRangeErrorWeight => '範囲外: 1.0〜300.0 kg';

  @override
  String get calcRangeErrorAge => '範囲外: 18〜120 歳';

  @override
  String get calcRangeErrorCreatinine => '範囲外: 0.10〜20.00 mg/dL';

  @override
  String get calcBmiCategoryUnderweight => '低体重';

  @override
  String get calcBmiCategoryNormal => '普通体重';

  @override
  String get calcBmiCategoryOverweight => '過体重';

  @override
  String get calcBmiCategoryObese1 => '肥満1度';

  @override
  String get calcBmiCategoryObese2 => '肥満2度';

  @override
  String get calcBmiCategoryObese3 => '肥満3度';

  @override
  String get calcBmiCategoryObese4 => '肥満4度';

  @override
  String get calcCkdStageG1 => 'G1 正常';

  @override
  String get calcCkdStageG2 => 'G2 軽度低下';

  @override
  String get calcCkdStageG3a => 'G3a 軽度〜中等度低下';

  @override
  String get calcCkdStageG3b => 'G3b 中等度〜高度低下';

  @override
  String get calcCkdStageG4 => 'G4 高度低下';

  @override
  String get calcCkdStageG5 => 'G5 末期腎不全';

  @override
  String get calcCkdShortG1 => 'G1';

  @override
  String get calcCkdShortG2 => 'G2';

  @override
  String get calcCkdShortG3a => 'G3a';

  @override
  String get calcCkdShortG3b => 'G3b';

  @override
  String get calcCkdShortG4 => 'G4';

  @override
  String get calcCkdShortG5 => 'G5';

  @override
  String get calcHistoryHeader => '履歴';

  @override
  String get calcHistoryEmpty => '履歴はありません';

  @override
  String get calcHistoryActionDelete => '削除';

  @override
  String get calcHistoryActionRestore => '復元';

  @override
  String get calcHistoryRestoring => '復元中…';

  @override
  String get calcKeyboardNext => '次へ';

  @override
  String get calcKeyboardDone => '完了';

  @override
  String get disclaimerRibbonText =>
      'FICTIONAL DATA - NOT FOR MEDICAL USE / 架空データ・医療判断には使用不可';

  @override
  String get detailDisclaimer =>
      'FICTIONAL DATA - NOT FOR MEDICAL USE / 架空データ・医療判断には使用不可';
}
