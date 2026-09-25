// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal_milking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimalMilking {

 String get id; String get sessionId; String get animalId; String? get spoutId; DateTime? get startedAt; DateTime? get endedAt;/// Alınan hacim, mL (TAMSAYI — §3'teki birim kuralı).
 int get volumeMl;/// Beklenen hacim, mL. 0 = beklenti yok (yeni hayvan, veri yok).
 int get expectedMl;/// L/dk.
 double get peakFlow; double get avgFlow;/// volumeMl / expectedMl yüzdesi. Backend hesaplar (§6.3).
 double get yieldPct;/// Oturum verimi rengi (§6.3). Uygulama AYNALAMAZ, olduğu gibi kullanır.
 MilkColor get color;/// Oturum tipi: morning | evening | other.
///
/// Oturumdan KOPYALANIR. Geçmiş listesinde her satır için ayrı oturum
/// sorgusu yapmamak için; beklenen verim de oturum tipine göre ayrışır
/// (§6.3), yani sabah/akşam ayrımı olmadan satırlar karşılaştırılamaz.
 String get sessionType;/// Sağımın neden kapandığı: flow_stopped | detached | session_end.
 String? get endReason;
/// Create a copy of AnimalMilking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalMilkingCopyWith<AnimalMilking> get copyWith => _$AnimalMilkingCopyWithImpl<AnimalMilking>(this as AnimalMilking, _$identity);

  /// Serializes this AnimalMilking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalMilking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalMilking&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.spoutId, _this.spoutId) || other.spoutId == _this.spoutId)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl)&&(identical(other.expectedMl, _this.expectedMl) || other.expectedMl == _this.expectedMl)&&(identical(other.peakFlow, _this.peakFlow) || other.peakFlow == _this.peakFlow)&&(identical(other.avgFlow, _this.avgFlow) || other.avgFlow == _this.avgFlow)&&(identical(other.yieldPct, _this.yieldPct) || other.yieldPct == _this.yieldPct)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.sessionType, _this.sessionType) || other.sessionType == _this.sessionType)&&(identical(other.endReason, _this.endReason) || other.endReason == _this.endReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalMilking;
  return Object.hash(runtimeType,_this.id,_this.sessionId,_this.animalId,_this.spoutId,_this.startedAt,_this.endedAt,_this.volumeMl,_this.expectedMl,_this.peakFlow,_this.avgFlow,_this.yieldPct,_this.color,_this.sessionType,_this.endReason);
}

@override
String toString() {
  final _this = this as AnimalMilking;
  return 'AnimalMilking(id: ${_this.id}, sessionId: ${_this.sessionId}, animalId: ${_this.animalId}, spoutId: ${_this.spoutId}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt}, volumeMl: ${_this.volumeMl}, expectedMl: ${_this.expectedMl}, peakFlow: ${_this.peakFlow}, avgFlow: ${_this.avgFlow}, yieldPct: ${_this.yieldPct}, color: ${_this.color}, sessionType: ${_this.sessionType}, endReason: ${_this.endReason})';
}


}

/// @nodoc
abstract mixin class $AnimalMilkingCopyWith<$Res>  {
  factory $AnimalMilkingCopyWith(AnimalMilking value, $Res Function(AnimalMilking) _then) = _$AnimalMilkingCopyWithImpl;
@useResult
$Res call({
 String id, String sessionId, String animalId, String? spoutId, DateTime? startedAt, DateTime? endedAt, int volumeMl, int expectedMl, double peakFlow, double avgFlow, double yieldPct, MilkColor color, String sessionType, String? endReason
});




}
/// @nodoc
class _$AnimalMilkingCopyWithImpl<$Res>
    implements $AnimalMilkingCopyWith<$Res> {
  _$AnimalMilkingCopyWithImpl(this._self, this._then);

  final AnimalMilking _self;
  final $Res Function(AnimalMilking) _then;

/// Create a copy of AnimalMilking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionId = null,Object? animalId = null,Object? spoutId = freezed,Object? startedAt = freezed,Object? endedAt = freezed,Object? volumeMl = null,Object? expectedMl = null,Object? peakFlow = null,Object? avgFlow = null,Object? yieldPct = null,Object? color = null,Object? sessionType = null,Object? endReason = freezed,}) {
  return _then(AnimalMilking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,spoutId: freezed == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,peakFlow: null == peakFlow ? _self.peakFlow : peakFlow // ignore: cast_nullable_to_non_nullable
as double,avgFlow: null == avgFlow ? _self.avgFlow : avgFlow // ignore: cast_nullable_to_non_nullable
as double,yieldPct: null == yieldPct ? _self.yieldPct : yieldPct // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as MilkColor,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,endReason: freezed == endReason ? _self.endReason : endReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalMilking].
extension AnimalMilkingPatterns on AnimalMilking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalMilking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalMilking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalMilking value)  $default,){
final _that = this;
switch (_that) {
case _AnimalMilking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalMilking value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalMilking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sessionId,  String animalId,  String? spoutId,  DateTime? startedAt,  DateTime? endedAt,  int volumeMl,  int expectedMl,  double peakFlow,  double avgFlow,  double yieldPct,  MilkColor color,  String sessionType,  String? endReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalMilking() when $default != null:
return $default(_that.id,_that.sessionId,_that.animalId,_that.spoutId,_that.startedAt,_that.endedAt,_that.volumeMl,_that.expectedMl,_that.peakFlow,_that.avgFlow,_that.yieldPct,_that.color,_that.sessionType,_that.endReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sessionId,  String animalId,  String? spoutId,  DateTime? startedAt,  DateTime? endedAt,  int volumeMl,  int expectedMl,  double peakFlow,  double avgFlow,  double yieldPct,  MilkColor color,  String sessionType,  String? endReason)  $default,) {final _that = this;
switch (_that) {
case _AnimalMilking():
return $default(_that.id,_that.sessionId,_that.animalId,_that.spoutId,_that.startedAt,_that.endedAt,_that.volumeMl,_that.expectedMl,_that.peakFlow,_that.avgFlow,_that.yieldPct,_that.color,_that.sessionType,_that.endReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sessionId,  String animalId,  String? spoutId,  DateTime? startedAt,  DateTime? endedAt,  int volumeMl,  int expectedMl,  double peakFlow,  double avgFlow,  double yieldPct,  MilkColor color,  String sessionType,  String? endReason)?  $default,) {final _that = this;
switch (_that) {
case _AnimalMilking() when $default != null:
return $default(_that.id,_that.sessionId,_that.animalId,_that.spoutId,_that.startedAt,_that.endedAt,_that.volumeMl,_that.expectedMl,_that.peakFlow,_that.avgFlow,_that.yieldPct,_that.color,_that.sessionType,_that.endReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalMilking implements AnimalMilking {
  const _AnimalMilking({required this.id, required this.sessionId, required this.animalId, this.spoutId, this.startedAt, this.endedAt, this.volumeMl = 0, this.expectedMl = 0, this.peakFlow = 0, this.avgFlow = 0, this.yieldPct = 0, this.color = MilkColor.grey, this.sessionType = 'morning', this.endReason});
  factory _AnimalMilking.fromJson(Map<String, dynamic> json) => _$AnimalMilkingFromJson(json);

@override final  String id;
@override final  String sessionId;
@override final  String animalId;
@override final  String? spoutId;
@override final  DateTime? startedAt;
@override final  DateTime? endedAt;
/// Alınan hacim, mL (TAMSAYI — §3'teki birim kuralı).
@override@JsonKey() final  int volumeMl;
/// Beklenen hacim, mL. 0 = beklenti yok (yeni hayvan, veri yok).
@override@JsonKey() final  int expectedMl;
/// L/dk.
@override@JsonKey() final  double peakFlow;
@override@JsonKey() final  double avgFlow;
/// volumeMl / expectedMl yüzdesi. Backend hesaplar (§6.3).
@override@JsonKey() final  double yieldPct;
/// Oturum verimi rengi (§6.3). Uygulama AYNALAMAZ, olduğu gibi kullanır.
@override@JsonKey() final  MilkColor color;
/// Oturum tipi: morning | evening | other.
///
/// Oturumdan KOPYALANIR. Geçmiş listesinde her satır için ayrı oturum
/// sorgusu yapmamak için; beklenen verim de oturum tipine göre ayrışır
/// (§6.3), yani sabah/akşam ayrımı olmadan satırlar karşılaştırılamaz.
@override@JsonKey() final  String sessionType;
/// Sağımın neden kapandığı: flow_stopped | detached | session_end.
@override final  String? endReason;

/// Create a copy of AnimalMilking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalMilkingCopyWith<_AnimalMilking> get copyWith => __$AnimalMilkingCopyWithImpl<_AnimalMilking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalMilkingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalMilking&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.expectedMl, expectedMl) || other.expectedMl == expectedMl)&&(identical(other.peakFlow, peakFlow) || other.peakFlow == peakFlow)&&(identical(other.avgFlow, avgFlow) || other.avgFlow == avgFlow)&&(identical(other.yieldPct, yieldPct) || other.yieldPct == yieldPct)&&(identical(other.color, color) || other.color == color)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.endReason, endReason) || other.endReason == endReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,sessionId,animalId,spoutId,startedAt,endedAt,volumeMl,expectedMl,peakFlow,avgFlow,yieldPct,color,sessionType,endReason);
}

@override
String toString() {
    return 'AnimalMilking(id: $id, sessionId: $sessionId, animalId: $animalId, spoutId: $spoutId, startedAt: $startedAt, endedAt: $endedAt, volumeMl: $volumeMl, expectedMl: $expectedMl, peakFlow: $peakFlow, avgFlow: $avgFlow, yieldPct: $yieldPct, color: $color, sessionType: $sessionType, endReason: $endReason)';
}


}

/// @nodoc
abstract mixin class _$AnimalMilkingCopyWith<$Res> implements $AnimalMilkingCopyWith<$Res> {
  factory _$AnimalMilkingCopyWith(_AnimalMilking value, $Res Function(_AnimalMilking) _then) = __$AnimalMilkingCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionId, String animalId, String? spoutId, DateTime? startedAt, DateTime? endedAt, int volumeMl, int expectedMl, double peakFlow, double avgFlow, double yieldPct, MilkColor color, String sessionType, String? endReason
});




}
/// @nodoc
class __$AnimalMilkingCopyWithImpl<$Res>
    implements _$AnimalMilkingCopyWith<$Res> {
  __$AnimalMilkingCopyWithImpl(this._self, this._then);

  final _AnimalMilking _self;
  final $Res Function(_AnimalMilking) _then;

/// Create a copy of AnimalMilking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionId = null,Object? animalId = null,Object? spoutId = freezed,Object? startedAt = freezed,Object? endedAt = freezed,Object? volumeMl = null,Object? expectedMl = null,Object? peakFlow = null,Object? avgFlow = null,Object? yieldPct = null,Object? color = null,Object? sessionType = null,Object? endReason = freezed,}) {
  return _then(_AnimalMilking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,spoutId: freezed == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,peakFlow: null == peakFlow ? _self.peakFlow : peakFlow // ignore: cast_nullable_to_non_nullable
as double,avgFlow: null == avgFlow ? _self.avgFlow : avgFlow // ignore: cast_nullable_to_non_nullable
as double,yieldPct: null == yieldPct ? _self.yieldPct : yieldPct // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as MilkColor,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,endReason: freezed == endReason ? _self.endReason : endReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
