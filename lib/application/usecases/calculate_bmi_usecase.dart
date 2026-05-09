import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';

/// Calculates BMI.
final class CalculateBmiUsecase {
  /// Creates the use case.
  const CalculateBmiUsecase();

  /// Executes the use case.
  CalculateBmiResult execute(BmiInputs inputs) {
    final validation = inputs.validate();
    if (validation is BmiInvalid) {
      return CalculateBmiInvalid(
        field: validation.field,
        range: validation.range,
      );
    }
    return CalculateBmiSuccess(Bmi.calculate(inputs));
  }
}

/// BMI calculation use case result.
sealed class CalculateBmiResult {
  const CalculateBmiResult();
}

/// Successful BMI calculation.
final class CalculateBmiSuccess extends CalculateBmiResult {
  /// Creates a success result.
  const CalculateBmiSuccess(this.result);

  /// Calculation result.
  final BmiResult result;
}

/// Invalid BMI calculation input.
final class CalculateBmiInvalid extends CalculateBmiResult {
  /// Creates an invalid result.
  const CalculateBmiInvalid({required this.field, required this.range});

  /// Invalid field name.
  final String field;

  /// Accepted range label.
  final String range;
}
