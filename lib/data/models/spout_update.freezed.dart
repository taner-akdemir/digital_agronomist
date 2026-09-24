// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spout_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpoutUpdate {

 String get sessionId; String get spoutId;/// Noktaya eşleştirilmiş hayvan; eşleşme yoksa null.
 SpoutAnimal? get animal;/// Anlık debi, L/dk.
 double get flowRate;/// Bu sağımda şu ana kadarki hacim, mL (TAMSAYI — float hatası olmasın).
 int get volumeMl;/// Bu sağımda beklenen hacim, mL. 0 = beklenti yok.
 int get expectedMl;/// volumeMl / expectedMl yüzdesi. Backend hesaplar.
 double get yieldPct;/// Anlık debi rengi (§6.2). Backend hesaplar; uygulama AYNALAR.
 MilkColor get flowColor;/// Oturum verimi rengi (§6.3).
 MilkColor get yieldColor; SpoutState get state; DateTime? get ts;/// Noktada okunan ama eşleştirilemeyen son küpe (kayıtlı değil ya da
/// hayvan sağmal değil). Yeni sağım açılınca backend siler.
 UnmatchedTag? get unmatchedTag;
/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpoutUpdateCopyWith<SpoutUpdate> get copyWith => _$SpoutUpdateCopyWithImpl<SpoutUpdate>(this as SpoutUpdate, _$identity);

  /// Serializes this SpoutUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpoutUpdate&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.animal, animal) || other.animal == animal)&&(identical(other.flowRate, flowRate) || other.flowRate == flowRate)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.expectedMl, expectedMl) || other.expectedMl == expectedMl)&&(identical(other.yieldPct, yieldPct) || other.yieldPct == yieldPct)&&(identical(other.flowColor, flowColor) || other.flowColor == flowColor)&&(identical(other.yieldColor, yieldColor) || other.yieldColor == yieldColor)&&(identical(other.state, state) || other.state == state)&&(identical(other.ts, ts) || other.ts == ts)&&(identical(other.unmatchedTag, unmatchedTag) || other.unmatchedTag == unmatchedTag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,spoutId,animal,flowRate,volumeMl,expectedMl,yieldPct,flowColor,yieldColor,state,ts,unmatchedTag);

@override
String toString() {
  return 'SpoutUpdate(sessionId: $sessionId, spoutId: $spoutId, animal: $animal, flowRate: $flowRate, volumeMl: $volumeMl, expectedMl: $expectedMl, yieldPct: $yieldPct, flowColor: $flowColor, yieldColor: $yieldColor, state: $state, ts: $ts, unmatchedTag: $unmatchedTag)';
}


}

/// @nodoc
abstract mixin class $SpoutUpdateCopyWith<$Res>  {
  factory $SpoutUpdateCopyWith(SpoutUpdate value, $Res Function(SpoutUpdate) _then) = _$SpoutUpdateCopyWithImpl;
@useResult
$Res call({
 String sessionId, String spoutId, SpoutAnimal? animal, double flowRate, int volumeMl, int expectedMl, double yieldPct, MilkColor flowColor, MilkColor yieldColor, SpoutState state, DateTime? ts, UnmatchedTag? unmatchedTag
});


$SpoutAnimalCopyWith<$Res>? get animal;$UnmatchedTagCopyWith<$Res>? get unmatchedTag;

}
/// @nodoc
class _$SpoutUpdateCopyWithImpl<$Res>
    implements $SpoutUpdateCopyWith<$Res> {
  _$SpoutUpdateCopyWithImpl(this._self, this._then);

  final SpoutUpdate _self;
  final $Res Function(SpoutUpdate) _then;

/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? spoutId = null,Object? animal = freezed,Object? flowRate = null,Object? volumeMl = null,Object? expectedMl = null,Object? yieldPct = null,Object? flowColor = null,Object? yieldColor = null,Object? state = null,Object? ts = freezed,Object? unmatchedTag = freezed,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,spoutId: null == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String,animal: freezed == animal ? _self.animal : animal // ignore: cast_nullable_to_non_nullable
as SpoutAnimal?,flowRate: null == flowRate ? _self.flowRate : flowRate // ignore: cast_nullable_to_non_nullable
as double,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,yieldPct: null == yieldPct ? _self.yieldPct : yieldPct // ignore: cast_nullable_to_non_nullable
as double,flowColor: null == flowColor ? _self.flowColor : flowColor // ignore: cast_nullable_to_non_nullable
as MilkColor,yieldColor: null == yieldColor ? _self.yieldColor : yieldColor // ignore: cast_nullable_to_non_nullable
as MilkColor,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as SpoutState,ts: freezed == ts ? _self.ts : ts // ignore: cast_nullable_to_non_nullable
as DateTime?,unmatchedTag: freezed == unmatchedTag ? _self.unmatchedTag : unmatchedTag // ignore: cast_nullable_to_non_nullable
as UnmatchedTag?,
  ));
}
/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpoutAnimalCopyWith<$Res>? get animal {
    if (_self.animal == null) {
    return null;
  }

  return $SpoutAnimalCopyWith<$Res>(_self.animal!, (value) {
    return _then(_self.copyWith(animal: value));
  });
}/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnmatchedTagCopyWith<$Res>? get unmatchedTag {
    if (_self.unmatchedTag == null) {
    return null;
  }

  return $UnmatchedTagCopyWith<$Res>(_self.unmatchedTag!, (value) {
    return _then(_self.copyWith(unmatchedTag: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpoutUpdate].
extension SpoutUpdatePatterns on SpoutUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpoutUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpoutUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpoutUpdate value)  $default,){
final _that = this;
switch (_that) {
case _SpoutUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpoutUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _SpoutUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String spoutId,  SpoutAnimal? animal,  double flowRate,  int volumeMl,  int expectedMl,  double yieldPct,  MilkColor flowColor,  MilkColor yieldColor,  SpoutState state,  DateTime? ts,  UnmatchedTag? unmatchedTag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpoutUpdate() when $default != null:
return $default(_that.sessionId,_that.spoutId,_that.animal,_that.flowRate,_that.volumeMl,_that.expectedMl,_that.yieldPct,_that.flowColor,_that.yieldColor,_that.state,_that.ts,_that.unmatchedTag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String spoutId,  SpoutAnimal? animal,  double flowRate,  int volumeMl,  int expectedMl,  double yieldPct,  MilkColor flowColor,  MilkColor yieldColor,  SpoutState state,  DateTime? ts,  UnmatchedTag? unmatchedTag)  $default,) {final _that = this;
switch (_that) {
case _SpoutUpdate():
return $default(_that.sessionId,_that.spoutId,_that.animal,_that.flowRate,_that.volumeMl,_that.expectedMl,_that.yieldPct,_that.flowColor,_that.yieldColor,_that.state,_that.ts,_that.unmatchedTag);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String spoutId,  SpoutAnimal? animal,  double flowRate,  int volumeMl,  int expectedMl,  double yieldPct,  MilkColor flowColor,  MilkColor yieldColor,  SpoutState state,  DateTime? ts,  UnmatchedTag? unmatchedTag)?  $default,) {final _that = this;
switch (_that) {
case _SpoutUpdate() when $default != null:
return $default(_that.sessionId,_that.spoutId,_that.animal,_that.flowRate,_that.volumeMl,_that.expectedMl,_that.yieldPct,_that.flowColor,_that.yieldColor,_that.state,_that.ts,_that.unmatchedTag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpoutUpdate implements SpoutUpdate {
  const _SpoutUpdate({required this.sessionId, required this.spoutId, this.animal, this.flowRate = 0, this.volumeMl = 0, this.expectedMl = 0, this.yieldPct = 0, this.flowColor = MilkColor.grey, this.yieldColor = MilkColor.grey, this.state = SpoutState.idle, this.ts, this.unmatchedTag});
  factory _SpoutUpdate.fromJson(Map<String, dynamic> json) => _$SpoutUpdateFromJson(json);

@override final  String sessionId;
@override final  String spoutId;
/// Noktaya eşleştirilmiş hayvan; eşleşme yoksa null.
@override final  SpoutAnimal? animal;
/// Anlık debi, L/dk.
@override@JsonKey() final  double flowRate;
/// Bu sağımda şu ana kadarki hacim, mL (TAMSAYI — float hatası olmasın).
@override@JsonKey() final  int volumeMl;
/// Bu sağımda beklenen hacim, mL. 0 = beklenti yok.
@override@JsonKey() final  int expectedMl;
/// volumeMl / expectedMl yüzdesi. Backend hesaplar.
@override@JsonKey() final  double yieldPct;
/// Anlık debi rengi (§6.2). Backend hesaplar; uygulama AYNALAR.
@override@JsonKey() final  MilkColor flowColor;
/// Oturum verimi rengi (§6.3).
@override@JsonKey() final  MilkColor yieldColor;
@override@JsonKey() final  SpoutState state;
@override final  DateTime? ts;
/// Noktada okunan ama eşleştirilemeyen son küpe (kayıtlı değil ya da
/// hayvan sağmal değil). Yeni sağım açılınca backend siler.
@override final  UnmatchedTag? unmatchedTag;

/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpoutUpdateCopyWith<_SpoutUpdate> get copyWith => __$SpoutUpdateCopyWithImpl<_SpoutUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpoutUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpoutUpdate&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.animal, animal) || other.animal == animal)&&(identical(other.flowRate, flowRate) || other.flowRate == flowRate)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.expectedMl, expectedMl) || other.expectedMl == expectedMl)&&(identical(other.yieldPct, yieldPct) || other.yieldPct == yieldPct)&&(identical(other.flowColor, flowColor) || other.flowColor == flowColor)&&(identical(other.yieldColor, yieldColor) || other.yieldColor == yieldColor)&&(identical(other.state, state) || other.state == state)&&(identical(other.ts, ts) || other.ts == ts)&&(identical(other.unmatchedTag, unmatchedTag) || other.unmatchedTag == unmatchedTag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,spoutId,animal,flowRate,volumeMl,expectedMl,yieldPct,flowColor,yieldColor,state,ts,unmatchedTag);

@override
String toString() {
  return 'SpoutUpdate(sessionId: $sessionId, spoutId: $spoutId, animal: $animal, flowRate: $flowRate, volumeMl: $volumeMl, expectedMl: $expectedMl, yieldPct: $yieldPct, flowColor: $flowColor, yieldColor: $yieldColor, state: $state, ts: $ts, unmatchedTag: $unmatchedTag)';
}


}

/// @nodoc
abstract mixin class _$SpoutUpdateCopyWith<$Res> implements $SpoutUpdateCopyWith<$Res> {
  factory _$SpoutUpdateCopyWith(_SpoutUpdate value, $Res Function(_SpoutUpdate) _then) = __$SpoutUpdateCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String spoutId, SpoutAnimal? animal, double flowRate, int volumeMl, int expectedMl, double yieldPct, MilkColor flowColor, MilkColor yieldColor, SpoutState state, DateTime? ts, UnmatchedTag? unmatchedTag
});


@override $SpoutAnimalCopyWith<$Res>? get animal;@override $UnmatchedTagCopyWith<$Res>? get unmatchedTag;

}
/// @nodoc
class __$SpoutUpdateCopyWithImpl<$Res>
    implements _$SpoutUpdateCopyWith<$Res> {
  __$SpoutUpdateCopyWithImpl(this._self, this._then);

  final _SpoutUpdate _self;
  final $Res Function(_SpoutUpdate) _then;

/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? spoutId = null,Object? animal = freezed,Object? flowRate = null,Object? volumeMl = null,Object? expectedMl = null,Object? yieldPct = null,Object? flowColor = null,Object? yieldColor = null,Object? state = null,Object? ts = freezed,Object? unmatchedTag = freezed,}) {
  return _then(_SpoutUpdate(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,spoutId: null == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String,animal: freezed == animal ? _self.animal : animal // ignore: cast_nullable_to_non_nullable
as SpoutAnimal?,flowRate: null == flowRate ? _self.flowRate : flowRate // ignore: cast_nullable_to_non_nullable
as double,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,yieldPct: null == yieldPct ? _self.yieldPct : yieldPct // ignore: cast_nullable_to_non_nullable
as double,flowColor: null == flowColor ? _self.flowColor : flowColor // ignore: cast_nullable_to_non_nullable
as MilkColor,yieldColor: null == yieldColor ? _self.yieldColor : yieldColor // ignore: cast_nullable_to_non_nullable
as MilkColor,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as SpoutState,ts: freezed == ts ? _self.ts : ts // ignore: cast_nullable_to_non_nullable
as DateTime?,unmatchedTag: freezed == unmatchedTag ? _self.unmatchedTag : unmatchedTag // ignore: cast_nullable_to_non_nullable
as UnmatchedTag?,
  ));
}

/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpoutAnimalCopyWith<$Res>? get animal {
    if (_self.animal == null) {
    return null;
  }

  return $SpoutAnimalCopyWith<$Res>(_self.animal!, (value) {
    return _then(_self.copyWith(animal: value));
  });
}/// Create a copy of SpoutUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnmatchedTagCopyWith<$Res>? get unmatchedTag {
    if (_self.unmatchedTag == null) {
    return null;
  }

  return $UnmatchedTagCopyWith<$Res>(_self.unmatchedTag!, (value) {
    return _then(_self.copyWith(unmatchedTag: value));
  });
}
}


/// @nodoc
mixin _$SpoutAnimal {

 String get id; String get earTag; String? get species; String? get name;
/// Create a copy of SpoutAnimal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpoutAnimalCopyWith<SpoutAnimal> get copyWith => _$SpoutAnimalCopyWithImpl<SpoutAnimal>(this as SpoutAnimal, _$identity);

  /// Serializes this SpoutAnimal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpoutAnimal&&(identical(other.id, id) || other.id == id)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.species, species) || other.species == species)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,earTag,species,name);

@override
String toString() {
  return 'SpoutAnimal(id: $id, earTag: $earTag, species: $species, name: $name)';
}


}

/// @nodoc
abstract mixin class $SpoutAnimalCopyWith<$Res>  {
  factory $SpoutAnimalCopyWith(SpoutAnimal value, $Res Function(SpoutAnimal) _then) = _$SpoutAnimalCopyWithImpl;
@useResult
$Res call({
 String id, String earTag, String? species, String? name
});




}
/// @nodoc
class _$SpoutAnimalCopyWithImpl<$Res>
    implements $SpoutAnimalCopyWith<$Res> {
  _$SpoutAnimalCopyWithImpl(this._self, this._then);

  final SpoutAnimal _self;
  final $Res Function(SpoutAnimal) _then;

/// Create a copy of SpoutAnimal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? earTag = null,Object? species = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,species: freezed == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpoutAnimal].
extension SpoutAnimalPatterns on SpoutAnimal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpoutAnimal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpoutAnimal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpoutAnimal value)  $default,){
final _that = this;
switch (_that) {
case _SpoutAnimal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpoutAnimal value)?  $default,){
final _that = this;
switch (_that) {
case _SpoutAnimal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String earTag,  String? species,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpoutAnimal() when $default != null:
return $default(_that.id,_that.earTag,_that.species,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String earTag,  String? species,  String? name)  $default,) {final _that = this;
switch (_that) {
case _SpoutAnimal():
return $default(_that.id,_that.earTag,_that.species,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String earTag,  String? species,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _SpoutAnimal() when $default != null:
return $default(_that.id,_that.earTag,_that.species,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpoutAnimal implements SpoutAnimal {
  const _SpoutAnimal({required this.id, required this.earTag, this.species, this.name});
  factory _SpoutAnimal.fromJson(Map<String, dynamic> json) => _$SpoutAnimalFromJson(json);

@override final  String id;
@override final  String earTag;
@override final  String? species;
@override final  String? name;

/// Create a copy of SpoutAnimal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpoutAnimalCopyWith<_SpoutAnimal> get copyWith => __$SpoutAnimalCopyWithImpl<_SpoutAnimal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpoutAnimalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpoutAnimal&&(identical(other.id, id) || other.id == id)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.species, species) || other.species == species)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,earTag,species,name);

@override
String toString() {
  return 'SpoutAnimal(id: $id, earTag: $earTag, species: $species, name: $name)';
}


}

/// @nodoc
abstract mixin class _$SpoutAnimalCopyWith<$Res> implements $SpoutAnimalCopyWith<$Res> {
  factory _$SpoutAnimalCopyWith(_SpoutAnimal value, $Res Function(_SpoutAnimal) _then) = __$SpoutAnimalCopyWithImpl;
@override @useResult
$Res call({
 String id, String earTag, String? species, String? name
});




}
/// @nodoc
class __$SpoutAnimalCopyWithImpl<$Res>
    implements _$SpoutAnimalCopyWith<$Res> {
  __$SpoutAnimalCopyWithImpl(this._self, this._then);

  final _SpoutAnimal _self;
  final $Res Function(_SpoutAnimal) _then;

/// Create a copy of SpoutAnimal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? earTag = null,Object? species = freezed,Object? name = freezed,}) {
  return _then(_SpoutAnimal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,species: freezed == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UnmatchedTag {

 String get rfid;/// `unknown` (küpe kayıtlı değil) ya da `not_milking` (hayvan sağmal
/// değil).
 String get reason; String get message; DateTime? get at;
/// Create a copy of UnmatchedTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnmatchedTagCopyWith<UnmatchedTag> get copyWith => _$UnmatchedTagCopyWithImpl<UnmatchedTag>(this as UnmatchedTag, _$identity);

  /// Serializes this UnmatchedTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnmatchedTag&&(identical(other.rfid, rfid) || other.rfid == rfid)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.message, message) || other.message == message)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rfid,reason,message,at);

@override
String toString() {
  return 'UnmatchedTag(rfid: $rfid, reason: $reason, message: $message, at: $at)';
}


}

/// @nodoc
abstract mixin class $UnmatchedTagCopyWith<$Res>  {
  factory $UnmatchedTagCopyWith(UnmatchedTag value, $Res Function(UnmatchedTag) _then) = _$UnmatchedTagCopyWithImpl;
@useResult
$Res call({
 String rfid, String reason, String message, DateTime? at
});




}
/// @nodoc
class _$UnmatchedTagCopyWithImpl<$Res>
    implements $UnmatchedTagCopyWith<$Res> {
  _$UnmatchedTagCopyWithImpl(this._self, this._then);

  final UnmatchedTag _self;
  final $Res Function(UnmatchedTag) _then;

/// Create a copy of UnmatchedTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rfid = null,Object? reason = null,Object? message = null,Object? at = freezed,}) {
  return _then(_self.copyWith(
rfid: null == rfid ? _self.rfid : rfid // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UnmatchedTag].
extension UnmatchedTagPatterns on UnmatchedTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnmatchedTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnmatchedTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnmatchedTag value)  $default,){
final _that = this;
switch (_that) {
case _UnmatchedTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnmatchedTag value)?  $default,){
final _that = this;
switch (_that) {
case _UnmatchedTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rfid,  String reason,  String message,  DateTime? at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnmatchedTag() when $default != null:
return $default(_that.rfid,_that.reason,_that.message,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rfid,  String reason,  String message,  DateTime? at)  $default,) {final _that = this;
switch (_that) {
case _UnmatchedTag():
return $default(_that.rfid,_that.reason,_that.message,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rfid,  String reason,  String message,  DateTime? at)?  $default,) {final _that = this;
switch (_that) {
case _UnmatchedTag() when $default != null:
return $default(_that.rfid,_that.reason,_that.message,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnmatchedTag implements UnmatchedTag {
  const _UnmatchedTag({required this.rfid, required this.reason, required this.message, this.at});
  factory _UnmatchedTag.fromJson(Map<String, dynamic> json) => _$UnmatchedTagFromJson(json);

@override final  String rfid;
/// `unknown` (küpe kayıtlı değil) ya da `not_milking` (hayvan sağmal
/// değil).
@override final  String reason;
@override final  String message;
@override final  DateTime? at;

/// Create a copy of UnmatchedTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnmatchedTagCopyWith<_UnmatchedTag> get copyWith => __$UnmatchedTagCopyWithImpl<_UnmatchedTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnmatchedTagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnmatchedTag&&(identical(other.rfid, rfid) || other.rfid == rfid)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.message, message) || other.message == message)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rfid,reason,message,at);

@override
String toString() {
  return 'UnmatchedTag(rfid: $rfid, reason: $reason, message: $message, at: $at)';
}


}

/// @nodoc
abstract mixin class _$UnmatchedTagCopyWith<$Res> implements $UnmatchedTagCopyWith<$Res> {
  factory _$UnmatchedTagCopyWith(_UnmatchedTag value, $Res Function(_UnmatchedTag) _then) = __$UnmatchedTagCopyWithImpl;
@override @useResult
$Res call({
 String rfid, String reason, String message, DateTime? at
});




}
/// @nodoc
class __$UnmatchedTagCopyWithImpl<$Res>
    implements _$UnmatchedTagCopyWith<$Res> {
  __$UnmatchedTagCopyWithImpl(this._self, this._then);

  final _UnmatchedTag _self;
  final $Res Function(_UnmatchedTag) _then;

/// Create a copy of UnmatchedTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rfid = null,Object? reason = null,Object? message = null,Object? at = freezed,}) {
  return _then(_UnmatchedTag(
rfid: null == rfid ? _self.rfid : rfid // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
