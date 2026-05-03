import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

/// Shared application logger.
final logger = Logger();

/// Starts the Flutter application with global error handlers.
void bootstrap(Widget Function() builder) {
  FlutterError.onError = (details) {
    logger.e(
      'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e('PlatformDispatcher', error: error, stackTrace: stack);
    return true;
  };
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(builder());
    },
    (error, stack) {
      logger.e('Zone', error: error, stackTrace: stack);
    },
  );
}
