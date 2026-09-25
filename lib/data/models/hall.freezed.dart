// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hall.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hall {

 String get id; String get name; String? get farmId;
/// Create a copy of Hall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HallCopyWith<Hall> get copyWith => _$HallCopyWithImpl<Hall>(this as Hall, _$identity);

  /// Serializes this Hall to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Hall;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hall&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.farmId, _this.farmId) || other.farmId == _this.farmId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Hall;
  return Object.hash(runtimeType,_this.id,_this.name,_this.farmId);
}

@override
String toString() {
  final _this = this as Hall;
  return 'Hall(id: ${_this.id}, name: ${_this.name}, farmId: ${_this.farmId})';
}


}

/// @nodoc
abstract mixin class $HallCopyWith<$Res>  {
  factory $HallCopyWith(Hall value, $Res Function(Hall) _then) = _$HallCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? farmId
});




}
/// @nodoc
class _$HallCopyWithImpl<$Res>
    implements $HallCopyWith<$Res> {
  _$HallCopyWithImpl(this._self, this._then);

  final Hall _self;
  final $Res Function(Hall) _then;

/// Create a copy of Hall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? farmId = freezed,}) {
  return _then(Hall(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,farmId: freezed == farmId ? _self.farmId : farmId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Hall].
extension HallPatterns on Hall {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hall value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hall() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hall value)  $default,){
final _that = this;
switch (_that) {
case _Hall():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hall value)?  $default,){
final _that = this;
switch (_that) {
case _Hall() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? farmId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hall() when $default != null:
return $default(_that.id,_that.name,_that.farmId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? farmId)  $default,) {final _that = this;
switch (_that) {
case _Hall():
return $default(_that.id,_that.name,_that.farmId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? farmId)?  $default,) {final _that = this;
switch (_that) {
case _Hall() when $default != null:
return $default(_that.id,_that.name,_that.farmId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hall implements Hall {
  const _Hall({required this.id, required this.name, this.farmId});
  factory _Hall.fromJson(Map<String, dynamic> json) => _$HallFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? farmId;

/// Create a copy of Hall
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HallCopyWith<_Hall> get copyWith => __$HallCopyWithImpl<_Hall>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HallToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hall&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.farmId, farmId) || other.farmId == farmId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,farmId);
}

@override
String toString() {
    return 'Hall(id: $id, name: $name, farmId: $farmId)';
}


}

/// @nodoc
abstract mixin class _$HallCopyWith<$Res> implements $HallCopyWith<$Res> {
  factory _$HallCopyWith(_Hall value, $Res Function(_Hall) _then) = __$HallCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? farmId
});




}
/// @nodoc
class __$HallCopyWithImpl<$Res>
    implements _$HallCopyWith<$Res> {
  __$HallCopyWithImpl(this._self, this._then);

  final _Hall _self;
  final $Res Function(_Hall) _then;

/// Create a copy of Hall
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? farmId = freezed,}) {
  return _then(_Hall(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,farmId: freezed == farmId ? _self.farmId : farmId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
