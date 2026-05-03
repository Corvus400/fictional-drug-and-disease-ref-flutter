import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';

/// Restores a disease summary snapshot from JSON.
DiseaseSummary diseaseSummaryFromJson(String json) {
  final Object? decoded = jsonDecode(json);
  if (decoded is! Map<String, Object?>) {
    throw const FormatException('Expected disease summary JSON object');
  }
  final map = decoded;
  return DiseaseSummary(
    id: _requiredString(map, 'id'),
    name: _requiredString(map, 'name'),
    icd10Chapter: _requiredString(map, 'icd10Chapter'),
    medicalDepartment: _stringList(map['medicalDepartment']),
    chronicity: _requiredString(map, 'chronicity'),
    infectious: _requiredBool(map, 'infectious'),
    nameKana: _requiredString(map, 'nameKana'),
    revisedAt: _requiredString(map, 'revisedAt'),
  );
}

/// JSON serialization helpers for disease summary snapshots.
extension DiseaseSummarySnapshotJson on DiseaseSummary {
  /// Converts this summary snapshot to JSON.
  Map<String, Object?> toJson() {
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

List<String> _stringList(Object? value) {
  if (value is! Iterable<Object?>) {
    throw const FormatException('Expected JSON string list');
  }
  return value
      .map((item) {
        if (item is! String) {
          throw const FormatException('Expected JSON string list');
        }
        return item;
      })
      .toList(growable: false);
}

String _requiredString(Map<String, Object?> map, String key) {
  final value = map[key];
  if (value is! String) {
    throw FormatException('Expected JSON string value for "$key"');
  }
  return value;
}

bool _requiredBool(Map<String, Object?> map, String key) {
  final value = map[key];
  if (value is! bool) {
    throw FormatException('Expected JSON bool value for "$key"');
  }
  return value;
}
