import 'package:fictional_drug_and_disease_ref/core/error/error_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  test('ErrorResponseDto.fromJson populates all fields', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'code': 'NOT_FOUND',
      'message': 'not found',
      'details': 'detail',
      'disclaimer': 'disc',
    });

    expect(dto.code, 'NOT_FOUND');
    expect(dto.message, 'not found');
    expect(dto.details, 'detail');
    expect(dto.disclaimer, 'disc');
  });

  test('ErrorResponseDto.fromJson tolerates null optional fields', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'code': 'BAD_REQUEST',
      'message': 'bad',
    });

    expect(dto.details, isNull);
    expect(dto.disclaimer, isNull);
  });

  test(
    'ErrorResponseDto.fromJson throws CheckedFromJsonException on missing '
    'required field',
    () {
      expect(
        () => ErrorResponseDto.fromJson(<String, dynamic>{'code': 'X'}),
        throwsA(isA<CheckedFromJsonException>()),
      );
    },
  );
}
