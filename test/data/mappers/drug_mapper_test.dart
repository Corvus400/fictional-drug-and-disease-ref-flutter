import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_summary_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toDomain maps DrugSummaryDto fields', () {
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
    expect(summary.brandName, dto.brandName);
    expect(summary.genericName, dto.genericName);
    expect(summary.therapeuticCategoryName, dto.therapeuticCategoryName);
    expect(summary.regulatoryClass, dto.regulatoryClass);
    expect(summary.dosageForm, dto.dosageForm);
    expect(summary.brandNameKana, dto.brandNameKana);
    expect(summary.atcCode, dto.atcCode);
    expect(summary.revisedAt, dto.revisedAt);
    expect(summary.imageUrl, dto.imageUrl);
  });

  test('toDomain extracts DrugListPage disclaimer and items', () {
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
    expect(page.page, 1);
    expect(page.pageSize, 20);
    expect(page.totalPages, 6);
    expect(page.totalCount, 120);
    expect(page.disclaimer, 'FICTIONAL DATA');
  });

  test('toDomain maps DrugDto root fields', () {
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
      composition: {'active_ingredient': '一般名'},
      warning: [],
      contraindications: [],
      indications: [],
      indicationsRelatedPrecautions: [],
      dosage: {'standard_dosage': '用量'},
      dosageRelatedPrecautions: [],
      importantPrecautions: [],
      precautionsForSpecificPopulations: [],
      interactions: null,
      adverseReactions: {
        'serious': <Object>[],
        'other': <String, Object?>{},
      },
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
    expect(drug.genericName, dto.genericName);
    expect(drug.brandName, dto.brandName);
    expect(drug.routeOfAdministration, dto.routeOfAdministration);
    expect(drug.relatedDiseaseIds, dto.relatedDiseaseIds);
    expect(drug.disclaimer, dto.disclaimer);
  });
}
