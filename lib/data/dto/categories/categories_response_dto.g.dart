// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AtcEntryDto _$AtcEntryDtoFromJson(Map<String, dynamic> json) =>
    _AtcEntryDto(code: json['code'] as String, label: json['label'] as String);

Map<String, dynamic> _$AtcEntryDtoToJson(_AtcEntryDto instance) =>
    <String, dynamic>{'code': instance.code, 'label': instance.label};

_TherapeuticCategoryEntryDto _$TherapeuticCategoryEntryDtoFromJson(
  Map<String, dynamic> json,
) => _TherapeuticCategoryEntryDto(
  id: json['id'] as String,
  label: json['label'] as String,
);

Map<String, dynamic> _$TherapeuticCategoryEntryDtoToJson(
  _TherapeuticCategoryEntryDto instance,
) => <String, dynamic>{'id': instance.id, 'label': instance.label};

_Icd10ChapterEntryDto _$Icd10ChapterEntryDtoFromJson(
  Map<String, dynamic> json,
) => _Icd10ChapterEntryDto(
  roman: json['roman'] as String,
  code: json['code'] as String,
  label: json['label'] as String,
);

Map<String, dynamic> _$Icd10ChapterEntryDtoToJson(
  _Icd10ChapterEntryDto instance,
) => <String, dynamic>{
  'roman': instance.roman,
  'code': instance.code,
  'label': instance.label,
};

_CategoriesResponseDto _$CategoriesResponseDtoFromJson(
  Map<String, dynamic> json,
) => _CategoriesResponseDto(
  atc: (json['atc'] as List<dynamic>)
      .map((e) => AtcEntryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  therapeuticCategories: (json['therapeutic_categories'] as List<dynamic>)
      .map(
        (e) => TherapeuticCategoryEntryDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  routeOfAdministration: (json['route_of_administration'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  dosageForm: (json['dosage_form'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  regulatoryClass: (json['regulatory_class'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  icd10Chapters: (json['icd10_chapters'] as List<dynamic>)
      .map((e) => Icd10ChapterEntryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  medicalDepartments: (json['medical_departments'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CategoriesResponseDtoToJson(
  _CategoriesResponseDto instance,
) => <String, dynamic>{
  'atc': instance.atc,
  'therapeutic_categories': instance.therapeuticCategories,
  'route_of_administration': instance.routeOfAdministration,
  'dosage_form': instance.dosageForm,
  'regulatory_class': instance.regulatoryClass,
  'icd10_chapters': instance.icd10Chapters,
  'medical_departments': instance.medicalDepartments,
};
