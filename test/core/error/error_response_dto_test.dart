import 'package:fictional_drug_and_disease_ref/core/error/error_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  test('ErrorResponseDto.fromJson parses RFC 9457 problem details', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'type':
          'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
      'title': 'Validation failed',
      'status': 422,
      'detail': 'Invalid query parameter',
      'instance': '/v1/drugs?therapeutic_category=BOGUS',
      'errors': <Map<String, dynamic>>[
        <String, dynamic>{
          'field': 'therapeutic_category',
          'reason': 'Unknown therapeutic_category: BOGUS',
        },
      ],
    });

    expect(
      dto,
      isA<ErrorResponseDto>()
          .having(
            (e) => e.type,
            'type',
            'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
          )
          .having((e) => e.title, 'title', 'Validation failed')
          .having((e) => e.status, 'status', 422)
          .having((e) => e.detail, 'detail', 'Invalid query parameter')
          .having(
            (e) => e.instance,
            'instance',
            '/v1/drugs?therapeutic_category=BOGUS',
          )
          .having((e) => e.errors, 'errors', hasLength(1))
          .having(
            (e) => e.errors!.single.field,
            'error field',
            'therapeutic_category',
          )
          .having(
            (e) => e.errors!.single.reason,
            'error reason',
            'Unknown therapeutic_category: BOGUS',
          ),
    );
  });

  test('ErrorResponseDto.fromJson tolerates omitted optional fields', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'title': 'Resource not found',
      'status': 404,
    });

    expect(
      dto,
      isA<ErrorResponseDto>()
          .having((e) => e.type, 'type', isNull)
          .having((e) => e.detail, 'detail', isNull)
          .having((e) => e.instance, 'instance', isNull)
          .having((e) => e.errors, 'errors', isNull),
    );
  });

  test('ErrorResponseDto.fromJson throws on missing required field', () {
    expect(
      () => ErrorResponseDto.fromJson(<String, dynamic>{'status': 422}),
      throwsA(isA<CheckedFromJsonException>()),
    );
  });

  test('FieldViolationDto.fromJson parses field and reason', () {
    final dto = FieldViolationDto.fromJson(<String, dynamic>{
      'field': 'size',
      'reason': 'Unknown image size: BOGUS',
    });

    expect(
      dto,
      isA<FieldViolationDto>()
          .having((e) => e.field, 'field', 'size')
          .having((e) => e.reason, 'reason', 'Unknown image size: BOGUS'),
    );
  });
}
