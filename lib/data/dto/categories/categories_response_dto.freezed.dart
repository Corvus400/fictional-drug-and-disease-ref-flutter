// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AtcEntryDto {

 String get code; String get label;
/// Create a copy of AtcEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AtcEntryDtoCopyWith<AtcEntryDto> get copyWith => _$AtcEntryDtoCopyWithImpl<AtcEntryDto>(this as AtcEntryDto, _$identity);

  /// Serializes this AtcEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AtcEntryDto&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label);

@override
String toString() {
  return 'AtcEntryDto(code: $code, label: $label)';
}


}

/// @nodoc
abstract mixin class $AtcEntryDtoCopyWith<$Res>  {
  factory $AtcEntryDtoCopyWith(AtcEntryDto value, $Res Function(AtcEntryDto) _then) = _$AtcEntryDtoCopyWithImpl;
@useResult
$Res call({
 String code, String label
});




}
/// @nodoc
class _$AtcEntryDtoCopyWithImpl<$Res>
    implements $AtcEntryDtoCopyWith<$Res> {
  _$AtcEntryDtoCopyWithImpl(this._self, this._then);

  final AtcEntryDto _self;
  final $Res Function(AtcEntryDto) _then;

/// Create a copy of AtcEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AtcEntryDto].
extension AtcEntryDtoPatterns on AtcEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AtcEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AtcEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AtcEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _AtcEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AtcEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _AtcEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AtcEntryDto() when $default != null:
return $default(_that.code,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String label)  $default,) {final _that = this;
switch (_that) {
case _AtcEntryDto():
return $default(_that.code,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String label)?  $default,) {final _that = this;
switch (_that) {
case _AtcEntryDto() when $default != null:
return $default(_that.code,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AtcEntryDto implements AtcEntryDto {
  const _AtcEntryDto({required this.code, required this.label});
  factory _AtcEntryDto.fromJson(Map<String, dynamic> json) => _$AtcEntryDtoFromJson(json);

@override final  String code;
@override final  String label;

/// Create a copy of AtcEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AtcEntryDtoCopyWith<_AtcEntryDto> get copyWith => __$AtcEntryDtoCopyWithImpl<_AtcEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AtcEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AtcEntryDto&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label);

@override
String toString() {
  return 'AtcEntryDto(code: $code, label: $label)';
}


}

/// @nodoc
abstract mixin class _$AtcEntryDtoCopyWith<$Res> implements $AtcEntryDtoCopyWith<$Res> {
  factory _$AtcEntryDtoCopyWith(_AtcEntryDto value, $Res Function(_AtcEntryDto) _then) = __$AtcEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String code, String label
});




}
/// @nodoc
class __$AtcEntryDtoCopyWithImpl<$Res>
    implements _$AtcEntryDtoCopyWith<$Res> {
  __$AtcEntryDtoCopyWithImpl(this._self, this._then);

  final _AtcEntryDto _self;
  final $Res Function(_AtcEntryDto) _then;

/// Create a copy of AtcEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,}) {
  return _then(_AtcEntryDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TherapeuticCategoryEntryDto {

 String get id; String get label;
/// Create a copy of TherapeuticCategoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TherapeuticCategoryEntryDtoCopyWith<TherapeuticCategoryEntryDto> get copyWith => _$TherapeuticCategoryEntryDtoCopyWithImpl<TherapeuticCategoryEntryDto>(this as TherapeuticCategoryEntryDto, _$identity);

  /// Serializes this TherapeuticCategoryEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TherapeuticCategoryEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'TherapeuticCategoryEntryDto(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $TherapeuticCategoryEntryDtoCopyWith<$Res>  {
  factory $TherapeuticCategoryEntryDtoCopyWith(TherapeuticCategoryEntryDto value, $Res Function(TherapeuticCategoryEntryDto) _then) = _$TherapeuticCategoryEntryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$TherapeuticCategoryEntryDtoCopyWithImpl<$Res>
    implements $TherapeuticCategoryEntryDtoCopyWith<$Res> {
  _$TherapeuticCategoryEntryDtoCopyWithImpl(this._self, this._then);

  final TherapeuticCategoryEntryDto _self;
  final $Res Function(TherapeuticCategoryEntryDto) _then;

/// Create a copy of TherapeuticCategoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TherapeuticCategoryEntryDto].
extension TherapeuticCategoryEntryDtoPatterns on TherapeuticCategoryEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TherapeuticCategoryEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TherapeuticCategoryEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TherapeuticCategoryEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _TherapeuticCategoryEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TherapeuticCategoryEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _TherapeuticCategoryEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TherapeuticCategoryEntryDto() when $default != null:
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label)  $default,) {final _that = this;
switch (_that) {
case _TherapeuticCategoryEntryDto():
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label)?  $default,) {final _that = this;
switch (_that) {
case _TherapeuticCategoryEntryDto() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TherapeuticCategoryEntryDto implements TherapeuticCategoryEntryDto {
  const _TherapeuticCategoryEntryDto({required this.id, required this.label});
  factory _TherapeuticCategoryEntryDto.fromJson(Map<String, dynamic> json) => _$TherapeuticCategoryEntryDtoFromJson(json);

@override final  String id;
@override final  String label;

/// Create a copy of TherapeuticCategoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TherapeuticCategoryEntryDtoCopyWith<_TherapeuticCategoryEntryDto> get copyWith => __$TherapeuticCategoryEntryDtoCopyWithImpl<_TherapeuticCategoryEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TherapeuticCategoryEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TherapeuticCategoryEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'TherapeuticCategoryEntryDto(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$TherapeuticCategoryEntryDtoCopyWith<$Res> implements $TherapeuticCategoryEntryDtoCopyWith<$Res> {
  factory _$TherapeuticCategoryEntryDtoCopyWith(_TherapeuticCategoryEntryDto value, $Res Function(_TherapeuticCategoryEntryDto) _then) = __$TherapeuticCategoryEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class __$TherapeuticCategoryEntryDtoCopyWithImpl<$Res>
    implements _$TherapeuticCategoryEntryDtoCopyWith<$Res> {
  __$TherapeuticCategoryEntryDtoCopyWithImpl(this._self, this._then);

  final _TherapeuticCategoryEntryDto _self;
  final $Res Function(_TherapeuticCategoryEntryDto) _then;

/// Create a copy of TherapeuticCategoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_TherapeuticCategoryEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Icd10ChapterEntryDto {

 String get roman; String get code; String get label;
/// Create a copy of Icd10ChapterEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Icd10ChapterEntryDtoCopyWith<Icd10ChapterEntryDto> get copyWith => _$Icd10ChapterEntryDtoCopyWithImpl<Icd10ChapterEntryDto>(this as Icd10ChapterEntryDto, _$identity);

  /// Serializes this Icd10ChapterEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Icd10ChapterEntryDto&&(identical(other.roman, roman) || other.roman == roman)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roman,code,label);

@override
String toString() {
  return 'Icd10ChapterEntryDto(roman: $roman, code: $code, label: $label)';
}


}

/// @nodoc
abstract mixin class $Icd10ChapterEntryDtoCopyWith<$Res>  {
  factory $Icd10ChapterEntryDtoCopyWith(Icd10ChapterEntryDto value, $Res Function(Icd10ChapterEntryDto) _then) = _$Icd10ChapterEntryDtoCopyWithImpl;
@useResult
$Res call({
 String roman, String code, String label
});




}
/// @nodoc
class _$Icd10ChapterEntryDtoCopyWithImpl<$Res>
    implements $Icd10ChapterEntryDtoCopyWith<$Res> {
  _$Icd10ChapterEntryDtoCopyWithImpl(this._self, this._then);

  final Icd10ChapterEntryDto _self;
  final $Res Function(Icd10ChapterEntryDto) _then;

/// Create a copy of Icd10ChapterEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roman = null,Object? code = null,Object? label = null,}) {
  return _then(_self.copyWith(
roman: null == roman ? _self.roman : roman // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Icd10ChapterEntryDto].
extension Icd10ChapterEntryDtoPatterns on Icd10ChapterEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Icd10ChapterEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Icd10ChapterEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Icd10ChapterEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _Icd10ChapterEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Icd10ChapterEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _Icd10ChapterEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String roman,  String code,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Icd10ChapterEntryDto() when $default != null:
return $default(_that.roman,_that.code,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String roman,  String code,  String label)  $default,) {final _that = this;
switch (_that) {
case _Icd10ChapterEntryDto():
return $default(_that.roman,_that.code,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String roman,  String code,  String label)?  $default,) {final _that = this;
switch (_that) {
case _Icd10ChapterEntryDto() when $default != null:
return $default(_that.roman,_that.code,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Icd10ChapterEntryDto implements Icd10ChapterEntryDto {
  const _Icd10ChapterEntryDto({required this.roman, required this.code, required this.label});
  factory _Icd10ChapterEntryDto.fromJson(Map<String, dynamic> json) => _$Icd10ChapterEntryDtoFromJson(json);

@override final  String roman;
@override final  String code;
@override final  String label;

/// Create a copy of Icd10ChapterEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Icd10ChapterEntryDtoCopyWith<_Icd10ChapterEntryDto> get copyWith => __$Icd10ChapterEntryDtoCopyWithImpl<_Icd10ChapterEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Icd10ChapterEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Icd10ChapterEntryDto&&(identical(other.roman, roman) || other.roman == roman)&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roman,code,label);

@override
String toString() {
  return 'Icd10ChapterEntryDto(roman: $roman, code: $code, label: $label)';
}


}

/// @nodoc
abstract mixin class _$Icd10ChapterEntryDtoCopyWith<$Res> implements $Icd10ChapterEntryDtoCopyWith<$Res> {
  factory _$Icd10ChapterEntryDtoCopyWith(_Icd10ChapterEntryDto value, $Res Function(_Icd10ChapterEntryDto) _then) = __$Icd10ChapterEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String roman, String code, String label
});




}
/// @nodoc
class __$Icd10ChapterEntryDtoCopyWithImpl<$Res>
    implements _$Icd10ChapterEntryDtoCopyWith<$Res> {
  __$Icd10ChapterEntryDtoCopyWithImpl(this._self, this._then);

  final _Icd10ChapterEntryDto _self;
  final $Res Function(_Icd10ChapterEntryDto) _then;

/// Create a copy of Icd10ChapterEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roman = null,Object? code = null,Object? label = null,}) {
  return _then(_Icd10ChapterEntryDto(
roman: null == roman ? _self.roman : roman // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CategoriesResponseDto {

 List<AtcEntryDto> get atc; List<TherapeuticCategoryEntryDto> get therapeuticCategories; List<String> get routeOfAdministration; List<String> get dosageForm; List<String> get regulatoryClass; List<Icd10ChapterEntryDto> get icd10Chapters; List<String> get medicalDepartments;
/// Create a copy of CategoriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesResponseDtoCopyWith<CategoriesResponseDto> get copyWith => _$CategoriesResponseDtoCopyWithImpl<CategoriesResponseDto>(this as CategoriesResponseDto, _$identity);

  /// Serializes this CategoriesResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesResponseDto&&const DeepCollectionEquality().equals(other.atc, atc)&&const DeepCollectionEquality().equals(other.therapeuticCategories, therapeuticCategories)&&const DeepCollectionEquality().equals(other.routeOfAdministration, routeOfAdministration)&&const DeepCollectionEquality().equals(other.dosageForm, dosageForm)&&const DeepCollectionEquality().equals(other.regulatoryClass, regulatoryClass)&&const DeepCollectionEquality().equals(other.icd10Chapters, icd10Chapters)&&const DeepCollectionEquality().equals(other.medicalDepartments, medicalDepartments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(atc),const DeepCollectionEquality().hash(therapeuticCategories),const DeepCollectionEquality().hash(routeOfAdministration),const DeepCollectionEquality().hash(dosageForm),const DeepCollectionEquality().hash(regulatoryClass),const DeepCollectionEquality().hash(icd10Chapters),const DeepCollectionEquality().hash(medicalDepartments));

@override
String toString() {
  return 'CategoriesResponseDto(atc: $atc, therapeuticCategories: $therapeuticCategories, routeOfAdministration: $routeOfAdministration, dosageForm: $dosageForm, regulatoryClass: $regulatoryClass, icd10Chapters: $icd10Chapters, medicalDepartments: $medicalDepartments)';
}


}

/// @nodoc
abstract mixin class $CategoriesResponseDtoCopyWith<$Res>  {
  factory $CategoriesResponseDtoCopyWith(CategoriesResponseDto value, $Res Function(CategoriesResponseDto) _then) = _$CategoriesResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<AtcEntryDto> atc, List<TherapeuticCategoryEntryDto> therapeuticCategories, List<String> routeOfAdministration, List<String> dosageForm, List<String> regulatoryClass, List<Icd10ChapterEntryDto> icd10Chapters, List<String> medicalDepartments
});




}
/// @nodoc
class _$CategoriesResponseDtoCopyWithImpl<$Res>
    implements $CategoriesResponseDtoCopyWith<$Res> {
  _$CategoriesResponseDtoCopyWithImpl(this._self, this._then);

  final CategoriesResponseDto _self;
  final $Res Function(CategoriesResponseDto) _then;

/// Create a copy of CategoriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? atc = null,Object? therapeuticCategories = null,Object? routeOfAdministration = null,Object? dosageForm = null,Object? regulatoryClass = null,Object? icd10Chapters = null,Object? medicalDepartments = null,}) {
  return _then(_self.copyWith(
atc: null == atc ? _self.atc : atc // ignore: cast_nullable_to_non_nullable
as List<AtcEntryDto>,therapeuticCategories: null == therapeuticCategories ? _self.therapeuticCategories : therapeuticCategories // ignore: cast_nullable_to_non_nullable
as List<TherapeuticCategoryEntryDto>,routeOfAdministration: null == routeOfAdministration ? _self.routeOfAdministration : routeOfAdministration // ignore: cast_nullable_to_non_nullable
as List<String>,dosageForm: null == dosageForm ? _self.dosageForm : dosageForm // ignore: cast_nullable_to_non_nullable
as List<String>,regulatoryClass: null == regulatoryClass ? _self.regulatoryClass : regulatoryClass // ignore: cast_nullable_to_non_nullable
as List<String>,icd10Chapters: null == icd10Chapters ? _self.icd10Chapters : icd10Chapters // ignore: cast_nullable_to_non_nullable
as List<Icd10ChapterEntryDto>,medicalDepartments: null == medicalDepartments ? _self.medicalDepartments : medicalDepartments // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoriesResponseDto].
extension CategoriesResponseDtoPatterns on CategoriesResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoriesResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoriesResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoriesResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CategoriesResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoriesResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CategoriesResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AtcEntryDto> atc,  List<TherapeuticCategoryEntryDto> therapeuticCategories,  List<String> routeOfAdministration,  List<String> dosageForm,  List<String> regulatoryClass,  List<Icd10ChapterEntryDto> icd10Chapters,  List<String> medicalDepartments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoriesResponseDto() when $default != null:
return $default(_that.atc,_that.therapeuticCategories,_that.routeOfAdministration,_that.dosageForm,_that.regulatoryClass,_that.icd10Chapters,_that.medicalDepartments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AtcEntryDto> atc,  List<TherapeuticCategoryEntryDto> therapeuticCategories,  List<String> routeOfAdministration,  List<String> dosageForm,  List<String> regulatoryClass,  List<Icd10ChapterEntryDto> icd10Chapters,  List<String> medicalDepartments)  $default,) {final _that = this;
switch (_that) {
case _CategoriesResponseDto():
return $default(_that.atc,_that.therapeuticCategories,_that.routeOfAdministration,_that.dosageForm,_that.regulatoryClass,_that.icd10Chapters,_that.medicalDepartments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AtcEntryDto> atc,  List<TherapeuticCategoryEntryDto> therapeuticCategories,  List<String> routeOfAdministration,  List<String> dosageForm,  List<String> regulatoryClass,  List<Icd10ChapterEntryDto> icd10Chapters,  List<String> medicalDepartments)?  $default,) {final _that = this;
switch (_that) {
case _CategoriesResponseDto() when $default != null:
return $default(_that.atc,_that.therapeuticCategories,_that.routeOfAdministration,_that.dosageForm,_that.regulatoryClass,_that.icd10Chapters,_that.medicalDepartments);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _CategoriesResponseDto implements CategoriesResponseDto {
  const _CategoriesResponseDto({required final  List<AtcEntryDto> atc, required final  List<TherapeuticCategoryEntryDto> therapeuticCategories, required final  List<String> routeOfAdministration, required final  List<String> dosageForm, required final  List<String> regulatoryClass, required final  List<Icd10ChapterEntryDto> icd10Chapters, required final  List<String> medicalDepartments}): _atc = atc,_therapeuticCategories = therapeuticCategories,_routeOfAdministration = routeOfAdministration,_dosageForm = dosageForm,_regulatoryClass = regulatoryClass,_icd10Chapters = icd10Chapters,_medicalDepartments = medicalDepartments;
  factory _CategoriesResponseDto.fromJson(Map<String, dynamic> json) => _$CategoriesResponseDtoFromJson(json);

 final  List<AtcEntryDto> _atc;
@override List<AtcEntryDto> get atc {
  if (_atc is EqualUnmodifiableListView) return _atc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_atc);
}

 final  List<TherapeuticCategoryEntryDto> _therapeuticCategories;
@override List<TherapeuticCategoryEntryDto> get therapeuticCategories {
  if (_therapeuticCategories is EqualUnmodifiableListView) return _therapeuticCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_therapeuticCategories);
}

 final  List<String> _routeOfAdministration;
@override List<String> get routeOfAdministration {
  if (_routeOfAdministration is EqualUnmodifiableListView) return _routeOfAdministration;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routeOfAdministration);
}

 final  List<String> _dosageForm;
@override List<String> get dosageForm {
  if (_dosageForm is EqualUnmodifiableListView) return _dosageForm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dosageForm);
}

 final  List<String> _regulatoryClass;
@override List<String> get regulatoryClass {
  if (_regulatoryClass is EqualUnmodifiableListView) return _regulatoryClass;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regulatoryClass);
}

 final  List<Icd10ChapterEntryDto> _icd10Chapters;
@override List<Icd10ChapterEntryDto> get icd10Chapters {
  if (_icd10Chapters is EqualUnmodifiableListView) return _icd10Chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_icd10Chapters);
}

 final  List<String> _medicalDepartments;
@override List<String> get medicalDepartments {
  if (_medicalDepartments is EqualUnmodifiableListView) return _medicalDepartments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medicalDepartments);
}


/// Create a copy of CategoriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesResponseDtoCopyWith<_CategoriesResponseDto> get copyWith => __$CategoriesResponseDtoCopyWithImpl<_CategoriesResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoriesResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesResponseDto&&const DeepCollectionEquality().equals(other._atc, _atc)&&const DeepCollectionEquality().equals(other._therapeuticCategories, _therapeuticCategories)&&const DeepCollectionEquality().equals(other._routeOfAdministration, _routeOfAdministration)&&const DeepCollectionEquality().equals(other._dosageForm, _dosageForm)&&const DeepCollectionEquality().equals(other._regulatoryClass, _regulatoryClass)&&const DeepCollectionEquality().equals(other._icd10Chapters, _icd10Chapters)&&const DeepCollectionEquality().equals(other._medicalDepartments, _medicalDepartments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_atc),const DeepCollectionEquality().hash(_therapeuticCategories),const DeepCollectionEquality().hash(_routeOfAdministration),const DeepCollectionEquality().hash(_dosageForm),const DeepCollectionEquality().hash(_regulatoryClass),const DeepCollectionEquality().hash(_icd10Chapters),const DeepCollectionEquality().hash(_medicalDepartments));

@override
String toString() {
  return 'CategoriesResponseDto(atc: $atc, therapeuticCategories: $therapeuticCategories, routeOfAdministration: $routeOfAdministration, dosageForm: $dosageForm, regulatoryClass: $regulatoryClass, icd10Chapters: $icd10Chapters, medicalDepartments: $medicalDepartments)';
}


}

/// @nodoc
abstract mixin class _$CategoriesResponseDtoCopyWith<$Res> implements $CategoriesResponseDtoCopyWith<$Res> {
  factory _$CategoriesResponseDtoCopyWith(_CategoriesResponseDto value, $Res Function(_CategoriesResponseDto) _then) = __$CategoriesResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<AtcEntryDto> atc, List<TherapeuticCategoryEntryDto> therapeuticCategories, List<String> routeOfAdministration, List<String> dosageForm, List<String> regulatoryClass, List<Icd10ChapterEntryDto> icd10Chapters, List<String> medicalDepartments
});




}
/// @nodoc
class __$CategoriesResponseDtoCopyWithImpl<$Res>
    implements _$CategoriesResponseDtoCopyWith<$Res> {
  __$CategoriesResponseDtoCopyWithImpl(this._self, this._then);

  final _CategoriesResponseDto _self;
  final $Res Function(_CategoriesResponseDto) _then;

/// Create a copy of CategoriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? atc = null,Object? therapeuticCategories = null,Object? routeOfAdministration = null,Object? dosageForm = null,Object? regulatoryClass = null,Object? icd10Chapters = null,Object? medicalDepartments = null,}) {
  return _then(_CategoriesResponseDto(
atc: null == atc ? _self._atc : atc // ignore: cast_nullable_to_non_nullable
as List<AtcEntryDto>,therapeuticCategories: null == therapeuticCategories ? _self._therapeuticCategories : therapeuticCategories // ignore: cast_nullable_to_non_nullable
as List<TherapeuticCategoryEntryDto>,routeOfAdministration: null == routeOfAdministration ? _self._routeOfAdministration : routeOfAdministration // ignore: cast_nullable_to_non_nullable
as List<String>,dosageForm: null == dosageForm ? _self._dosageForm : dosageForm // ignore: cast_nullable_to_non_nullable
as List<String>,regulatoryClass: null == regulatoryClass ? _self._regulatoryClass : regulatoryClass // ignore: cast_nullable_to_non_nullable
as List<String>,icd10Chapters: null == icd10Chapters ? _self._icd10Chapters : icd10Chapters // ignore: cast_nullable_to_non_nullable
as List<Icd10ChapterEntryDto>,medicalDepartments: null == medicalDepartments ? _self._medicalDepartments : medicalDepartments // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
