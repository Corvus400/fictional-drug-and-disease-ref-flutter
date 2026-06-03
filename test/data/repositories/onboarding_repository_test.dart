import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/onboarding_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('OnboardingRepository', () {
    late _MockOnboardingService service;
    late OnboardingRepository repository;

    setUp(() {
      service = _MockOnboardingService();
      repository = OnboardingRepository(service);
    });

    test('read returns onboarding completion value from service', () async {
      when(() => service.read()).thenAnswer((_) async => const Result.ok(true));

      final result = await repository.read();

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, true);
    });

    test('write passes onboarding completion value to service', () async {
      when(() => service.write(completed: true)).thenAnswer(
        (_) async => const Result.ok(null),
      );

      final result = await repository.write(completed: true);

      expect(result, isA<Ok<void>>());
      verify(() => service.write(completed: true)).called(1);
    });
  });
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
