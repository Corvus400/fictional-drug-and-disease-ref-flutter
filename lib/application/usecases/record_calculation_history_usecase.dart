import 'dart:math';

import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_inputs_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_result_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';

const _calculationHistoryLimit = 50;

/// Clock used for calculation history timestamps.
typedef CalculationHistoryClock = DateTime Function();

/// Calculation history id factory.
typedef CalculationHistoryIdFactory = String Function();

/// Records calculation history.
final class RecordCalculationHistoryUsecase {
  /// Creates the use case.
  const RecordCalculationHistoryUsecase({
    required CalculationHistoryRepository calculationHistoryRepository,
    CalculationInputsCodec inputsCodec = const CalculationInputsCodec(),
    CalculationResultCodec resultCodec = const CalculationResultCodec(),
    CalculationHistoryClock clock = _defaultClock,
    CalculationHistoryIdFactory idFactory = _defaultId,
  }) : _calculationHistoryRepository = calculationHistoryRepository,
       _inputsCodec = inputsCodec,
       _resultCodec = resultCodec,
       _clock = clock,
       _idFactory = idFactory;

  static DateTime _defaultClock() => DateTime.now().toUtc();

  static String _defaultId() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0'));
    final value = hex.join();
    return '${value.substring(0, 8)}-'
        '${value.substring(8, 12)}-'
        '${value.substring(12, 16)}-'
        '${value.substring(16, 20)}-'
        '${value.substring(20)}';
  }

  final CalculationHistoryRepository _calculationHistoryRepository;
  final CalculationInputsCodec _inputsCodec;
  final CalculationResultCodec _resultCodec;
  final CalculationHistoryClock _clock;
  final CalculationHistoryIdFactory _idFactory;

  /// Executes the use case.
  Future<RecordCalculationHistoryResult> execute(
    CalcType calcType,
    Object inputs,
    Object result,
  ) async {
    try {
      final calculatedAt = _clock();
      final id = _idFactory();
      final insertResult = await _calculationHistoryRepository.insert(
        id: id,
        calcType: calcType.storageKey,
        inputsJson: _inputsCodec.encode(inputs),
        resultJson: _resultCodec.encode(result),
        calculatedAt: calculatedAt,
      );
      if (insertResult case Err<void>(:final error)) {
        return RecordCalculationHistoryFailure(error);
      }
      final trimResult = await _trimToLimit(calcType);
      if (trimResult is Err<void>) {
        return RecordCalculationHistoryFailure(trimResult.error);
      }
      return RecordCalculationHistorySuccess(id: id);
    } on Object catch (error) {
      return RecordCalculationHistoryFailure(toAppException(error));
    }
  }

  Future<Result<void>> _trimToLimit(CalcType calcType) async {
    final result = await _calculationHistoryRepository.findByCalcType(
      calcType.storageKey,
    );
    if (result case Err<List<CalculationHistoryEntry>>(:final error)) {
      return Result.error(error);
    }
    final entries = (result as Ok<List<CalculationHistoryEntry>>).value;
    for (
      var deleteCount = entries.length - _calculationHistoryLimit;
      deleteCount > 0;
      deleteCount -= 1
    ) {
      final deleteResult = await _calculationHistoryRepository
          .deleteOldestByCalcType(calcType.storageKey);
      if (deleteResult is Err<void>) {
        return deleteResult;
      }
    }
    return const Result.ok(null);
  }
}

/// Record calculation history result.
sealed class RecordCalculationHistoryResult {
  const RecordCalculationHistoryResult();
}

/// Successful record result.
final class RecordCalculationHistorySuccess
    extends RecordCalculationHistoryResult {
  /// Creates a success result.
  const RecordCalculationHistorySuccess({required this.id});

  /// Inserted row id.
  final String id;
}

/// Failed record result.
final class RecordCalculationHistoryFailure
    extends RecordCalculationHistoryResult {
  /// Creates a failure result.
  const RecordCalculationHistoryFailure(this.error);

  /// Application exception.
  final AppException error;
}
