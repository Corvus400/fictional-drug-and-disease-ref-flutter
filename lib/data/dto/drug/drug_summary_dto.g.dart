// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DrugSummaryDto _$DrugSummaryDtoFromJson(Map<String, dynamic> json) =>
    _DrugSummaryDto(
      id: json['id'] as String,
      brandName: json['brand_name'] as String,
      genericName: json['generic_name'] as String,
      therapeuticCategoryName: json['therapeutic_category_name'] as String,
      regulatoryClass: (json['regulatory_class'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dosageForm: json['dosage_form'] as String,
      brandNameKana: json['brand_name_kana'] as String,
      atcCode: json['atc_code'] as String,
      revisedAt: json['revised_at'] as String,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$DrugSummaryDtoToJson(_DrugSummaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand_name': instance.brandName,
      'generic_name': instance.genericName,
      'therapeutic_category_name': instance.therapeuticCategoryName,
      'regulatory_class': instance.regulatoryClass,
      'dosage_form': instance.dosageForm,
      'brand_name_kana': instance.brandNameKana,
      'atc_code': instance.atcCode,
      'revised_at': instance.revisedAt,
      'image_url': instance.imageUrl,
    };
