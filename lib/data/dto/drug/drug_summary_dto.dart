// Freezed applies JsonSerializable annotations to the generated class.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'drug_summary_dto.freezed.dart';
part 'drug_summary_dto.g.dart';

/// Drug summary DTO returned by `/v1/drugs`.
@freezed
abstract class DrugSummaryDto with _$DrugSummaryDto {
  /// Creates a drug summary DTO.
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DrugSummaryDto({
    required String id,
    required String brandName,
    required String genericName,
    required String therapeuticCategoryName,
    required List<String> regulatoryClass,
    required String dosageForm,
    required String brandNameKana,
    required String atcCode,
    required String revisedAt,
    required String imageUrl,
  }) = _DrugSummaryDto;

  /// Creates a DTO from JSON.
  factory DrugSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$DrugSummaryDtoFromJson(json);
}
