// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thresholds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Thresholds {

 String get speciesId;/// Altında debi kırmızı (L/dk).
 double get flowLow;/// Üstünde debi yeşil (L/dk).
 double get flowHigh; double get yieldGreenPct; double get yieldRedPct;/// Sağım başından sonraki ısınma süresi; bu sürede kırmızı üretilmez.
 int get rampUpSec;/// Kırmızı durumun uyarıya dönüşmesi için sürmesi gereken süre.
 int get alertHoldSec; double get endFlowThreshold; int get endGraceSec; int get dryOffDailyMl; int get highYieldDailyMl;
/// Create a copy of Thresholds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThresholdsCopyWith<Thresholds> get copyWith => _$ThresholdsCopyWithImpl<Thresholds>(this as Thresholds, _$identity);

  /// Serializes this Thresholds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Thresholds&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.flowLow, flowLow) || other.flowLow == flowLow)&&(identical(other.flowHigh, flowHigh) || other.flowHigh == flowHigh)&&(identical(other.yieldGreenPct, yieldGreenPct) || other.yieldGreenPct == yieldGreenPct)&&(identical(other.yieldRedPct, yieldRedPct) || other.yieldRedPct == yieldRedPct)&&(identical(other.rampUpSec, rampUpSec) || other.rampUpSec == rampUpSec)&&(identical(other.alertHoldSec, alertHoldSec) || other.alertHoldSec == alertHoldSec)&&(identical(other.endFlowThreshold, endFlowThreshold) || other.endFlowThreshold == endFlowThreshold)&&(identical(other.endGraceSec, endGraceSec) || other.endGraceSec == endGraceSec)&&(identical(other.dryOffDailyMl, dryOffDailyMl) || other.dryOffDailyMl == dryOffDailyMl)&&(identical(other.highYieldDailyMl, highYieldDailyMl) || other.highYieldDailyMl == highYieldDailyMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,flowLow,flowHigh,yieldGreenPct,yieldRedPct,rampUpSec,alertHoldSec,endFlowThreshold,endGraceSec,dryOffDailyMl,highYieldDailyMl);

@override
String toString() {
  return 'Thresholds(speciesId: $speciesId, flowLow: $flowLow, flowHigh: $flowHigh, yieldGreenPct: $yieldGreenPct, yieldRedPct: $yieldRedPct, rampUpSec: $rampUpSec, alertHoldSec: $alertHoldSec, endFlowThreshold: $endFlowThreshold, endGraceSec: $endGraceSec, dryOffDailyMl: $dryOffDailyMl, highYieldDailyMl: $highYieldDailyMl)';
}


}

/// @nodoc
abstract mixin class $ThresholdsCopyWith<$Res>  {
  factory $ThresholdsCopyWith(Thresholds value, $Res Function(Thresholds) _then) = _$ThresholdsCopyWithImpl;
@useResult
$Res call({
 String speciesId, double flowLow, double flowHigh, double yieldGreenPct, double yieldRedPct, int rampUpSec, int alertHoldSec, double endFlowThreshold, int endGraceSec, int dryOffDailyMl, int highYieldDailyMl
});




}
/// @nodoc
class _$ThresholdsCopyWithImpl<$Res>
    implements $ThresholdsCopyWith<$Res> {
  _$ThresholdsCopyWithImpl(this._self, this._then);

  final Thresholds _self;
  final $Res Function(Thresholds) _then;

/// Create a copy of Thresholds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speciesId = null,Object? flowLow = null,Object? flowHigh = null,Object? yieldGreenPct = null,Object? yieldRedPct = null,Object? rampUpSec = null,Object? alertHoldSec = null,Object? endFlowThreshold = null,Object? endGraceSec = null,Object? dryOffDailyMl = null,Object? highYieldDailyMl = null,}) {
  return _then(_self.copyWith(
speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,flowLow: null == flowLow ? _self.flowLow : flowLow // ignore: cast_nullable_to_non_nullable
as double,flowHigh: null == flowHigh ? _self.flowHigh : flowHigh // ignore: cast_nullable_to_non_nullable
as double,yieldGreenPct: null == yieldGreenPct ? _self.yieldGreenPct : yieldGreenPct // ignore: cast_nullable_to_non_nullable
as double,yieldRedPct: null == yieldRedPct ? _self.yieldRedPct : yieldRedPct // ignore: cast_nullable_to_non_nullable
as double,rampUpSec: null == rampUpSec ? _self.rampUpSec : rampUpSec // ignore: cast_nullable_to_non_nullable
as int,alertHoldSec: null == alertHoldSec ? _self.alertHoldSec : alertHoldSec // ignore: cast_nullable_to_non_nullable
as int,endFlowThreshold: null == endFlowThreshold ? _self.endFlowThreshold : endFlowThreshold // ignore: cast_nullable_to_non_nullable
as double,endGraceSec: null == endGraceSec ? _self.endGraceSec : endGraceSec // ignore: cast_nullable_to_non_nullable
as int,dryOffDailyMl: null == dryOffDailyMl ? _self.dryOffDailyMl : dryOffDailyMl // ignore: cast_nullable_to_non_nullable
as int,highYieldDailyMl: null == highYieldDailyMl ? _self.highYieldDailyMl : highYieldDailyMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Thresholds].
extension ThresholdsPatterns on Thresholds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Thresholds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Thresholds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Thresholds value)  $default,){
final _that = this;
switch (_that) {
case _Thresholds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Thresholds value)?  $default,){
final _that = this;
switch (_that) {
case _Thresholds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String speciesId,  double flowLow,  double flowHigh,  double yieldGreenPct,  double yieldRedPct,  int rampUpSec,  int alertHoldSec,  double endFlowThreshold,  int endGraceSec,  int dryOffDailyMl,  int highYieldDailyMl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Thresholds() when $default != null:
return $default(_that.speciesId,_that.flowLow,_that.flowHigh,_that.yieldGreenPct,_that.yieldRedPct,_that.rampUpSec,_that.alertHoldSec,_that.endFlowThreshold,_that.endGraceSec,_that.dryOffDailyMl,_that.highYieldDailyMl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String speciesId,  double flowLow,  double flowHigh,  double yieldGreenPct,  double yieldRedPct,  int rampUpSec,  int alertHoldSec,  double endFlowThreshold,  int endGraceSec,  int dryOffDailyMl,  int highYieldDailyMl)  $default,) {final _that = this;
switch (_that) {
case _Thresholds():
return $default(_that.speciesId,_that.flowLow,_that.flowHigh,_that.yieldGreenPct,_that.yieldRedPct,_that.rampUpSec,_that.alertHoldSec,_that.endFlowThreshold,_that.endGraceSec,_that.dryOffDailyMl,_that.highYieldDailyMl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String speciesId,  double flowLow,  double flowHigh,  double yieldGreenPct,  double yieldRedPct,  int rampUpSec,  int alertHoldSec,  double endFlowThreshold,  int endGraceSec,  int dryOffDailyMl,  int highYieldDailyMl)?  $default,) {final _that = this;
switch (_that) {
case _Thresholds() when $default != null:
return $default(_that.speciesId,_that.flowLow,_that.flowHigh,_that.yieldGreenPct,_that.yieldRedPct,_that.rampUpSec,_that.alertHoldSec,_that.endFlowThreshold,_that.endGraceSec,_that.dryOffDailyMl,_that.highYieldDailyMl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Thresholds implements Thresholds {
  const _Thresholds({required this.speciesId, required this.flowLow, required this.flowHigh, this.yieldGreenPct = 90, this.yieldRedPct = 60, this.rampUpSec = 60, this.alertHoldSec = 30, this.endFlowThreshold = 0.2, this.endGraceSec = 10, this.dryOffDailyMl = 0, this.highYieldDailyMl = 0});
  factory _Thresholds.fromJson(Map<String, dynamic> json) => _$ThresholdsFromJson(json);

@override final  String speciesId;
/// Altında debi kırmızı (L/dk).
@override final  double flowLow;
/// Üstünde debi yeşil (L/dk).
@override final  double flowHigh;
@override@JsonKey() final  double yieldGreenPct;
@override@JsonKey() final  double yieldRedPct;
/// Sağım başından sonraki ısınma süresi; bu sürede kırmızı üretilmez.
@override@JsonKey() final  int rampUpSec;
/// Kırmızı durumun uyarıya dönüşmesi için sürmesi gereken süre.
@override@JsonKey() final  int alertHoldSec;
@override@JsonKey() final  double endFlowThreshold;
@override@JsonKey() final  int endGraceSec;
@override@JsonKey() final  int dryOffDailyMl;
@override@JsonKey() final  int highYieldDailyMl;

/// Create a copy of Thresholds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThresholdsCopyWith<_Thresholds> get copyWith => __$ThresholdsCopyWithImpl<_Thresholds>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThresholdsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Thresholds&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.flowLow, flowLow) || other.flowLow == flowLow)&&(identical(other.flowHigh, flowHigh) || other.flowHigh == flowHigh)&&(identical(other.yieldGreenPct, yieldGreenPct) || other.yieldGreenPct == yieldGreenPct)&&(identical(other.yieldRedPct, yieldRedPct) || other.yieldRedPct == yieldRedPct)&&(identical(other.rampUpSec, rampUpSec) || other.rampUpSec == rampUpSec)&&(identical(other.alertHoldSec, alertHoldSec) || other.alertHoldSec == alertHoldSec)&&(identical(other.endFlowThreshold, endFlowThreshold) || other.endFlowThreshold == endFlowThreshold)&&(identical(other.endGraceSec, endGraceSec) || other.endGraceSec == endGraceSec)&&(identical(other.dryOffDailyMl, dryOffDailyMl) || other.dryOffDailyMl == dryOffDailyMl)&&(identical(other.highYieldDailyMl, highYieldDailyMl) || other.highYieldDailyMl == highYieldDailyMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,flowLow,flowHigh,yieldGreenPct,yieldRedPct,rampUpSec,alertHoldSec,endFlowThreshold,endGraceSec,dryOffDailyMl,highYieldDailyMl);

@override
String toString() {
  return 'Thresholds(speciesId: $speciesId, flowLow: $flowLow, flowHigh: $flowHigh, yieldGreenPct: $yieldGreenPct, yieldRedPct: $yieldRedPct, rampUpSec: $rampUpSec, alertHoldSec: $alertHoldSec, endFlowThreshold: $endFlowThreshold, endGraceSec: $endGraceSec, dryOffDailyMl: $dryOffDailyMl, highYieldDailyMl: $highYieldDailyMl)';
}


}

/// @nodoc
abstract mixin class _$ThresholdsCopyWith<$Res> implements $ThresholdsCopyWith<$Res> {
  factory _$ThresholdsCopyWith(_Thresholds value, $Res Function(_Thresholds) _then) = __$ThresholdsCopyWithImpl;
@override @useResult
$Res call({
 String speciesId, double flowLow, double flowHigh, double yieldGreenPct, double yieldRedPct, int rampUpSec, int alertHoldSec, double endFlowThreshold, int endGraceSec, int dryOffDailyMl, int highYieldDailyMl
});




}
/// @nodoc
class __$ThresholdsCopyWithImpl<$Res>
    implements _$ThresholdsCopyWith<$Res> {
  __$ThresholdsCopyWithImpl(this._self, this._then);

  final _Thresholds _self;
  final $Res Function(_Thresholds) _then;

/// Create a copy of Thresholds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speciesId = null,Object? flowLow = null,Object? flowHigh = null,Object? yieldGreenPct = null,Object? yieldRedPct = null,Object? rampUpSec = null,Object? alertHoldSec = null,Object? endFlowThreshold = null,Object? endGraceSec = null,Object? dryOffDailyMl = null,Object? highYieldDailyMl = null,}) {
  return _then(_Thresholds(
speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,flowLow: null == flowLow ? _self.flowLow : flowLow // ignore: cast_nullable_to_non_nullable
as double,flowHigh: null == flowHigh ? _self.flowHigh : flowHigh // ignore: cast_nullable_to_non_nullable
as double,yieldGreenPct: null == yieldGreenPct ? _self.yieldGreenPct : yieldGreenPct // ignore: cast_nullable_to_non_nullable
as double,yieldRedPct: null == yieldRedPct ? _self.yieldRedPct : yieldRedPct // ignore: cast_nullable_to_non_nullable
as double,rampUpSec: null == rampUpSec ? _self.rampUpSec : rampUpSec // ignore: cast_nullable_to_non_nullable
as int,alertHoldSec: null == alertHoldSec ? _self.alertHoldSec : alertHoldSec // ignore: cast_nullable_to_non_nullable
as int,endFlowThreshold: null == endFlowThreshold ? _self.endFlowThreshold : endFlowThreshold // ignore: cast_nullable_to_non_nullable
as double,endGraceSec: null == endGraceSec ? _self.endGraceSec : endGraceSec // ignore: cast_nullable_to_non_nullable
as int,dryOffDailyMl: null == dryOffDailyMl ? _self.dryOffDailyMl : dryOffDailyMl // ignore: cast_nullable_to_non_nullable
as int,highYieldDailyMl: null == highYieldDailyMl ? _self.highYieldDailyMl : highYieldDailyMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
