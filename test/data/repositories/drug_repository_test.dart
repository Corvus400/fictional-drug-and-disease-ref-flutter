import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('DrugRepository', () {
    late _MockDrugApiClient apiClient;
    late DrugRepository repository;

    setUp(() {
      apiClient = _MockDrugApiClient();
      repository = DrugRepository(apiClient);
    });

    test('getDrugs returns mapped domain page on success', () async {
      final response = _drugListResponseFixture();
      when(() => apiClient.getDrugs()).thenAnswer((_) async => response);

      final result = await repository.getDrugs();

      expect(result, isA<Ok<DrugListPage>>());
      final page = (result as Ok<DrugListPage>).value;
      expect(page.items, hasLength(response.items.length));
      expect(page.items.first.id, response.items.first.id);
      expect(page.totalCount, response.totalCount);
    });

    test('getDrug returns mapped domain detail on success', () async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      final result = await repository.getDrug(dto.id);

      expect(result, isA<Ok<Drug>>());
      final drug = (result as Ok<Drug>).value;
      expect(drug.id, dto.id);
      expect(drug.brandName, dto.brandName);
      expect(drug.relatedDiseaseIds, dto.relatedDiseaseIds);
    });

    test('getDrugs expands search params to API wire values', () async {
      final response = _drugListResponseFixture();
      when(
        () => apiClient.getDrugs(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          categoryAtc: any(named: 'categoryAtc'),
          therapeuticCategory: any(named: 'therapeuticCategory'),
          regulatoryClass: any(named: 'regulatoryClass'),
          dosageForm: any(named: 'dosageForm'),
          route: any(named: 'route'),
          keyword: any(named: 'keyword'),
          keywordMatch: any(named: 'keywordMatch'),
          keywordTarget: any(named: 'keywordTarget'),
          adverseReactionKeyword: any(named: 'adverseReactionKeyword'),
          precautionCategory: any(named: 'precautionCategory'),
          sort: any(named: 'sort'),
        ),
      ).thenAnswer((_) async => response);

      await repository.getDrugs(
        const DrugSearchParams(
          page: 2,
          pageSize: 10,
          categoryAtc: 'C',
          therapeuticCategory: 'antihypertensive',
          regulatoryClass: ['prescription'],
          dosageForm: ['tablet'],
          route: ['oral'],
          keyword: 'アムロジピン',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.brand,
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['elderly'],
          sort: DrugSort.brandNameKana,
        ),
      );

      verify(
        () => apiClient.getDrugs(
          page: 2,
          pageSize: 10,
          categoryAtc: 'C',
          therapeuticCategory: 'antihypertensive',
          regulatoryClass: ['prescription'],
          dosageForm: ['tablet'],
          route: ['oral'],
          keyword: 'アムロジピン',
          keywordMatch: 'prefix',
          keywordTarget: 'brand',
          adverseReactionKeyword: '浮腫',
          precautionCategory: ['elderly'],
          sort: 'brand_name_kana',
        ),
      ).called(1);
    });

    test('getDrug maps 404 response to ApiException', () async {
      when(() => apiClient.getDrug('missing')).thenThrow(
        _badResponse(
          404,
          data: {
            'code': 'NOT_FOUND',
            'message': 'Drug not found',
          },
        ),
      );

      final result = await repository.getDrug('missing');

      expect(result, isA<Err<Drug>>());
      final error = (result as Err<Drug>).error;
      expect(error, isA<ApiException>());
      expect((error as ApiException).code, 'NOT_FOUND');
      expect(error.statusCode, 404);
    });

    test('getDrugs maps 500 response to ServerException', () async {
      when(() => apiClient.getDrugs()).thenThrow(_badResponse(500));

      final result = await repository.getDrugs();

      expect(result, isA<Err<DrugListPage>>());
      expect((result as Err<DrugListPage>).error, isA<ServerException>());
    });

    test('getDrugs maps FormatException to ParseException', () async {
      when(() => apiClient.getDrugs()).thenThrow(const FormatException('bad'));

      final result = await repository.getDrugs();

      expect(result, isA<Err<DrugListPage>>());
      expect((result as Err<DrugListPage>).error, isA<ParseException>());
    });
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

DrugListResponseDto _drugListResponseFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}

DrugDto _drugFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}

DioException _badResponse(int statusCode, {Object? data}) {
  final requestOptions = RequestOptions(path: '/v1/drugs');
  return DioException(
    requestOptions: requestOptions,
    response: Response<Object?>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
    type: DioExceptionType.badResponse,
  );
}
