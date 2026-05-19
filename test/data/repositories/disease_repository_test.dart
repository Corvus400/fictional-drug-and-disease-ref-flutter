import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('DiseaseRepository', () {
    late _MockDiseaseApiClient apiClient;
    late DiseaseRepository repository;

    setUp(() {
      apiClient = _MockDiseaseApiClient();
      repository = DiseaseRepository(apiClient);
    });

    test(
      'getDiseases returns mapped domain page on success [assertion 1/4]',
      () async {
        final response = _diseaseListResponseFixture();
        when(() => apiClient.getDiseases()).thenAnswer((_) async => response);

        final result = await repository.getDiseases();

        expect(result, isA<Ok<DiseaseListPage>>());
        final page = (result as Ok<DiseaseListPage>).value;
        Object.hashAll([page.items, hasLength(response.items.length)]);

        Object.hashAll([page.items.first.id, response.items.first.id]);

        Object.hashAll([page.totalCount, response.totalCount]);
      },
    );

    test(
      'getDiseases returns mapped domain page on success [assertion 2/4]',
      () async {
        final response = _diseaseListResponseFixture();
        when(() => apiClient.getDiseases()).thenAnswer((_) async => response);

        final result = await repository.getDiseases();

        Object.hashAll([result, isA<Ok<DiseaseListPage>>()]);

        final page = (result as Ok<DiseaseListPage>).value;
        expect(page.items, hasLength(response.items.length));
        Object.hashAll([page.items.first.id, response.items.first.id]);

        Object.hashAll([page.totalCount, response.totalCount]);
      },
    );

    test(
      'getDiseases returns mapped domain page on success [assertion 3/4]',
      () async {
        final response = _diseaseListResponseFixture();
        when(() => apiClient.getDiseases()).thenAnswer((_) async => response);

        final result = await repository.getDiseases();

        Object.hashAll([result, isA<Ok<DiseaseListPage>>()]);

        final page = (result as Ok<DiseaseListPage>).value;
        Object.hashAll([page.items, hasLength(response.items.length)]);

        expect(page.items.first.id, response.items.first.id);
        Object.hashAll([page.totalCount, response.totalCount]);
      },
    );

    test(
      'getDiseases returns mapped domain page on success [assertion 4/4]',
      () async {
        final response = _diseaseListResponseFixture();
        when(() => apiClient.getDiseases()).thenAnswer((_) async => response);

        final result = await repository.getDiseases();

        Object.hashAll([result, isA<Ok<DiseaseListPage>>()]);

        final page = (result as Ok<DiseaseListPage>).value;
        Object.hashAll([page.items, hasLength(response.items.length)]);

        Object.hashAll([page.items.first.id, response.items.first.id]);

        expect(page.totalCount, response.totalCount);
      },
    );

    test(
      'getDisease returns mapped domain detail on success [assertion 1/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

        final result = await repository.getDisease(dto.id);

        expect(result, isA<Ok<Disease>>());
        final disease = (result as Ok<Disease>).value;
        Object.hashAll([disease.id, dto.id]);

        Object.hashAll([disease.name, dto.name]);

        Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);
      },
    );

    test(
      'getDisease returns mapped domain detail on success [assertion 2/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

        final result = await repository.getDisease(dto.id);

        Object.hashAll([result, isA<Ok<Disease>>()]);

        final disease = (result as Ok<Disease>).value;
        expect(disease.id, dto.id);
        Object.hashAll([disease.name, dto.name]);

        Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);
      },
    );

    test(
      'getDisease returns mapped domain detail on success [assertion 3/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

        final result = await repository.getDisease(dto.id);

        Object.hashAll([result, isA<Ok<Disease>>()]);

        final disease = (result as Ok<Disease>).value;
        Object.hashAll([disease.id, dto.id]);

        expect(disease.name, dto.name);
        Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);
      },
    );

    test(
      'getDisease returns mapped domain detail on success [assertion 4/4]',
      () async {
        final dto = _diseaseFixture();
        when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

        final result = await repository.getDisease(dto.id);

        Object.hashAll([result, isA<Ok<Disease>>()]);

        final disease = (result as Ok<Disease>).value;
        Object.hashAll([disease.id, dto.id]);

        Object.hashAll([disease.name, dto.name]);

        expect(disease.relatedDrugIds, dto.relatedDrugIds);
      },
    );

    test('getDiseases expands search params to API wire values', () async {
      final response = _diseaseListResponseFixture();
      when(
        () => apiClient.getDiseases(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          icd10Chapter: any(named: 'icd10Chapter'),
          department: any(named: 'department'),
          chronicity: any(named: 'chronicity'),
          infectious: any(named: 'infectious'),
          keyword: any(named: 'keyword'),
          keywordMatch: any(named: 'keywordMatch'),
          keywordTarget: any(named: 'keywordTarget'),
          symptomKeyword: any(named: 'symptomKeyword'),
          onsetPattern: any(named: 'onsetPattern'),
          examCategory: any(named: 'examCategory'),
          hasPharmacologicalTreatment: any(
            named: 'hasPharmacologicalTreatment',
          ),
          hasSeverityGrading: any(named: 'hasSeverityGrading'),
          sort: any(named: 'sort'),
        ),
      ).thenAnswer((_) async => response);

      await repository.getDiseases(
        const DiseaseSearchParams(
          page: 3,
          pageSize: 15,
          icd10Chapter: ['IX'],
          department: ['cardiology'],
          chronicity: ['chronic'],
          infectious: false,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.nameEnglish,
          symptomKeyword: '頭痛',
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: true,
          hasSeverityGrading: true,
          sort: DiseaseSort.nameKana,
        ),
      );

      verify(
        () => apiClient.getDiseases(
          page: 3,
          pageSize: 15,
          icd10Chapter: ['IX'],
          department: ['cardiology'],
          chronicity: ['chronic'],
          infectious: false,
          keyword: '高血圧',
          keywordMatch: 'partial',
          keywordTarget: 'name_english',
          symptomKeyword: '頭痛',
          onsetPattern: ['INTERMITTENT'],
          examCategory: ['BLOOD_TEST'],
          hasPharmacologicalTreatment: true,
          hasSeverityGrading: true,
          sort: 'name_kana',
        ),
      ).called(1);
    });

    test(
      'getDiseases normalizes disease enum serial names to API enum constants',
      () async {
        final response = _diseaseListResponseFixture();
        when(
          () => apiClient.getDiseases(
            onsetPattern: any(named: 'onsetPattern'),
            examCategory: any(named: 'examCategory'),
          ),
        ).thenAnswer((_) async => response);

        await repository.getDiseases(
          const DiseaseSearchParams(
            onsetPattern: ['intermittent'],
            examCategory: ['blood_test'],
          ),
        );

        verify(
          () => apiClient.getDiseases(
            onsetPattern: ['INTERMITTENT'],
            examCategory: ['BLOOD_TEST'],
          ),
        ).called(1);
      },
    );

    test(
      'getDisease maps 404 response to ApiException [assertion 1/4]',
      () async {
        when(() => apiClient.getDisease('missing')).thenThrow(
          _badResponse(
            404,
            data: {
              'code': 'NOT_FOUND',
              'message': 'Disease not found',
            },
          ),
        );

        final result = await repository.getDisease('missing');

        expect(result, isA<Err<Disease>>());
        final error = (result as Err<Disease>).error;
        Object.hashAll([error, isA<ApiException>()]);

        Object.hashAll([(error as ApiException).code, 'NOT_FOUND']);

        Object.hashAll([error.statusCode, 404]);
      },
    );

    test(
      'getDisease maps 404 response to ApiException [assertion 2/4]',
      () async {
        when(() => apiClient.getDisease('missing')).thenThrow(
          _badResponse(
            404,
            data: {
              'code': 'NOT_FOUND',
              'message': 'Disease not found',
            },
          ),
        );

        final result = await repository.getDisease('missing');

        Object.hashAll([result, isA<Err<Disease>>()]);

        final error = (result as Err<Disease>).error;
        expect(error, isA<ApiException>());
        Object.hashAll([(error as ApiException).code, 'NOT_FOUND']);

        Object.hashAll([error.statusCode, 404]);
      },
    );

    test(
      'getDisease maps 404 response to ApiException [assertion 3/4]',
      () async {
        when(() => apiClient.getDisease('missing')).thenThrow(
          _badResponse(
            404,
            data: {
              'code': 'NOT_FOUND',
              'message': 'Disease not found',
            },
          ),
        );

        final result = await repository.getDisease('missing');

        Object.hashAll([result, isA<Err<Disease>>()]);

        final error = (result as Err<Disease>).error;
        Object.hashAll([error, isA<ApiException>()]);

        expect((error as ApiException).code, 'NOT_FOUND');
        Object.hashAll([error.statusCode, 404]);
      },
    );

    test(
      'getDisease maps 404 response to ApiException [assertion 4/4]',
      () async {
        when(() => apiClient.getDisease('missing')).thenThrow(
          _badResponse(
            404,
            data: {
              'code': 'NOT_FOUND',
              'message': 'Disease not found',
            },
          ),
        );

        final result = await repository.getDisease('missing');

        Object.hashAll([result, isA<Err<Disease>>()]);

        final error = (result as Err<Disease>).error;
        Object.hashAll([error, isA<ApiException>()]);

        Object.hashAll([(error as ApiException).code, 'NOT_FOUND']);

        expect(error.statusCode, 404);
      },
    );

    test(
      'getDiseases maps 500 response to ServerException [assertion 1/2]',
      () async {
        when(() => apiClient.getDiseases()).thenThrow(_badResponse(500));

        final result = await repository.getDiseases();

        expect(result, isA<Err<DiseaseListPage>>());
        Object.hashAll([
          (result as Err<DiseaseListPage>).error,
          isA<ServerException>(),
        ]);
      },
    );

    test(
      'getDiseases maps 500 response to ServerException [assertion 2/2]',
      () async {
        when(() => apiClient.getDiseases()).thenThrow(_badResponse(500));

        final result = await repository.getDiseases();

        Object.hashAll([result, isA<Err<DiseaseListPage>>()]);

        expect((result as Err<DiseaseListPage>).error, isA<ServerException>());
      },
    );

    test(
      'getDiseases maps FormatException to ParseException [assertion 1/2]',
      () async {
        when(
          () => apiClient.getDiseases(),
        ).thenThrow(const FormatException('bad'));

        final result = await repository.getDiseases();

        expect(result, isA<Err<DiseaseListPage>>());
        Object.hashAll([
          (result as Err<DiseaseListPage>).error,
          isA<ParseException>(),
        ]);
      },
    );

    test(
      'getDiseases maps FormatException to ParseException [assertion 2/2]',
      () async {
        when(
          () => apiClient.getDiseases(),
        ).thenThrow(const FormatException('bad'));

        final result = await repository.getDiseases();

        Object.hashAll([result, isA<Err<DiseaseListPage>>()]);

        expect((result as Err<DiseaseListPage>).error, isA<ParseException>());
      },
    );
  });
}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

DiseaseListResponseDto _diseaseListResponseFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseListResponseDto.fromJson(json);
}

DiseaseDto _diseaseFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}

DioException _badResponse(int statusCode, {Object? data}) {
  final requestOptions = RequestOptions(path: '/v1/diseases');
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
