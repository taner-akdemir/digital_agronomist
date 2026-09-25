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
 List<AnimalDailyStat> get daily;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalTrend&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.yieldClass, _this.yieldClass) || other.yieldClass == _this.yieldClass)&&(identical(other.ma7Ml, _this.ma7Ml) || other.ma7Ml == _this.ma7Ml)&&(identical(other.ma30Ml, _this.ma30Ml) || other.ma30Ml == _this.ma30Ml)&&(identical(other.trendSlope, _this.trendSlope) || other.trendSlope == _this.trendSlope)&&const DeepCollectionEquality().equals(other.daily, _this.daily));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalTrend;
  return Object.hash(runtimeType,_this.animalId,_this.yieldClass,_this.ma7Ml,_this.ma30Ml,_this.trendSlope,const DeepCollectionEquality().hash(_this.daily));
}

@override
String toString() {
  final _this = this as AnimalTrend;
  return 'AnimalTrend(animalId: ${_this.animalId}, yieldClass: ${_this.yieldClass}, ma7Ml: ${_this.ma7Ml}, ma30Ml: ${_this.ma30Ml}, trendSlope: ${_this.trendSlope}, daily: ${_this.daily})';
}


}

/// @nodoc
abstract mixin class $AnimalTrendCopyWith<$Res>  {
  factory $AnimalTrendCopyWith(AnimalTrend value, $Res Function(AnimalTrend) _then) = _$AnimalTrendCopyWithImpl;
@useResult
$Res call({
 String animalId,@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, int ma7Ml, int ma30Ml, double trendSlope, List<AnimalDailyStat> daily
});




}
/// @nodoc
class _$AnimalTrendCopyWithImpl<$Res>
    implements $AnimalTrendCopyWith<$Res> {
  _$AnimalTrendCopyWithImpl(this._self, this._then);

  final AnimalTrend _self;
  final $Res Function(AnimalTrend) _then;

/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? yieldClass = null,Object? ma7Ml = null,Object? ma30Ml = null,Object? trendSlope = null,Object? daily = null,}) {
  return _then(AnimalTrend(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,ma7Ml: null == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int,ma30Ml: null == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int,trendSlope: null == trendSlope ? _self.trendSlope : trendSlope // ignore: cast_nullable_to_non_nullable
as double,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as List<AnimalDailyStat>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int ma7Ml,  int ma30Ml,  double trendSlope,  List<AnimalDailyStat> daily)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalTrend() when $default != null:
return $default(_that.animalId,_that.yieldClass,_that.ma7Ml,_that.ma30Ml,_that.trendSlope,_that.daily);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int ma7Ml,  int ma30Ml,  double trendSlope,  List<AnimalDailyStat> daily)  $default,) {final _that = this;
switch (_that) {
case _AnimalTrend():
return $default(_that.animalId,_that.yieldClass,_that.ma7Ml,_that.ma30Ml,_that.trendSlope,_that.daily);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int ma7Ml,  int ma30Ml,  double trendSlope,  List<AnimalDailyStat> daily)?  $default,) {final _that = this;
switch (_that) {
case _AnimalTrend() when $default != null:
return $default(_that.animalId,_that.yieldClass,_that.ma7Ml,_that.ma30Ml,_that.trendSlope,_that.daily);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalTrend implements AnimalTrend {
  const _AnimalTrend({required this.animalId, @JsonKey(unknownEnumValue: YieldClass.normal) this.yieldClass = YieldClass.normal, this.ma7Ml = 0, this.ma30Ml = 0, this.trendSlope = 0,  List<AnimalDailyStat> daily = const <AnimalDailyStat>[]}): _daily = daily;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalTrend&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.yieldClass, yieldClass) || other.yieldClass == yieldClass)&&(identical(other.ma7Ml, ma7Ml) || other.ma7Ml == ma7Ml)&&(identical(other.ma30Ml, ma30Ml) || other.ma30Ml == ma30Ml)&&(identical(other.trendSlope, trendSlope) || other.trendSlope == trendSlope)&&const DeepCollectionEquality().equals(other.daily, _daily));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,yieldClass,ma7Ml,ma30Ml,trendSlope,const DeepCollectionEquality().hash(_daily));
}

@override
String toString() {
    return 'AnimalTrend(animalId: $animalId, yieldClass: $yieldClass, ma7Ml: $ma7Ml, ma30Ml: $ma30Ml, trendSlope: $trendSlope, daily: $daily)';
}


}

/// @nodoc
abstract mixin class _$AnimalTrendCopyWith<$Res> implements $AnimalTrendCopyWith<$Res> {
  factory _$AnimalTrendCopyWith(_AnimalTrend value, $Res Function(_AnimalTrend) _then) = __$AnimalTrendCopyWithImpl;
@override @useResult
$Res call({
 String animalId,@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, int ma7Ml, int ma30Ml, double trendSlope, List<AnimalDailyStat> daily
});




}
/// @nodoc
class __$AnimalTrendCopyWithImpl<$Res>
    implements _$AnimalTrendCopyWith<$Res> {
  __$AnimalTrendCopyWithImpl(this._self, this._then);

  final _AnimalTrend _self;
  final $Res Function(_AnimalTrend) _then;

/// Create a copy of AnimalTrend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? yieldClass = null,Object? ma7Ml = null,Object? ma30Ml = null,Object? trendSlope = null,Object? daily = null,}) {
  return _then(_AnimalTrend(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,ma7Ml: null == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int,ma30Ml: null == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int,trendSlope: null == trendSlope ? _self.trendSlope : trendSlope // ignore: cast_nullable_to_non_nullable
as double,daily: null == daily ? _self._daily : daily // ignore: cast_nullable_to_non_nullable
as List<AnimalDailyStat>,
  ));
}


}


/// @nodoc
mixin _$AnimalDailyStat {

 DateTime get date; int get totalMl; int get milkingCount;/// O güne kadarki hareketli ortalamalar; serinin başında veri yetmediği
/// için null olabilir.
 int? get ma7Ml; int? get ma30Ml;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalDailyStat&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.totalMl, _this.totalMl) || other.totalMl == _this.totalMl)&&(identical(other.milkingCount, _this.milkingCount) || other.milkingCount == _this.milkingCount)&&(identical(other.ma7Ml, _this.ma7Ml) || other.ma7Ml == _this.ma7Ml)&&(identical(other.ma30Ml, _this.ma30Ml) || other.ma30Ml == _this.ma30Ml));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalDailyStat;
  return Object.hash(runtimeType,_this.date,_this.totalMl,_this.milkingCount,_this.ma7Ml,_this.ma30Ml);
}

@override
String toString() {
  final _this = this as AnimalDailyStat;
  return 'AnimalDailyStat(date: ${_this.date}, totalMl: ${_this.totalMl}, milkingCount: ${_this.milkingCount}, ma7Ml: ${_this.ma7Ml}, ma30Ml: ${_this.ma30Ml})';
}


}

/// @nodoc
abstract mixin class $AnimalDailyStatCopyWith<$Res>  {
  factory $AnimalDailyStatCopyWith(AnimalDailyStat value, $Res Function(AnimalDailyStat) _then) = _$AnimalDailyStatCopyWithImpl;
@useResult
$Res call({
 DateTime date, int totalMl, int milkingCount, int? ma7Ml, int? ma30Ml
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
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? totalMl = null,Object? milkingCount = null,Object? ma7Ml = freezed,Object? ma30Ml = freezed,}) {
  return _then(AnimalDailyStat(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,ma7Ml: freezed == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int?,ma30Ml: freezed == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int totalMl,  int milkingCount,  int? ma7Ml,  int? ma30Ml)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalDailyStat() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.ma7Ml,_that.ma30Ml);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int totalMl,  int milkingCount,  int? ma7Ml,  int? ma30Ml)  $default,) {final _that = this;
switch (_that) {
case _AnimalDailyStat():
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.ma7Ml,_that.ma30Ml);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int totalMl,  int milkingCount,  int? ma7Ml,  int? ma30Ml)?  $default,) {final _that = this;
switch (_that) {
case _AnimalDailyStat() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.ma7Ml,_that.ma30Ml);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalDailyStat implements AnimalDailyStat {
  const _AnimalDailyStat({required this.date, this.totalMl = 0, this.milkingCount = 0, this.ma7Ml, this.ma30Ml});
  factory _AnimalDailyStat.fromJson(Map<String, dynamic> json) => _$AnimalDailyStatFromJson(json);

@override final  DateTime date;
@override@JsonKey() final  int totalMl;
@override@JsonKey() final  int milkingCount;
/// O güne kadarki hareketli ortalamalar; serinin başında veri yetmediği
/// için null olabilir.
@override final  int? ma7Ml;
@override final  int? ma30Ml;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalDailyStat&&(identical(other.date, date) || other.date == date)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl)&&(identical(other.milkingCount, milkingCount) || other.milkingCount == milkingCount)&&(identical(other.ma7Ml, ma7Ml) || other.ma7Ml == ma7Ml)&&(identical(other.ma30Ml, ma30Ml) || other.ma30Ml == ma30Ml));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,totalMl,milkingCount,ma7Ml,ma30Ml);
}

@override
String toString() {
    return 'AnimalDailyStat(date: $date, totalMl: $totalMl, milkingCount: $milkingCount, ma7Ml: $ma7Ml, ma30Ml: $ma30Ml)';
}


}

/// @nodoc
abstract mixin class _$AnimalDailyStatCopyWith<$Res> implements $AnimalDailyStatCopyWith<$Res> {
  factory _$AnimalDailyStatCopyWith(_AnimalDailyStat value, $Res Function(_AnimalDailyStat) _then) = __$AnimalDailyStatCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int totalMl, int milkingCount, int? ma7Ml, int? ma30Ml
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
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? totalMl = null,Object? milkingCount = null,Object? ma7Ml = freezed,Object? ma30Ml = freezed,}) {
  return _then(_AnimalDailyStat(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,ma7Ml: freezed == ma7Ml ? _self.ma7Ml : ma7Ml // ignore: cast_nullable_to_non_nullable
as int?,ma30Ml: freezed == ma30Ml ? _self.ma30Ml : ma30Ml // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
