import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

void main() {
  test('AppLogFilter in dev mode emits trace level', () {
    final filter = AppLogFilter(isReleaseMode: () => false);

    expect(filter.shouldLog(LogEvent(Level.trace, 'msg')), isTrue);
  });

  test('AppLogFilter in release mode suppresses info', () {
    final filter = AppLogFilter(isReleaseMode: () => true);

    expect(filter.shouldLog(LogEvent(Level.info, 'msg')), isFalse);
  });

  test('AppLogFilter in release mode emits warning level', () {
    final filter = AppLogFilter(isReleaseMode: () => true);

    expect(filter.shouldLog(LogEvent(Level.warning, 'msg')), isTrue);
  });

  test('RedactingPrinter masks sensitive keys', () {
    final printer = RedactingPrinter(inner: SimplePrinter(colors: false));
    final lines = printer.log(
      LogEvent(
        Level.info,
        <String, dynamic>{
          'Authorization': 'Bearer abc',
          'password': 'p',
          'foo': 'ok',
        },
      ),
    );

    final joined = lines.join('\n');
    expect(joined, contains('Authorization: ***'));
    expect(joined, contains('password: ***'));
    expect(joined, contains('foo: ok'));
  });

  test('RedactingPrinter masks token and email keys case-insensitively', () {
    final printer = RedactingPrinter(inner: SimplePrinter(colors: false));
    final lines = printer.log(
      LogEvent(
        Level.info,
        <String, dynamic>{'refreshToken': 'abc', 'userEmail': 'a@example.com'},
      ),
    );

    final joined = lines.join('\n');
    expect(joined, contains('refreshToken: ***'));
    expect(joined, contains('userEmail: ***'));
  });
}
