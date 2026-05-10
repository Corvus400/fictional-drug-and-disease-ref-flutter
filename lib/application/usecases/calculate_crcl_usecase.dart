import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';

/// Calculates Cockcroft-Gault CrCl.
final class CalculateCrClUsecase {
  /// Creates the use case.
  const CalculateCrClUsecase();

  /// Executes the use case.
  CalculateCrClResult execute(CrClInputs inputs) {
    final validation = inputs.validate();
    if (validation is CrClInvalid) {
      return CalculateCrClInvalid(errors: validation.errors);
    }
    return CalculateCrClSuccess(CrCl.calculate(inputs));
  }
}

/// CrCl calculation use case result.
sealed class CalculateCrClResult {
  const CalculateCrClResult();
}

/// Successful CrCl calculation.
final class CalculateCrClSuccess extends CalculateCrClResult {
  /// Creates a success result.
  const CalculateCrClSuccess(this.result);

  /// Calculation result.
  final CrClResult result;
}

/// Invalid CrCl calculation input.
final class CalculateCrClInvalid extends CalculateCrClResult {
  /// Creates an invalid result.
  const CalculateCrClInvalid({required this.errors});

  /// Field-level accepted range labels.
  final Map<String, String> errors;

  /// Invalid field name.
  String get field => errors.keys.first;

  /// Accepted range label.
  String get range => errors[field]!;
}
