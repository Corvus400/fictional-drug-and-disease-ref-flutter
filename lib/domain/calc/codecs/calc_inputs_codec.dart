import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';

/// Codec for typed calculation inputs stored in calculation history.
final class CalculationInputsCodec {
  /// Creates a calculation inputs codec.
  const CalculationInputsCodec();

  /// Encodes typed inputs to a JSON string.
  String encode(Object inputs) {
    return switch (inputs) {
      BmiInputs() => jsonEncode(<String, Object>{
        'heightCm': inputs.heightCm,
        'weightKg': inputs.weightKg,
      }),
      EgfrInputs() => jsonEncode(<String, Object>{
        'ageYears': inputs.ageYears,
        'sex': inputs.sex.storageKey,
        'serumCreatinineMgDl': inputs.serumCreatinineMgDl,
      }),
      CrClInputs() => jsonEncode(<String, Object>{
        'ageYears': inputs.ageYears,
        'sex': inputs.sex.storageKey,
        'weightKg': inputs.weightKg,
        'serumCreatinineMgDl': inputs.serumCreatinineMgDl,
      }),
      _ => throw ArgumentError.value(inputs, 'inputs', 'Unsupported inputs'),
    };
  }

  /// Decodes a JSON string to typed inputs for [calcType].
  Object decode(CalcType calcType, String source) {
    final data = _decodeObject(source);
    return switch (calcType) {
      CalcType.bmi => BmiInputs(
        heightCm: _requiredDouble(data, 'heightCm'),
        weightKg: _requiredDouble(data, 'weightKg'),
      ),
      CalcType.egfr => EgfrInputs(
        ageYears: _requiredInt(data, 'ageYears'),
        sex: Sex.parse(_requiredString(data, 'sex')),
        serumCreatinineMgDl: _requiredDouble(data, 'serumCreatinineMgDl'),
      ),
      CalcType.crcl => CrClInputs(
        ageYears: _requiredInt(data, 'ageYears'),
        sex: Sex.parse(_requiredString(data, 'sex')),
        weightKg: _requiredDouble(data, 'weightKg'),
        serumCreatinineMgDl: _requiredDouble(data, 'serumCreatinineMgDl'),
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

int _requiredInt(Map<String, Object?> data, String key) {
  final value = data[key];
  if (value is int) {
    return value;
  }
  throw FormatException('Expected integer $key');
}

String _requiredString(Map<String, Object?> data, String key) {
  final value = data[key];
  if (value is String) {
    return value;
  }
  throw FormatException('Expected string $key');
}
