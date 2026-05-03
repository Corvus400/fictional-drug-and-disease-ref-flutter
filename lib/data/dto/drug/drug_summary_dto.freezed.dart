// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drug_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DrugSummaryDto {

 String get id; String get brandName; String get genericName; String get therapeuticCategoryName; List<String> get regulatoryClass; String get dosageForm; String get brandNameKana; String get atcCode; String get revisedAt; String get imageUrl;
/// Create a copy of DrugSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DrugSummaryDtoCopyWith<DrugSummaryDto> get copyWith => _$DrugSummaryDtoCopyWithImpl<DrugSummaryDto>(this as DrugSummaryDto, _$identity);

  /// Serializes this DrugSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DrugSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.genericName, genericName) || other.genericName == genericName)&&(identical(other.therapeuticCategoryName, therapeuticCategoryName) || other.therapeuticCategoryName == therapeuticCategoryName)&&const DeepCollectionEquality().equals(other.regulatoryClass, regulatoryClass)&&(identical(other.dosageForm, dosageForm) || other.dosageForm == dosageForm)&&(identical(other.brandNameKana, brandNameKana) || other.brandNameKana == brandNameKana)&&(identical(other.atcCode, atcCode) || other.atcCode == atcCode)&&(identical(other.revisedAt, revisedAt) || other.revisedAt == revisedAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brandName,genericName,therapeuticCategoryName,const DeepCollectionEquality().hash(regulatoryClass),dosageForm,brandNameKana,atcCode,revisedAt,imageUrl);

@override
String toString() {
  return 'DrugSummaryDto(id: $id, brandName: $brandName, genericName: $genericName, therapeuticCategoryName: $therapeuticCategoryName, regulatoryClass: $regulatoryClass, dosageForm: $dosageForm, brandNameKana: $brandNameKana, atcCode: $atcCode, revisedAt: $revisedAt, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $DrugSummaryDtoCopyWith<$Res>  {
  factory $DrugSummaryDtoCopyWith(DrugSummaryDto value, $Res Function(DrugSummaryDto) _then) = _$DrugSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String brandName, String genericName, String therapeuticCategoryName, List<String> regulatoryClass, String dosageForm, String brandNameKana, String atcCode, String revisedAt, String imageUrl
});




}
/// @nodoc
class _$DrugSummaryDtoCopyWithImpl<$Res>
    implements $DrugSummaryDtoCopyWith<$Res> {
  _$DrugSummaryDtoCopyWithImpl(this._self, this._then);

  final DrugSummaryDto _self;
  final $Res Function(DrugSummaryDto) _then;

/// Create a copy of DrugSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandName = null,Object? genericName = null,Object? therapeuticCategoryName = null,Object? regulatoryClass = null,Object? dosageForm = null,Object? brandNameKana = null,Object? atcCode = null,Object? revisedAt = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,genericName: null == genericName ? _self.genericName : genericName // ignore: cast_nullable_to_non_nullable
as String,therapeuticCategoryName: null == therapeuticCategoryName ? _self.therapeuticCategoryName : therapeuticCategoryName // ignore: cast_nullable_to_non_nullable
as String,regulatoryClass: null == regulatoryClass ? _self.regulatoryClass : regulatoryClass // ignore: cast_nullable_to_non_nullable
as List<String>,dosageForm: null == dosageForm ? _self.dosageForm : dosageForm // ignore: cast_nullable_to_non_nullable
as String,brandNameKana: null == brandNameKana ? _self.brandNameKana : brandNameKana // ignore: cast_nullable_to_non_nullable
as String,atcCode: null == atcCode ? _self.atcCode : atcCode // ignore: cast_nullable_to_non_nullable
as String,revisedAt: null == revisedAt ? _self.revisedAt : revisedAt // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DrugSummaryDto].
extension DrugSummaryDtoPatterns on DrugSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DrugSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DrugSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DrugSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _DrugSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DrugSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _DrugSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandName,  String genericName,  String therapeuticCategoryName,  List<String> regulatoryClass,  String dosageForm,  String brandNameKana,  String atcCode,  String revisedAt,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DrugSummaryDto() when $default != null:
return $default(_that.id,_that.brandName,_that.genericName,_that.therapeuticCategoryName,_that.regulatoryClass,_that.dosageForm,_that.brandNameKana,_that.atcCode,_that.revisedAt,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandName,  String genericName,  String therapeuticCategoryName,  List<String> regulatoryClass,  String dosageForm,  String brandNameKana,  String atcCode,  String revisedAt,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _DrugSummaryDto():
return $default(_that.id,_that.brandName,_that.genericName,_that.therapeuticCategoryName,_that.regulatoryClass,_that.dosageForm,_that.brandNameKana,_that.atcCode,_that.revisedAt,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandName,  String genericName,  String therapeuticCategoryName,  List<String> regulatoryClass,  String dosageForm,  String brandNameKana,  String atcCode,  String revisedAt,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _DrugSummaryDto() when $default != null:
return $default(_that.id,_that.brandName,_that.genericName,_that.therapeuticCategoryName,_that.regulatoryClass,_that.dosageForm,_that.brandNameKana,_that.atcCode,_that.revisedAt,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DrugSummaryDto implements DrugSummaryDto {
  const _DrugSummaryDto({required this.id, required this.brandName, required this.genericName, required this.therapeuticCategoryName, required final  List<String> regulatoryClass, required this.dosageForm, required this.brandNameKana, required this.atcCode, required this.revisedAt, required this.imageUrl}): _regulatoryClass = regulatoryClass;
  factory _DrugSummaryDto.fromJson(Map<String, dynamic> json) => _$DrugSummaryDtoFromJson(json);

@override final  String id;
@override final  String brandName;
@override final  String genericName;
@override final  String therapeuticCategoryName;
 final  List<String> _regulatoryClass;
@override List<String> get regulatoryClass {
  if (_regulatoryClass is EqualUnmodifiableListView) return _regulatoryClass;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regulatoryClass);
}

@override final  String dosageForm;
@override final  String brandNameKana;
@override final  String atcCode;
@override final  String revisedAt;
@override final  String imageUrl;

/// Create a copy of DrugSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DrugSummaryDtoCopyWith<_DrugSummaryDto> get copyWith => __$DrugSummaryDtoCopyWithImpl<_DrugSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DrugSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DrugSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.genericName, genericName) || other.genericName == genericName)&&(identical(other.therapeuticCategoryName, therapeuticCategoryName) || other.therapeuticCategoryName == therapeuticCategoryName)&&const DeepCollectionEquality().equals(other._regulatoryClass, _regulatoryClass)&&(identical(other.dosageForm, dosageForm) || other.dosageForm == dosageForm)&&(identical(other.brandNameKana, brandNameKana) || other.brandNameKana == brandNameKana)&&(identical(other.atcCode, atcCode) || other.atcCode == atcCode)&&(identical(other.revisedAt, revisedAt) || other.revisedAt == revisedAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brandName,genericName,therapeuticCategoryName,const DeepCollectionEquality().hash(_regulatoryClass),dosageForm,brandNameKana,atcCode,revisedAt,imageUrl);

@override
String toString() {
  return 'DrugSummaryDto(id: $id, brandName: $brandName, genericName: $genericName, therapeuticCategoryName: $therapeuticCategoryName, regulatoryClass: $regulatoryClass, dosageForm: $dosageForm, brandNameKana: $brandNameKana, atcCode: $atcCode, revisedAt: $revisedAt, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$DrugSummaryDtoCopyWith<$Res> implements $DrugSummaryDtoCopyWith<$Res> {
  factory _$DrugSummaryDtoCopyWith(_DrugSummaryDto value, $Res Function(_DrugSummaryDto) _then) = __$DrugSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandName, String genericName, String therapeuticCategoryName, List<String> regulatoryClass, String dosageForm, String brandNameKana, String atcCode, String revisedAt, String imageUrl
});




}
/// @nodoc
class __$DrugSummaryDtoCopyWithImpl<$Res>
    implements _$DrugSummaryDtoCopyWith<$Res> {
  __$DrugSummaryDtoCopyWithImpl(this._self, this._then);

  final _DrugSummaryDto _self;
  final $Res Function(_DrugSummaryDto) _then;

/// Create a copy of DrugSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandName = null,Object? genericName = null,Object? therapeuticCategoryName = null,Object? regulatoryClass = null,Object? dosageForm = null,Object? brandNameKana = null,Object? atcCode = null,Object? revisedAt = null,Object? imageUrl = null,}) {
  return _then(_DrugSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,genericName: null == genericName ? _self.genericName : genericName // ignore: cast_nullable_to_non_nullable
as String,therapeuticCategoryName: null == therapeuticCategoryName ? _self.therapeuticCategoryName : therapeuticCategoryName // ignore: cast_nullable_to_non_nullable
as String,regulatoryClass: null == regulatoryClass ? _self._regulatoryClass : regulatoryClass // ignore: cast_nullable_to_non_nullable
as List<String>,dosageForm: null == dosageForm ? _self.dosageForm : dosageForm // ignore: cast_nullable_to_non_nullable
as String,brandNameKana: null == brandNameKana ? _self.brandNameKana : brandNameKana // ignore: cast_nullable_to_non_nullable
as String,atcCode: null == atcCode ? _self.atcCode : atcCode // ignore: cast_nullable_to_non_nullable
as String,revisedAt: null == revisedAt ? _self.revisedAt : revisedAt // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
