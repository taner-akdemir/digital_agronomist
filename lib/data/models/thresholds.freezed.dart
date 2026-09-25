// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thresholds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Thresholds {

 String get speciesId;/// Altında debi kırmızı (L/dk).
 double get flowLow;/// Üstünde debi yeşil (L/dk).
 double get flowHigh; double get yieldGreenPct; double get yieldRedPct;/// Sağım başından sonraki ısınma süresi; bu sürede kırmızı üretilmez.
 int get rampUpSec;/// Kırmızı durumun uyarıya dönüşmesi için sürmesi gereken süre.
 int get alertHoldSec; double get endFlowThreshold; int get endGraceSec; int get dryOffDailyMl; int get highYieldDailyMl;/// Hayvanın GEÇMİŞİ YOKKEN beklenen sağım hacmi, mL (§6.3). Kaydetmede
/// GÖNDERİLMELİ: backend sıfırı reddediyor.
 int get expectedPerMilkingMl;/// false: işletme kendi eşiğini tanımlamamış, platform varsayılanı.
 bool get tenantScoped;/// Sınıflandırma kuralları (§6.4, backend ADR 0054). Varsayılanlar
/// backend'inkilerle aynı.
///
/// 7 günlük ortalama 30 günlüğe göre yüzde kaç düşünce "düşüşte".
 int get declinePct;/// Bu değerin altındaki sağım boş sayılır (mL).
 int get noMilkMl;/// Son kaç sağımın hepsi boşsa "süt vermiyor".
 int get noMilkMilkings;/// Buzağılamadan sonra "düşüşte" ve "kuruya çıkarma adayı" verilmeyen
/// gün sayısı (backend ADR 0051, 0059).
 int get freshLactationDays;
/// Create a copy of Thresholds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThresholdsCopyWith<Thresholds> get copyWith => _$ThresholdsCopyWithImpl<Thresholds>(this as Thresholds, _$identity);

  /// Serializes this Thresholds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Thresholds;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Thresholds&&(identical(other.speciesId, _this.speciesId) || other.speciesId == _this.speciesId)&&(identical(other.flowLow, _this.flowLow) || other.flowLow == _this.flowLow)&&(identical(other.flowHigh, _this.flowHigh) || other.flowHigh == _this.flowHigh)&&(identical(other.yieldGreenPct, _this.yieldGreenPct) || other.yieldGreenPct == _this.yieldGreenPct)&&(identical(other.yieldRedPct, _this.yieldRedPct) || other.yieldRedPct == _this.yieldRedPct)&&(identical(other.rampUpSec, _this.rampUpSec) || other.rampUpSec == _this.rampUpSec)&&(identical(other.alertHoldSec, _this.alertHoldSec) || other.alertHoldSec == _this.alertHoldSec)&&(identical(other.endFlowThreshold, _this.endFlowThreshold) || other.endFlowThreshold == _this.endFlowThreshold)&&(identical(other.endGraceSec, _this.endGraceSec) || other.endGraceSec == _this.endGraceSec)&&(identical(other.dryOffDailyMl, _this.dryOffDailyMl) || other.dryOffDailyMl == _this.dryOffDailyMl)&&(identical(other.highYieldDailyMl, _this.highYieldDailyMl) || other.highYieldDailyMl == _this.highYieldDailyMl)&&(identical(other.expectedPerMilkingMl, _this.expectedPerMilkingMl) || other.expectedPerMilkingMl == _this.expectedPerMilkingMl)&&(identical(other.tenantScoped, _this.tenantScoped) || other.tenantScoped == _this.tenantScoped)&&(identical(other.declinePct, _this.declinePct) || other.declinePct == _this.declinePct)&&(identical(other.noMilkMl, _this.noMilkMl) || other.noMilkMl == _this.noMilkMl)&&(identical(other.noMilkMilkings, _this.noMilkMilkings) || other.noMilkMilkings == _this.noMilkMilkings)&&(identical(other.freshLactationDays, _this.freshLactationDays) || other.freshLactationDays == _this.freshLactationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Thresholds;
  return Object.hash(runtimeType,_this.speciesId,_this.flowLow,_this.flowHigh,_this.yieldGreenPct,_this.yieldRedPct,_this.rampUpSec,_this.alertHoldSec,_this.endFlowThreshold,_this.endGraceSec,_this.dryOffDailyMl,_this.highYieldDailyMl,_this.expectedPerMilkingMl,_this.tenantScoped,_this.declinePct,_this.noMilkMl,_this.noMilkMilkings,_this.freshLactationDays);
}

@override
String toString() {
  final _this = this as Thresholds;
  return 'Thresholds(speciesId: ${_this.speciesId}, flowLow: ${_this.flowLow}, flowHigh: ${_this.flowHigh}, yieldGreenPct: ${_this.yieldGreenPct}, yieldRedPct: ${_this.yieldRedPct}, rampUpSec: ${_this.rampUpSec}, alertHoldSec: ${_this.alertHoldSec}, endFlowThreshold: ${_this.endFlowThreshold}, endGraceSec: ${_this.endGraceSec}, dryOffDailyMl: ${_this.dryOffDailyMl}, highYieldDailyMl: ${_this.highYieldDailyMl}, expectedPerMilkingMl: ${_this.expectedPerMilkingMl}, tenantScoped: ${_this.tenantScoped}, declinePct: ${_this.declinePct}, noMilkMl: ${_this.noMilkMl}, noMilkMilkings: ${_this.noMilkMilkings}, freshLactationDays: ${_this.freshLactationDays})';
}


}

/// @nodoc
abstract mixin class $ThresholdsCopyWith<$Res>  {
  factory $ThresholdsCopyWith(Thresholds value, $Res Function(Thresholds) _then) = _$ThresholdsCopyWithImpl;
@useResult
$Res call({
 String speciesId, double flowLow, double flowHigh, double yieldGreenPct, double yieldRedPct, int rampUpSec, int alertHoldSec, double endFlowThreshold, int endGraceSec, int dryOffDailyMl, int highYieldDailyMl, int expectedPerMilkingMl, bool tenantScoped, int declinePct, int noMilkMl, int noMilkMilkings, int freshLactationDays
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
@pragma('vm:prefer-inline') @override $Res call({Object? speciesId = null,Object? flowLow = null,Object? flowHigh = null,Object? yieldGreenPct = null,Object? yieldRedPct = null,Object? rampUpSec = null,Object? alertHoldSec = null,Object? endFlowThreshold = null,Object? endGraceSec = null,Object? dryOffDailyMl = null,Object? highYieldDailyMl = null,Object? expectedPerMilkingMl = null,Object? tenantScoped = null,Object? declinePct = null,Object? noMilkMl = null,Object? noMilkMilkings = null,Object? freshLactationDays = null,}) {
  return _then(Thresholds(
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
as int,expectedPerMilkingMl: null == expectedPerMilkingMl ? _self.expectedPerMilkingMl : expectedPerMilkingMl // ignore: cast_nullable_to_non_nullable
as int,tenantScoped: null == tenantScoped ? _self.tenantScoped : tenantScoped // ignore: cast_nullable_to_non_nullable
as bool,declinePct: null == declinePct ? _self.declinePct : declinePct // ignore: cast_nullable_to_non_nullable
as int,noMilkMl: null == noMilkMl ? _self.noMilkMl : noMilkMl // ignore: cast_nullable_to_non_nullable
as int,noMilkMilkings: null == noMilkMilkings ? _self.noMilkMilkings : noMilkMilkings // ignore: cast_nullable_to_non_nullable
as int,freshLactationDays: null == freshLactationDays ? _self.freshLactationDays : freshLactationDays // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String speciesId,  double flowLow,  double flowHigh,  double yieldGreenPct,  double yieldRedPct,  int rampUpSec,  int alertHoldSec,  double endFlowThreshold,  int endGraceSec,  int dryOffDailyMl,  int highYieldDailyMl,  int expectedPerMilkingMl,  bool tenantScoped,  int declinePct,  int noMilkMl,  int noMilkMilkings,  int freshLactationDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Thresholds() when $default != null:
return $default(_that.speciesId,_that.flowLow,_that.flowHigh,_that.yieldGreenPct,_that.yieldRedPct,_that.rampUpSec,_that.alertHoldSec,_that.endFlowThreshold,_that.endGraceSec,_that.dryOffDailyMl,_that.highYieldDailyMl,_that.expectedPerMilkingMl,_that.tenantScoped,_that.declinePct,_that.noMilkMl,_that.noMilkMilkings,_that.freshLactationDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String speciesId,  double flowLow,  double flowHigh,  double yieldGreenPct,  double yieldRedPct,  int rampUpSec,  int alertHoldSec,  double endFlowThreshold,  int endGraceSec,  int dryOffDailyMl,  int highYieldDailyMl,  int expectedPerMilkingMl,  bool tenantScoped,  int declinePct,  int noMilkMl,  int noMilkMilkings,  int freshLactationDays)  $default,) {final _that = this;
switch (_that) {
case _Thresholds():
return $default(_that.speciesId,_that.flowLow,_that.flowHigh,_that.yieldGreenPct,_that.yieldRedPct,_that.rampUpSec,_that.alertHoldSec,_that.endFlowThreshold,_that.endGraceSec,_that.dryOffDailyMl,_that.highYieldDailyMl,_that.expectedPerMilkingMl,_that.tenantScoped,_that.declinePct,_that.noMilkMl,_that.noMilkMilkings,_that.freshLactationDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String speciesId,  double flowLow,  double flowHigh,  double yieldGreenPct,  double yieldRedPct,  int rampUpSec,  int alertHoldSec,  double endFlowThreshold,  int endGraceSec,  int dryOffDailyMl,  int highYieldDailyMl,  int expectedPerMilkingMl,  bool tenantScoped,  int declinePct,  int noMilkMl,  int noMilkMilkings,  int freshLactationDays)?  $default,) {final _that = this;
switch (_that) {
case _Thresholds() when $default != null:
return $default(_that.speciesId,_that.flowLow,_that.flowHigh,_that.yieldGreenPct,_that.yieldRedPct,_that.rampUpSec,_that.alertHoldSec,_that.endFlowThreshold,_that.endGraceSec,_that.dryOffDailyMl,_that.highYieldDailyMl,_that.expectedPerMilkingMl,_that.tenantScoped,_that.declinePct,_that.noMilkMl,_that.noMilkMilkings,_that.freshLactationDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Thresholds implements Thresholds {
  const _Thresholds({required this.speciesId, required this.flowLow, required this.flowHigh, this.yieldGreenPct = 90, this.yieldRedPct = 60, this.rampUpSec = 60, this.alertHoldSec = 30, this.endFlowThreshold = 0.2, this.endGraceSec = 10, this.dryOffDailyMl = 0, this.highYieldDailyMl = 0, this.expectedPerMilkingMl = 0, this.tenantScoped = false, this.declinePct = 20, this.noMilkMl = 100, this.noMilkMilkings = 4, this.freshLactationDays = 30});
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
/// Hayvanın GEÇMİŞİ YOKKEN beklenen sağım hacmi, mL (§6.3). Kaydetmede
/// GÖNDERİLMELİ: backend sıfırı reddediyor.
@override@JsonKey() final  int expectedPerMilkingMl;
/// false: işletme kendi eşiğini tanımlamamış, platform varsayılanı.
@override@JsonKey() final  bool tenantScoped;
/// Sınıflandırma kuralları (§6.4, backend ADR 0054). Varsayılanlar
/// backend'inkilerle aynı.
///
/// 7 günlük ortalama 30 günlüğe göre yüzde kaç düşünce "düşüşte".
@override@JsonKey() final  int declinePct;
/// Bu değerin altındaki sağım boş sayılır (mL).
@override@JsonKey() final  int noMilkMl;
/// Son kaç sağımın hepsi boşsa "süt vermiyor".
@override@JsonKey() final  int noMilkMilkings;
/// Buzağılamadan sonra "düşüşte" ve "kuruya çıkarma adayı" verilmeyen
/// gün sayısı (backend ADR 0051, 0059).
@override@JsonKey() final  int freshLactationDays;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Thresholds&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.flowLow, flowLow) || other.flowLow == flowLow)&&(identical(other.flowHigh, flowHigh) || other.flowHigh == flowHigh)&&(identical(other.yieldGreenPct, yieldGreenPct) || other.yieldGreenPct == yieldGreenPct)&&(identical(other.yieldRedPct, yieldRedPct) || other.yieldRedPct == yieldRedPct)&&(identical(other.rampUpSec, rampUpSec) || other.rampUpSec == rampUpSec)&&(identical(other.alertHoldSec, alertHoldSec) || other.alertHoldSec == alertHoldSec)&&(identical(other.endFlowThreshold, endFlowThreshold) || other.endFlowThreshold == endFlowThreshold)&&(identical(other.endGraceSec, endGraceSec) || other.endGraceSec == endGraceSec)&&(identical(other.dryOffDailyMl, dryOffDailyMl) || other.dryOffDailyMl == dryOffDailyMl)&&(identical(other.highYieldDailyMl, highYieldDailyMl) || other.highYieldDailyMl == highYieldDailyMl)&&(identical(other.expectedPerMilkingMl, expectedPerMilkingMl) || other.expectedPerMilkingMl == expectedPerMilkingMl)&&(identical(other.tenantScoped, tenantScoped) || other.tenantScoped == tenantScoped)&&(identical(other.declinePct, declinePct) || other.declinePct == declinePct)&&(identical(other.noMilkMl, noMilkMl) || other.noMilkMl == noMilkMl)&&(identical(other.noMilkMilkings, noMilkMilkings) || other.noMilkMilkings == noMilkMilkings)&&(identical(other.freshLactationDays, freshLactationDays) || other.freshLactationDays == freshLactationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,speciesId,flowLow,flowHigh,yieldGreenPct,yieldRedPct,rampUpSec,alertHoldSec,endFlowThreshold,endGraceSec,dryOffDailyMl,highYieldDailyMl,expectedPerMilkingMl,tenantScoped,declinePct,noMilkMl,noMilkMilkings,freshLactationDays);
}

@override
String toString() {
    return 'Thresholds(speciesId: $speciesId, flowLow: $flowLow, flowHigh: $flowHigh, yieldGreenPct: $yieldGreenPct, yieldRedPct: $yieldRedPct, rampUpSec: $rampUpSec, alertHoldSec: $alertHoldSec, endFlowThreshold: $endFlowThreshold, endGraceSec: $endGraceSec, dryOffDailyMl: $dryOffDailyMl, highYieldDailyMl: $highYieldDailyMl, expectedPerMilkingMl: $expectedPerMilkingMl, tenantScoped: $tenantScoped, declinePct: $declinePct, noMilkMl: $noMilkMl, noMilkMilkings: $noMilkMilkings, freshLactationDays: $freshLactationDays)';
}


}

/// @nodoc
abstract mixin class _$ThresholdsCopyWith<$Res> implements $ThresholdsCopyWith<$Res> {
  factory _$ThresholdsCopyWith(_Thresholds value, $Res Function(_Thresholds) _then) = __$ThresholdsCopyWithImpl;
@override @useResult
$Res call({
 String speciesId, double flowLow, double flowHigh, double yieldGreenPct, double yieldRedPct, int rampUpSec, int alertHoldSec, double endFlowThreshold, int endGraceSec, int dryOffDailyMl, int highYieldDailyMl, int expectedPerMilkingMl, bool tenantScoped, int declinePct, int noMilkMl, int noMilkMilkings, int freshLactationDays
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
@override @pragma('vm:prefer-inline') $Res call({Object? speciesId = null,Object? flowLow = null,Object? flowHigh = null,Object? yieldGreenPct = null,Object? yieldRedPct = null,Object? rampUpSec = null,Object? alertHoldSec = null,Object? endFlowThreshold = null,Object? endGraceSec = null,Object? dryOffDailyMl = null,Object? highYieldDailyMl = null,Object? expectedPerMilkingMl = null,Object? tenantScoped = null,Object? declinePct = null,Object? noMilkMl = null,Object? noMilkMilkings = null,Object? freshLactationDays = null,}) {
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
as int,expectedPerMilkingMl: null == expectedPerMilkingMl ? _self.expectedPerMilkingMl : expectedPerMilkingMl // ignore: cast_nullable_to_non_nullable
as int,tenantScoped: null == tenantScoped ? _self.tenantScoped : tenantScoped // ignore: cast_nullable_to_non_nullable
as bool,declinePct: null == declinePct ? _self.declinePct : declinePct // ignore: cast_nullable_to_non_nullable
as int,noMilkMl: null == noMilkMl ? _self.noMilkMl : noMilkMl // ignore: cast_nullable_to_non_nullable
as int,noMilkMilkings: null == noMilkMilkings ? _self.noMilkMilkings : noMilkMilkings // ignore: cast_nullable_to_non_nullable
as int,freshLactationDays: null == freshLactationDays ? _self.freshLactationDays : freshLactationDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
