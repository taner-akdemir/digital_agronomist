// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milking_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MilkingSchedule {

 String get morningAt; String get eveningAt; int get graceMinutes;
/// Create a copy of MilkingSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilkingScheduleCopyWith<MilkingSchedule> get copyWith => _$MilkingScheduleCopyWithImpl<MilkingSchedule>(this as MilkingSchedule, _$identity);

  /// Serializes this MilkingSchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MilkingSchedule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilkingSchedule&&(identical(other.morningAt, _this.morningAt) || other.morningAt == _this.morningAt)&&(identical(other.eveningAt, _this.eveningAt) || other.eveningAt == _this.eveningAt)&&(identical(other.graceMinutes, _this.graceMinutes) || other.graceMinutes == _this.graceMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MilkingSchedule;
  return Object.hash(runtimeType,_this.morningAt,_this.eveningAt,_this.graceMinutes);
}

@override
String toString() {
  final _this = this as MilkingSchedule;
  return 'MilkingSchedule(morningAt: ${_this.morningAt}, eveningAt: ${_this.eveningAt}, graceMinutes: ${_this.graceMinutes})';
}


}

/// @nodoc
abstract mixin class $MilkingScheduleCopyWith<$Res>  {
  factory $MilkingScheduleCopyWith(MilkingSchedule value, $Res Function(MilkingSchedule) _then) = _$MilkingScheduleCopyWithImpl;
@useResult
$Res call({
 String morningAt, String eveningAt, int graceMinutes
});




}
/// @nodoc
class _$MilkingScheduleCopyWithImpl<$Res>
    implements $MilkingScheduleCopyWith<$Res> {
  _$MilkingScheduleCopyWithImpl(this._self, this._then);

  final MilkingSchedule _self;
  final $Res Function(MilkingSchedule) _then;

/// Create a copy of MilkingSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? morningAt = null,Object? eveningAt = null,Object? graceMinutes = null,}) {
  return _then(MilkingSchedule(
morningAt: null == morningAt ? _self.morningAt : morningAt // ignore: cast_nullable_to_non_nullable
as String,eveningAt: null == eveningAt ? _self.eveningAt : eveningAt // ignore: cast_nullable_to_non_nullable
as String,graceMinutes: null == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MilkingSchedule].
extension MilkingSchedulePatterns on MilkingSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MilkingSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MilkingSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MilkingSchedule value)  $default,){
final _that = this;
switch (_that) {
case _MilkingSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MilkingSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _MilkingSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String morningAt,  String eveningAt,  int graceMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MilkingSchedule() when $default != null:
return $default(_that.morningAt,_that.eveningAt,_that.graceMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String morningAt,  String eveningAt,  int graceMinutes)  $default,) {final _that = this;
switch (_that) {
case _MilkingSchedule():
return $default(_that.morningAt,_that.eveningAt,_that.graceMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String morningAt,  String eveningAt,  int graceMinutes)?  $default,) {final _that = this;
switch (_that) {
case _MilkingSchedule() when $default != null:
return $default(_that.morningAt,_that.eveningAt,_that.graceMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MilkingSchedule implements MilkingSchedule {
  const _MilkingSchedule({this.morningAt = '', this.eveningAt = '', this.graceMinutes = 45});
  factory _MilkingSchedule.fromJson(Map<String, dynamic> json) => _$MilkingScheduleFromJson(json);

@override@JsonKey() final  String morningAt;
@override@JsonKey() final  String eveningAt;
@override@JsonKey() final  int graceMinutes;

/// Create a copy of MilkingSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilkingScheduleCopyWith<_MilkingSchedule> get copyWith => __$MilkingScheduleCopyWithImpl<_MilkingSchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MilkingScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilkingSchedule&&(identical(other.morningAt, morningAt) || other.morningAt == morningAt)&&(identical(other.eveningAt, eveningAt) || other.eveningAt == eveningAt)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,morningAt,eveningAt,graceMinutes);
}

@override
String toString() {
    return 'MilkingSchedule(morningAt: $morningAt, eveningAt: $eveningAt, graceMinutes: $graceMinutes)';
}


}

/// @nodoc
abstract mixin class _$MilkingScheduleCopyWith<$Res> implements $MilkingScheduleCopyWith<$Res> {
  factory _$MilkingScheduleCopyWith(_MilkingSchedule value, $Res Function(_MilkingSchedule) _then) = __$MilkingScheduleCopyWithImpl;
@override @useResult
$Res call({
 String morningAt, String eveningAt, int graceMinutes
});




}
/// @nodoc
class __$MilkingScheduleCopyWithImpl<$Res>
    implements _$MilkingScheduleCopyWith<$Res> {
  __$MilkingScheduleCopyWithImpl(this._self, this._then);

  final _MilkingSchedule _self;
  final $Res Function(_MilkingSchedule) _then;

/// Create a copy of MilkingSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? morningAt = null,Object? eveningAt = null,Object? graceMinutes = null,}) {
  return _then(_MilkingSchedule(
morningAt: null == morningAt ? _self.morningAt : morningAt // ignore: cast_nullable_to_non_nullable
as String,eveningAt: null == eveningAt ? _self.eveningAt : eveningAt // ignore: cast_nullable_to_non_nullable
as String,graceMinutes: null == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
