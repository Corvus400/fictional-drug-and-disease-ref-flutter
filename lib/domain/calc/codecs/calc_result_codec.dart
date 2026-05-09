import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';

/// Codec for typed calculation results stored in calculation history.
final class CalculationResultCodec {
  /// Creates a calculation result codec.
  const CalculationResultCodec();

  /// Encodes typed result to a JSON string.
  String encode(Object result) {
    return switch (result) {
      BmiResult() => jsonEncode(<String, Object>{
        'bmi': result.bmi,
        'category': result.category.storageKey,
      }),
      EgfrResult() => jsonEncode(<String, Object>{
        'eGfrMlMin173m2': result.eGfrMlMin173m2,
        'ckdStage': result.stage.storageKey,
      }),
      CrClResult() => jsonEncode(<String, Object>{
        'crClMlMin': result.crClMlMin,
      }),
      _ => throw ArgumentError.value(result, 'result', 'Unsupported result'),
    };
  }

  /// Decodes a JSON string to typed result for [calcType].
  Object decode(CalcType calcType, String source) {
    final data = _decodeObject(source);
    return switch (calcType) {
      CalcType.bmi => BmiResult(
        bmi: _requiredDouble(data, 'bmi'),
        category: BmiCategory.parse(_requiredString(data, 'category')),
      ),
      CalcType.egfr => EgfrResult(
        eGfrMlMin173m2: _requiredDouble(data, 'eGfrMlMin173m2'),
        stage: CkdStage.parse(_requiredString(data, 'ckdStage')),
      ),
      CalcType.crcl => CrClResult(
        crClMlMin: _requiredDouble(data, 'crClMlMin'),
      ),
    };
  }
}

Map<String, Object?> _decodeObject(String source) {
  final decoded = jsonDecode(source);
  if (decoded is Map<String, Object?>) {
    return decoded;
  }
  throw const FormatException('Expected JSON object');
}

double _requiredDouble(Map<String, Object?> data, String key) {
  final value = data[key];
  if (value is num) {
    return value.toDouble();
  }
  throw FormatException('Expected numeric $key');
}

String _requiredString(Map<String, Object?> data, String key) {
  final value = data[key];
  if (value is String) {
    return value;
  }
  throw FormatException('Expected string $key');
}
