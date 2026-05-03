import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Encodes and decodes drug bookmark snapshots.
final class DrugBookmarkSnapshotCodec {
  /// Creates a drug bookmark snapshot codec.
  const DrugBookmarkSnapshotCodec();

  /// Extracts a bookmark snapshot from a drug detail.
  DrugSummary fromDrug(Drug drug) {
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

  /// Encodes a drug summary snapshot to JSON.
  String encode(DrugSummary summary) => jsonEncode(_toJson(summary));

  /// Decodes a drug summary snapshot from JSON.
  DrugSummary decode(String json) {
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

  Map<String, Object?> _toJson(DrugSummary summary) {
    return {
      'id': summary.id,
      'brandName': summary.brandName,
      'genericName': summary.genericName,
      'therapeuticCategoryName': summary.therapeuticCategoryName,
      'regulatoryClass': summary.regulatoryClass,
      'dosageForm': summary.dosageForm,
      'brandNameKana': summary.brandNameKana,
      'atcCode': summary.atcCode,
      'revisedAt': summary.revisedAt,
      'imageUrl': summary.imageUrl,
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
