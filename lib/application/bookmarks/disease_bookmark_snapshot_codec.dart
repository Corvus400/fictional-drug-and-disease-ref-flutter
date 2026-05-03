import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';

/// Encodes and decodes disease bookmark snapshots.
final class DiseaseBookmarkSnapshotCodec {
  /// Creates a disease bookmark snapshot codec.
  const DiseaseBookmarkSnapshotCodec();

  /// Extracts a bookmark snapshot from a disease detail.
  DiseaseSummary fromDisease(Disease disease) {
    return DiseaseSummary(
      id: disease.id,
      name: disease.name,
      icd10Chapter: disease.icd10Chapter,
      medicalDepartment: disease.medicalDepartment,
      chronicity: disease.chronicity,
      infectious: disease.infectious,
      nameKana: disease.nameKana,
      revisedAt: disease.revisedAt,
    );
  }

  /// Encodes a disease summary snapshot to JSON.
  String encode(DiseaseSummary summary) => jsonEncode(_toJson(summary));

  /// Decodes a disease summary snapshot from JSON.
  DiseaseSummary decode(String json) {
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

  Map<String, Object?> _toJson(DiseaseSummary summary) {
    return {
      'id': summary.id,
      'name': summary.name,
      'icd10Chapter': summary.icd10Chapter,
      'medicalDepartment': summary.medicalDepartment,
      'chronicity': summary.chronicity,
      'infectious': summary.infectious,
      'nameKana': summary.nameKana,
      'revisedAt': summary.revisedAt,
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
