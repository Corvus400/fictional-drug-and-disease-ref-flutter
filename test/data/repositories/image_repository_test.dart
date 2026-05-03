import 'dart:typed_data';

import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/image_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/image_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('ImageRepository', () {
    late _MockImageApiService service;
    late ImageRepository repository;

    setUp(() {
      service = _MockImageApiService();
      repository = ImageRepository(service);
    });

    test('getDrugImage returns drug image bytes on success', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      when(
        () => service.getDrugImage('drug_001', size: any(named: 'size')),
      ).thenAnswer((_) async => Result.ok(bytes));

      final result = await repository.getDrugImage(
        drugId: 'drug_001',
        dosageForm: 'tablet',
      );

      expect(result, isA<Ok<Uint8List>>());
      expect((result as Ok<Uint8List>).value, bytes);
      verify(
        () => service.getDrugImage('drug_001', size: any(named: 'size')),
      ).called(1);
      verifyNever(
        () => service.getDosageFormImage(any(), size: any(named: 'size')),
      );
    });

    test('getDrugImage falls back to dosage form image on NOT_FOUND', () async {
      final fallback = Uint8List.fromList([9, 8, 7]);
      when(
        () => service.getDrugImage('drug_001', size: 'Small'),
      ).thenAnswer(
        (_) async => const Result.error(
          ApiException(
            statusCode: 404,
            code: 'NOT_FOUND',
            message: 'missing',
          ),
        ),
      );
      when(
        () => service.getDosageFormImage('tablet', size: 'Small'),
      ).thenAnswer((_) async => Result.ok(fallback));

      final result = await repository.getDrugImage(
        drugId: 'drug_001',
        dosageForm: 'tablet',
        size: 'Small',
      );

      expect(result, isA<Ok<Uint8List>>());
      expect((result as Ok<Uint8List>).value, fallback);
      verify(
        () => service.getDosageFormImage('tablet', size: 'Small'),
      ).called(1);
    });

    test(
      'getDrugImage returns dosage form NOT_FOUND when fallback misses',
      () async {
        const notFound = ApiException(
          statusCode: 404,
          code: 'NOT_FOUND',
          message: 'missing',
        );
        when(
          () => service.getDrugImage('drug_001', size: any(named: 'size')),
        ).thenAnswer((_) async => const Result.error(notFound));
        when(
          () => service.getDosageFormImage('tablet', size: any(named: 'size')),
        ).thenAnswer((_) async => const Result.error(notFound));

        final result = await repository.getDrugImage(
          drugId: 'drug_001',
          dosageForm: 'tablet',
        );

        expect(result, isA<Err<Uint8List>>());
        final error = (result as Err<Uint8List>).error;
        expect(error, isA<ApiException>());
        expect((error as ApiException).code, 'NOT_FOUND');
        verify(
          () => service.getDosageFormImage('tablet', size: any(named: 'size')),
        ).called(1);
      },
    );

    test('getDrugImage does not fall back on server error', () async {
      const error = ServerException(statusCode: 500);
      when(
        () => service.getDrugImage('drug_001', size: any(named: 'size')),
      ).thenAnswer((_) async => const Result.error(error));

      final result = await repository.getDrugImage(
        drugId: 'drug_001',
        dosageForm: 'tablet',
      );

      expect(result, isA<Err<Uint8List>>());
      expect((result as Err<Uint8List>).error, isA<ServerException>());
      verifyNever(
        () => service.getDosageFormImage(any(), size: any(named: 'size')),
      );
    });

    test('getDosageFormImage delegates to service', () async {
      final bytes = Uint8List.fromList([4, 5, 6]);
      when(
        () => service.getDosageFormImage('tablet', size: any(named: 'size')),
      ).thenAnswer((_) async => Result.ok(bytes));

      final result = await repository.getDosageFormImage('tablet');

      expect(result, isA<Ok<Uint8List>>());
      expect((result as Ok<Uint8List>).value, bytes);
      verify(
        () => service.getDosageFormImage('tablet', size: any(named: 'size')),
      ).called(1);
    });
  });
}

final class _MockImageApiService extends Mock implements ImageApiService {}
