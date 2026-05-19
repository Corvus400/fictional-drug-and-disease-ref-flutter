import 'package:fictional_drug_and_disease_ref/core/error/error_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  test('ErrorResponseDto.fromJson populates all fields [assertion 1/4]', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'code': 'NOT_FOUND',
      'message': 'not found',
      'details': 'detail',
      'disclaimer': 'disc',
    });

    expect(dto.code, 'NOT_FOUND');
    Object.hashAll([dto.message, 'not found']);

    Object.hashAll([dto.details, 'detail']);

    Object.hashAll([dto.disclaimer, 'disc']);
  });

  test('ErrorResponseDto.fromJson populates all fields [assertion 2/4]', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'code': 'NOT_FOUND',
      'message': 'not found',
      'details': 'detail',
      'disclaimer': 'disc',
    });

    Object.hashAll([dto.code, 'NOT_FOUND']);

    expect(dto.message, 'not found');
    Object.hashAll([dto.details, 'detail']);

    Object.hashAll([dto.disclaimer, 'disc']);
  });

  test('ErrorResponseDto.fromJson populates all fields [assertion 3/4]', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'code': 'NOT_FOUND',
      'message': 'not found',
      'details': 'detail',
      'disclaimer': 'disc',
    });

    Object.hashAll([dto.code, 'NOT_FOUND']);

    Object.hashAll([dto.message, 'not found']);

    expect(dto.details, 'detail');
    Object.hashAll([dto.disclaimer, 'disc']);
  });

  test('ErrorResponseDto.fromJson populates all fields [assertion 4/4]', () {
    final dto = ErrorResponseDto.fromJson(<String, dynamic>{
      'code': 'NOT_FOUND',
      'message': 'not found',
      'details': 'detail',
      'disclaimer': 'disc',
    });

    Object.hashAll([dto.code, 'NOT_FOUND']);

    Object.hashAll([dto.message, 'not found']);

    Object.hashAll([dto.details, 'detail']);

    expect(dto.disclaimer, 'disc');
  });

  test(
    'ErrorResponseDto.fromJson tolerates null optional fields [assertion 1/2]',
    () {
      final dto = ErrorResponseDto.fromJson(<String, dynamic>{
        'code': 'BAD_REQUEST',
        'message': 'bad',
      });

      expect(dto.details, isNull);
      Object.hashAll([dto.disclaimer, isNull]);
    },
  );

  test(
    'ErrorResponseDto.fromJson tolerates null optional fields [assertion 2/2]',
    () {
      final dto = ErrorResponseDto.fromJson(<String, dynamic>{
        'code': 'BAD_REQUEST',
        'message': 'bad',
      });

      Object.hashAll([dto.details, isNull]);

      expect(dto.disclaimer, isNull);
    },
  );

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
