// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Alert {

 String get id; String get message;/// low_flow | low_yield | device_offline | ... (§7 mt.alerts.v1)
 String get type;/// info | warning | critical
 String get severity; String? get animalId; String? get sessionId; DateTime? get createdAt; String? get acknowledgedBy; DateTime? get acknowledgedAt;/// Sorunun geçtiği an: sayaç geri geldi (ADR 0041) ya da hatası düzeldi
/// (ADR 0058). Okundu
/// bilgisinden BAĞIMSIZ — sağımcı görmeden sayaç dönmüş olabilir.
 DateTime? get resolvedAt;
/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertCopyWith<Alert> get copyWith => _$AlertCopyWithImpl<Alert>(this as Alert, _$identity);

  /// Serializes this Alert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Alert&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.acknowledgedBy, acknowledgedBy) || other.acknowledgedBy == acknowledgedBy)&&(identical(other.acknowledgedAt, acknowledgedAt) || other.acknowledgedAt == acknowledgedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,type,severity,animalId,sessionId,createdAt,acknowledgedBy,acknowledgedAt,resolvedAt);

@override
String toString() {
  return 'Alert(id: $id, message: $message, type: $type, severity: $severity, animalId: $animalId, sessionId: $sessionId, createdAt: $createdAt, acknowledgedBy: $acknowledgedBy, acknowledgedAt: $acknowledgedAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $AlertCopyWith<$Res>  {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) _then) = _$AlertCopyWithImpl;
@useResult
$Res call({
 String id, String message, String type, String severity, String? animalId, String? sessionId, DateTime? createdAt, String? acknowledgedBy, DateTime? acknowledgedAt, DateTime? resolvedAt
});




}
/// @nodoc
class _$AlertCopyWithImpl<$Res>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._self, this._then);

  final Alert _self;
  final $Res Function(Alert) _then;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? message = null,Object? type = null,Object? severity = null,Object? animalId = freezed,Object? sessionId = freezed,Object? createdAt = freezed,Object? acknowledgedBy = freezed,Object? acknowledgedAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,acknowledgedBy: freezed == acknowledgedBy ? _self.acknowledgedBy : acknowledgedBy // ignore: cast_nullable_to_non_nullable
as String?,acknowledgedAt: freezed == acknowledgedAt ? _self.acknowledgedAt : acknowledgedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Alert].
extension AlertPatterns on Alert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Alert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Alert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Alert value)  $default,){
final _that = this;
switch (_that) {
case _Alert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Alert value)?  $default,){
final _that = this;
switch (_that) {
case _Alert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String message,  String type,  String severity,  String? animalId,  String? sessionId,  DateTime? createdAt,  String? acknowledgedBy,  DateTime? acknowledgedAt,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Alert() when $default != null:
return $default(_that.id,_that.message,_that.type,_that.severity,_that.animalId,_that.sessionId,_that.createdAt,_that.acknowledgedBy,_that.acknowledgedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String message,  String type,  String severity,  String? animalId,  String? sessionId,  DateTime? createdAt,  String? acknowledgedBy,  DateTime? acknowledgedAt,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _Alert():
return $default(_that.id,_that.message,_that.type,_that.severity,_that.animalId,_that.sessionId,_that.createdAt,_that.acknowledgedBy,_that.acknowledgedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String message,  String type,  String severity,  String? animalId,  String? sessionId,  DateTime? createdAt,  String? acknowledgedBy,  DateTime? acknowledgedAt,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _Alert() when $default != null:
return $default(_that.id,_that.message,_that.type,_that.severity,_that.animalId,_that.sessionId,_that.createdAt,_that.acknowledgedBy,_that.acknowledgedAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Alert extends Alert {
  const _Alert({required this.id, required this.message, this.type = '', this.severity = 'warning', this.animalId, this.sessionId, this.createdAt, this.acknowledgedBy, this.acknowledgedAt, this.resolvedAt}): super._();
  factory _Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

@override final  String id;
@override final  String message;
/// low_flow | low_yield | device_offline | ... (§7 mt.alerts.v1)
@override@JsonKey() final  String type;
/// info | warning | critical
@override@JsonKey() final  String severity;
@override final  String? animalId;
@override final  String? sessionId;
@override final  DateTime? createdAt;
@override final  String? acknowledgedBy;
@override final  DateTime? acknowledgedAt;
/// Sorunun geçtiği an: sayaç geri geldi (ADR 0041) ya da hatası düzeldi
/// (ADR 0058). Okundu
/// bilgisinden BAĞIMSIZ — sağımcı görmeden sayaç dönmüş olabilir.
@override final  DateTime? resolvedAt;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertCopyWith<_Alert> get copyWith => __$AlertCopyWithImpl<_Alert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Alert&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.acknowledgedBy, acknowledgedBy) || other.acknowledgedBy == acknowledgedBy)&&(identical(other.acknowledgedAt, acknowledgedAt) || other.acknowledgedAt == acknowledgedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,type,severity,animalId,sessionId,createdAt,acknowledgedBy,acknowledgedAt,resolvedAt);

@override
String toString() {
  return 'Alert(id: $id, message: $message, type: $type, severity: $severity, animalId: $animalId, sessionId: $sessionId, createdAt: $createdAt, acknowledgedBy: $acknowledgedBy, acknowledgedAt: $acknowledgedAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$AlertCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$AlertCopyWith(_Alert value, $Res Function(_Alert) _then) = __$AlertCopyWithImpl;
@override @useResult
$Res call({
 String id, String message, String type, String severity, String? animalId, String? sessionId, DateTime? createdAt, String? acknowledgedBy, DateTime? acknowledgedAt, DateTime? resolvedAt
});




}
/// @nodoc
class __$AlertCopyWithImpl<$Res>
    implements _$AlertCopyWith<$Res> {
  __$AlertCopyWithImpl(this._self, this._then);

  final _Alert _self;
  final $Res Function(_Alert) _then;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? message = null,Object? type = null,Object? severity = null,Object? animalId = freezed,Object? sessionId = freezed,Object? createdAt = freezed,Object? acknowledgedBy = freezed,Object? acknowledgedAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_Alert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,acknowledgedBy: freezed == acknowledgedBy ? _self.acknowledgedBy : acknowledgedBy // ignore: cast_nullable_to_non_nullable
as String?,acknowledgedAt: freezed == acknowledgedAt ? _self.acknowledgedAt : acknowledgedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
