import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/categories_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('CategoriesRepository', () {
    late _MockCategoryApiClient apiClient;
    late CategoriesRepository repository;

    setUp(() {
      apiClient = _MockCategoryApiClient();
      repository = CategoriesRepository(apiClient);
    });

    test('getCategories first call hits API and maps domain model', () async {
      final response = _categoriesFixture();
      when(() => apiClient.getCategories()).thenAnswer((_) async => response);

      final result = await repository.getCategories();

      expect(result, isA<Ok<Categories>>());
      final categories = (result as Ok<Categories>).value;
      expect(categories.atc.first.code, response.atc.first.code);
      expect(categories.dosageForm, response.dosageForm);
      verify(() => apiClient.getCategories()).called(1);
    });

    test('getCategories second call without forceRefresh uses cache', () async {
      final response = _categoriesFixture();
      when(() => apiClient.getCategories()).thenAnswer((_) async => response);

      final first = await repository.getCategories();
      final second = await repository.getCategories();

      expect(first, isA<Ok<Categories>>());
      expect(second, isA<Ok<Categories>>());
      expect(
        identical(
          (first as Ok<Categories>).value,
          (second as Ok<Categories>).value,
        ),
        isTrue,
      );
      verify(() => apiClient.getCategories()).called(1);
    });

    test('getCategories forceRefresh ignores cache and updates it', () async {
      final firstResponse = _categoriesFixture();
      final secondResponse = firstResponse.copyWith(dosageForm: ['capsule']);
      var calls = 0;
      when(() => apiClient.getCategories()).thenAnswer((_) async {
        calls += 1;
        return calls == 1 ? firstResponse : secondResponse;
      });

      final first = await repository.getCategories();
      final refreshed = await repository.getCategories(forceRefresh: true);
      final cachedAfterRefresh = await repository.getCategories();

      expect((first as Ok<Categories>).value.dosageForm, contains('tablet'));
      expect(
        (refreshed as Ok<Categories>).value.dosageForm,
        ['capsule'],
      );
      expect(
        (cachedAfterRefresh as Ok<Categories>).value.dosageForm,
        ['capsule'],
      );
      verify(() => apiClient.getCategories()).called(2);
    });

    test('getCategories error does not populate cache', () async {
      final response = _categoriesFixture();
      when(() => apiClient.getCategories()).thenThrow(_badResponse(500));

      final failed = await repository.getCategories();

      expect(failed, isA<Err<Categories>>());
      expect((failed as Err<Categories>).error, isA<ServerException>());

      when(() => apiClient.getCategories()).thenAnswer((_) async => response);
      final recovered = await repository.getCategories();

      expect(recovered, isA<Ok<Categories>>());
      verify(() => apiClient.getCategories()).called(2);
    });
  });
}

final class _MockCategoryApiClient extends Mock implements CategoryApiClient {}

CategoriesResponseDto _categoriesFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_categories.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return CategoriesResponseDto.fromJson(json);
}

DioException _badResponse(int statusCode) {
  final requestOptions = RequestOptions(path: '/v1/categories');
  return DioException(
    requestOptions: requestOptions,
    response: Response<Object?>(
      requestOptions: requestOptions,
      statusCode: statusCode,
    ),
    type: DioExceptionType.badResponse,
  );
}
