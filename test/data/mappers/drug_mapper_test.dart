import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_summary_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toDomain maps DrugSummaryDto fields [assertion 1/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    expect(summary.id, dto.id);
    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 2/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    expect(summary.brandName, dto.brandName);
    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 3/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    expect(summary.genericName, dto.genericName);
    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 4/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    expect(summary.therapeuticCategoryName, dto.therapeuticCategoryName);
    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 5/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    expect(summary.regulatoryClass, dto.regulatoryClass);
    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 6/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    expect(summary.dosageForm, dto.dosageForm);
    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 7/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    expect(summary.brandNameKana, dto.brandNameKana);
    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 8/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    expect(summary.atcCode, dto.atcCode);
    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 9/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    expect(summary.revisedAt, dto.revisedAt);
    Object.hashAll([summary.imageUrl, dto.imageUrl]);
  });

  test('toDomain maps DrugSummaryDto fields [assertion 10/10]', () {
    const dto = DrugSummaryDto(
      id: 'drug_0001',
      brandName: 'ブランド名',
      genericName: '一般名',
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      revisedAt: '2026-05-01',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    final summary = dto.toDomain();

    Object.hashAll([summary.id, dto.id]);

    Object.hashAll([summary.brandName, dto.brandName]);

    Object.hashAll([summary.genericName, dto.genericName]);

    Object.hashAll([
      summary.therapeuticCategoryName,
      dto.therapeuticCategoryName,
    ]);

    Object.hashAll([summary.regulatoryClass, dto.regulatoryClass]);

    Object.hashAll([summary.dosageForm, dto.dosageForm]);

    Object.hashAll([summary.brandNameKana, dto.brandNameKana]);

    Object.hashAll([summary.atcCode, dto.atcCode]);

    Object.hashAll([summary.revisedAt, dto.revisedAt]);

    expect(summary.imageUrl, dto.imageUrl);
  });

  test(
    'toDomain extracts DrugListPage disclaimer and items [assertion 1/6]',
    () {
      const dto = DrugListResponseDto(
        items: [
          DrugSummaryDto(
            id: 'drug_0001',
            brandName: 'ブランド名',
            genericName: '一般名',
            therapeuticCategoryName: '分類名',
            regulatoryClass: ['ordinary'],
            dosageForm: 'tablet',
            brandNameKana: 'ブランドメイ',
            atcCode: 'A00AA00',
            revisedAt: '2026-05-01',
            imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
          ),
        ],
        page: 1,
        pageSize: 20,
        totalPages: 6,
        totalCount: 120,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      expect(page.items.single.id, 'drug_0001');
      Object.hashAll([page.page, 1]);

      Object.hashAll([page.pageSize, 20]);

      Object.hashAll([page.totalPages, 6]);

      Object.hashAll([page.totalCount, 120]);

      Object.hashAll([page.disclaimer, 'FICTIONAL DATA']);
    },
  );

  test(
    'toDomain extracts DrugListPage disclaimer and items [assertion 2/6]',
    () {
      const dto = DrugListResponseDto(
        items: [
          DrugSummaryDto(
            id: 'drug_0001',
            brandName: 'ブランド名',
            genericName: '一般名',
            therapeuticCategoryName: '分類名',
            regulatoryClass: ['ordinary'],
            dosageForm: 'tablet',
            brandNameKana: 'ブランドメイ',
            atcCode: 'A00AA00',
            revisedAt: '2026-05-01',
            imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
          ),
        ],
        page: 1,
        pageSize: 20,
        totalPages: 6,
        totalCount: 120,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      Object.hashAll([page.items.single.id, 'drug_0001']);

      expect(page.page, 1);
      Object.hashAll([page.pageSize, 20]);

      Object.hashAll([page.totalPages, 6]);

      Object.hashAll([page.totalCount, 120]);

      Object.hashAll([page.disclaimer, 'FICTIONAL DATA']);
    },
  );

  test(
    'toDomain extracts DrugListPage disclaimer and items [assertion 3/6]',
    () {
      const dto = DrugListResponseDto(
        items: [
          DrugSummaryDto(
            id: 'drug_0001',
            brandName: 'ブランド名',
            genericName: '一般名',
            therapeuticCategoryName: '分類名',
            regulatoryClass: ['ordinary'],
            dosageForm: 'tablet',
            brandNameKana: 'ブランドメイ',
            atcCode: 'A00AA00',
            revisedAt: '2026-05-01',
            imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
          ),
        ],
        page: 1,
        pageSize: 20,
        totalPages: 6,
        totalCount: 120,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      Object.hashAll([page.items.single.id, 'drug_0001']);

      Object.hashAll([page.page, 1]);

      expect(page.pageSize, 20);
      Object.hashAll([page.totalPages, 6]);

      Object.hashAll([page.totalCount, 120]);

      Object.hashAll([page.disclaimer, 'FICTIONAL DATA']);
    },
  );

  test(
    'toDomain extracts DrugListPage disclaimer and items [assertion 4/6]',
    () {
      const dto = DrugListResponseDto(
        items: [
          DrugSummaryDto(
            id: 'drug_0001',
            brandName: 'ブランド名',
            genericName: '一般名',
            therapeuticCategoryName: '分類名',
            regulatoryClass: ['ordinary'],
            dosageForm: 'tablet',
            brandNameKana: 'ブランドメイ',
            atcCode: 'A00AA00',
            revisedAt: '2026-05-01',
            imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
          ),
        ],
        page: 1,
        pageSize: 20,
        totalPages: 6,
        totalCount: 120,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      Object.hashAll([page.items.single.id, 'drug_0001']);

      Object.hashAll([page.page, 1]);

      Object.hashAll([page.pageSize, 20]);

      expect(page.totalPages, 6);
      Object.hashAll([page.totalCount, 120]);

      Object.hashAll([page.disclaimer, 'FICTIONAL DATA']);
    },
  );

  test(
    'toDomain extracts DrugListPage disclaimer and items [assertion 5/6]',
    () {
      const dto = DrugListResponseDto(
        items: [
          DrugSummaryDto(
            id: 'drug_0001',
            brandName: 'ブランド名',
            genericName: '一般名',
            therapeuticCategoryName: '分類名',
            regulatoryClass: ['ordinary'],
            dosageForm: 'tablet',
            brandNameKana: 'ブランドメイ',
            atcCode: 'A00AA00',
            revisedAt: '2026-05-01',
            imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
          ),
        ],
        page: 1,
        pageSize: 20,
        totalPages: 6,
        totalCount: 120,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      Object.hashAll([page.items.single.id, 'drug_0001']);

      Object.hashAll([page.page, 1]);

      Object.hashAll([page.pageSize, 20]);

      Object.hashAll([page.totalPages, 6]);

      expect(page.totalCount, 120);
      Object.hashAll([page.disclaimer, 'FICTIONAL DATA']);
    },
  );

  test(
    'toDomain extracts DrugListPage disclaimer and items [assertion 6/6]',
    () {
      const dto = DrugListResponseDto(
        items: [
          DrugSummaryDto(
            id: 'drug_0001',
            brandName: 'ブランド名',
            genericName: '一般名',
            therapeuticCategoryName: '分類名',
            regulatoryClass: ['ordinary'],
            dosageForm: 'tablet',
            brandNameKana: 'ブランドメイ',
            atcCode: 'A00AA00',
            revisedAt: '2026-05-01',
            imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
          ),
        ],
        page: 1,
        pageSize: 20,
        totalPages: 6,
        totalCount: 120,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      Object.hashAll([page.items.single.id, 'drug_0001']);

      Object.hashAll([page.page, 1]);

      Object.hashAll([page.pageSize, 20]);

      Object.hashAll([page.totalPages, 6]);

      Object.hashAll([page.totalCount, 120]);

      expect(page.disclaimer, 'FICTIONAL DATA');
    },
  );

  test('toDomain maps DrugDto root fields [assertion 1/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    expect(drug.id, dto.id);
    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 2/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    expect(drug.genericName, dto.genericName);
    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 3/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    expect(drug.brandName, dto.brandName);
    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 4/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    expect(drug.routeOfAdministration, dto.routeOfAdministration);
    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 5/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    expect(drug.composition, isA<CompositionInfo>());
    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 6/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    expect(drug.composition.activeIngredient, '一般名');
    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 7/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    expect(drug.composition.activeIngredientAmount.unit, 'mg');
    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 8/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    expect(drug.dosage, isA<DosageInfo>());
    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 9/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    expect(drug.dosage.standardDosage, '用量');
    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 10/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    expect(drug.adverseReactions, isA<AdverseReactionInfo>());
    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 11/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    expect(drug.adverseReactions.other.frequencyUnknown, isEmpty);
    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 12/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    expect(drug.relatedDiseaseIds, dto.relatedDiseaseIds);
    Object.hashAll([drug.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DrugDto root fields [assertion 13/13]', () {
    const dto = DrugDto(
      id: 'drug_0001',
      genericName: '一般名',
      brandName: 'ブランド名',
      brandNameKana: 'ブランドメイ',
      atcCode: 'A00AA00',
      yjCode: null,
      therapeuticCategoryName: '分類名',
      regulatoryClass: ['ordinary'],
      dosageForm: 'tablet',
      routeOfAdministration: 'oral',
      composition: CompositionInfoDto(
        activeIngredient: '一般名',
        activeIngredientAmount: DoseDto(amount: 1, unit: 'mg', per: null),
        inactiveIngredients: [],
        appearance: '白色',
        identificationCode: null,
      ),
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: DosageInfoDto(
        standardDosage: '用量',
        ageSpecificDosage: [],
        renalAdjustment: [],
        hepaticAdjustment: [],
      ),
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: AdverseReactionInfoDto(
        serious: [],
        other: AdverseReactionByFrequencyDto(
          over5Percent: [],
          between1And5Percent: [],
          under1Percent: [],
          frequencyUnknown: [],
        ),
      ),
      effectsOnLabTests: [],
      overdose: null,
      administrationPrecautions: [],
      otherPrecautions: [],
      pharmacokinetics: null,
      clinicalResults: [],
      pharmacology: null,
      physicochemicalProperties: null,
      handlingPrecautions: [],
      approvalConditions: [],
      packages: [],
      references: [],
      insuranceNotes: [],
      manufacturer: '架空製薬',
      revisedAt: '2026-05-01',
      relatedDiseaseIds: ['disease_0001'],
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
      disclaimer: 'FICTIONAL DATA',
    );

    final drug = dto.toDomain();

    Object.hashAll([drug.id, dto.id]);

    Object.hashAll([drug.genericName, dto.genericName]);

    Object.hashAll([drug.brandName, dto.brandName]);

    Object.hashAll([drug.routeOfAdministration, dto.routeOfAdministration]);

    Object.hashAll([drug.composition, isA<CompositionInfo>()]);

    Object.hashAll([drug.composition.activeIngredient, '一般名']);

    Object.hashAll([drug.composition.activeIngredientAmount.unit, 'mg']);

    Object.hashAll([drug.dosage, isA<DosageInfo>()]);

    Object.hashAll([drug.dosage.standardDosage, '用量']);

    Object.hashAll([drug.adverseReactions, isA<AdverseReactionInfo>()]);

    Object.hashAll([drug.adverseReactions.other.frequencyUnknown, isEmpty]);

    Object.hashAll([drug.relatedDiseaseIds, dto.relatedDiseaseIds]);

    expect(drug.disclaimer, dto.disclaimer);
  });
}
