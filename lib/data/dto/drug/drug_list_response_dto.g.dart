// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DrugListResponseDto _$DrugListResponseDtoFromJson(Map<String, dynamic> json) =>
    _DrugListResponseDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => DrugSummaryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalCount: (json['total_count'] as num).toInt(),
      disclaimer: json['disclaimer'] as String,
    );

Map<String, dynamic> _$DrugListResponseDtoToJson(
  _DrugListResponseDto instance,
) => <String, dynamic>{
  'items': instance.items,
  'page': instance.page,
  'page_size': instance.pageSize,
  'total_pages': instance.totalPages,
  'total_count': instance.totalCount,
  'disclaimer': instance.disclaimer,
};
