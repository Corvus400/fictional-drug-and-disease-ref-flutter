import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Extracts a bookmark/list snapshot from a drug detail.
DrugSummary drugSummaryFromDrug(Drug drug) {
  return DrugSummary(
    id: drug.id,
    brandName: drug.brandName,
    genericName: drug.genericName,
    therapeuticCategoryName: drug.therapeuticCategoryName,
    regulatoryClass: drug.regulatoryClass,
    dosageForm: drug.dosageForm,
    brandNameKana: drug.brandNameKana,
    atcCode: drug.atcCode,
    revisedAt: drug.revisedAt,
    imageUrl: drug.imageUrl,
  );
}
