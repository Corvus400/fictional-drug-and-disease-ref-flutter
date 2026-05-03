// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'disease_list_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiseaseListResponseDto {

 List<DiseaseSummaryDto> get items; int get page; int get pageSize; int get totalPages; int get totalCount; String get disclaimer;
/// Create a copy of DiseaseListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiseaseListResponseDtoCopyWith<DiseaseListResponseDto> get copyWith => _$DiseaseListResponseDtoCopyWithImpl<DiseaseListResponseDto>(this as DiseaseListResponseDto, _$identity);

  /// Serializes this DiseaseListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiseaseListResponseDto&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),page,pageSize,totalPages,totalCount,disclaimer);

@override
String toString() {
  return 'DiseaseListResponseDto(items: $items, page: $page, pageSize: $pageSize, totalPages: $totalPages, totalCount: $totalCount, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class $DiseaseListResponseDtoCopyWith<$Res>  {
  factory $DiseaseListResponseDtoCopyWith(DiseaseListResponseDto value, $Res Function(DiseaseListResponseDto) _then) = _$DiseaseListResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<DiseaseSummaryDto> items, int page, int pageSize, int totalPages, int totalCount, String disclaimer
});




}
/// @nodoc
class _$DiseaseListResponseDtoCopyWithImpl<$Res>
    implements $DiseaseListResponseDtoCopyWith<$Res> {
  _$DiseaseListResponseDtoCopyWithImpl(this._self, this._then);

  final DiseaseListResponseDto _self;
  final $Res Function(DiseaseListResponseDto) _then;

/// Create a copy of DiseaseListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,Object? totalCount = null,Object? disclaimer = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<DiseaseSummaryDto>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DiseaseListResponseDto].
extension DiseaseListResponseDtoPatterns on DiseaseListResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiseaseListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiseaseListResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiseaseListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _DiseaseListResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiseaseListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _DiseaseListResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DiseaseSummaryDto> items,  int page,  int pageSize,  int totalPages,  int totalCount,  String disclaimer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiseaseListResponseDto() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.totalPages,_that.totalCount,_that.disclaimer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DiseaseSummaryDto> items,  int page,  int pageSize,  int totalPages,  int totalCount,  String disclaimer)  $default,) {final _that = this;
switch (_that) {
case _DiseaseListResponseDto():
return $default(_that.items,_that.page,_that.pageSize,_that.totalPages,_that.totalCount,_that.disclaimer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DiseaseSummaryDto> items,  int page,  int pageSize,  int totalPages,  int totalCount,  String disclaimer)?  $default,) {final _that = this;
switch (_that) {
case _DiseaseListResponseDto() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.totalPages,_that.totalCount,_that.disclaimer);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DiseaseListResponseDto implements DiseaseListResponseDto {
  const _DiseaseListResponseDto({required final  List<DiseaseSummaryDto> items, required this.page, required this.pageSize, required this.totalPages, required this.totalCount, required this.disclaimer}): _items = items;
  factory _DiseaseListResponseDto.fromJson(Map<String, dynamic> json) => _$DiseaseListResponseDtoFromJson(json);

 final  List<DiseaseSummaryDto> _items;
@override List<DiseaseSummaryDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int page;
@override final  int pageSize;
@override final  int totalPages;
@override final  int totalCount;
@override final  String disclaimer;

/// Create a copy of DiseaseListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiseaseListResponseDtoCopyWith<_DiseaseListResponseDto> get copyWith => __$DiseaseListResponseDtoCopyWithImpl<_DiseaseListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiseaseListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiseaseListResponseDto&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,pageSize,totalPages,totalCount,disclaimer);

@override
String toString() {
  return 'DiseaseListResponseDto(items: $items, page: $page, pageSize: $pageSize, totalPages: $totalPages, totalCount: $totalCount, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class _$DiseaseListResponseDtoCopyWith<$Res> implements $DiseaseListResponseDtoCopyWith<$Res> {
  factory _$DiseaseListResponseDtoCopyWith(_DiseaseListResponseDto value, $Res Function(_DiseaseListResponseDto) _then) = __$DiseaseListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<DiseaseSummaryDto> items, int page, int pageSize, int totalPages, int totalCount, String disclaimer
});




}
/// @nodoc
class __$DiseaseListResponseDtoCopyWithImpl<$Res>
    implements _$DiseaseListResponseDtoCopyWith<$Res> {
  __$DiseaseListResponseDtoCopyWithImpl(this._self, this._then);

  final _DiseaseListResponseDto _self;
  final $Res Function(_DiseaseListResponseDto) _then;

/// Create a copy of DiseaseListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,Object? totalCount = null,Object? disclaimer = null,}) {
  return _then(_DiseaseListResponseDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DiseaseSummaryDto>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
