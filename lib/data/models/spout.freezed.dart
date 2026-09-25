// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Spout {

 String get id; String get vacuumId;/// Ünite üzerindeki sıra numarası (§8.4 spouts.position_no).
 int get positionNo;
/// Create a copy of Spout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpoutCopyWith<Spout> get copyWith => _$SpoutCopyWithImpl<Spout>(this as Spout, _$identity);

  /// Serializes this Spout to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Spout;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Spout&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.vacuumId, _this.vacuumId) || other.vacuumId == _this.vacuumId)&&(identical(other.positionNo, _this.positionNo) || other.positionNo == _this.positionNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Spout;
  return Object.hash(runtimeType,_this.id,_this.vacuumId,_this.positionNo);
}

@override
String toString() {
  final _this = this as Spout;
  return 'Spout(id: ${_this.id}, vacuumId: ${_this.vacuumId}, positionNo: ${_this.positionNo})';
}


}

/// @nodoc
abstract mixin class $SpoutCopyWith<$Res>  {
  factory $SpoutCopyWith(Spout value, $Res Function(Spout) _then) = _$SpoutCopyWithImpl;
@useResult
$Res call({
 String id, String vacuumId, int positionNo
});




}
/// @nodoc
class _$SpoutCopyWithImpl<$Res>
    implements $SpoutCopyWith<$Res> {
  _$SpoutCopyWithImpl(this._self, this._then);

  final Spout _self;
  final $Res Function(Spout) _then;

/// Create a copy of Spout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vacuumId = null,Object? positionNo = null,}) {
  return _then(Spout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vacuumId: null == vacuumId ? _self.vacuumId : vacuumId // ignore: cast_nullable_to_non_nullable
as String,positionNo: null == positionNo ? _self.positionNo : positionNo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Spout].
extension SpoutPatterns on Spout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Spout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Spout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Spout value)  $default,){
final _that = this;
switch (_that) {
case _Spout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Spout value)?  $default,){
final _that = this;
switch (_that) {
case _Spout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vacuumId,  int positionNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Spout() when $default != null:
return $default(_that.id,_that.vacuumId,_that.positionNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vacuumId,  int positionNo)  $default,) {final _that = this;
switch (_that) {
case _Spout():
return $default(_that.id,_that.vacuumId,_that.positionNo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vacuumId,  int positionNo)?  $default,) {final _that = this;
switch (_that) {
case _Spout() when $default != null:
return $default(_that.id,_that.vacuumId,_that.positionNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Spout implements Spout {
  const _Spout({required this.id, required this.vacuumId, required this.positionNo});
  factory _Spout.fromJson(Map<String, dynamic> json) => _$SpoutFromJson(json);

@override final  String id;
@override final  String vacuumId;
/// Ünite üzerindeki sıra numarası (§8.4 spouts.position_no).
@override final  int positionNo;

/// Create a copy of Spout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpoutCopyWith<_Spout> get copyWith => __$SpoutCopyWithImpl<_Spout>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpoutToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Spout&&(identical(other.id, id) || other.id == id)&&(identical(other.vacuumId, vacuumId) || other.vacuumId == vacuumId)&&(identical(other.positionNo, positionNo) || other.positionNo == positionNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,vacuumId,positionNo);
}

@override
String toString() {
    return 'Spout(id: $id, vacuumId: $vacuumId, positionNo: $positionNo)';
}


}

/// @nodoc
abstract mixin class _$SpoutCopyWith<$Res> implements $SpoutCopyWith<$Res> {
  factory _$SpoutCopyWith(_Spout value, $Res Function(_Spout) _then) = __$SpoutCopyWithImpl;
@override @useResult
$Res call({
 String id, String vacuumId, int positionNo
});




}
/// @nodoc
class __$SpoutCopyWithImpl<$Res>
    implements _$SpoutCopyWith<$Res> {
  __$SpoutCopyWithImpl(this._self, this._then);

  final _Spout _self;
  final $Res Function(_Spout) _then;

/// Create a copy of Spout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vacuumId = null,Object? positionNo = null,}) {
  return _then(_Spout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vacuumId: null == vacuumId ? _self.vacuumId : vacuumId // ignore: cast_nullable_to_non_nullable
as String,positionNo: null == positionNo ? _self.positionNo : positionNo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
