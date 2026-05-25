// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorResponseDto _$ErrorResponseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ErrorResponseDto', json, ($checkedConvert) {
      final val = _ErrorResponseDto(
        title: $checkedConvert('title', (v) => v as String),
        status: $checkedConvert('status', (v) => (v as num).toInt()),
        type: $checkedConvert('type', (v) => v as String?),
        detail: $checkedConvert('detail', (v) => v as String?),
        instance: $checkedConvert('instance', (v) => v as String?),
        errors: $checkedConvert(
          'errors',
          (v) => (v as List<dynamic>?)
              ?.map(
                (e) => FieldViolationDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ErrorResponseDtoToJson(_ErrorResponseDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'status': instance.status,
      'type': instance.type,
      'detail': instance.detail,
      'instance': instance.instance,
      'errors': instance.errors,
    };

_FieldViolationDto _$FieldViolationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FieldViolationDto', json, ($checkedConvert) {
      final val = _FieldViolationDto(
        field: $checkedConvert('field', (v) => v as String),
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FieldViolationDtoToJson(_FieldViolationDto instance) =>
    <String, dynamic>{'field': instance.field, 'reason': instance.reason};
