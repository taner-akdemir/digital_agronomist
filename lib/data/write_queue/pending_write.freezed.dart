// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_write.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PendingWrite {

 String get id; PendingKind get kind;/// Hayvana bağlı kayıtta hayvan; aşıda tek hayvan işaretlendiyse o.
 String? get animalId;/// Listede gösterilecek konu: küpe / ad ya da "12 hayvan". Gönderilmez.
 String get subject;/// İsteğin alanları; biçimi [PendingPayload]'da. Gösterim için ek alan
/// (aşı planının adı gibi) taşıyabilir, gönderen yalnızca bildiklerini
/// okur.
 Map<String, dynamic> get payload; DateTime get createdAt;/// Kuyruktan yapılan deneme sayısı (ilk doğrudan istek sayılmaz).
 int get attempts;/// Sunucu hatası sayısı; ağ hatası sayılmaz (ADR 0140/7).
 int get serverErrors;/// Bundan önce yeniden denenmez (artan bekleme). Null: hemen.
 DateTime? get nextAttemptAt; PendingState get state; PendingFailure? get failure;/// Sunucunun mesajı (reddedildiyse); olduğu gibi gösterilir.
 String? get error;/// Gönderilemeyenlere düştüğü an (30 gün sonra silinir).
 DateTime? get failedAt;
/// Create a copy of PendingWrite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingWriteCopyWith<PendingWrite> get copyWith => _$PendingWriteCopyWithImpl<PendingWrite>(this as PendingWrite, _$identity);

  /// Serializes this PendingWrite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PendingWrite;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingWrite&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&const DeepCollectionEquality().equals(other.payload, _this.payload)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts)&&(identical(other.serverErrors, _this.serverErrors) || other.serverErrors == _this.serverErrors)&&(identical(other.nextAttemptAt, _this.nextAttemptAt) || other.nextAttemptAt == _this.nextAttemptAt)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.failedAt, _this.failedAt) || other.failedAt == _this.failedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PendingWrite;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.animalId,_this.subject,const DeepCollectionEquality().hash(_this.payload),_this.createdAt,_this.attempts,_this.serverErrors,_this.nextAttemptAt,_this.state,_this.failure,_this.error,_this.failedAt);
}

@override
String toString() {
  final _this = this as PendingWrite;
  return 'PendingWrite(id: ${_this.id}, kind: ${_this.kind}, animalId: ${_this.animalId}, subject: ${_this.subject}, payload: ${_this.payload}, createdAt: ${_this.createdAt}, attempts: ${_this.attempts}, serverErrors: ${_this.serverErrors}, nextAttemptAt: ${_this.nextAttemptAt}, state: ${_this.state}, failure: ${_this.failure}, error: ${_this.error}, failedAt: ${_this.failedAt})';
}


}

/// @nodoc
abstract mixin class $PendingWriteCopyWith<$Res>  {
  factory $PendingWriteCopyWith(PendingWrite value, $Res Function(PendingWrite) _then) = _$PendingWriteCopyWithImpl;
@useResult
$Res call({
 String id, PendingKind kind, String? animalId, String subject, Map<String, dynamic> payload, DateTime createdAt, int attempts, int serverErrors, DateTime? nextAttemptAt, PendingState state, PendingFailure? failure, String? error, DateTime? failedAt
});




}
/// @nodoc
class _$PendingWriteCopyWithImpl<$Res>
    implements $PendingWriteCopyWith<$Res> {
  _$PendingWriteCopyWithImpl(this._self, this._then);

  final PendingWrite _self;
  final $Res Function(PendingWrite) _then;

/// Create a copy of PendingWrite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? animalId = freezed,Object? subject = null,Object? payload = null,Object? createdAt = null,Object? attempts = null,Object? serverErrors = null,Object? nextAttemptAt = freezed,Object? state = null,Object? failure = freezed,Object? error = freezed,Object? failedAt = freezed,}) {
  return _then(PendingWrite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PendingKind,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,serverErrors: null == serverErrors ? _self.serverErrors : serverErrors // ignore: cast_nullable_to_non_nullable
as int,nextAttemptAt: freezed == nextAttemptAt ? _self.nextAttemptAt : nextAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as PendingState,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as PendingFailure?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingWrite].
extension PendingWritePatterns on PendingWrite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingWrite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingWrite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingWrite value)  $default,){
final _that = this;
switch (_that) {
case _PendingWrite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingWrite value)?  $default,){
final _that = this;
switch (_that) {
case _PendingWrite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PendingKind kind,  String? animalId,  String subject,  Map<String, dynamic> payload,  DateTime createdAt,  int attempts,  int serverErrors,  DateTime? nextAttemptAt,  PendingState state,  PendingFailure? failure,  String? error,  DateTime? failedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingWrite() when $default != null:
return $default(_that.id,_that.kind,_that.animalId,_that.subject,_that.payload,_that.createdAt,_that.attempts,_that.serverErrors,_that.nextAttemptAt,_that.state,_that.failure,_that.error,_that.failedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PendingKind kind,  String? animalId,  String subject,  Map<String, dynamic> payload,  DateTime createdAt,  int attempts,  int serverErrors,  DateTime? nextAttemptAt,  PendingState state,  PendingFailure? failure,  String? error,  DateTime? failedAt)  $default,) {final _that = this;
switch (_that) {
case _PendingWrite():
return $default(_that.id,_that.kind,_that.animalId,_that.subject,_that.payload,_that.createdAt,_that.attempts,_that.serverErrors,_that.nextAttemptAt,_that.state,_that.failure,_that.error,_that.failedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PendingKind kind,  String? animalId,  String subject,  Map<String, dynamic> payload,  DateTime createdAt,  int attempts,  int serverErrors,  DateTime? nextAttemptAt,  PendingState state,  PendingFailure? failure,  String? error,  DateTime? failedAt)?  $default,) {final _that = this;
switch (_that) {
case _PendingWrite() when $default != null:
return $default(_that.id,_that.kind,_that.animalId,_that.subject,_that.payload,_that.createdAt,_that.attempts,_that.serverErrors,_that.nextAttemptAt,_that.state,_that.failure,_that.error,_that.failedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingWrite extends PendingWrite {
  const _PendingWrite({required this.id, required this.kind, this.animalId, this.subject = '',  Map<String, dynamic> payload = const <String, dynamic>{}, required this.createdAt, this.attempts = 0, this.serverErrors = 0, this.nextAttemptAt, this.state = PendingState.pending, this.failure, this.error, this.failedAt}): _payload = payload,super._();
  factory _PendingWrite.fromJson(Map<String, dynamic> json) => _$PendingWriteFromJson(json);

@override final  String id;
@override final  PendingKind kind;
/// Hayvana bağlı kayıtta hayvan; aşıda tek hayvan işaretlendiyse o.
@override final  String? animalId;
/// Listede gösterilecek konu: küpe / ad ya da "12 hayvan". Gönderilmez.
@override@JsonKey() final  String subject;
/// İsteğin alanları; biçimi [PendingPayload]'da. Gösterim için ek alan
/// (aşı planının adı gibi) taşıyabilir, gönderen yalnızca bildiklerini
/// okur.
 final  Map<String, dynamic> _payload;
/// İsteğin alanları; biçimi [PendingPayload]'da. Gösterim için ek alan
/// (aşı planının adı gibi) taşıyabilir, gönderen yalnızca bildiklerini
/// okur.
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override final  DateTime createdAt;
/// Kuyruktan yapılan deneme sayısı (ilk doğrudan istek sayılmaz).
@override@JsonKey() final  int attempts;
/// Sunucu hatası sayısı; ağ hatası sayılmaz (ADR 0140/7).
@override@JsonKey() final  int serverErrors;
/// Bundan önce yeniden denenmez (artan bekleme). Null: hemen.
@override final  DateTime? nextAttemptAt;
@override@JsonKey() final  PendingState state;
@override final  PendingFailure? failure;
/// Sunucunun mesajı (reddedildiyse); olduğu gibi gösterilir.
@override final  String? error;
/// Gönderilemeyenlere düştüğü an (30 gün sonra silinir).
@override final  DateTime? failedAt;

/// Create a copy of PendingWrite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingWriteCopyWith<_PendingWrite> get copyWith => __$PendingWriteCopyWithImpl<_PendingWrite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingWriteToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingWrite&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.subject, subject) || other.subject == subject)&&const DeepCollectionEquality().equals(other.payload, _payload)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.serverErrors, serverErrors) || other.serverErrors == serverErrors)&&(identical(other.nextAttemptAt, nextAttemptAt) || other.nextAttemptAt == nextAttemptAt)&&(identical(other.state, state) || other.state == state)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.error, error) || other.error == error)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,animalId,subject,const DeepCollectionEquality().hash(_payload),createdAt,attempts,serverErrors,nextAttemptAt,state,failure,error,failedAt);
}

@override
String toString() {
    return 'PendingWrite(id: $id, kind: $kind, animalId: $animalId, subject: $subject, payload: $payload, createdAt: $createdAt, attempts: $attempts, serverErrors: $serverErrors, nextAttemptAt: $nextAttemptAt, state: $state, failure: $failure, error: $error, failedAt: $failedAt)';
}


}

/// @nodoc
abstract mixin class _$PendingWriteCopyWith<$Res> implements $PendingWriteCopyWith<$Res> {
  factory _$PendingWriteCopyWith(_PendingWrite value, $Res Function(_PendingWrite) _then) = __$PendingWriteCopyWithImpl;
@override @useResult
$Res call({
 String id, PendingKind kind, String? animalId, String subject, Map<String, dynamic> payload, DateTime createdAt, int attempts, int serverErrors, DateTime? nextAttemptAt, PendingState state, PendingFailure? failure, String? error, DateTime? failedAt
});




}
/// @nodoc
class __$PendingWriteCopyWithImpl<$Res>
    implements _$PendingWriteCopyWith<$Res> {
  __$PendingWriteCopyWithImpl(this._self, this._then);

  final _PendingWrite _self;
  final $Res Function(_PendingWrite) _then;

/// Create a copy of PendingWrite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? animalId = freezed,Object? subject = null,Object? payload = null,Object? createdAt = null,Object? attempts = null,Object? serverErrors = null,Object? nextAttemptAt = freezed,Object? state = null,Object? failure = freezed,Object? error = freezed,Object? failedAt = freezed,}) {
  return _then(_PendingWrite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PendingKind,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,serverErrors: null == serverErrors ? _self.serverErrors : serverErrors // ignore: cast_nullable_to_non_nullable
as int,nextAttemptAt: freezed == nextAttemptAt ? _self.nextAttemptAt : nextAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as PendingState,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as PendingFailure?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
