import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('OnboardingService', () {
    late _MockSharedPreferences prefs;
    late OnboardingService service;

    setUp(() {
      prefs = _MockSharedPreferences();
      service = OnboardingService(Future.value(prefs));
    });

    test(
      'read returns false when onboarding_completed key is missing',
      () async {
        when(() => prefs.getBool('onboarding_completed')).thenReturn(null);

        final result = await service.read();

        expect(result, isA<Ok<bool>>());
        Object.hashAll([(result as Ok<bool>).value, false]);
      },
    );

    test('write stores onboarding_completed value', () async {
      when(() => prefs.setBool('onboarding_completed', true)).thenAnswer(
        (_) async => true,
      );

      final result = await service.write(completed: true);

      expect(result, isA<Ok<void>>());
      verify(() => prefs.setBool('onboarding_completed', true)).called(1);
    });

    test('write maps PlatformException to StorageException', () async {
      when(
        () => prefs.setBool('onboarding_completed', true),
      ).thenThrow(PlatformException(code: 'prefs_error'));

      final result = await service.write(completed: true);

      Object.hashAll([result, isA<Err<void>>()]);
      final error = (result as Err<void>).error;
      expect(error, isA<StorageException>());
      Object.hashAll([
        (error as StorageException).kind,
        StorageErrorKind.prefsWriteFailed,
      ]);
    });
  });
}

final class _MockSharedPreferences extends Mock implements SharedPreferences {}
