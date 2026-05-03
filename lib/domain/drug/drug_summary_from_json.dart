import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Restores a drug summary snapshot from JSON.
DrugSummary drugSummaryFromJson(String json) {
  final Object? decoded = jsonDecode(json);
  if (decoded is! Map<String, Object?>) {
    throw const FormatException('Expected drug summary JSON object');
  }
  final map = decoded;
  return DrugSummary(
    id: _requiredString(map, 'id'),
    brandName: _requiredString(map, 'brandName'),
    genericName: _requiredString(map, 'genericName'),
    therapeuticCategoryName: _requiredString(map, 'therapeuticCategoryName'),
    regulatoryClass: _stringList(map['regulatoryClass']),
    dosageForm: _requiredString(map, 'dosageForm'),
    brandNameKana: _requiredString(map, 'brandNameKana'),
    atcCode: _requiredString(map, 'atcCode'),
    revisedAt: _requiredString(map, 'revisedAt'),
    imageUrl: _requiredString(map, 'imageUrl'),
  );
}

/// JSON serialization helpers for drug summary snapshots.
extension DrugSummarySnapshotJson on DrugSummary {
  /// Converts this summary snapshot to JSON.
  Map<String, Object?> toJson() {
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
