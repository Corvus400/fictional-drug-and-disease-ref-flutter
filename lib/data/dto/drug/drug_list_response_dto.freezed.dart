// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drug_list_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DrugListResponseDto {

 List<DrugSummaryDto> get items; int get page; int get pageSize; int get totalPages; int get totalCount; String get disclaimer;
/// Create a copy of DrugListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DrugListResponseDtoCopyWith<DrugListResponseDto> get copyWith => _$DrugListResponseDtoCopyWithImpl<DrugListResponseDto>(this as DrugListResponseDto, _$identity);

  /// Serializes this DrugListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DrugListResponseDto&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),page,pageSize,totalPages,totalCount,disclaimer);

@override
String toString() {
  return 'DrugListResponseDto(items: $items, page: $page, pageSize: $pageSize, totalPages: $totalPages, totalCount: $totalCount, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class $DrugListResponseDtoCopyWith<$Res>  {
  factory $DrugListResponseDtoCopyWith(DrugListResponseDto value, $Res Function(DrugListResponseDto) _then) = _$DrugListResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<DrugSummaryDto> items, int page, int pageSize, int totalPages, int totalCount, String disclaimer
});




}
/// @nodoc
class _$DrugListResponseDtoCopyWithImpl<$Res>
    implements $DrugListResponseDtoCopyWith<$Res> {
  _$DrugListResponseDtoCopyWithImpl(this._self, this._then);

  final DrugListResponseDto _self;
  final $Res Function(DrugListResponseDto) _then;

/// Create a copy of DrugListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,Object? totalCount = null,Object? disclaimer = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<DrugSummaryDto>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DrugListResponseDto].
extension DrugListResponseDtoPatterns on DrugListResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DrugListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DrugListResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DrugListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _DrugListResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DrugListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _DrugListResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DrugSummaryDto> items,  int page,  int pageSize,  int totalPages,  int totalCount,  String disclaimer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DrugListResponseDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DrugSummaryDto> items,  int page,  int pageSize,  int totalPages,  int totalCount,  String disclaimer)  $default,) {final _that = this;
switch (_that) {
case _DrugListResponseDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DrugSummaryDto> items,  int page,  int pageSize,  int totalPages,  int totalCount,  String disclaimer)?  $default,) {final _that = this;
switch (_that) {
case _DrugListResponseDto() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.totalPages,_that.totalCount,_that.disclaimer);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DrugListResponseDto implements DrugListResponseDto {
  const _DrugListResponseDto({required final  List<DrugSummaryDto> items, required this.page, required this.pageSize, required this.totalPages, required this.totalCount, required this.disclaimer}): _items = items;
  factory _DrugListResponseDto.fromJson(Map<String, dynamic> json) => _$DrugListResponseDtoFromJson(json);

 final  List<DrugSummaryDto> _items;
@override List<DrugSummaryDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int page;
@override final  int pageSize;
@override final  int totalPages;
@override final  int totalCount;
@override final  String disclaimer;

/// Create a copy of DrugListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DrugListResponseDtoCopyWith<_DrugListResponseDto> get copyWith => __$DrugListResponseDtoCopyWithImpl<_DrugListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DrugListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DrugListResponseDto&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,pageSize,totalPages,totalCount,disclaimer);

@override
String toString() {
  return 'DrugListResponseDto(items: $items, page: $page, pageSize: $pageSize, totalPages: $totalPages, totalCount: $totalCount, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class _$DrugListResponseDtoCopyWith<$Res> implements $DrugListResponseDtoCopyWith<$Res> {
  factory _$DrugListResponseDtoCopyWith(_DrugListResponseDto value, $Res Function(_DrugListResponseDto) _then) = __$DrugListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<DrugSummaryDto> items, int page, int pageSize, int totalPages, int totalCount, String disclaimer
});




}
/// @nodoc
class __$DrugListResponseDtoCopyWithImpl<$Res>
    implements _$DrugListResponseDtoCopyWith<$Res> {
  __$DrugListResponseDtoCopyWithImpl(this._self, this._then);

  final _DrugListResponseDto _self;
  final $Res Function(_DrugListResponseDto) _then;

/// Create a copy of DrugListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalPages = null,Object? totalCount = null,Object? disclaimer = null,}) {
  return _then(_DrugListResponseDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DrugSummaryDto>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
