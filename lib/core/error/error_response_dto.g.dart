// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorResponseDto _$ErrorResponseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ErrorResponseDto', json, ($checkedConvert) {
      final val = _ErrorResponseDto(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
        details: $checkedConvert('details', (v) => v as String?),
        disclaimer: $checkedConvert('disclaimer', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ErrorResponseDtoToJson(_ErrorResponseDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'details': instance.details,
      'disclaimer': instance.disclaimer,
    };
