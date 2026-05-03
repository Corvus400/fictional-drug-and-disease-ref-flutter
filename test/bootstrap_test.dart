import 'package:fictional_drug_and_disease_ref/bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

void main() {
  test('handleFlutterError calls FlutterError.presentError in debug', () {
    final originalPresent = FlutterError.presentError;
    var presented = 0;
    FlutterError.presentError = (_) {
      presented++;
    };
    addTearDown(() {
      FlutterError.presentError = originalPresent;
    });

    handleFlutterError(
      FlutterErrorDetails(exception: Exception('x')),
      isDebug: () => true,
      logger: _capturingLogger(),
    );

    expect(presented, 1);
  });

  test('handleFlutterError suppresses presentError in release', () {
    final originalPresent = FlutterError.presentError;
    var presented = 0;
    FlutterError.presentError = (_) {
      presented++;
    };
    addTearDown(() {
      FlutterError.presentError = originalPresent;
    });

    handleFlutterError(
      FlutterErrorDetails(exception: Exception('x')),
      isDebug: () => false,
      logger: _capturingLogger(),
    );

    expect(presented, 0);
  });

  test('handlePlatformError returns true', () {
    expect(
      handlePlatformError(
        Exception('x'),
        StackTrace.current,
        logger: _capturingLogger(),
      ),
      isTrue,
    );
  });

  test('handleZoneError logs error/stack via injected logger', () {
    final captured = _CapturingLogOutput();
    final testLogger = _capturingLogger(output: captured);

    handleZoneError(
      Exception('zone-x'),
      StackTrace.current,
      logger: testLogger,
    );

    expect(captured.events, hasLength(1));
    expect(captured.events.first.level, Level.error);
  });
}

Logger _capturingLogger({_CapturingLogOutput? output}) {
  return Logger(
    filter: ProductionFilter(),
    printer: SimplePrinter(colors: false),
    output: output ?? _CapturingLogOutput(),
  );
}

class _CapturingLogOutput extends LogOutput {
  final events = <OutputEvent>[];

  @override
  void output(OutputEvent event) => events.add(event);
}
