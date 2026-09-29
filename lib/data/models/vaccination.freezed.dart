// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccinePlan {

 String get id; String get name; int get intervalDays;/// Null: bütün türler.
 String? get speciesId; String get note;/// Plana giren (sağmal ya da kurudaki) hayvan.
 int get animals;/// Zamanı geçmiş ya da 7 gün içinde olan; [never] buna dahil.
 int get dueSoon;/// Hiç uygulanmamış.
 int get never;
/// Create a copy of VaccinePlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaccinePlanCopyWith<VaccinePlan> get copyWith => _$VaccinePlanCopyWithImpl<VaccinePlan>(this as VaccinePlan, _$identity);

  /// Serializes this VaccinePlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VaccinePlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaccinePlan&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.intervalDays, _this.intervalDays) || other.intervalDays == _this.intervalDays)&&(identical(other.speciesId, _this.speciesId) || other.speciesId == _this.speciesId)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.animals, _this.animals) || other.animals == _this.animals)&&(identical(other.dueSoon, _this.dueSoon) || other.dueSoon == _this.dueSoon)&&(identical(other.never, _this.never) || other.never == _this.never));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VaccinePlan;
  return Object.hash(runtimeType,_this.id,_this.name,_this.intervalDays,_this.speciesId,_this.note,_this.animals,_this.dueSoon,_this.never);
}

@override
String toString() {
  final _this = this as VaccinePlan;
  return 'VaccinePlan(id: ${_this.id}, name: ${_this.name}, intervalDays: ${_this.intervalDays}, speciesId: ${_this.speciesId}, note: ${_this.note}, animals: ${_this.animals}, dueSoon: ${_this.dueSoon}, never: ${_this.never})';
}


}

/// @nodoc
abstract mixin class $VaccinePlanCopyWith<$Res>  {
  factory $VaccinePlanCopyWith(VaccinePlan value, $Res Function(VaccinePlan) _then) = _$VaccinePlanCopyWithImpl;
@useResult
$Res call({
 String id, String name, int intervalDays, String? speciesId, String note, int animals, int dueSoon, int never
});




}
/// @nodoc
class _$VaccinePlanCopyWithImpl<$Res>
    implements $VaccinePlanCopyWith<$Res> {
  _$VaccinePlanCopyWithImpl(this._self, this._then);

  final VaccinePlan _self;
  final $Res Function(VaccinePlan) _then;

/// Create a copy of VaccinePlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? intervalDays = null,Object? speciesId = freezed,Object? note = null,Object? animals = null,Object? dueSoon = null,Object? never = null,}) {
  return _then(VaccinePlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intervalDays: null == intervalDays ? _self.intervalDays : intervalDays // ignore: cast_nullable_to_non_nullable
as int,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,dueSoon: null == dueSoon ? _self.dueSoon : dueSoon // ignore: cast_nullable_to_non_nullable
as int,never: null == never ? _self.never : never // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VaccinePlan].
extension VaccinePlanPatterns on VaccinePlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaccinePlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaccinePlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaccinePlan value)  $default,){
final _that = this;
switch (_that) {
case _VaccinePlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaccinePlan value)?  $default,){
final _that = this;
switch (_that) {
case _VaccinePlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int intervalDays,  String? speciesId,  String note,  int animals,  int dueSoon,  int never)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaccinePlan() when $default != null:
return $default(_that.id,_that.name,_that.intervalDays,_that.speciesId,_that.note,_that.animals,_that.dueSoon,_that.never);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int intervalDays,  String? speciesId,  String note,  int animals,  int dueSoon,  int never)  $default,) {final _that = this;
switch (_that) {
case _VaccinePlan():
return $default(_that.id,_that.name,_that.intervalDays,_that.speciesId,_that.note,_that.animals,_that.dueSoon,_that.never);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int intervalDays,  String? speciesId,  String note,  int animals,  int dueSoon,  int never)?  $default,) {final _that = this;
switch (_that) {
case _VaccinePlan() when $default != null:
return $default(_that.id,_that.name,_that.intervalDays,_that.speciesId,_that.note,_that.animals,_that.dueSoon,_that.never);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VaccinePlan implements VaccinePlan {
  const _VaccinePlan({required this.id, required this.name, required this.intervalDays, this.speciesId, this.note = '', this.animals = 0, this.dueSoon = 0, this.never = 0});
  factory _VaccinePlan.fromJson(Map<String, dynamic> json) => _$VaccinePlanFromJson(json);

@override final  String id;
@override final  String name;
@override final  int intervalDays;
/// Null: bütün türler.
@override final  String? speciesId;
@override@JsonKey() final  String note;
/// Plana giren (sağmal ya da kurudaki) hayvan.
@override@JsonKey() final  int animals;
/// Zamanı geçmiş ya da 7 gün içinde olan; [never] buna dahil.
@override@JsonKey() final  int dueSoon;
/// Hiç uygulanmamış.
@override@JsonKey() final  int never;

/// Create a copy of VaccinePlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaccinePlanCopyWith<_VaccinePlan> get copyWith => __$VaccinePlanCopyWithImpl<_VaccinePlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaccinePlanToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaccinePlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.intervalDays, intervalDays) || other.intervalDays == intervalDays)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.note, note) || other.note == note)&&(identical(other.animals, animals) || other.animals == animals)&&(identical(other.dueSoon, dueSoon) || other.dueSoon == dueSoon)&&(identical(other.never, never) || other.never == never));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,intervalDays,speciesId,note,animals,dueSoon,never);
}

@override
String toString() {
    return 'VaccinePlan(id: $id, name: $name, intervalDays: $intervalDays, speciesId: $speciesId, note: $note, animals: $animals, dueSoon: $dueSoon, never: $never)';
}


}

/// @nodoc
abstract mixin class _$VaccinePlanCopyWith<$Res> implements $VaccinePlanCopyWith<$Res> {
  factory _$VaccinePlanCopyWith(_VaccinePlan value, $Res Function(_VaccinePlan) _then) = __$VaccinePlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int intervalDays, String? speciesId, String note, int animals, int dueSoon, int never
});




}
/// @nodoc
class __$VaccinePlanCopyWithImpl<$Res>
    implements _$VaccinePlanCopyWith<$Res> {
  __$VaccinePlanCopyWithImpl(this._self, this._then);

  final _VaccinePlan _self;
  final $Res Function(_VaccinePlan) _then;

/// Create a copy of VaccinePlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? intervalDays = null,Object? speciesId = freezed,Object? note = null,Object? animals = null,Object? dueSoon = null,Object? never = null,}) {
  return _then(_VaccinePlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intervalDays: null == intervalDays ? _self.intervalDays : intervalDays // ignore: cast_nullable_to_non_nullable
as int,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,dueSoon: null == dueSoon ? _self.dueSoon : dueSoon // ignore: cast_nullable_to_non_nullable
as int,never: null == never ? _self.never : never // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$VaccinationDue {

 String get planId; String get planName; String get animalId; String get earTag; String get animalName; DateTime? get lastGivenOn; DateTime? get dueOn;
/// Create a copy of VaccinationDue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaccinationDueCopyWith<VaccinationDue> get copyWith => _$VaccinationDueCopyWithImpl<VaccinationDue>(this as VaccinationDue, _$identity);

  /// Serializes this VaccinationDue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VaccinationDue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaccinationDue&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.planName, _this.planName) || other.planName == _this.planName)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.earTag, _this.earTag) || other.earTag == _this.earTag)&&(identical(other.animalName, _this.animalName) || other.animalName == _this.animalName)&&(identical(other.lastGivenOn, _this.lastGivenOn) || other.lastGivenOn == _this.lastGivenOn)&&(identical(other.dueOn, _this.dueOn) || other.dueOn == _this.dueOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VaccinationDue;
  return Object.hash(runtimeType,_this.planId,_this.planName,_this.animalId,_this.earTag,_this.animalName,_this.lastGivenOn,_this.dueOn);
}

@override
String toString() {
  final _this = this as VaccinationDue;
  return 'VaccinationDue(planId: ${_this.planId}, planName: ${_this.planName}, animalId: ${_this.animalId}, earTag: ${_this.earTag}, animalName: ${_this.animalName}, lastGivenOn: ${_this.lastGivenOn}, dueOn: ${_this.dueOn})';
}


}

/// @nodoc
abstract mixin class $VaccinationDueCopyWith<$Res>  {
  factory $VaccinationDueCopyWith(VaccinationDue value, $Res Function(VaccinationDue) _then) = _$VaccinationDueCopyWithImpl;
@useResult
$Res call({
 String planId, String planName, String animalId, String earTag, String animalName, DateTime? lastGivenOn, DateTime? dueOn
});




}
/// @nodoc
class _$VaccinationDueCopyWithImpl<$Res>
    implements $VaccinationDueCopyWith<$Res> {
  _$VaccinationDueCopyWithImpl(this._self, this._then);

  final VaccinationDue _self;
  final $Res Function(VaccinationDue) _then;

/// Create a copy of VaccinationDue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? planName = null,Object? animalId = null,Object? earTag = null,Object? animalName = null,Object? lastGivenOn = freezed,Object? dueOn = freezed,}) {
  return _then(VaccinationDue(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,animalName: null == animalName ? _self.animalName : animalName // ignore: cast_nullable_to_non_nullable
as String,lastGivenOn: freezed == lastGivenOn ? _self.lastGivenOn : lastGivenOn // ignore: cast_nullable_to_non_nullable
as DateTime?,dueOn: freezed == dueOn ? _self.dueOn : dueOn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VaccinationDue].
extension VaccinationDuePatterns on VaccinationDue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaccinationDue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaccinationDue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaccinationDue value)  $default,){
final _that = this;
switch (_that) {
case _VaccinationDue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaccinationDue value)?  $default,){
final _that = this;
switch (_that) {
case _VaccinationDue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String planId,  String planName,  String animalId,  String earTag,  String animalName,  DateTime? lastGivenOn,  DateTime? dueOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaccinationDue() when $default != null:
return $default(_that.planId,_that.planName,_that.animalId,_that.earTag,_that.animalName,_that.lastGivenOn,_that.dueOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String planId,  String planName,  String animalId,  String earTag,  String animalName,  DateTime? lastGivenOn,  DateTime? dueOn)  $default,) {final _that = this;
switch (_that) {
case _VaccinationDue():
return $default(_that.planId,_that.planName,_that.animalId,_that.earTag,_that.animalName,_that.lastGivenOn,_that.dueOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String planId,  String planName,  String animalId,  String earTag,  String animalName,  DateTime? lastGivenOn,  DateTime? dueOn)?  $default,) {final _that = this;
switch (_that) {
case _VaccinationDue() when $default != null:
return $default(_that.planId,_that.planName,_that.animalId,_that.earTag,_that.animalName,_that.lastGivenOn,_that.dueOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VaccinationDue extends VaccinationDue {
  const _VaccinationDue({required this.planId, required this.planName, required this.animalId, required this.earTag, this.animalName = '', this.lastGivenOn, this.dueOn}): super._();
  factory _VaccinationDue.fromJson(Map<String, dynamic> json) => _$VaccinationDueFromJson(json);

@override final  String planId;
@override final  String planName;
@override final  String animalId;
@override final  String earTag;
@override@JsonKey() final  String animalName;
@override final  DateTime? lastGivenOn;
@override final  DateTime? dueOn;

/// Create a copy of VaccinationDue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaccinationDueCopyWith<_VaccinationDue> get copyWith => __$VaccinationDueCopyWithImpl<_VaccinationDue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaccinationDueToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaccinationDue&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.animalName, animalName) || other.animalName == animalName)&&(identical(other.lastGivenOn, lastGivenOn) || other.lastGivenOn == lastGivenOn)&&(identical(other.dueOn, dueOn) || other.dueOn == dueOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,planId,planName,animalId,earTag,animalName,lastGivenOn,dueOn);
}

@override
String toString() {
    return 'VaccinationDue(planId: $planId, planName: $planName, animalId: $animalId, earTag: $earTag, animalName: $animalName, lastGivenOn: $lastGivenOn, dueOn: $dueOn)';
}


}

/// @nodoc
abstract mixin class _$VaccinationDueCopyWith<$Res> implements $VaccinationDueCopyWith<$Res> {
  factory _$VaccinationDueCopyWith(_VaccinationDue value, $Res Function(_VaccinationDue) _then) = __$VaccinationDueCopyWithImpl;
@override @useResult
$Res call({
 String planId, String planName, String animalId, String earTag, String animalName, DateTime? lastGivenOn, DateTime? dueOn
});




}
/// @nodoc
class __$VaccinationDueCopyWithImpl<$Res>
    implements _$VaccinationDueCopyWith<$Res> {
  __$VaccinationDueCopyWithImpl(this._self, this._then);

  final _VaccinationDue _self;
  final $Res Function(_VaccinationDue) _then;

/// Create a copy of VaccinationDue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? planName = null,Object? animalId = null,Object? earTag = null,Object? animalName = null,Object? lastGivenOn = freezed,Object? dueOn = freezed,}) {
  return _then(_VaccinationDue(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,animalName: null == animalName ? _self.animalName : animalName // ignore: cast_nullable_to_non_nullable
as String,lastGivenOn: freezed == lastGivenOn ? _self.lastGivenOn : lastGivenOn // ignore: cast_nullable_to_non_nullable
as DateTime?,dueOn: freezed == dueOn ? _self.dueOn : dueOn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Vaccination {

 String get id; String get planId; String get planName; String get animalId; DateTime get givenOn; String get note; String get authorName; DateTime? get createdAt;
/// Create a copy of Vaccination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaccinationCopyWith<Vaccination> get copyWith => _$VaccinationCopyWithImpl<Vaccination>(this as Vaccination, _$identity);

  /// Serializes this Vaccination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Vaccination;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vaccination&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.planName, _this.planName) || other.planName == _this.planName)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.givenOn, _this.givenOn) || other.givenOn == _this.givenOn)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Vaccination;
  return Object.hash(runtimeType,_this.id,_this.planId,_this.planName,_this.animalId,_this.givenOn,_this.note,_this.authorName,_this.createdAt);
}

@override
String toString() {
  final _this = this as Vaccination;
  return 'Vaccination(id: ${_this.id}, planId: ${_this.planId}, planName: ${_this.planName}, animalId: ${_this.animalId}, givenOn: ${_this.givenOn}, note: ${_this.note}, authorName: ${_this.authorName}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $VaccinationCopyWith<$Res>  {
  factory $VaccinationCopyWith(Vaccination value, $Res Function(Vaccination) _then) = _$VaccinationCopyWithImpl;
@useResult
$Res call({
 String id, String planId, String planName, String animalId, DateTime givenOn, String note, String authorName, DateTime? createdAt
});




}
/// @nodoc
class _$VaccinationCopyWithImpl<$Res>
    implements $VaccinationCopyWith<$Res> {
  _$VaccinationCopyWithImpl(this._self, this._then);

  final Vaccination _self;
  final $Res Function(Vaccination) _then;

/// Create a copy of Vaccination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? animalId = null,Object? givenOn = null,Object? note = null,Object? authorName = null,Object? createdAt = freezed,}) {
  return _then(Vaccination(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,givenOn: null == givenOn ? _self.givenOn : givenOn // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Vaccination].
extension VaccinationPatterns on Vaccination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vaccination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vaccination() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vaccination value)  $default,){
final _that = this;
switch (_that) {
case _Vaccination():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vaccination value)?  $default,){
final _that = this;
switch (_that) {
case _Vaccination() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String planId,  String planName,  String animalId,  DateTime givenOn,  String note,  String authorName,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vaccination() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.animalId,_that.givenOn,_that.note,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String planId,  String planName,  String animalId,  DateTime givenOn,  String note,  String authorName,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Vaccination():
return $default(_that.id,_that.planId,_that.planName,_that.animalId,_that.givenOn,_that.note,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String planId,  String planName,  String animalId,  DateTime givenOn,  String note,  String authorName,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Vaccination() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.animalId,_that.givenOn,_that.note,_that.authorName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Vaccination implements Vaccination {
  const _Vaccination({required this.id, required this.planId, required this.planName, required this.animalId, required this.givenOn, this.note = '', this.authorName = '', this.createdAt});
  factory _Vaccination.fromJson(Map<String, dynamic> json) => _$VaccinationFromJson(json);

@override final  String id;
@override final  String planId;
@override final  String planName;
@override final  String animalId;
@override final  DateTime givenOn;
@override@JsonKey() final  String note;
@override@JsonKey() final  String authorName;
@override final  DateTime? createdAt;

/// Create a copy of Vaccination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaccinationCopyWith<_Vaccination> get copyWith => __$VaccinationCopyWithImpl<_Vaccination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaccinationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vaccination&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.givenOn, givenOn) || other.givenOn == givenOn)&&(identical(other.note, note) || other.note == note)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,planId,planName,animalId,givenOn,note,authorName,createdAt);
}

@override
String toString() {
    return 'Vaccination(id: $id, planId: $planId, planName: $planName, animalId: $animalId, givenOn: $givenOn, note: $note, authorName: $authorName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$VaccinationCopyWith<$Res> implements $VaccinationCopyWith<$Res> {
  factory _$VaccinationCopyWith(_Vaccination value, $Res Function(_Vaccination) _then) = __$VaccinationCopyWithImpl;
@override @useResult
$Res call({
 String id, String planId, String planName, String animalId, DateTime givenOn, String note, String authorName, DateTime? createdAt
});




}
/// @nodoc
class __$VaccinationCopyWithImpl<$Res>
    implements _$VaccinationCopyWith<$Res> {
  __$VaccinationCopyWithImpl(this._self, this._then);

  final _Vaccination _self;
  final $Res Function(_Vaccination) _then;

/// Create a copy of Vaccination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? animalId = null,Object? givenOn = null,Object? note = null,Object? authorName = null,Object? createdAt = freezed,}) {
  return _then(_Vaccination(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,givenOn: null == givenOn ? _self.givenOn : givenOn // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$AnimalVaccinations {

 List<Vaccination> get items; List<VaccinationDue> get due;
/// Create a copy of AnimalVaccinations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalVaccinationsCopyWith<AnimalVaccinations> get copyWith => _$AnimalVaccinationsCopyWithImpl<AnimalVaccinations>(this as AnimalVaccinations, _$identity);

  /// Serializes this AnimalVaccinations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalVaccinations;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalVaccinations&&const DeepCollectionEquality().equals(other.items, _this.items)&&const DeepCollectionEquality().equals(other.due, _this.due));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalVaccinations;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),const DeepCollectionEquality().hash(_this.due));
}

@override
String toString() {
  final _this = this as AnimalVaccinations;
  return 'AnimalVaccinations(items: ${_this.items}, due: ${_this.due})';
}


}

/// @nodoc
abstract mixin class $AnimalVaccinationsCopyWith<$Res>  {
  factory $AnimalVaccinationsCopyWith(AnimalVaccinations value, $Res Function(AnimalVaccinations) _then) = _$AnimalVaccinationsCopyWithImpl;
@useResult
$Res call({
 List<Vaccination> items, List<VaccinationDue> due
});




}
/// @nodoc
class _$AnimalVaccinationsCopyWithImpl<$Res>
    implements $AnimalVaccinationsCopyWith<$Res> {
  _$AnimalVaccinationsCopyWithImpl(this._self, this._then);

  final AnimalVaccinations _self;
  final $Res Function(AnimalVaccinations) _then;

/// Create a copy of AnimalVaccinations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? due = null,}) {
  return _then(AnimalVaccinations(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Vaccination>,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as List<VaccinationDue>,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalVaccinations].
extension AnimalVaccinationsPatterns on AnimalVaccinations {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalVaccinations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalVaccinations() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalVaccinations value)  $default,){
final _that = this;
switch (_that) {
case _AnimalVaccinations():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalVaccinations value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalVaccinations() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Vaccination> items,  List<VaccinationDue> due)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalVaccinations() when $default != null:
return $default(_that.items,_that.due);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Vaccination> items,  List<VaccinationDue> due)  $default,) {final _that = this;
switch (_that) {
case _AnimalVaccinations():
return $default(_that.items,_that.due);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Vaccination> items,  List<VaccinationDue> due)?  $default,) {final _that = this;
switch (_that) {
case _AnimalVaccinations() when $default != null:
return $default(_that.items,_that.due);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalVaccinations implements AnimalVaccinations {
  const _AnimalVaccinations({ List<Vaccination> items = const [],  List<VaccinationDue> due = const []}): _items = items,_due = due;
  factory _AnimalVaccinations.fromJson(Map<String, dynamic> json) => _$AnimalVaccinationsFromJson(json);

 final  List<Vaccination> _items;
@override@JsonKey() List<Vaccination> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<VaccinationDue> _due;
@override@JsonKey() List<VaccinationDue> get due {
  if (_due is EqualUnmodifiableListView) return _due;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_due);
}


/// Create a copy of AnimalVaccinations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalVaccinationsCopyWith<_AnimalVaccinations> get copyWith => __$AnimalVaccinationsCopyWithImpl<_AnimalVaccinations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalVaccinationsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalVaccinations&&const DeepCollectionEquality().equals(other.items, _items)&&const DeepCollectionEquality().equals(other.due, _due));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_due));
}

@override
String toString() {
    return 'AnimalVaccinations(items: $items, due: $due)';
}


}

/// @nodoc
abstract mixin class _$AnimalVaccinationsCopyWith<$Res> implements $AnimalVaccinationsCopyWith<$Res> {
  factory _$AnimalVaccinationsCopyWith(_AnimalVaccinations value, $Res Function(_AnimalVaccinations) _then) = __$AnimalVaccinationsCopyWithImpl;
@override @useResult
$Res call({
 List<Vaccination> items, List<VaccinationDue> due
});




}
/// @nodoc
class __$AnimalVaccinationsCopyWithImpl<$Res>
    implements _$AnimalVaccinationsCopyWith<$Res> {
  __$AnimalVaccinationsCopyWithImpl(this._self, this._then);

  final _AnimalVaccinations _self;
  final $Res Function(_AnimalVaccinations) _then;

/// Create a copy of AnimalVaccinations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? due = null,}) {
  return _then(_AnimalVaccinations(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Vaccination>,due: null == due ? _self._due : due // ignore: cast_nullable_to_non_nullable
as List<VaccinationDue>,
  ));
}


}

// dart format on
