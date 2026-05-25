// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorResponseDto {

 String get title; int get status; String? get type; String? get detail; String? get instance; List<FieldViolationDto>? get errors;
/// Create a copy of ErrorResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorResponseDtoCopyWith<ErrorResponseDto> get copyWith => _$ErrorResponseDtoCopyWithImpl<ErrorResponseDto>(this as ErrorResponseDto, _$identity);

  /// Serializes this ErrorResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorResponseDto&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.instance, instance) || other.instance == instance)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,status,type,detail,instance,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'ErrorResponseDto(title: $title, status: $status, type: $type, detail: $detail, instance: $instance, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $ErrorResponseDtoCopyWith<$Res>  {
  factory $ErrorResponseDtoCopyWith(ErrorResponseDto value, $Res Function(ErrorResponseDto) _then) = _$ErrorResponseDtoCopyWithImpl;
@useResult
$Res call({
 String title, int status, String? type, String? detail, String? instance, List<FieldViolationDto>? errors
});




}
/// @nodoc
class _$ErrorResponseDtoCopyWithImpl<$Res>
    implements $ErrorResponseDtoCopyWith<$Res> {
  _$ErrorResponseDtoCopyWithImpl(this._self, this._then);

  final ErrorResponseDto _self;
  final $Res Function(ErrorResponseDto) _then;

/// Create a copy of ErrorResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? status = null,Object? type = freezed,Object? detail = freezed,Object? instance = freezed,Object? errors = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,instance: freezed == instance ? _self.instance : instance // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<FieldViolationDto>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorResponseDto].
extension ErrorResponseDtoPatterns on ErrorResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ErrorResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int status,  String? type,  String? detail,  String? instance,  List<FieldViolationDto>? errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorResponseDto() when $default != null:
return $default(_that.title,_that.status,_that.type,_that.detail,_that.instance,_that.errors);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int status,  String? type,  String? detail,  String? instance,  List<FieldViolationDto>? errors)  $default,) {final _that = this;
switch (_that) {
case _ErrorResponseDto():
return $default(_that.title,_that.status,_that.type,_that.detail,_that.instance,_that.errors);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int status,  String? type,  String? detail,  String? instance,  List<FieldViolationDto>? errors)?  $default,) {final _that = this;
switch (_that) {
case _ErrorResponseDto() when $default != null:
return $default(_that.title,_that.status,_that.type,_that.detail,_that.instance,_that.errors);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(checked: true)
class _ErrorResponseDto implements ErrorResponseDto {
  const _ErrorResponseDto({required this.title, required this.status, this.type, this.detail, this.instance, final  List<FieldViolationDto>? errors}): _errors = errors;
  factory _ErrorResponseDto.fromJson(Map<String, dynamic> json) => _$ErrorResponseDtoFromJson(json);

@override final  String title;
@override final  int status;
@override final  String? type;
@override final  String? detail;
@override final  String? instance;
 final  List<FieldViolationDto>? _errors;
@override List<FieldViolationDto>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ErrorResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorResponseDtoCopyWith<_ErrorResponseDto> get copyWith => __$ErrorResponseDtoCopyWithImpl<_ErrorResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorResponseDto&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.instance, instance) || other.instance == instance)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,status,type,detail,instance,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'ErrorResponseDto(title: $title, status: $status, type: $type, detail: $detail, instance: $instance, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$ErrorResponseDtoCopyWith<$Res> implements $ErrorResponseDtoCopyWith<$Res> {
  factory _$ErrorResponseDtoCopyWith(_ErrorResponseDto value, $Res Function(_ErrorResponseDto) _then) = __$ErrorResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String title, int status, String? type, String? detail, String? instance, List<FieldViolationDto>? errors
});




}
/// @nodoc
class __$ErrorResponseDtoCopyWithImpl<$Res>
    implements _$ErrorResponseDtoCopyWith<$Res> {
  __$ErrorResponseDtoCopyWithImpl(this._self, this._then);

  final _ErrorResponseDto _self;
  final $Res Function(_ErrorResponseDto) _then;

/// Create a copy of ErrorResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? status = null,Object? type = freezed,Object? detail = freezed,Object? instance = freezed,Object? errors = freezed,}) {
  return _then(_ErrorResponseDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,instance: freezed == instance ? _self.instance : instance // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<FieldViolationDto>?,
  ));
}


}


/// @nodoc
mixin _$FieldViolationDto {

 String get field; String get reason;
/// Create a copy of FieldViolationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldViolationDtoCopyWith<FieldViolationDto> get copyWith => _$FieldViolationDtoCopyWithImpl<FieldViolationDto>(this as FieldViolationDto, _$identity);

  /// Serializes this FieldViolationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldViolationDto&&(identical(other.field, field) || other.field == field)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,reason);

@override
String toString() {
  return 'FieldViolationDto(field: $field, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $FieldViolationDtoCopyWith<$Res>  {
  factory $FieldViolationDtoCopyWith(FieldViolationDto value, $Res Function(FieldViolationDto) _then) = _$FieldViolationDtoCopyWithImpl;
@useResult
$Res call({
 String field, String reason
});




}
/// @nodoc
class _$FieldViolationDtoCopyWithImpl<$Res>
    implements $FieldViolationDtoCopyWith<$Res> {
  _$FieldViolationDtoCopyWithImpl(this._self, this._then);

  final FieldViolationDto _self;
  final $Res Function(FieldViolationDto) _then;

/// Create a copy of FieldViolationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? reason = null,}) {
  return _then(_self.copyWith(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldViolationDto].
extension FieldViolationDtoPatterns on FieldViolationDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldViolationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldViolationDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldViolationDto value)  $default,){
final _that = this;
switch (_that) {
case _FieldViolationDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldViolationDto value)?  $default,){
final _that = this;
switch (_that) {
case _FieldViolationDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String field,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldViolationDto() when $default != null:
return $default(_that.field,_that.reason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String field,  String reason)  $default,) {final _that = this;
switch (_that) {
case _FieldViolationDto():
return $default(_that.field,_that.reason);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String field,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _FieldViolationDto() when $default != null:
return $default(_that.field,_that.reason);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(checked: true)
class _FieldViolationDto implements FieldViolationDto {
  const _FieldViolationDto({required this.field, required this.reason});
  factory _FieldViolationDto.fromJson(Map<String, dynamic> json) => _$FieldViolationDtoFromJson(json);

@override final  String field;
@override final  String reason;

/// Create a copy of FieldViolationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldViolationDtoCopyWith<_FieldViolationDto> get copyWith => __$FieldViolationDtoCopyWithImpl<_FieldViolationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldViolationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldViolationDto&&(identical(other.field, field) || other.field == field)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,reason);

@override
String toString() {
  return 'FieldViolationDto(field: $field, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$FieldViolationDtoCopyWith<$Res> implements $FieldViolationDtoCopyWith<$Res> {
  factory _$FieldViolationDtoCopyWith(_FieldViolationDto value, $Res Function(_FieldViolationDto) _then) = __$FieldViolationDtoCopyWithImpl;
@override @useResult
$Res call({
 String field, String reason
});




}
/// @nodoc
class __$FieldViolationDtoCopyWithImpl<$Res>
    implements _$FieldViolationDtoCopyWith<$Res> {
  __$FieldViolationDtoCopyWithImpl(this._self, this._then);

  final _FieldViolationDto _self;
  final $Res Function(_FieldViolationDto) _then;

/// Create a copy of FieldViolationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? reason = null,}) {
  return _then(_FieldViolationDto(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
