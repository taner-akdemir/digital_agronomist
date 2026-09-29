// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal_trend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimalTrend {

 String get animalId;@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass get yieldClass;/// 7 ve 30 günlük hareketli ortalama, GÜNLÜK toplam mL.
 int get ma7Ml; int get ma30Ml;/// Günlük değişim eğimi, mL/gün. Negatif = düşüş (§8.4 trend_slope).
 double get trendSlope;/// Günlük seri — grafiğin veri kaynağı. Eskiden yeniye sıralı.
 List<AnimalDailyStat> get daily;/// Bu laktasyonun 305 gün değerleri (backend ADR 0115); buzağılama
/// kaydı yoksa null.
 Lactation305? get lactation;
/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalTrendCopyWith<AnimalTrend> get copyWith => _$AnimalTrendCopyWithImpl<AnimalTrend>(this as AnimalTrend, _$identity);

  /// Serializes this AnimalTrend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalTrend;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalTrend&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.yieldClass, _this.yieldClass) || other.yieldClass == _this.yieldClass)&&(identical(other.ma7Ml, _this.ma7Ml) || other.ma7Ml == _this.ma7Ml)&&(identical(other.ma30Ml, _this.ma30Ml) || other.ma30Ml == _this.ma30Ml)&&(identical(other.trendSlope, _this.trendSlope) || other.trendSlope == _this.trendSlope)&&const DeepCollectionEquality().equals(other.daily, _this.daily)&&(identical(other.lactation, _this.lactation) || other.lactation == _this.lactation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalTrend;
  return Object.hash(runtimeType,_this.animalId,_this.yieldClass,_this.ma7Ml,_this.ma30Ml,_this.trendSlope,const DeepCollectionEquality().hash(_this.daily),_this.lactation);
}

@override
String toString() {
  final _this = this as AnimalTrend;
  return 'AnimalTrend(animalId: ${_this.animalId}, yieldClass: ${_this.yieldClass}, ma7Ml: ${_this.ma7Ml}, ma30Ml: ${_this.ma30Ml}, trendSlope: ${_this.trendSlope}, daily: ${_this.daily}, lactation: ${_this.lactation})';
}


}

/// @nodoc
abstract mixin class $AnimalTrendCopyWith<$Res>  {
  factory $AnimalTrendCopyWith(AnimalTrend value, $Res Function(AnimalTrend) _then) = _$AnimalTrendCopyWithImpl;
@useResult
$Res call({
 String animalId,@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, int ma7Ml, int ma30Ml, double trendSlope, List<AnimalDailyStat> daily, Lactation305? lactation
});


$Lactation305CopyWith<$Res>? get lactation;

}
/// @nodoc
class _$AnimalTrendCopyWithImpl<$Res>
    implements $AnimalTrendCopyWith<$Res> {
  _$AnimalTrendCopyWithImpl(this._self, this._then);

  final AnimalTrend _self;
  final $Res Function(AnimalTrend) _then;

/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? yieldClass = null,Object? ma7Ml = null,Object? ma30Ml = null,Object? trendSlope = null,Object? daily = null,Object? lactation = freezed,}) {
  return _then(AnimalTrend(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,ma7Ml: null == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int,ma30Ml: null == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int,trendSlope: null == trendSlope ? _self.trendSlope : trendSlope // ignore: cast_nullable_to_non_nullable
as double,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as List<AnimalDailyStat>,lactation: freezed == lactation ? _self.lactation : lactation // ignore: cast_nullable_to_non_nullable
as Lactation305?,
  ));
}
/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Lactation305CopyWith<$Res>? get lactation {
    if (_self.lactation == null) {
    return null;
  }

  return $Lactation305CopyWith<$Res>(_self.lactation!, (value) {
    return _then(_self.copyWith(lactation: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnimalTrend].
extension AnimalTrendPatterns on AnimalTrend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalTrend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalTrend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalTrend value)  $default,){
final _that = this;
switch (_that) {
case _AnimalTrend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalTrend value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalTrend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int ma7Ml,  int ma30Ml,  double trendSlope,  List<AnimalDailyStat> daily,  Lactation305? lactation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalTrend() when $default != null:
return $default(_that.animalId,_that.yieldClass,_that.ma7Ml,_that.ma30Ml,_that.trendSlope,_that.daily,_that.lactation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int ma7Ml,  int ma30Ml,  double trendSlope,  List<AnimalDailyStat> daily,  Lactation305? lactation)  $default,) {final _that = this;
switch (_that) {
case _AnimalTrend():
return $default(_that.animalId,_that.yieldClass,_that.ma7Ml,_that.ma30Ml,_that.trendSlope,_that.daily,_that.lactation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int ma7Ml,  int ma30Ml,  double trendSlope,  List<AnimalDailyStat> daily,  Lactation305? lactation)?  $default,) {final _that = this;
switch (_that) {
case _AnimalTrend() when $default != null:
return $default(_that.animalId,_that.yieldClass,_that.ma7Ml,_that.ma30Ml,_that.trendSlope,_that.daily,_that.lactation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalTrend implements AnimalTrend {
  const _AnimalTrend({required this.animalId, @JsonKey(unknownEnumValue: YieldClass.normal) this.yieldClass = YieldClass.normal, this.ma7Ml = 0, this.ma30Ml = 0, this.trendSlope = 0,  List<AnimalDailyStat> daily = const <AnimalDailyStat>[], this.lactation}): _daily = daily;
  factory _AnimalTrend.fromJson(Map<String, dynamic> json) => _$AnimalTrendFromJson(json);

@override final  String animalId;
@override@JsonKey(unknownEnumValue: YieldClass.normal) final  YieldClass yieldClass;
/// 7 ve 30 günlük hareketli ortalama, GÜNLÜK toplam mL.
@override@JsonKey() final  int ma7Ml;
@override@JsonKey() final  int ma30Ml;
/// Günlük değişim eğimi, mL/gün. Negatif = düşüş (§8.4 trend_slope).
@override@JsonKey() final  double trendSlope;
/// Günlük seri — grafiğin veri kaynağı. Eskiden yeniye sıralı.
 final  List<AnimalDailyStat> _daily;
/// Günlük seri — grafiğin veri kaynağı. Eskiden yeniye sıralı.
@override@JsonKey() List<AnimalDailyStat> get daily {
  if (_daily is EqualUnmodifiableListView) return _daily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daily);
}

/// Bu laktasyonun 305 gün değerleri (backend ADR 0115); buzağılama
/// kaydı yoksa null.
@override final  Lactation305? lactation;

/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalTrendCopyWith<_AnimalTrend> get copyWith => __$AnimalTrendCopyWithImpl<_AnimalTrend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalTrendToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalTrend&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.yieldClass, yieldClass) || other.yieldClass == yieldClass)&&(identical(other.ma7Ml, ma7Ml) || other.ma7Ml == ma7Ml)&&(identical(other.ma30Ml, ma30Ml) || other.ma30Ml == ma30Ml)&&(identical(other.trendSlope, trendSlope) || other.trendSlope == trendSlope)&&const DeepCollectionEquality().equals(other.daily, _daily)&&(identical(other.lactation, lactation) || other.lactation == lactation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,yieldClass,ma7Ml,ma30Ml,trendSlope,const DeepCollectionEquality().hash(_daily),lactation);
}

@override
String toString() {
    return 'AnimalTrend(animalId: $animalId, yieldClass: $yieldClass, ma7Ml: $ma7Ml, ma30Ml: $ma30Ml, trendSlope: $trendSlope, daily: $daily, lactation: $lactation)';
}


}

/// @nodoc
abstract mixin class _$AnimalTrendCopyWith<$Res> implements $AnimalTrendCopyWith<$Res> {
  factory _$AnimalTrendCopyWith(_AnimalTrend value, $Res Function(_AnimalTrend) _then) = __$AnimalTrendCopyWithImpl;
@override @useResult
$Res call({
 String animalId,@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, int ma7Ml, int ma30Ml, double trendSlope, List<AnimalDailyStat> daily, Lactation305? lactation
});


@override $Lactation305CopyWith<$Res>? get lactation;

}
/// @nodoc
class __$AnimalTrendCopyWithImpl<$Res>
    implements _$AnimalTrendCopyWith<$Res> {
  __$AnimalTrendCopyWithImpl(this._self, this._then);

  final _AnimalTrend _self;
  final $Res Function(_AnimalTrend) _then;

/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? yieldClass = null,Object? ma7Ml = null,Object? ma30Ml = null,Object? trendSlope = null,Object? daily = null,Object? lactation = freezed,}) {
  return _then(_AnimalTrend(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,ma7Ml: null == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int,ma30Ml: null == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int,trendSlope: null == trendSlope ? _self.trendSlope : trendSlope // ignore: cast_nullable_to_non_nullable
as double,daily: null == daily ? _self._daily : daily // ignore: cast_nullable_to_non_nullable
as List<AnimalDailyStat>,lactation: freezed == lactation ? _self.lactation : lactation // ignore: cast_nullable_to_non_nullable
as Lactation305?,
  ));
}

/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Lactation305CopyWith<$Res>? get lactation {
    if (_self.lactation == null) {
    return null;
  }

  return $Lactation305CopyWith<$Res>(_self.lactation!, (value) {
    return _then(_self.copyWith(lactation: value));
  });
}
}


/// @nodoc
mixin _$AnimalDailyStat {

 DateTime get date; int get totalMl; int get milkingCount;/// O güne kadarki hareketli ortalamalar; serinin başında veri yetmediği
/// için null olabilir.
 int? get ma7Ml; int? get ma30Ml;/// O günün en yüksek sıcaklık-nem indeksi (backend ADR 0119); tahmin
/// yoksa null. Grafik ≥ 72 günleri işaretler.
 double? get thi;
/// Create a copy of AnimalDailyStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalDailyStatCopyWith<AnimalDailyStat> get copyWith => _$AnimalDailyStatCopyWithImpl<AnimalDailyStat>(this as AnimalDailyStat, _$identity);

  /// Serializes this AnimalDailyStat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalDailyStat;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalDailyStat&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.totalMl, _this.totalMl) || other.totalMl == _this.totalMl)&&(identical(other.milkingCount, _this.milkingCount) || other.milkingCount == _this.milkingCount)&&(identical(other.ma7Ml, _this.ma7Ml) || other.ma7Ml == _this.ma7Ml)&&(identical(other.ma30Ml, _this.ma30Ml) || other.ma30Ml == _this.ma30Ml)&&(identical(other.thi, _this.thi) || other.thi == _this.thi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalDailyStat;
  return Object.hash(runtimeType,_this.date,_this.totalMl,_this.milkingCount,_this.ma7Ml,_this.ma30Ml,_this.thi);
}

@override
String toString() {
  final _this = this as AnimalDailyStat;
  return 'AnimalDailyStat(date: ${_this.date}, totalMl: ${_this.totalMl}, milkingCount: ${_this.milkingCount}, ma7Ml: ${_this.ma7Ml}, ma30Ml: ${_this.ma30Ml}, thi: ${_this.thi})';
}


}

/// @nodoc
abstract mixin class $AnimalDailyStatCopyWith<$Res>  {
  factory $AnimalDailyStatCopyWith(AnimalDailyStat value, $Res Function(AnimalDailyStat) _then) = _$AnimalDailyStatCopyWithImpl;
@useResult
$Res call({
 DateTime date, int totalMl, int milkingCount, int? ma7Ml, int? ma30Ml, double? thi
});




}
/// @nodoc
class _$AnimalDailyStatCopyWithImpl<$Res>
    implements $AnimalDailyStatCopyWith<$Res> {
  _$AnimalDailyStatCopyWithImpl(this._self, this._then);

  final AnimalDailyStat _self;
  final $Res Function(AnimalDailyStat) _then;

/// Create a copy of AnimalDailyStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? totalMl = null,Object? milkingCount = null,Object? ma7Ml = freezed,Object? ma30Ml = freezed,Object? thi = freezed,}) {
  return _then(AnimalDailyStat(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,ma7Ml: freezed == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int?,ma30Ml: freezed == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int?,thi: freezed == thi ? _self.thi : thi // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalDailyStat].
extension AnimalDailyStatPatterns on AnimalDailyStat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalDailyStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalDailyStat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalDailyStat value)  $default,){
final _that = this;
switch (_that) {
case _AnimalDailyStat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalDailyStat value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalDailyStat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int totalMl,  int milkingCount,  int? ma7Ml,  int? ma30Ml,  double? thi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalDailyStat() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.ma7Ml,_that.ma30Ml,_that.thi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int totalMl,  int milkingCount,  int? ma7Ml,  int? ma30Ml,  double? thi)  $default,) {final _that = this;
switch (_that) {
case _AnimalDailyStat():
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.ma7Ml,_that.ma30Ml,_that.thi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int totalMl,  int milkingCount,  int? ma7Ml,  int? ma30Ml,  double? thi)?  $default,) {final _that = this;
switch (_that) {
case _AnimalDailyStat() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.ma7Ml,_that.ma30Ml,_that.thi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalDailyStat implements AnimalDailyStat {
  const _AnimalDailyStat({required this.date, this.totalMl = 0, this.milkingCount = 0, this.ma7Ml, this.ma30Ml, this.thi});
  factory _AnimalDailyStat.fromJson(Map<String, dynamic> json) => _$AnimalDailyStatFromJson(json);

@override final  DateTime date;
@override@JsonKey() final  int totalMl;
@override@JsonKey() final  int milkingCount;
/// O güne kadarki hareketli ortalamalar; serinin başında veri yetmediği
/// için null olabilir.
@override final  int? ma7Ml;
@override final  int? ma30Ml;
/// O günün en yüksek sıcaklık-nem indeksi (backend ADR 0119); tahmin
/// yoksa null. Grafik ≥ 72 günleri işaretler.
@override final  double? thi;

/// Create a copy of AnimalDailyStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalDailyStatCopyWith<_AnimalDailyStat> get copyWith => __$AnimalDailyStatCopyWithImpl<_AnimalDailyStat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalDailyStatToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalDailyStat&&(identical(other.date, date) || other.date == date)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl)&&(identical(other.milkingCount, milkingCount) || other.milkingCount == milkingCount)&&(identical(other.ma7Ml, ma7Ml) || other.ma7Ml == ma7Ml)&&(identical(other.ma30Ml, ma30Ml) || other.ma30Ml == ma30Ml)&&(identical(other.thi, thi) || other.thi == thi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,totalMl,milkingCount,ma7Ml,ma30Ml,thi);
}

@override
String toString() {
    return 'AnimalDailyStat(date: $date, totalMl: $totalMl, milkingCount: $milkingCount, ma7Ml: $ma7Ml, ma30Ml: $ma30Ml, thi: $thi)';
}


}

/// @nodoc
abstract mixin class _$AnimalDailyStatCopyWith<$Res> implements $AnimalDailyStatCopyWith<$Res> {
  factory _$AnimalDailyStatCopyWith(_AnimalDailyStat value, $Res Function(_AnimalDailyStat) _then) = __$AnimalDailyStatCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int totalMl, int milkingCount, int? ma7Ml, int? ma30Ml, double? thi
});




}
/// @nodoc
class __$AnimalDailyStatCopyWithImpl<$Res>
    implements _$AnimalDailyStatCopyWith<$Res> {
  __$AnimalDailyStatCopyWithImpl(this._self, this._then);

  final _AnimalDailyStat _self;
  final $Res Function(_AnimalDailyStat) _then;

/// Create a copy of AnimalDailyStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? totalMl = null,Object? milkingCount = null,Object? ma7Ml = freezed,Object? ma30Ml = freezed,Object? thi = freezed,}) {
  return _then(_AnimalDailyStat(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,ma7Ml: freezed == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int?,ma30Ml: freezed == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int?,thi: freezed == thi ? _self.thi : thi // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$Lactation305 {

 DateTime get calvingDate; int get daysInMilk; int get actualMl; int? get projected305Ml; bool get complete;
/// Create a copy of Lactation305
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Lactation305CopyWith<Lactation305> get copyWith => _$Lactation305CopyWithImpl<Lactation305>(this as Lactation305, _$identity);

  /// Serializes this Lactation305 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Lactation305;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lactation305&&(identical(other.calvingDate, _this.calvingDate) || other.calvingDate == _this.calvingDate)&&(identical(other.daysInMilk, _this.daysInMilk) || other.daysInMilk == _this.daysInMilk)&&(identical(other.actualMl, _this.actualMl) || other.actualMl == _this.actualMl)&&(identical(other.projected305Ml, _this.projected305Ml) || other.projected305Ml == _this.projected305Ml)&&(identical(other.complete, _this.complete) || other.complete == _this.complete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Lactation305;
  return Object.hash(runtimeType,_this.calvingDate,_this.daysInMilk,_this.actualMl,_this.projected305Ml,_this.complete);
}

@override
String toString() {
  final _this = this as Lactation305;
  return 'Lactation305(calvingDate: ${_this.calvingDate}, daysInMilk: ${_this.daysInMilk}, actualMl: ${_this.actualMl}, projected305Ml: ${_this.projected305Ml}, complete: ${_this.complete})';
}


}

/// @nodoc
abstract mixin class $Lactation305CopyWith<$Res>  {
  factory $Lactation305CopyWith(Lactation305 value, $Res Function(Lactation305) _then) = _$Lactation305CopyWithImpl;
@useResult
$Res call({
 DateTime calvingDate, int daysInMilk, int actualMl, int? projected305Ml, bool complete
});




}
/// @nodoc
class _$Lactation305CopyWithImpl<$Res>
    implements $Lactation305CopyWith<$Res> {
  _$Lactation305CopyWithImpl(this._self, this._then);

  final Lactation305 _self;
  final $Res Function(Lactation305) _then;

/// Create a copy of Lactation305
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calvingDate = null,Object? daysInMilk = null,Object? actualMl = null,Object? projected305Ml = freezed,Object? complete = null,}) {
  return _then(Lactation305(
calvingDate: null == calvingDate ? _self.calvingDate : calvingDate // ignore: cast_nullable_to_non_nullable
as DateTime,daysInMilk: null == daysInMilk ? _self.daysInMilk : daysInMilk // ignore: cast_nullable_to_non_nullable
as int,actualMl: null == actualMl ? _self.actualMl : actualMl // ignore: cast_nullable_to_non_nullable
as int,projected305Ml: freezed == projected305Ml ? _self.projected305Ml : projected305Ml // ignore: cast_nullable_to_non_nullable
as int?,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Lactation305].
extension Lactation305Patterns on Lactation305 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lactation305 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lactation305() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lactation305 value)  $default,){
final _that = this;
switch (_that) {
case _Lactation305():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lactation305 value)?  $default,){
final _that = this;
switch (_that) {
case _Lactation305() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime calvingDate,  int daysInMilk,  int actualMl,  int? projected305Ml,  bool complete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lactation305() when $default != null:
return $default(_that.calvingDate,_that.daysInMilk,_that.actualMl,_that.projected305Ml,_that.complete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime calvingDate,  int daysInMilk,  int actualMl,  int? projected305Ml,  bool complete)  $default,) {final _that = this;
switch (_that) {
case _Lactation305():
return $default(_that.calvingDate,_that.daysInMilk,_that.actualMl,_that.projected305Ml,_that.complete);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime calvingDate,  int daysInMilk,  int actualMl,  int? projected305Ml,  bool complete)?  $default,) {final _that = this;
switch (_that) {
case _Lactation305() when $default != null:
return $default(_that.calvingDate,_that.daysInMilk,_that.actualMl,_that.projected305Ml,_that.complete);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lactation305 implements Lactation305 {
  const _Lactation305({required this.calvingDate, this.daysInMilk = 0, this.actualMl = 0, this.projected305Ml, this.complete = false});
  factory _Lactation305.fromJson(Map<String, dynamic> json) => _$Lactation305FromJson(json);

@override final  DateTime calvingDate;
@override@JsonKey() final  int daysInMilk;
@override@JsonKey() final  int actualMl;
@override final  int? projected305Ml;
@override@JsonKey() final  bool complete;

/// Create a copy of Lactation305
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Lactation305CopyWith<_Lactation305> get copyWith => __$Lactation305CopyWithImpl<_Lactation305>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Lactation305ToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lactation305&&(identical(other.calvingDate, calvingDate) || other.calvingDate == calvingDate)&&(identical(other.daysInMilk, daysInMilk) || other.daysInMilk == daysInMilk)&&(identical(other.actualMl, actualMl) || other.actualMl == actualMl)&&(identical(other.projected305Ml, projected305Ml) || other.projected305Ml == projected305Ml)&&(identical(other.complete, complete) || other.complete == complete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,calvingDate,daysInMilk,actualMl,projected305Ml,complete);
}

@override
String toString() {
    return 'Lactation305(calvingDate: $calvingDate, daysInMilk: $daysInMilk, actualMl: $actualMl, projected305Ml: $projected305Ml, complete: $complete)';
}


}

/// @nodoc
abstract mixin class _$Lactation305CopyWith<$Res> implements $Lactation305CopyWith<$Res> {
  factory _$Lactation305CopyWith(_Lactation305 value, $Res Function(_Lactation305) _then) = __$Lactation305CopyWithImpl;
@override @useResult
$Res call({
 DateTime calvingDate, int daysInMilk, int actualMl, int? projected305Ml, bool complete
});




}
/// @nodoc
class __$Lactation305CopyWithImpl<$Res>
    implements _$Lactation305CopyWith<$Res> {
  __$Lactation305CopyWithImpl(this._self, this._then);

  final _Lactation305 _self;
  final $Res Function(_Lactation305) _then;

/// Create a copy of Lactation305
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calvingDate = null,Object? daysInMilk = null,Object? actualMl = null,Object? projected305Ml = freezed,Object? complete = null,}) {
  return _then(_Lactation305(
calvingDate: null == calvingDate ? _self.calvingDate : calvingDate // ignore: cast_nullable_to_non_nullable
as DateTime,daysInMilk: null == daysInMilk ? _self.daysInMilk : daysInMilk // ignore: cast_nullable_to_non_nullable
as int,actualMl: null == actualMl ? _self.actualMl : actualMl // ignore: cast_nullable_to_non_nullable
as int,projected305Ml: freezed == projected305Ml ? _self.projected305Ml : projected305Ml // ignore: cast_nullable_to_non_nullable
as int?,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
