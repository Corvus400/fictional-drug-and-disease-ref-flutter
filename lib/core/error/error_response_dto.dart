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
    required String code,
    required String message,
    String? details,
    String? disclaimer,
  }) = _ErrorResponseDto;

  /// Creates an API error response payload from JSON.
  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDtoFromJson(json);
}
