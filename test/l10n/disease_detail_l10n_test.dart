import 'package:fictional_drug_and_disease_ref/l10n/app_localizations_ja.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('disease detail labels match Detail Spec tab and section copy', () {
    final l10n = AppLocalizationsJa();

    final labels = <(String actual, String expected)>[
      (l10n.detailDiseaseTabOverview, '概要'),
      (l10n.detailDiseaseTabDiagnosis, '診断'),
      (l10n.detailDiseaseTabTreatment, '治療'),
      (l10n.detailDiseaseTabClinicalCourse, '経過'),
      (l10n.detailDiseaseTabRelated, '関連'),
      (l10n.detailDiseaseSectionSynonyms, '同義語'),
      (l10n.detailDiseaseSectionSummary, '概要'),
      (l10n.detailDiseaseSectionEpidemiology, '疫学'),
      (l10n.detailDiseaseSectionPrevalence, '有病率'),
      (l10n.detailDiseaseSectionOnsetAge, '発症年齢'),
      (l10n.detailDiseaseSectionSexRatio, '性別'),
      (l10n.detailDiseaseSectionRiskFactors, 'リスク因子'),
      (l10n.detailDiseaseSectionEtiology, '原因・病態'),
      (l10n.detailDiseaseSectionSymptoms, '症状'),
      (l10n.detailDiseaseSectionMainSymptoms, '主症状'),
      (l10n.detailDiseaseSectionAssociatedSymptoms, '随伴症状'),
      (l10n.detailDiseaseSectionOnsetPattern, '発症パターン'),
      (l10n.detailDiseaseSectionDiagnosticCriteria, '診断基準'),
      (l10n.detailDiseaseSectionRequired, '必須'),
      (l10n.detailDiseaseSectionSupporting, '補助'),
      (l10n.detailDiseaseSectionNotes, '備考'),
      (l10n.detailDiseaseSectionRequiredExams, '必須検査'),
      (l10n.detailDiseaseSectionSeverityGrading, '重症度分類'),
      (l10n.detailDiseaseSectionGradingSystem, '体系'),
      (l10n.detailDiseaseSectionDifferentialDiagnoses, '鑑別'),
      (l10n.detailDiseaseSectionComplications, '合併症'),
      (l10n.detailDiseaseSectionTreatments, '治療'),
      (l10n.detailDiseaseSectionPharmacological, '薬物療法'),
      (l10n.detailDiseaseSectionNonPharmacological, '非薬物療法'),
      (l10n.detailDiseaseSectionAcutePhaseProtocol, '急性期プロトコル'),
      (l10n.detailDiseaseSectionPrognosis, '予後'),
      (l10n.detailDiseaseSectionPrevention, '予防'),
      (l10n.detailDiseaseSectionRelatedDrugs, '関連医薬品'),
      (l10n.detailDiseaseSectionRelatedDiseases, '関連疾患'),
      (l10n.detailDiseaseSectionRevisedAt, '改訂日'),
      (l10n.detailBookmarkAdd, 'ブックマークに追加'),
      (l10n.detailBookmarkRemove, 'ブックマークを解除'),
      (l10n.detailRetry, '再試行'),
      (
        l10n.detailDisclaimer,
        'FICTIONAL DATA - NOT FOR MEDICAL USE / 架空データ・医療判断には使用不可',
      ),
    ];

    for (final label in labels) {
      expect(label.$1, label.$2);
    }
  });
}
