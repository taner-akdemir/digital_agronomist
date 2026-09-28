// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'treatment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Treatment {

 String get id; String get animalId; String get drug; DateTime get startedOn;/// Sütün ayrılacağı SON gün (dahil).
 DateTime get withdrawalUntil; String get note; String? get authorName; DateTime? get createdAt;
/// Create a copy of Treatment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TreatmentCopyWith<Treatment> get copyWith => _$TreatmentCopyWithImpl<Treatment>(this as Treatment, _$identity);

  /// Serializes this Treatment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Treatment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Treatment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.drug, _this.drug) || other.drug == _this.drug)&&(identical(other.startedOn, _this.startedOn) || other.startedOn == _this.startedOn)&&(identical(other.withdrawalUntil, _this.withdrawalUntil) || other.withdrawalUntil == _this.withdrawalUntil)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Treatment;
  return Object.hash(runtimeType,_this.id,_this.animalId,_this.drug,_this.startedOn,_this.withdrawalUntil,_this.note,_this.authorName,_this.createdAt);
}

@override
String toString() {
  final _this = this as Treatment;
  return 'Treatment(id: ${_this.id}, animalId: ${_this.animalId}, drug: ${_this.drug}, startedOn: ${_this.startedOn}, withdrawalUntil: ${_this.withdrawalUntil}, note: ${_this.note}, authorName: ${_this.authorName}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $TreatmentCopyWith<$Res>  {
  factory $TreatmentCopyWith(Treatment value, $Res Function(Treatment) _then) = _$TreatmentCopyWithImpl;
@useResult
$Res call({
 String id, String animalId, String drug, DateTime startedOn, DateTime withdrawalUntil, String note, String? authorName, DateTime? createdAt
});




}
/// @nodoc
class _$TreatmentCopyWithImpl<$Res>
    implements $TreatmentCopyWith<$Res> {
  _$TreatmentCopyWithImpl(this._self, this._then);

  final Treatment _self;
  final $Res Function(Treatment) _then;

/// Create a copy of Treatment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? animalId = null,Object? drug = null,Object? startedOn = null,Object? withdrawalUntil = null,Object? note = null,Object? authorName = freezed,Object? createdAt = freezed,}) {
  return _then(Treatment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,drug: null == drug ? _self.drug : drug // ignore: cast_nullable_to_non_nullable
as String,startedOn: null == startedOn ? _self.startedOn : startedOn // ignore: cast_nullable_to_non_nullable
as DateTime,withdrawalUntil: null == withdrawalUntil ? _self.withdrawalUntil : withdrawalUntil // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Treatment].
extension TreatmentPatterns on Treatment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Treatment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Treatment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Treatment value)  $default,){
final _that = this;
switch (_that) {
case _Treatment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Treatment value)?  $default,){
final _that = this;
switch (_that) {
case _Treatment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String animalId,  String drug,  DateTime startedOn,  DateTime withdrawalUntil,  String note,  String? authorName,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Treatment() when $default != null:
return $default(_that.id,_that.animalId,_that.drug,_that.startedOn,_that.withdrawalUntil,_that.note,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String animalId,  String drug,  DateTime startedOn,  DateTime withdrawalUntil,  String note,  String? authorName,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Treatment():
return $default(_that.id,_that.animalId,_that.drug,_that.startedOn,_that.withdrawalUntil,_that.note,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String animalId,  String drug,  DateTime startedOn,  DateTime withdrawalUntil,  String note,  String? authorName,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Treatment() when $default != null:
return $default(_that.id,_that.animalId,_that.drug,_that.startedOn,_that.withdrawalUntil,_that.note,_that.authorName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Treatment extends Treatment {
  const _Treatment({required this.id, required this.animalId, required this.drug, required this.startedOn, required this.withdrawalUntil, this.note = '', this.authorName, this.createdAt}): super._();
  factory _Treatment.fromJson(Map<String, dynamic> json) => _$TreatmentFromJson(json);

@override final  String id;
@override final  String animalId;
@override final  String drug;
@override final  DateTime startedOn;
/// Sütün ayrılacağı SON gün (dahil).
@override final  DateTime withdrawalUntil;
@override@JsonKey() final  String note;
@override final  String? authorName;
@override final  DateTime? createdAt;

/// Create a copy of Treatment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TreatmentCopyWith<_Treatment> get copyWith => __$TreatmentCopyWithImpl<_Treatment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TreatmentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Treatment&&(identical(other.id, id) || other.id == id)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.drug, drug) || other.drug == drug)&&(identical(other.startedOn, startedOn) || other.startedOn == startedOn)&&(identical(other.withdrawalUntil, withdrawalUntil) || other.withdrawalUntil == withdrawalUntil)&&(identical(other.note, note) || other.note == note)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,animalId,drug,startedOn,withdrawalUntil,note,authorName,createdAt);
}

@override
String toString() {
    return 'Treatment(id: $id, animalId: $animalId, drug: $drug, startedOn: $startedOn, withdrawalUntil: $withdrawalUntil, note: $note, authorName: $authorName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TreatmentCopyWith<$Res> implements $TreatmentCopyWith<$Res> {
  factory _$TreatmentCopyWith(_Treatment value, $Res Function(_Treatment) _then) = __$TreatmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String animalId, String drug, DateTime startedOn, DateTime withdrawalUntil, String note, String? authorName, DateTime? createdAt
});




}
/// @nodoc
class __$TreatmentCopyWithImpl<$Res>
    implements _$TreatmentCopyWith<$Res> {
  __$TreatmentCopyWithImpl(this._self, this._then);

  final _Treatment _self;
  final $Res Function(_Treatment) _then;

/// Create a copy of Treatment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? animalId = null,Object? drug = null,Object? startedOn = null,Object? withdrawalUntil = null,Object? note = null,Object? authorName = freezed,Object? createdAt = freezed,}) {
  return _then(_Treatment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,drug: null == drug ? _self.drug : drug // ignore: cast_nullable_to_non_nullable
as String,startedOn: null == startedOn ? _self.startedOn : startedOn // ignore: cast_nullable_to_non_nullable
as DateTime,withdrawalUntil: null == withdrawalUntil ? _self.withdrawalUntil : withdrawalUntil // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
