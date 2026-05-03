import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Shared application logger.
final appLogger = Logger(
  filter: AppLogFilter(),
  printer: RedactingPrinter(
    inner: kReleaseMode ? SimplePrinter() : PrettyPrinter(),
  ),
  output: ConsoleOutput(),
);

/// Controls application log levels per build mode.
@visibleForTesting
class AppLogFilter extends LogFilter {
  /// Creates a filter.
  AppLogFilter({this.isReleaseMode = _defaultIsRelease});

  /// Build-mode predicate injected by tests.
  final bool Function() isReleaseMode;

  static bool _defaultIsRelease() => kReleaseMode;

  @override
  bool shouldLog(LogEvent event) {
    if (isReleaseMode()) {
      return event.level.index >= Level.warning.index;
    }
    return event.level.index >= Level.trace.index;
  }
}

/// Masks sensitive map values before delegating to an inner [LogPrinter].
@visibleForTesting
class RedactingPrinter extends LogPrinter {
  /// Creates a redacting printer.
  RedactingPrinter({required this.inner});

  static const _sensitiveKeyParts = {
    'authorization',
    'password',
    'token',
    'email',
  };

  /// Printer that receives the redacted event.
  final LogPrinter inner;

  @override
  Future<void> init() => inner.init();

  @override
  List<String> log(LogEvent event) {
    return inner.log(
      LogEvent(
        event.level,
        _redact(event.message),
        time: event.time,
        error: event.error,
        stackTrace: event.stackTrace,
      ),
    );
  }

  @override
  Future<void> destroy() => inner.destroy();

  Object? _redact(Object? value) {
    if (value is Map) {
      return value.entries
          .map((entry) {
            final key = entry.key.toString();
            final redactedValue = _isSensitiveKey(key) ? '***' : entry.value;
            return '$key: $redactedValue';
          })
          .join('\n');
    }
    return value;
  }

  bool _isSensitiveKey(String key) {
    final normalized = key.toLowerCase();
    return _sensitiveKeyParts.any(normalized.contains);
  }
}
