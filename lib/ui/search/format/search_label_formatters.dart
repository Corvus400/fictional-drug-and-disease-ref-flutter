part of '../search_view.dart';

String _regulatoryClassLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'poison' => l10n.searchDrugRegulatoryPoison,
    'potent' => l10n.searchDrugRegulatoryPotent,
    'ordinary' => l10n.searchDrugRegulatoryOrdinary,
    'psychotropic_1' => l10n.searchDrugRegulatoryPsychotropic1,
    'psychotropic_2' => l10n.searchDrugRegulatoryPsychotropic2,
    'psychotropic_3' => l10n.searchDrugRegulatoryPsychotropic3,
    'narcotic' => l10n.searchDrugRegulatoryNarcotic,
    'stimulant_precursor' => l10n.searchDrugRegulatoryStimulantPrecursor,
    'biological' => l10n.searchDrugRegulatoryBiological,
    'specified_biological' => l10n.searchDrugRegulatorySpecifiedBiological,
    'prescription_required' => l10n.searchDrugRegulatoryPrescriptionRequired,
    _ => value,
  };
}

String _dosageFormLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'tablet' => l10n.searchDrugDosageFormTablet,
    'capsule' => l10n.searchDrugDosageFormCapsule,
    'powder' => l10n.searchDrugDosageFormPowder,
    'granule' => l10n.searchDrugDosageFormGranule,
    'liquid' => l10n.searchDrugDosageFormLiquid,
    'injection_form' => l10n.searchDrugDosageFormInjection,
    'ointment' => l10n.searchDrugDosageFormOintment,
    'cream' => l10n.searchDrugDosageFormCream,
    'patch' => l10n.searchDrugDosageFormPatch,
    'eye_drops' => l10n.searchDrugDosageFormEyeDrops,
    'suppository' => l10n.searchDrugDosageFormSuppository,
    'inhaler' => l10n.searchDrugDosageFormInhaler,
    'nasal_spray' => l10n.searchDrugDosageFormNasalSpray,
    _ => value,
  };
}

String _atcLabel(Categories categories, String value) {
  for (final entry in categories.atc) {
    if (entry.code == value) {
      return '${entry.code} ${entry.label}';
    }
  }
  return value;
}

String _therapeuticCategoryLabel(Categories categories, String value) {
  for (final entry in categories.therapeuticCategories) {
    if (entry.id == value) {
      return entry.label;
    }
  }
  return value;
}

String _icd10ChapterValue(Icd10ChapterEntry entry) {
  return 'chapter_${entry.roman.toLowerCase()}';
}

String _icd10ChapterLabel(Categories categories, String value) {
  for (final entry in categories.icd10Chapters) {
    if (_icd10ChapterValue(entry) == value) {
      return '${entry.roman} ${entry.label}';
    }
  }
  return value;
}

String _diseaseIcd10ChapterLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'chapter_i' => l10n.searchDiseaseIcd10ChapterI,
    'chapter_ii' => l10n.searchDiseaseIcd10ChapterII,
    'chapter_iii' => l10n.searchDiseaseIcd10ChapterIII,
    'chapter_iv' => l10n.searchDiseaseIcd10ChapterIV,
    'chapter_v' => l10n.searchDiseaseIcd10ChapterV,
    'chapter_vi' => l10n.searchDiseaseIcd10ChapterVI,
    'chapter_vii' => l10n.searchDiseaseIcd10ChapterVII,
    'chapter_viii' => l10n.searchDiseaseIcd10ChapterVIII,
    'chapter_ix' => l10n.searchDiseaseIcd10ChapterIX,
    'chapter_x' => l10n.searchDiseaseIcd10ChapterX,
    'chapter_xi' => l10n.searchDiseaseIcd10ChapterXI,
    'chapter_xii' => l10n.searchDiseaseIcd10ChapterXII,
    'chapter_xiii' => l10n.searchDiseaseIcd10ChapterXIII,
    'chapter_xiv' => l10n.searchDiseaseIcd10ChapterXIV,
    'chapter_xv' => l10n.searchDiseaseIcd10ChapterXV,
    'chapter_xvi' => l10n.searchDiseaseIcd10ChapterXVI,
    'chapter_xvii' => l10n.searchDiseaseIcd10ChapterXVII,
    'chapter_xviii' => l10n.searchDiseaseIcd10ChapterXVIII,
    'chapter_xix' => l10n.searchDiseaseIcd10ChapterXIX,
    'chapter_xx' => l10n.searchDiseaseIcd10ChapterXX,
    'chapter_xxi' => l10n.searchDiseaseIcd10ChapterXXI,
    'chapter_xxii' => l10n.searchDiseaseIcd10ChapterXXII,
    _ => value,
  };
}

String _departmentLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'internal_medicine' => l10n.searchDiseaseDepartmentInternalMedicine,
    'cardiology' => l10n.searchDiseaseDepartmentCardiology,
    'gastroenterology' => l10n.searchDiseaseDepartmentGastroenterology,
    'endocrinology' => l10n.searchDiseaseDepartmentEndocrinology,
    'neurology' => l10n.searchDiseaseDepartmentNeurology,
    'psychiatry' => l10n.searchDiseaseDepartmentPsychiatry,
    'surgery' => l10n.searchDiseaseDepartmentSurgery,
    'orthopedics' => l10n.searchDiseaseDepartmentOrthopedics,
    'dermatology' => l10n.searchDiseaseDepartmentDermatology,
    'ophthalmology' => l10n.searchDiseaseDepartmentOphthalmology,
    'otolaryngology' => l10n.searchDiseaseDepartmentOtolaryngology,
    'urology' => l10n.searchDiseaseDepartmentUrology,
    'gynecology' => l10n.searchDiseaseDepartmentGynecology,
    'pediatrics' => l10n.searchDiseaseDepartmentPediatrics,
    'emergency' => l10n.searchDiseaseDepartmentEmergency,
    'infectious_disease' => l10n.searchDiseaseDepartmentInfectiousDisease,
    _ => value,
  };
}

String _routeLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'oral' => l10n.searchDrugRouteOral,
    'topical' => l10n.searchDrugRouteTopical,
    'injection_route' => l10n.searchDrugRouteInjection,
    'inhalation' => l10n.searchDrugRouteInhalation,
    'rectal' => l10n.searchDrugRouteRectal,
    'ophthalmic' => l10n.searchDrugRouteOphthalmic,
    'nasal' => l10n.searchDrugRouteNasal,
    'transdermal' => l10n.searchDrugRouteTransdermal,
    _ => value,
  };
}

String _precautionCategoryLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'COMORBIDITY' => l10n.searchDrugPrecautionComorbidity,
    'RENAL_IMPAIRMENT' => l10n.searchDrugPrecautionRenalImpairment,
    'HEPATIC_IMPAIRMENT' => l10n.searchDrugPrecautionHepaticImpairment,
    'REPRODUCTIVE_POTENTIAL' => l10n.searchDrugPrecautionReproductivePotential,
    'PREGNANT' => l10n.searchDrugPrecautionPregnant,
    'LACTATING' => l10n.searchDrugPrecautionLactating,
    'PEDIATRIC' => l10n.searchDrugPrecautionPediatric,
    'GERIATRIC' => l10n.searchDrugPrecautionGeriatric,
    _ => value,
  };
}

const _diseaseChronicityValues = ['acute', 'subacute', 'chronic', 'relapsing'];

const _diseaseOnsetPatternValues = [
  'acute',
  'subacute',
  'chronic',
  'intermittent',
  'relapsing',
];

const _diseaseExamCategoryValues = [
  'blood_test',
  'imaging',
  'physiological',
  'pathology',
  'interview',
];

String _chronicityLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseChronicityAcute,
    'subacute' => l10n.searchDiseaseChronicitySubacute,
    'chronic' => l10n.searchDiseaseChronicityChronic,
    'relapsing' => l10n.searchDiseaseChronicityRelapsing,
    _ => value,
  };
}

String _onsetPatternLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseOnsetPatternAcute,
    'subacute' => l10n.searchDiseaseOnsetPatternSubacute,
    'chronic' => l10n.searchDiseaseOnsetPatternChronic,
    'intermittent' => l10n.searchDiseaseOnsetPatternIntermittent,
    'relapsing' => l10n.searchDiseaseOnsetPatternRelapsing,
    _ => value,
  };
}

String _examCategoryLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'blood_test' => l10n.searchDiseaseExamCategoryBloodTest,
    'imaging' => l10n.searchDiseaseExamCategoryImaging,
    'physiological' => l10n.searchDiseaseExamCategoryPhysiological,
    'pathology' => l10n.searchDiseaseExamCategoryPathology,
    'interview' => l10n.searchDiseaseExamCategoryInterview,
    _ => value,
  };
}

String _appliedChipLabel(
  AppLocalizations l10n,
  Categories? categories,
  AppliedChip chip,
) {
  return switch (chip.axis) {
    'categoryAtc' =>
      categories == null ? chip.label : _atcLabel(categories, chip.label),
    'therapeuticCategory' =>
      categories == null
          ? chip.label
          : _therapeuticCategoryLabel(categories, chip.label),
    'regulatoryClass' => _regulatoryClassLabel(l10n, chip.label),
    'dosageForm' => _dosageFormLabel(l10n, chip.label),
    'route' => _routeLabel(l10n, chip.label),
    'precautionCategory' => _precautionCategoryLabel(l10n, chip.label),
    'icd10Chapter' => _diseaseIcd10ChapterLabel(l10n, chip.label),
    'department' => _departmentLabel(l10n, chip.label),
    'chronicity' => _chronicityLabel(l10n, chip.label),
    'onsetPattern' => _onsetPatternLabel(l10n, chip.label),
    'examCategory' => _examCategoryLabel(l10n, chip.label),
    'infectious' =>
      chip.label == 'true'
          ? l10n.searchDiseaseInfectiousTrue
          : l10n.searchDiseaseInfectiousFalse,
    'hasPharmacologicalTreatment' =>
      chip.label == 'true'
          ? l10n.searchDiseasePharmacologicalTreatmentTrue
          : l10n.searchDiseasePharmacologicalTreatmentFalse,
    'hasSeverityGrading' =>
      chip.label == 'true'
          ? l10n.searchDiseaseSeverityGradingTrue
          : l10n.searchDiseaseSeverityGradingFalse,
    _ => chip.label,
  };
}

String _selectedSummary(
  AppLocalizations l10n,
  Set<String> selected,
  String Function(String value) labelFor,
) {
  if (selected.isEmpty) {
    return l10n.searchFilterSummaryAll;
  }
  return selected.map(labelFor).join(', ');
}

String _textSummary(AppLocalizations l10n, String value) {
  return value.isEmpty ? l10n.searchFilterSummaryUnspecified : value;
}

String _boolSummary(AppLocalizations l10n, bool? value) {
  return switch (value) {
    true => l10n.searchDiseaseBoolTrue,
    false => l10n.searchDiseaseBoolFalse,
    null => l10n.searchFilterSummaryAll,
  };
}

String? _emptyToNull(String value) => value.isEmpty ? null : value;

List<String>? _emptyListToNull(List<String> values) {
  if (values.isEmpty) {
    return null;
  }
  return values;
}

int _resultCount(SearchPhase phase) {
  return switch (phase) {
    SearchPhaseResults(:final view) => view.totalCount,
    SearchPhaseLoadingMore(:final previous) => previous.totalCount,
    _ => 0,
  };
}
