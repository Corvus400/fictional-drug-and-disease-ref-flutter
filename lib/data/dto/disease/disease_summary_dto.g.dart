// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiseaseSummaryDto _$DiseaseSummaryDtoFromJson(Map<String, dynamic> json) =>
    _DiseaseSummaryDto(
      id: json['id'] as String,
      name: json['name'] as String,
      icd10Chapter: json['icd10_chapter'] as String,
      medicalDepartment: (json['medical_department'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      chronicity: json['chronicity'] as String,
      infectious: json['infectious'] as bool,
      nameKana: json['name_kana'] as String,
      revisedAt: json['revised_at'] as String,
    );

Map<String, dynamic> _$DiseaseSummaryDtoToJson(_DiseaseSummaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icd10_chapter': instance.icd10Chapter,
      'medical_department': instance.medicalDepartment,
      'chronicity': instance.chronicity,
      'infectious': instance.infectious,
      'name_kana': instance.nameKana,
      'revised_at': instance.revisedAt,
    };
