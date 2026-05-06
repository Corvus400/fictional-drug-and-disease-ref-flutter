import 'package:fictional_drug_and_disease_ref/l10n/app_localizations_ja.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsJa();

  group('drug filter labels match mock-server SSOT', () {
    test('route labels match RouteOfAdministration KDoc labels', () {
      final actual = {
        'oral': l10n.searchDrugRouteOral,
        'topical': l10n.searchDrugRouteTopical,
        'injection_route': l10n.searchDrugRouteInjection,
        'inhalation': l10n.searchDrugRouteInhalation,
        'rectal': l10n.searchDrugRouteRectal,
        'ophthalmic': l10n.searchDrugRouteOphthalmic,
        'nasal': l10n.searchDrugRouteNasal,
        'transdermal': l10n.searchDrugRouteTransdermal,
      };

      expect(actual, {
        'oral': '内服',
        'topical': '外用',
        'injection_route': '注射',
        'inhalation': '吸入',
        'rectal': '坐剤',
        'ophthalmic': '点眼',
        'nasal': '点鼻',
        'transdermal': '貼付',
      });
    });

    test('dosage form labels match DosageForm KDoc labels', () {
      final actual = {
        'tablet': l10n.searchDrugDosageFormTablet,
        'capsule': l10n.searchDrugDosageFormCapsule,
        'powder': l10n.searchDrugDosageFormPowder,
        'granule': l10n.searchDrugDosageFormGranule,
        'liquid': l10n.searchDrugDosageFormLiquid,
        'injection_form': l10n.searchDrugDosageFormInjection,
        'ointment': l10n.searchDrugDosageFormOintment,
        'cream': l10n.searchDrugDosageFormCream,
        'patch': l10n.searchDrugDosageFormPatch,
        'eye_drops': l10n.searchDrugDosageFormEyeDrops,
        'suppository': l10n.searchDrugDosageFormSuppository,
        'inhaler': l10n.searchDrugDosageFormInhaler,
        'nasal_spray': l10n.searchDrugDosageFormNasalSpray,
      };

      expect(actual, {
        'tablet': '錠剤',
        'capsule': 'カプセル',
        'powder': '散剤',
        'granule': '顆粒',
        'liquid': '液剤',
        'injection_form': '注射剤',
        'ointment': '軟膏',
        'cream': 'クリーム',
        'patch': '貼付剤',
        'eye_drops': '点眼液',
        'suppository': '坐剤',
        'inhaler': '吸入剤',
        'nasal_spray': '点鼻液',
      });
    });

    test(
      'precaution labels match PrecautionPopulationCategory KDoc labels',
      () {
        final actual = {
          'COMORBIDITY': l10n.searchDrugPrecautionComorbidity,
          'RENAL_IMPAIRMENT': l10n.searchDrugPrecautionRenalImpairment,
          'HEPATIC_IMPAIRMENT': l10n.searchDrugPrecautionHepaticImpairment,
          'REPRODUCTIVE_POTENTIAL':
              l10n.searchDrugPrecautionReproductivePotential,
          'PREGNANT': l10n.searchDrugPrecautionPregnant,
          'LACTATING': l10n.searchDrugPrecautionLactating,
          'PEDIATRIC': l10n.searchDrugPrecautionPediatric,
          'GERIATRIC': l10n.searchDrugPrecautionGeriatric,
        };

        expect(actual, {
          'COMORBIDITY': '合併症',
          'RENAL_IMPAIRMENT': '腎機能障害',
          'HEPATIC_IMPAIRMENT': '肝機能障害',
          'REPRODUCTIVE_POTENTIAL': '生殖能有する患者',
          'PREGNANT': '妊婦',
          'LACTATING': '授乳婦',
          'PEDIATRIC': '小児等',
          'GERIATRIC': '高齢者',
        });
      },
    );
  });

  group('disease filter labels match mock-server SSOT', () {
    test('department labels match MedicalDepartment KDoc labels', () {
      final actual = {
        'internal_medicine': l10n.searchDiseaseDepartmentInternalMedicine,
        'cardiology': l10n.searchDiseaseDepartmentCardiology,
        'gastroenterology': l10n.searchDiseaseDepartmentGastroenterology,
        'endocrinology': l10n.searchDiseaseDepartmentEndocrinology,
        'neurology': l10n.searchDiseaseDepartmentNeurology,
        'psychiatry': l10n.searchDiseaseDepartmentPsychiatry,
        'surgery': l10n.searchDiseaseDepartmentSurgery,
        'orthopedics': l10n.searchDiseaseDepartmentOrthopedics,
        'dermatology': l10n.searchDiseaseDepartmentDermatology,
        'ophthalmology': l10n.searchDiseaseDepartmentOphthalmology,
        'otolaryngology': l10n.searchDiseaseDepartmentOtolaryngology,
        'urology': l10n.searchDiseaseDepartmentUrology,
        'gynecology': l10n.searchDiseaseDepartmentGynecology,
        'pediatrics': l10n.searchDiseaseDepartmentPediatrics,
        'emergency': l10n.searchDiseaseDepartmentEmergency,
        'infectious_disease': l10n.searchDiseaseDepartmentInfectiousDisease,
      };

      expect(actual, {
        'internal_medicine': '内科',
        'cardiology': '循環器内科',
        'gastroenterology': '消化器内科',
        'endocrinology': '内分泌代謝科',
        'neurology': '神経内科',
        'psychiatry': '精神科',
        'surgery': '外科',
        'orthopedics': '整形外科',
        'dermatology': '皮膚科',
        'ophthalmology': '眼科',
        'otolaryngology': '耳鼻咽喉科',
        'urology': '泌尿器科',
        'gynecology': '婦人科',
        'pediatrics': '小児科',
        'emergency': '救急科',
        'infectious_disease': '感染症科',
      });
    });
  });
}
