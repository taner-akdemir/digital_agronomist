// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milking_speed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MilkingSpeed {

 String get animalId; int get milkings;/// L/dk.
 double get avgFlow; double get peakFlow; int get durationSec; double get herdAvgFlow; bool get slow;
/// Create a copy of MilkingSpeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilkingSpeedCopyWith<MilkingSpeed> get copyWith => _$MilkingSpeedCopyWithImpl<MilkingSpeed>(this as MilkingSpeed, _$identity);

  /// Serializes this MilkingSpeed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MilkingSpeed;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilkingSpeed&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.milkings, _this.milkings) || other.milkings == _this.milkings)&&(identical(other.avgFlow, _this.avgFlow) || other.avgFlow == _this.avgFlow)&&(identical(other.peakFlow, _this.peakFlow) || other.peakFlow == _this.peakFlow)&&(identical(other.durationSec, _this.durationSec) || other.durationSec == _this.durationSec)&&(identical(other.herdAvgFlow, _this.herdAvgFlow) || other.herdAvgFlow == _this.herdAvgFlow)&&(identical(other.slow, _this.slow) || other.slow == _this.slow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MilkingSpeed;
  return Object.hash(runtimeType,_this.animalId,_this.milkings,_this.avgFlow,_this.peakFlow,_this.durationSec,_this.herdAvgFlow,_this.slow);
}

@override
String toString() {
  final _this = this as MilkingSpeed;
  return 'MilkingSpeed(animalId: ${_this.animalId}, milkings: ${_this.milkings}, avgFlow: ${_this.avgFlow}, peakFlow: ${_this.peakFlow}, durationSec: ${_this.durationSec}, herdAvgFlow: ${_this.herdAvgFlow}, slow: ${_this.slow})';
}


}

/// @nodoc
abstract mixin class $MilkingSpeedCopyWith<$Res>  {
  factory $MilkingSpeedCopyWith(MilkingSpeed value, $Res Function(MilkingSpeed) _then) = _$MilkingSpeedCopyWithImpl;
@useResult
$Res call({
 String animalId, int milkings, double avgFlow, double peakFlow, int durationSec, double herdAvgFlow, bool slow
});




}
/// @nodoc
class _$MilkingSpeedCopyWithImpl<$Res>
    implements $MilkingSpeedCopyWith<$Res> {
  _$MilkingSpeedCopyWithImpl(this._self, this._then);

  final MilkingSpeed _self;
  final $Res Function(MilkingSpeed) _then;

/// Create a copy of MilkingSpeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? milkings = null,Object? avgFlow = null,Object? peakFlow = null,Object? durationSec = null,Object? herdAvgFlow = null,Object? slow = null,}) {
  return _then(MilkingSpeed(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,milkings: null == milkings ? _self.milkings : milkings // ignore: cast_nullable_to_non_nullable
as int,avgFlow: null == avgFlow ? _self.avgFlow : avgFlow // ignore: cast_nullable_to_non_nullable
as double,peakFlow: null == peakFlow ? _self.peakFlow : peakFlow // ignore: cast_nullable_to_non_nullable
as double,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,herdAvgFlow: null == herdAvgFlow ? _self.herdAvgFlow : herdAvgFlow // ignore: cast_nullable_to_non_nullable
as double,slow: null == slow ? _self.slow : slow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MilkingSpeed].
extension MilkingSpeedPatterns on MilkingSpeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MilkingSpeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MilkingSpeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MilkingSpeed value)  $default,){
final _that = this;
switch (_that) {
case _MilkingSpeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MilkingSpeed value)?  $default,){
final _that = this;
switch (_that) {
case _MilkingSpeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId,  int milkings,  double avgFlow,  double peakFlow,  int durationSec,  double herdAvgFlow,  bool slow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MilkingSpeed() when $default != null:
return $default(_that.animalId,_that.milkings,_that.avgFlow,_that.peakFlow,_that.durationSec,_that.herdAvgFlow,_that.slow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId,  int milkings,  double avgFlow,  double peakFlow,  int durationSec,  double herdAvgFlow,  bool slow)  $default,) {final _that = this;
switch (_that) {
case _MilkingSpeed():
return $default(_that.animalId,_that.milkings,_that.avgFlow,_that.peakFlow,_that.durationSec,_that.herdAvgFlow,_that.slow);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId,  int milkings,  double avgFlow,  double peakFlow,  int durationSec,  double herdAvgFlow,  bool slow)?  $default,) {final _that = this;
switch (_that) {
case _MilkingSpeed() when $default != null:
return $default(_that.animalId,_that.milkings,_that.avgFlow,_that.peakFlow,_that.durationSec,_that.herdAvgFlow,_that.slow);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MilkingSpeed extends MilkingSpeed {
  const _MilkingSpeed({required this.animalId, this.milkings = 0, this.avgFlow = 0, this.peakFlow = 0, this.durationSec = 0, this.herdAvgFlow = 0, this.slow = false}): super._();
  factory _MilkingSpeed.fromJson(Map<String, dynamic> json) => _$MilkingSpeedFromJson(json);

@override final  String animalId;
@override@JsonKey() final  int milkings;
/// L/dk.
@override@JsonKey() final  double avgFlow;
@override@JsonKey() final  double peakFlow;
@override@JsonKey() final  int durationSec;
@override@JsonKey() final  double herdAvgFlow;
@override@JsonKey() final  bool slow;

/// Create a copy of MilkingSpeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilkingSpeedCopyWith<_MilkingSpeed> get copyWith => __$MilkingSpeedCopyWithImpl<_MilkingSpeed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MilkingSpeedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilkingSpeed&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.milkings, milkings) || other.milkings == milkings)&&(identical(other.avgFlow, avgFlow) || other.avgFlow == avgFlow)&&(identical(other.peakFlow, peakFlow) || other.peakFlow == peakFlow)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec)&&(identical(other.herdAvgFlow, herdAvgFlow) || other.herdAvgFlow == herdAvgFlow)&&(identical(other.slow, slow) || other.slow == slow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,milkings,avgFlow,peakFlow,durationSec,herdAvgFlow,slow);
}

@override
String toString() {
    return 'MilkingSpeed(animalId: $animalId, milkings: $milkings, avgFlow: $avgFlow, peakFlow: $peakFlow, durationSec: $durationSec, herdAvgFlow: $herdAvgFlow, slow: $slow)';
}


}

/// @nodoc
abstract mixin class _$MilkingSpeedCopyWith<$Res> implements $MilkingSpeedCopyWith<$Res> {
  factory _$MilkingSpeedCopyWith(_MilkingSpeed value, $Res Function(_MilkingSpeed) _then) = __$MilkingSpeedCopyWithImpl;
@override @useResult
$Res call({
 String animalId, int milkings, double avgFlow, double peakFlow, int durationSec, double herdAvgFlow, bool slow
});




}
/// @nodoc
class __$MilkingSpeedCopyWithImpl<$Res>
    implements _$MilkingSpeedCopyWith<$Res> {
  __$MilkingSpeedCopyWithImpl(this._self, this._then);

  final _MilkingSpeed _self;
  final $Res Function(_MilkingSpeed) _then;

/// Create a copy of MilkingSpeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? milkings = null,Object? avgFlow = null,Object? peakFlow = null,Object? durationSec = null,Object? herdAvgFlow = null,Object? slow = null,}) {
  return _then(_MilkingSpeed(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,milkings: null == milkings ? _self.milkings : milkings // ignore: cast_nullable_to_non_nullable
as int,avgFlow: null == avgFlow ? _self.avgFlow : avgFlow // ignore: cast_nullable_to_non_nullable
as double,peakFlow: null == peakFlow ? _self.peakFlow : peakFlow // ignore: cast_nullable_to_non_nullable
as double,durationSec: null == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int,herdAvgFlow: null == herdAvgFlow ? _self.herdAvgFlow : herdAvgFlow // ignore: cast_nullable_to_non_nullable
as double,slow: null == slow ? _self.slow : slow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
