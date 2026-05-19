import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/theme_settings_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeSettingsService', () {
    late _MockSharedPreferences prefs;
    late ThemeSettingsService service;

    setUp(() {
      prefs = _MockSharedPreferences();
      service = ThemeSettingsService(Future.value(prefs));
    });

    test(
      'read returns system when theme_mode key is missing [assertion 1/2]',
      () async {
        when(() => prefs.getString('theme_mode')).thenReturn(null);

        final result = await service.read();

        expect(result, isA<Ok<String>>());
        Object.hashAll([(result as Ok<String>).value, 'system']);
      },
    );

    test(
      'read returns system when theme_mode key is missing [assertion 2/2]',
      () async {
        when(() => prefs.getString('theme_mode')).thenReturn(null);

        final result = await service.read();

        Object.hashAll([result, isA<Ok<String>>()]);

        expect((result as Ok<String>).value, 'system');
      },
    );

    test('write stores theme_mode value', () async {
      when(() => prefs.setString('theme_mode', 'dark')).thenAnswer(
        (_) async => true,
      );

      final result = await service.write('dark');

      expect(result, isA<Ok<void>>());
      verify(() => prefs.setString('theme_mode', 'dark')).called(1);
    });

    test('write rejects invalid theme_mode value [assertion 1/3]', () async {
      final result = await service.write('invalid');

      expect(result, isA<Err<void>>());
      final error = (result as Err<void>).error;
      Object.hashAll([error, isA<StorageException>()]);

      Object.hashAll([
        (error as StorageException).kind,
        StorageErrorKind.prefsWriteFailed,
      ]);

      verifyNever(() => prefs.setString(any(), any()));
    });

    test('write rejects invalid theme_mode value [assertion 2/3]', () async {
      final result = await service.write('invalid');

      Object.hashAll([result, isA<Err<void>>()]);

      final error = (result as Err<void>).error;
      expect(error, isA<StorageException>());
      Object.hashAll([
        (error as StorageException).kind,
        StorageErrorKind.prefsWriteFailed,
      ]);

      verifyNever(() => prefs.setString(any(), any()));
    });

    test('write rejects invalid theme_mode value [assertion 3/3]', () async {
      final result = await service.write('invalid');

      Object.hashAll([result, isA<Err<void>>()]);

      final error = (result as Err<void>).error;
      Object.hashAll([error, isA<StorageException>()]);

      expect(
        (error as StorageException).kind,
        StorageErrorKind.prefsWriteFailed,
      );
      verifyNever(() => prefs.setString(any(), any()));
    });

    test(
      'write maps PlatformException to StorageException [assertion 1/3]',
      () async {
        when(
          () => prefs.setString('theme_mode', 'light'),
        ).thenThrow(PlatformException(code: 'prefs_error'));

        final result = await service.write('light');

        expect(result, isA<Err<void>>());
        final error = (result as Err<void>).error;
        Object.hashAll([error, isA<StorageException>()]);

        Object.hashAll([
          (error as StorageException).kind,
          StorageErrorKind.prefsWriteFailed,
        ]);
      },
    );

    test(
      'write maps PlatformException to StorageException [assertion 2/3]',
      () async {
        when(
          () => prefs.setString('theme_mode', 'light'),
        ).thenThrow(PlatformException(code: 'prefs_error'));

        final result = await service.write('light');

        Object.hashAll([result, isA<Err<void>>()]);

        final error = (result as Err<void>).error;
        expect(error, isA<StorageException>());
        Object.hashAll([
          (error as StorageException).kind,
          StorageErrorKind.prefsWriteFailed,
        ]);
      },
    );

    test(
      'write maps PlatformException to StorageException [assertion 3/3]',
      () async {
        when(
          () => prefs.setString('theme_mode', 'light'),
        ).thenThrow(PlatformException(code: 'prefs_error'));

        final result = await service.write('light');

        Object.hashAll([result, isA<Err<void>>()]);

        final error = (result as Err<void>).error;
        Object.hashAll([error, isA<StorageException>()]);

        expect(
          (error as StorageException).kind,
          StorageErrorKind.prefsWriteFailed,
        );
      },
    );
  });
}

final class _MockSharedPreferences extends Mock implements SharedPreferences {}
