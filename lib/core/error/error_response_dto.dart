import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response_dto.freezed.dart';
part 'error_response_dto.g.dart';

/// API error response payload.
@freezed
abstract class ErrorResponseDto with _$ErrorResponseDto {
  // Freezed annotates a factory constructor; json_serializable supports this
  // generator pattern even though the analyzer target is broader.
  /// Creates an API error response payload.
  // ignore: invalid_annotation_target
  @JsonSerializable(checked: true)
  const factory ErrorResponseDto({
    required String title,
    required int status,
    String? type,
    String? detail,
    String? instance,
    List<FieldViolationDto>? errors,
  }) = _ErrorResponseDto;

  /// Creates an API error response payload from JSON.
  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDtoFromJson(json);
}

/// RFC 9457 validation error extension payload.
@freezed
abstract class FieldViolationDto with _$FieldViolationDto {
  /// Creates a field violation payload.
  // ignore: invalid_annotation_target
  @JsonSerializable(checked: true)
  const factory FieldViolationDto({
    required String field,
    required String reason,
  }) = _FieldViolationDto;

  /// Creates a field violation payload from JSON.
  factory FieldViolationDto.fromJson(Map<String, dynamic> json) =>
      _$FieldViolationDtoFromJson(json);
}
