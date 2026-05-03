// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'disease_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiseaseSummaryDto {

 String get id; String get name; String get icd10Chapter; List<String> get medicalDepartment; String get chronicity; bool get infectious; String get nameKana; String get revisedAt;
/// Create a copy of DiseaseSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiseaseSummaryDtoCopyWith<DiseaseSummaryDto> get copyWith => _$DiseaseSummaryDtoCopyWithImpl<DiseaseSummaryDto>(this as DiseaseSummaryDto, _$identity);

  /// Serializes this DiseaseSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiseaseSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icd10Chapter, icd10Chapter) || other.icd10Chapter == icd10Chapter)&&const DeepCollectionEquality().equals(other.medicalDepartment, medicalDepartment)&&(identical(other.chronicity, chronicity) || other.chronicity == chronicity)&&(identical(other.infectious, infectious) || other.infectious == infectious)&&(identical(other.nameKana, nameKana) || other.nameKana == nameKana)&&(identical(other.revisedAt, revisedAt) || other.revisedAt == revisedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icd10Chapter,const DeepCollectionEquality().hash(medicalDepartment),chronicity,infectious,nameKana,revisedAt);

@override
String toString() {
  return 'DiseaseSummaryDto(id: $id, name: $name, icd10Chapter: $icd10Chapter, medicalDepartment: $medicalDepartment, chronicity: $chronicity, infectious: $infectious, nameKana: $nameKana, revisedAt: $revisedAt)';
}


}

/// @nodoc
abstract mixin class $DiseaseSummaryDtoCopyWith<$Res>  {
  factory $DiseaseSummaryDtoCopyWith(DiseaseSummaryDto value, $Res Function(DiseaseSummaryDto) _then) = _$DiseaseSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String icd10Chapter, List<String> medicalDepartment, String chronicity, bool infectious, String nameKana, String revisedAt
});




}
/// @nodoc
class _$DiseaseSummaryDtoCopyWithImpl<$Res>
    implements $DiseaseSummaryDtoCopyWith<$Res> {
  _$DiseaseSummaryDtoCopyWithImpl(this._self, this._then);

  final DiseaseSummaryDto _self;
  final $Res Function(DiseaseSummaryDto) _then;

/// Create a copy of DiseaseSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icd10Chapter = null,Object? medicalDepartment = null,Object? chronicity = null,Object? infectious = null,Object? nameKana = null,Object? revisedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icd10Chapter: null == icd10Chapter ? _self.icd10Chapter : icd10Chapter // ignore: cast_nullable_to_non_nullable
as String,medicalDepartment: null == medicalDepartment ? _self.medicalDepartment : medicalDepartment // ignore: cast_nullable_to_non_nullable
as List<String>,chronicity: null == chronicity ? _self.chronicity : chronicity // ignore: cast_nullable_to_non_nullable
as String,infectious: null == infectious ? _self.infectious : infectious // ignore: cast_nullable_to_non_nullable
as bool,nameKana: null == nameKana ? _self.nameKana : nameKana // ignore: cast_nullable_to_non_nullable
as String,revisedAt: null == revisedAt ? _self.revisedAt : revisedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DiseaseSummaryDto].
extension DiseaseSummaryDtoPatterns on DiseaseSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiseaseSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiseaseSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiseaseSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _DiseaseSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiseaseSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _DiseaseSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String icd10Chapter,  List<String> medicalDepartment,  String chronicity,  bool infectious,  String nameKana,  String revisedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiseaseSummaryDto() when $default != null:
return $default(_that.id,_that.name,_that.icd10Chapter,_that.medicalDepartment,_that.chronicity,_that.infectious,_that.nameKana,_that.revisedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String icd10Chapter,  List<String> medicalDepartment,  String chronicity,  bool infectious,  String nameKana,  String revisedAt)  $default,) {final _that = this;
switch (_that) {
case _DiseaseSummaryDto():
return $default(_that.id,_that.name,_that.icd10Chapter,_that.medicalDepartment,_that.chronicity,_that.infectious,_that.nameKana,_that.revisedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String icd10Chapter,  List<String> medicalDepartment,  String chronicity,  bool infectious,  String nameKana,  String revisedAt)?  $default,) {final _that = this;
switch (_that) {
case _DiseaseSummaryDto() when $default != null:
return $default(_that.id,_that.name,_that.icd10Chapter,_that.medicalDepartment,_that.chronicity,_that.infectious,_that.nameKana,_that.revisedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DiseaseSummaryDto implements DiseaseSummaryDto {
  const _DiseaseSummaryDto({required this.id, required this.name, required this.icd10Chapter, required final  List<String> medicalDepartment, required this.chronicity, required this.infectious, required this.nameKana, required this.revisedAt}): _medicalDepartment = medicalDepartment;
  factory _DiseaseSummaryDto.fromJson(Map<String, dynamic> json) => _$DiseaseSummaryDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String icd10Chapter;
 final  List<String> _medicalDepartment;
@override List<String> get medicalDepartment {
  if (_medicalDepartment is EqualUnmodifiableListView) return _medicalDepartment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medicalDepartment);
}

@override final  String chronicity;
@override final  bool infectious;
@override final  String nameKana;
@override final  String revisedAt;

/// Create a copy of DiseaseSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiseaseSummaryDtoCopyWith<_DiseaseSummaryDto> get copyWith => __$DiseaseSummaryDtoCopyWithImpl<_DiseaseSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiseaseSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiseaseSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icd10Chapter, icd10Chapter) || other.icd10Chapter == icd10Chapter)&&const DeepCollectionEquality().equals(other._medicalDepartment, _medicalDepartment)&&(identical(other.chronicity, chronicity) || other.chronicity == chronicity)&&(identical(other.infectious, infectious) || other.infectious == infectious)&&(identical(other.nameKana, nameKana) || other.nameKana == nameKana)&&(identical(other.revisedAt, revisedAt) || other.revisedAt == revisedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icd10Chapter,const DeepCollectionEquality().hash(_medicalDepartment),chronicity,infectious,nameKana,revisedAt);

@override
String toString() {
  return 'DiseaseSummaryDto(id: $id, name: $name, icd10Chapter: $icd10Chapter, medicalDepartment: $medicalDepartment, chronicity: $chronicity, infectious: $infectious, nameKana: $nameKana, revisedAt: $revisedAt)';
}


}

/// @nodoc
abstract mixin class _$DiseaseSummaryDtoCopyWith<$Res> implements $DiseaseSummaryDtoCopyWith<$Res> {
  factory _$DiseaseSummaryDtoCopyWith(_DiseaseSummaryDto value, $Res Function(_DiseaseSummaryDto) _then) = __$DiseaseSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String icd10Chapter, List<String> medicalDepartment, String chronicity, bool infectious, String nameKana, String revisedAt
});




}
/// @nodoc
class __$DiseaseSummaryDtoCopyWithImpl<$Res>
    implements _$DiseaseSummaryDtoCopyWith<$Res> {
  __$DiseaseSummaryDtoCopyWithImpl(this._self, this._then);

  final _DiseaseSummaryDto _self;
  final $Res Function(_DiseaseSummaryDto) _then;

/// Create a copy of DiseaseSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icd10Chapter = null,Object? medicalDepartment = null,Object? chronicity = null,Object? infectious = null,Object? nameKana = null,Object? revisedAt = null,}) {
  return _then(_DiseaseSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icd10Chapter: null == icd10Chapter ? _self.icd10Chapter : icd10Chapter // ignore: cast_nullable_to_non_nullable
as String,medicalDepartment: null == medicalDepartment ? _self._medicalDepartment : medicalDepartment // ignore: cast_nullable_to_non_nullable
as List<String>,chronicity: null == chronicity ? _self.chronicity : chronicity // ignore: cast_nullable_to_non_nullable
as String,infectious: null == infectious ? _self.infectious : infectious // ignore: cast_nullable_to_non_nullable
as bool,nameKana: null == nameKana ? _self.nameKana : nameKana // ignore: cast_nullable_to_non_nullable
as String,revisedAt: null == revisedAt ? _self.revisedAt : revisedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
