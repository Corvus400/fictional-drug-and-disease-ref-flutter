import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';

/// Fixed clock used by previews that render relative time.
final DateTime previewNow = DateTime(2026, 5, 14, 9, 30);

/// Search and card sample drug.
const DrugSummary previewDrugSummary = DrugSummary(
  id: 'drug_001',
  brandName: 'アムロジン錠5mg',
  genericName: 'アムロジピンベシル酸塩',
  therapeuticCategoryName: '持続性Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'アムロジンジョウ',
  atcCode: 'C08CA01',
  revisedAt: '2026-05-10',
  imageUrl: '/v1/images/drugs/drug_001',
);

/// Secondary search and card sample drug.
const DrugSummary previewInjectionDrugSummary = DrugSummary(
  id: 'drug_042',
  brandName: 'セフメタゾン静注用1g',
  genericName: 'セフメタゾールナトリウム',
  therapeuticCategoryName: 'セファマイシン系抗菌薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'injection_form',
  brandNameKana: 'セフメタゾンジョウチュウヨウ',
  atcCode: 'J01DC09',
  revisedAt: '2026-04-21',
  imageUrl: '/v1/images/drugs/drug_042',
);

/// Search and card sample disease.
const DiseaseSummary previewDiseaseSummary = DiseaseSummary(
  id: 'disease_001',
  name: '本態性高血圧症',
  icd10Chapter: 'chapter_ix',
  medicalDepartment: ['cardiology', 'internal_medicine'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'ホンタイセイコウケツアツショウ',
  revisedAt: '2026-05-10',
);

/// Secondary search and card sample disease.
const DiseaseSummary previewInfectiousDiseaseSummary = DiseaseSummary(
  id: 'disease_028',
  name: '市中肺炎',
  icd10Chapter: 'chapter_x',
  medicalDepartment: ['infectious_disease', 'internal_medicine'],
  chronicity: 'acute',
  infectious: true,
  nameKana: 'シチュウハイエン',
  revisedAt: '2026-04-18',
);

/// Filter category master sample.
const Categories previewCategories = Categories(
  atc: [
    AtcEntry(code: 'C', label: '循環器系'),
    AtcEntry(code: 'J', label: '全身用抗感染薬'),
    AtcEntry(code: 'N', label: '神経系'),
  ],
  therapeuticCategories: [
    TherapeuticCategoryEntry(
      id: 'ca_antagonist',
      queryValue: 'CA_ANTAGONIST',
      label: 'Ca拮抗薬',
    ),
    TherapeuticCategoryEntry(
      id: 'antibacterial',
      queryValue: 'ANTIBACTERIAL',
      label: '抗菌薬',
    ),
    TherapeuticCategoryEntry(
      id: 'analgesic',
      queryValue: 'ANALGESIC',
      label: '鎮痛薬',
    ),
  ],
  routeOfAdministration: ['oral', 'injection_route', 'topical'],
  dosageForm: ['tablet', 'capsule', 'injection_form', 'eye_drops'],
  regulatoryClass: ['prescription_required', 'psychotropic_3', 'ordinary'],
  icd10Chapters: [
    Icd10ChapterEntry(roman: 'IX', code: 'I00-I99', label: '循環器系の疾患'),
    Icd10ChapterEntry(roman: 'X', code: 'J00-J99', label: '呼吸器系の疾患'),
    Icd10ChapterEntry(roman: 'IV', code: 'E00-E90', label: '内分泌疾患'),
  ],
  medicalDepartments: [
    'cardiology',
    'internal_medicine',
    'infectious_disease',
  ],
);

/// Full drug detail sample.
const Drug previewDrug = Drug(
  id: 'drug_001',
  genericName: 'アムロジピンベシル酸塩',
  brandName: 'アムロジン錠5mg',
  brandNameKana: 'アムロジンジョウ5ミリグラム',
  atcCode: 'C08CA01',
  yjCode: '2171022F1020',
  therapeuticCategoryName: 'ジヒドロピリジン系Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  routeOfAdministration: 'oral',
  composition: CompositionInfo(
    activeIngredient: 'アムロジピンベシル酸塩',
    activeIngredientAmount: Dose(amount: 5, unit: 'mg', per: '1錠中'),
    inactiveIngredients: ['結晶セルロース', '無水リン酸水素カルシウム', 'ステアリン酸Mg'],
    appearance: '白色から帯黄白色の割線入り素錠',
    identificationCode: 'AML5',
  ),
  warning: [
    NumberedParagraph(order: 1, subOrder: null, content: '過度の血圧低下に注意して投与する。'),
  ],
  contraindications: [
    NumberedParagraph(order: 1, subOrder: null, content: '本剤の成分に過敏症の既往歴がある患者。'),
  ],
  indications: [
    IndicationItem(order: 1, content: '高血圧症'),
    IndicationItem(order: 2, content: '狭心症'),
  ],
  indicationsRelatedPrecautions: [
    NumberedParagraph(order: 1, subOrder: null, content: '症状に応じて適切な治療選択を行う。'),
  ],
  dosage: DosageInfo(
    standardDosage: '通常、成人には1日1回5mgを経口投与する。',
    ageSpecificDosage: [
      AgeDosage(
        range: AgeRange(minAgeMonths: 216, maxAgeMonths: null, label: '成人'),
        dose: '1日1回5mg',
      ),
    ],
    renalAdjustment: [
      RenalDose(
        range: CrClRange(
          minMlPerMin: 30,
          maxMlPerMin: null,
          severity: 'mild',
          label: 'CrCl 30mL/min以上',
        ),
        dose: '通常用量',
      ),
    ],
    hepaticAdjustment: [
      HepaticDose(severity: 'mild', dose: '慎重に増量する。'),
    ],
  ),
  dosageRelatedPrecautions: [
    NumberedParagraph(order: 1, subOrder: null, content: '効果不十分な場合は慎重に増量する。'),
  ],
  importantPrecautions: [
    NumberedParagraph(order: 1, subOrder: null, content: 'めまい等があらわれることがある。'),
  ],
  precautionsForSpecificPopulations: [
    PrecautionPopulation(category: 'GERIATRIC', note: '高齢者では低用量から開始する。'),
    PrecautionPopulation(category: 'PREGNANT', note: '治療上の有益性を考慮する。'),
  ],
  interactions: InteractionInfo(
    combinationProhibited: [],
    combinationCaution: [
      InteractionEntry(
        drugId: null,
        displayName: '降圧作用を有する薬剤',
        clinicalSymptom: '降圧作用が増強することがある。',
        mechanism: '相加的な血管拡張作用。',
      ),
    ],
  ),
  adverseReactions: AdverseReactionInfo(
    serious: [
      AdverseReaction(
        name: '過度の血圧低下',
        frequency: '頻度不明',
        symptom: 'ふらつき、失神',
        initialSigns: 'めまい',
        countermeasure: '減量または休薬を考慮する。',
      ),
    ],
    other: AdverseReactionByFrequency(
      over5Percent: ['浮腫'],
      between1And5Percent: ['顔面潮紅', '頭痛'],
      under1Percent: ['動悸'],
      frequencyUnknown: ['発疹'],
    ),
  ),
  effectsOnLabTests: [
    NumberedParagraph(order: 1, subOrder: null, content: '肝機能検査値の変動に注意する。'),
  ],
  overdose: OverdoseInfo(symptoms: '著しい血圧低下。', management: '循環動態を観察し補液等を行う。'),
  administrationPrecautions: [
    NumberedParagraph(order: 1, subOrder: null, content: 'PTP包装から取り出して服用する。'),
  ],
  otherPrecautions: [
    NumberedParagraph(order: 1, subOrder: null, content: '長期投与時は定期的に状態を確認する。'),
  ],
  pharmacokinetics: PharmacokineticsInfo(
    bloodConcentration: '投与後6から8時間で最高血中濃度に到達する。',
    absorption: '経口投与後、良好に吸収される。',
    distribution: '血漿蛋白結合率は高い。',
    metabolism: '主に肝で代謝される。',
    excretion: '代謝物として尿中に排泄される。',
    parameters: [
      PkParameter(name: 'Tmax', value: '6-8 h'),
      PkParameter(name: 'T1/2', value: '約35 h'),
    ],
  ),
  clinicalResults: [
    ClinicalResultSection(heading: '降圧効果', content: '収縮期血圧および拡張期血圧を低下させた。'),
  ],
  pharmacology: PharmacologyInfo(
    mechanism: '血管平滑筋のCaチャネルを遮断する。',
    effect: '末梢血管抵抗を低下させる。',
  ),
  physicochemicalProperties: PhysicochemicalInfo(
    genericNameEnglish: 'Amlodipine Besilate',
    molecularFormula: 'C20H25ClN2O5',
    molecularWeight: 567.05,
    description: '白色から淡黄色の結晶性粉末。',
  ),
  handlingPrecautions: [
    NumberedParagraph(order: 1, subOrder: null, content: '高温多湿を避けて保存する。'),
  ],
  approvalConditions: [
    NumberedParagraph(order: 1, subOrder: null, content: '使用成績に関する情報を収集する。'),
  ],
  packages: [
    PackageInfo(
      size: '100錠 PTP',
      storageCondition: StorageCondition(
        temperature: 'room_temperature',
        lightProtection: false,
        moistureProtection: true,
        additionalNote: '気密容器',
      ),
      expirationMonths: 36,
    ),
  ],
  references: [
    Reference(citation: '架空添付文書 2026年5月改訂', source: '社内資料'),
  ],
  insuranceNotes: [
    NumberedParagraph(order: 1, subOrder: null, content: '保険適用上の注意を確認する。'),
  ],
  manufacturer: '架空製薬株式会社',
  revisedAt: '2026-05-10',
  relatedDiseaseIds: [],
  imageUrl: '/v1/images/drugs/drug_001',
  disclaimer: '架空データ / 医療判断には使用しないでください',
);

/// Full disease detail sample.
const Disease previewDisease = Disease(
  id: 'disease_001',
  name: '本態性高血圧症',
  nameKana: 'ホンタイセイコウケツアツショウ',
  nameEnglish: 'Essential hypertension',
  icd10Chapter: 'chapter_ix',
  medicalDepartment: ['cardiology', 'internal_medicine'],
  chronicity: 'chronic',
  infectious: false,
  synonyms: ['高血圧', '一次性高血圧'],
  summary: '持続的な血圧上昇を特徴とする慢性疾患。',
  epidemiology: EpidemiologyInfo(
    prevalence: Prevalence(
      rate: 43,
      denominator: 100,
      unit: '%',
      label: '成人',
    ),
    onsetAgeRange: OnsetAgeRange(
      minAgeYears: 40,
      maxAgeYears: null,
      label: '中年以降',
    ),
    sexRatio: SexDistribution(maleRatio: 52, femaleRatio: 48, note: '年齢で変動する'),
    riskFactors: ['加齢', '食塩摂取過多', '肥満', '家族歴'],
  ),
  etiology: '生活習慣、遺伝的背景、腎・内分泌因子などが複合的に関与する。',
  symptoms: SymptomInfo(
    mainSymptoms: ['多くは無症状', '頭重感'],
    associatedSymptoms: ['動悸', 'めまい'],
    onsetPattern: 'gradual',
  ),
  diagnosticCriteria: DiagnosticCriteriaInfo(
    required: ['診察室血圧 140/90mmHg 以上', '家庭血圧 135/85mmHg 以上'],
    supporting: ['繰り返し測定で持続的に高値'],
    notes: '白衣高血圧や仮面高血圧を考慮する。',
  ),
  requiredExams: [
    Exam(
      name: '血圧測定',
      category: 'vital',
      typicalFinding: '持続的な血圧高値',
      referenceRange: '診察室 140/90mmHg 未満',
    ),
    Exam(
      name: '血清クレアチニン',
      category: 'blood',
      typicalFinding: '腎機能評価',
      referenceRange: null,
    ),
  ],
  severityGrading: SeverityInfo(
    gradingSystem: '血圧分類',
    grades: [
      Grade(
        label: 'I度',
        criteria: '140-159/90-99mmHg',
        recommendedAction: '生活習慣修正を行う。',
      ),
      Grade(
        label: 'II度',
        criteria: '160-179/100-109mmHg',
        recommendedAction: '薬物療法を検討する。',
      ),
    ],
  ),
  differentialDiagnoses: ['二次性高血圧', '白衣高血圧'],
  complications: ['脳卒中', '心不全', '慢性腎臓病'],
  treatments: TreatmentInfo(
    pharmacological: [
      PharmaTreatment(
        drugCategory: 'Ca拮抗薬',
        drugIds: ['drug_001'],
        indication: '降圧治療',
        notes: '患者背景に応じて選択する。',
      ),
    ],
    nonPharmacological: [
      TreatmentSection(
        heading: '生活習慣修正',
        items: ['減塩', '体重管理', '運動療法'],
        description: '継続可能な目標を設定する。',
      ),
    ],
    acutePhaseProtocol: [
      ProtocolStep(order: 1, action: '血圧と臓器障害を評価する。', target: '初期評価'),
      ProtocolStep(order: 2, action: '必要に応じて薬物療法を開始する。', target: '治療開始'),
    ],
  ),
  prognosis: '適切な管理により心血管イベントリスクを低減できる。',
  prevention: ['減塩', '適正体重維持', '禁煙'],
  relatedDrugIds: [],
  relatedDiseaseIds: [],
  revisedAt: '2026-05-10',
  disclaimer: '架空データ / 医療判断には使用しないでください',
);

/// Drug search state with visible results.
final SearchScreenState previewDrugSearchResultsState =
    SearchScreenState.initial().copyWith(
      queryText: 'アムロ',
      drugParams: const DrugSearchParams(
        page: 1,
        pageSize: 20,
        keyword: 'アムロ',
        categoryAtc: 'C',
        regulatoryClass: ['prescription_required'],
        sort: DrugSort.revisedAtDesc,
      ),
      phase: const SearchPhase.results(
        DrugSearchResultsView(
          items: [previewDrugSummary, previewInjectionDrugSummary],
          page: 1,
          pageSize: 20,
          totalPages: 2,
          totalCount: 24,
        ),
      ),
      categories: previewCategories,
      appliedChips: const AppliedFilterChips([
        AppliedChip(axis: 'category_atc', label: '循環器系'),
        AppliedChip(axis: 'regulatory_class', label: '処方箋医薬品'),
      ]),
    );

/// Disease search state with visible results.
final SearchScreenState previewDiseaseSearchResultsState =
    SearchScreenState.initial().copyWith(
      tab: SearchTab.diseases,
      queryText: '高血圧',
      diseaseParams: const DiseaseSearchParams(
        page: 1,
        pageSize: 20,
        keyword: '高血圧',
        icd10Chapter: ['chapter_ix'],
        department: ['cardiology'],
        sort: DiseaseSort.revisedAtDesc,
      ),
      phase: const SearchPhase.results(
        DiseaseSearchResultsView(
          items: [previewDiseaseSummary, previewInfectiousDiseaseSummary],
          page: 1,
          pageSize: 20,
          totalPages: 1,
          totalCount: 2,
        ),
      ),
      categories: previewCategories,
      appliedChips: const AppliedFilterChips([
        AppliedChip(axis: 'icd10_chapter', label: '循環器系の疾患'),
        AppliedChip(axis: 'department', label: '循環器内科'),
      ]),
    );

/// Search state with recent history dropdown.
final SearchScreenState previewSearchHistoryState =
    previewDrugSearchResultsState.copyWith(
      historyDropdownOpen: true,
      historyForTab: [
        DrugSearchHistoryEnvelope(
          id: 'search-history-drug-1',
          queryText: 'アムロ',
          params: const DrugSearchParams(keyword: 'アムロ'),
          filterCount: 2,
          searchedAt: previewNow.subtract(const Duration(minutes: 15)),
          totalCount: 24,
        ),
        DrugSearchHistoryEnvelope(
          id: 'search-history-drug-2',
          queryText: 'Ca拮抗薬',
          params: const DrugSearchParams(categoryAtc: 'C'),
          filterCount: 1,
          searchedAt: previewNow.subtract(const Duration(hours: 3)),
          totalCount: 48,
        ),
      ],
    );

/// Search state with loading-more overlay.
final SearchScreenState previewSearchLoadingMoreState =
    previewDrugSearchResultsState.copyWith(
      phase: const SearchPhase.loadingMore(
        previous: DrugSearchResultsView(
          items: [previewDrugSummary, previewInjectionDrugSummary],
          page: 1,
          pageSize: 20,
          totalPages: 2,
          totalCount: 24,
        ),
      ),
    );

/// Search empty-result state.
final SearchScreenState previewSearchEmptyState = previewDrugSearchResultsState
    .copyWith(
      phase: const SearchPhase.empty(
        chips: AppliedFilterChips([
          AppliedChip(axis: 'category_atc', label: '循環器系'),
        ]),
      ),
    );

/// BMI result preview state.
final CalcScreenState previewBmiResultState = CalcScreenState(
  activeTool: CalcType.bmi,
  phase: const CalcPhase.resultWithClassification(
    CalcType.bmi,
    BmiInputs(heightCm: 170, weightKg: 65),
    BmiResult(bmi: 22.49, category: BmiCategory.normal),
    BmiCategory.normal,
  ),
  historyExpanded: true,
  history: [
    CalculationHistoryEntry(
      id: 'calc-bmi-1',
      calcType: 'bmi',
      inputsJson: '{"heightCm":170,"weightKg":65}',
      resultJson: '{"bmi":22.49,"category":"normal"}',
      calculatedAt: DateTime(2026, 5, 14, 8, 50),
    ),
    CalculationHistoryEntry(
      id: 'calc-bmi-2',
      calcType: 'bmi',
      inputsJson: '{"heightCm":165,"weightKg":72}',
      resultJson: '{"bmi":26.45,"category":"overweight"}',
      calculatedAt: DateTime(2026, 5, 13, 18, 15),
    ),
  ],
  historyPhase: CalcHistoryPhase.loaded,
);

/// eGFR result preview state.
const CalcScreenState previewEgfrResultState = CalcScreenState(
  activeTool: CalcType.egfr,
  phase: CalcPhase.resultWithClassification(
    CalcType.egfr,
    EgfrInputs(ageYears: 72, sex: Sex.female, serumCreatinineMgDl: 1.1),
    EgfrResult(eGfrMlMin173m2: 39.8, stage: CkdStage.g3b),
    CkdStage.g3b,
  ),
  historyExpanded: false,
  history: [],
  historyPhase: CalcHistoryPhase.empty,
);

/// CrCl result preview state.
const CalcScreenState previewCrClResultState = CalcScreenState(
  activeTool: CalcType.crcl,
  phase: CalcPhase.validInput(
    CalcType.crcl,
    CrClInputs(
      ageYears: 72,
      sex: Sex.female,
      weightKg: 52,
      serumCreatinineMgDl: 1.1,
    ),
    CrClResult(crClMlMin: 35.8),
  ),
  historyExpanded: false,
  history: [],
  historyPhase: CalcHistoryPhase.empty,
);

/// Calc partial input preview state.
const CalcScreenState previewCalcPartialState = CalcScreenState(
  activeTool: CalcType.bmi,
  phase: CalcPhase.partialInput(
    CalcType.bmi,
    CalcInputDraft(values: {CalcInputFieldKey.heightCm: '170'}),
  ),
  historyExpanded: false,
  history: [],
  historyPhase: CalcHistoryPhase.empty,
);

/// Calc out-of-range preview state.
const CalcScreenState previewCalcOutOfRangeState = CalcScreenState(
  activeTool: CalcType.bmi,
  phase: CalcPhase.outOfRange(
    CalcType.bmi,
    CalcInputDraft(
      values: {
        CalcInputFieldKey.heightCm: '80',
        CalcInputFieldKey.weightKg: '500',
      },
    ),
    errors: {'heightCm': '100-250 cm', 'weightKg': '20-300 kg'},
  ),
  historyExpanded: false,
  history: [],
  historyPhase: CalcHistoryPhase.empty,
);

/// Drug detail screen state.
DrugDetailScreenState previewDrugDetailState(DrugDetailTab tab) {
  return DrugDetailScreenState(
    phase: const DrugDetailLoadedPhase(previewDrug),
    activeTab: tab,
    isBookmarked: true,
    isBookmarkBusy: false,
    bookmarkError: null,
  );
}

/// Disease detail screen state.
DiseaseDetailScreenState previewDiseaseDetailState(DiseaseDetailTab tab) {
  return DiseaseDetailScreenState(
    phase: const DiseaseDetailLoadedPhase(previewDisease),
    activeTab: tab,
    isBookmarked: true,
    isBookmarkBusy: false,
    bookmarkError: null,
  );
}

/// Browsing history loaded state.
final HistoryLoaded previewHistoryLoadedState = HistoryLoaded(
  rows: [
    HistoryDrugRow(
      id: previewDrugSummary.id,
      viewedAt: previewNow.subtract(const Duration(minutes: 20)),
      summary: previewDrugSummary,
    ),
    HistoryDiseaseRow(
      id: previewDiseaseSummary.id,
      viewedAt: previewNow.subtract(const Duration(hours: 2)),
      summary: previewDiseaseSummary,
    ),
    HistoryUnresolvedRow(
      id: 'deleted-drug-999',
      viewedAt: previewNow.subtract(const Duration(days: 1)),
    ),
  ],
  selectedTab: HistoryTab.all,
  hasNameFailure: true,
  totalCount: 3,
);

/// Bookmarks loaded state.
final BookmarksLoaded previewBookmarksLoadedState = BookmarksLoaded(
  selectedTab: BookmarksTab.all,
  searchQuery: '',
  visibleRows: [
    BookmarksDrugRow(
      id: previewDrugSummary.id,
      bookmarkedAt: previewNow.subtract(const Duration(days: 2)),
      summary: previewDrugSummary,
    ),
    BookmarksDiseaseRow(
      id: previewDiseaseSummary.id,
      bookmarkedAt: previewNow.subtract(const Duration(days: 3)),
      summary: previewDiseaseSummary,
    ),
  ],
  visibleCount: 2,
  isSearchZero: false,
);

/// Bookmark search-zero state.
const BookmarksLoaded previewBookmarksSearchZeroState = BookmarksLoaded(
  selectedTab: BookmarksTab.all,
  searchQuery: '該当なし',
  visibleRows: [],
  visibleCount: 0,
  isSearchZero: true,
);
