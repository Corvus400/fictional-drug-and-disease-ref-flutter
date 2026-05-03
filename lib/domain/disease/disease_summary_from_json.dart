import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';

/// Restores a disease summary snapshot from JSON.
DiseaseSummary diseaseSummaryFromJson(String json) {
  final map = jsonDecode(json) as Map<String, dynamic>;
  return DiseaseSummary(
    id: map['id'] as String,
    name: map['name'] as String,
    icd10Chapter: map['icd10Chapter'] as String,
    medicalDepartment: (map['medicalDepartment'] as List<dynamic>)
        .cast<String>(),
    chronicity: map['chronicity'] as String,
    infectious: map['infectious'] as bool,
    nameKana: map['nameKana'] as String,
    revisedAt: map['revisedAt'] as String,
  );
}

/// JSON serialization helpers for disease summary snapshots.
extension DiseaseSummarySnapshotJson on DiseaseSummary {
  /// Converts this summary snapshot to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icd10Chapter': icd10Chapter,
      'medicalDepartment': medicalDepartment,
      'chronicity': chronicity,
      'infectious': infectious,
      'nameKana': nameKana,
      'revisedAt': revisedAt,
    };
  }
}
