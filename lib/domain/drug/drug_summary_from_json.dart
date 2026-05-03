import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Restores a drug summary snapshot from JSON.
DrugSummary drugSummaryFromJson(String json) {
  final map = jsonDecode(json) as Map<String, dynamic>;
  return DrugSummary(
    id: map['id'] as String,
    brandName: map['brandName'] as String,
    genericName: map['genericName'] as String,
    therapeuticCategoryName: map['therapeuticCategoryName'] as String,
    regulatoryClass: (map['regulatoryClass'] as List<dynamic>).cast<String>(),
    dosageForm: map['dosageForm'] as String,
    brandNameKana: map['brandNameKana'] as String,
    atcCode: map['atcCode'] as String,
    revisedAt: map['revisedAt'] as String,
    imageUrl: map['imageUrl'] as String,
  );
}

/// JSON serialization helpers for drug summary snapshots.
extension DrugSummarySnapshotJson on DrugSummary {
  /// Converts this summary snapshot to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandName': brandName,
      'genericName': genericName,
      'therapeuticCategoryName': therapeuticCategoryName,
      'regulatoryClass': regulatoryClass,
      'dosageForm': dosageForm,
      'brandNameKana': brandNameKana,
      'atcCode': atcCode,
      'revisedAt': revisedAt,
      'imageUrl': imageUrl,
    };
  }
}
