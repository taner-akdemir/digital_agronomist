// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spout_health.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpoutHealth {

 String get spoutId; int get milkings; int get animals; double get avgFlow; double? get unitMedian; double get diffPct; bool get low;
/// Create a copy of SpoutHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpoutHealthCopyWith<SpoutHealth> get copyWith => _$SpoutHealthCopyWithImpl<SpoutHealth>(this as SpoutHealth, _$identity);

  /// Serializes this SpoutHealth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpoutHealth;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpoutHealth&&(identical(other.spoutId, _this.spoutId) || other.spoutId == _this.spoutId)&&(identical(other.milkings, _this.milkings) || other.milkings == _this.milkings)&&(identical(other.animals, _this.animals) || other.animals == _this.animals)&&(identical(other.avgFlow, _this.avgFlow) || other.avgFlow == _this.avgFlow)&&(identical(other.unitMedian, _this.unitMedian) || other.unitMedian == _this.unitMedian)&&(identical(other.diffPct, _this.diffPct) || other.diffPct == _this.diffPct)&&(identical(other.low, _this.low) || other.low == _this.low));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpoutHealth;
  return Object.hash(runtimeType,_this.spoutId,_this.milkings,_this.animals,_this.avgFlow,_this.unitMedian,_this.diffPct,_this.low);
}

@override
String toString() {
  final _this = this as SpoutHealth;
  return 'SpoutHealth(spoutId: ${_this.spoutId}, milkings: ${_this.milkings}, animals: ${_this.animals}, avgFlow: ${_this.avgFlow}, unitMedian: ${_this.unitMedian}, diffPct: ${_this.diffPct}, low: ${_this.low})';
}


}

/// @nodoc
abstract mixin class $SpoutHealthCopyWith<$Res>  {
  factory $SpoutHealthCopyWith(SpoutHealth value, $Res Function(SpoutHealth) _then) = _$SpoutHealthCopyWithImpl;
@useResult
$Res call({
 String spoutId, int milkings, int animals, double avgFlow, double? unitMedian, double diffPct, bool low
});




}
/// @nodoc
class _$SpoutHealthCopyWithImpl<$Res>
    implements $SpoutHealthCopyWith<$Res> {
  _$SpoutHealthCopyWithImpl(this._self, this._then);

  final SpoutHealth _self;
  final $Res Function(SpoutHealth) _then;

/// Create a copy of SpoutHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spoutId = null,Object? milkings = null,Object? animals = null,Object? avgFlow = null,Object? unitMedian = freezed,Object? diffPct = null,Object? low = null,}) {
  return _then(SpoutHealth(
spoutId: null == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String,milkings: null == milkings ? _self.milkings : milkings // ignore: cast_nullable_to_non_nullable
as int,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,avgFlow: null == avgFlow ? _self.avgFlow : avgFlow // ignore: cast_nullable_to_non_nullable
as double,unitMedian: freezed == unitMedian ? _self.unitMedian : unitMedian // ignore: cast_nullable_to_non_nullable
as double?,diffPct: null == diffPct ? _self.diffPct : diffPct // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SpoutHealth].
extension SpoutHealthPatterns on SpoutHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpoutHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpoutHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpoutHealth value)  $default,){
final _that = this;
switch (_that) {
case _SpoutHealth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpoutHealth value)?  $default,){
final _that = this;
switch (_that) {
case _SpoutHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String spoutId,  int milkings,  int animals,  double avgFlow,  double? unitMedian,  double diffPct,  bool low)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpoutHealth() when $default != null:
return $default(_that.spoutId,_that.milkings,_that.animals,_that.avgFlow,_that.unitMedian,_that.diffPct,_that.low);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String spoutId,  int milkings,  int animals,  double avgFlow,  double? unitMedian,  double diffPct,  bool low)  $default,) {final _that = this;
switch (_that) {
case _SpoutHealth():
return $default(_that.spoutId,_that.milkings,_that.animals,_that.avgFlow,_that.unitMedian,_that.diffPct,_that.low);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String spoutId,  int milkings,  int animals,  double avgFlow,  double? unitMedian,  double diffPct,  bool low)?  $default,) {final _that = this;
switch (_that) {
case _SpoutHealth() when $default != null:
return $default(_that.spoutId,_that.milkings,_that.animals,_that.avgFlow,_that.unitMedian,_that.diffPct,_that.low);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpoutHealth implements SpoutHealth {
  const _SpoutHealth({required this.spoutId, this.milkings = 0, this.animals = 0, this.avgFlow = 0, this.unitMedian, this.diffPct = 0, this.low = false});
  factory _SpoutHealth.fromJson(Map<String, dynamic> json) => _$SpoutHealthFromJson(json);

@override final  String spoutId;
@override@JsonKey() final  int milkings;
@override@JsonKey() final  int animals;
@override@JsonKey() final  double avgFlow;
@override final  double? unitMedian;
@override@JsonKey() final  double diffPct;
@override@JsonKey() final  bool low;

/// Create a copy of SpoutHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpoutHealthCopyWith<_SpoutHealth> get copyWith => __$SpoutHealthCopyWithImpl<_SpoutHealth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpoutHealthToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpoutHealth&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.milkings, milkings) || other.milkings == milkings)&&(identical(other.animals, animals) || other.animals == animals)&&(identical(other.avgFlow, avgFlow) || other.avgFlow == avgFlow)&&(identical(other.unitMedian, unitMedian) || other.unitMedian == unitMedian)&&(identical(other.diffPct, diffPct) || other.diffPct == diffPct)&&(identical(other.low, low) || other.low == low));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,spoutId,milkings,animals,avgFlow,unitMedian,diffPct,low);
}

@override
String toString() {
    return 'SpoutHealth(spoutId: $spoutId, milkings: $milkings, animals: $animals, avgFlow: $avgFlow, unitMedian: $unitMedian, diffPct: $diffPct, low: $low)';
}


}

/// @nodoc
abstract mixin class _$SpoutHealthCopyWith<$Res> implements $SpoutHealthCopyWith<$Res> {
  factory _$SpoutHealthCopyWith(_SpoutHealth value, $Res Function(_SpoutHealth) _then) = __$SpoutHealthCopyWithImpl;
@override @useResult
$Res call({
 String spoutId, int milkings, int animals, double avgFlow, double? unitMedian, double diffPct, bool low
});




}
/// @nodoc
class __$SpoutHealthCopyWithImpl<$Res>
    implements _$SpoutHealthCopyWith<$Res> {
  __$SpoutHealthCopyWithImpl(this._self, this._then);

  final _SpoutHealth _self;
  final $Res Function(_SpoutHealth) _then;

/// Create a copy of SpoutHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spoutId = null,Object? milkings = null,Object? animals = null,Object? avgFlow = null,Object? unitMedian = freezed,Object? diffPct = null,Object? low = null,}) {
  return _then(_SpoutHealth(
spoutId: null == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String,milkings: null == milkings ? _self.milkings : milkings // ignore: cast_nullable_to_non_nullable
as int,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,avgFlow: null == avgFlow ? _self.avgFlow : avgFlow // ignore: cast_nullable_to_non_nullable
as double,unitMedian: freezed == unitMedian ? _self.unitMedian : unitMedian // ignore: cast_nullable_to_non_nullable
as double?,diffPct: null == diffPct ? _self.diffPct : diffPct // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
