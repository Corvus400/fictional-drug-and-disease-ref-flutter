import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';

/// Calculates eGFR.
final class CalculateEgfrUsecase {
  /// Creates the use case.
  const CalculateEgfrUsecase();

  /// Executes the use case.
  CalculateEgfrResult execute(EgfrInputs inputs) {
    final validation = inputs.validate();
    if (validation is EgfrInvalid) {
      return CalculateEgfrInvalid(errors: validation.errors);
    }
    return CalculateEgfrSuccess(Egfr.calculate(inputs));
  }
}

/// eGFR calculation use case result.
sealed class CalculateEgfrResult {
  const CalculateEgfrResult();
}

/// Successful eGFR calculation.
final class CalculateEgfrSuccess extends CalculateEgfrResult {
  /// Creates a success result.
  const CalculateEgfrSuccess(this.result);

  /// Calculation result.
  final EgfrResult result;
}

/// Invalid eGFR calculation input.
final class CalculateEgfrInvalid extends CalculateEgfrResult {
  /// Creates an invalid result.
  const CalculateEgfrInvalid({required this.errors});

  /// Field-level accepted range labels.
  final Map<String, String> errors;

  /// Invalid field name.
  String get field => errors.keys.first;

  /// Accepted range label.
  String get range => errors[field]!;
}
