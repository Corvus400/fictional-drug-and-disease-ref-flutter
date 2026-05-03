import 'dart:async';

import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

/// Backward-compatible logger export for existing call sites.
final Logger logger = appLogger;

/// Predicate for checking whether debug behavior should run.
typedef IsDebugPredicate = bool Function();

/// Logs Flutter framework errors and presents them in debug mode.
@visibleForTesting
void handleFlutterError(
  FlutterErrorDetails details, {
  IsDebugPredicate isDebug = _defaultIsDebug,
  Logger? logger,
}) {
  (logger ?? appLogger).e(
    'FlutterError',
    error: details.exception,
    stackTrace: details.stack,
  );
  if (isDebug()) {
    FlutterError.presentError(details);
  }
}

/// Logs platform-dispatcher errors and reports them as handled.
@visibleForTesting
bool handlePlatformError(Object error, StackTrace stack, {Logger? logger}) {
  (logger ?? appLogger).e(
    'PlatformDispatcher',
    error: error,
    stackTrace: stack,
  );
  return true;
}

/// Logs uncaught zone errors.
@visibleForTesting
void handleZoneError(Object error, StackTrace stack, {Logger? logger}) {
  (logger ?? appLogger).e('Zone', error: error, stackTrace: stack);
}

bool _defaultIsDebug() => kDebugMode;

/// Starts the Flutter application with global error handlers.
void bootstrap(Widget Function() builder) {
  FlutterError.onError = handleFlutterError;
  PlatformDispatcher.instance.onError = handlePlatformError;
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(builder());
    },
    handleZoneError,
  );
}
