// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSession {

 String get id; String get userAgent; String get ip; DateTime? get startedAt; DateTime? get lastUsedAt;/// Bu isteği yapan oturum ("bu cihaz").
 bool get current;
/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSessionCopyWith<UserSession> get copyWith => _$UserSessionCopyWithImpl<UserSession>(this as UserSession, _$identity);

  /// Serializes this UserSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userAgent, _this.userAgent) || other.userAgent == _this.userAgent)&&(identical(other.ip, _this.ip) || other.ip == _this.ip)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.lastUsedAt, _this.lastUsedAt) || other.lastUsedAt == _this.lastUsedAt)&&(identical(other.current, _this.current) || other.current == _this.current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserSession;
  return Object.hash(runtimeType,_this.id,_this.userAgent,_this.ip,_this.startedAt,_this.lastUsedAt,_this.current);
}

@override
String toString() {
  final _this = this as UserSession;
  return 'UserSession(id: ${_this.id}, userAgent: ${_this.userAgent}, ip: ${_this.ip}, startedAt: ${_this.startedAt}, lastUsedAt: ${_this.lastUsedAt}, current: ${_this.current})';
}


}

/// @nodoc
abstract mixin class $UserSessionCopyWith<$Res>  {
  factory $UserSessionCopyWith(UserSession value, $Res Function(UserSession) _then) = _$UserSessionCopyWithImpl;
@useResult
$Res call({
 String id, String userAgent, String ip, DateTime? startedAt, DateTime? lastUsedAt, bool current
});




}
/// @nodoc
class _$UserSessionCopyWithImpl<$Res>
    implements $UserSessionCopyWith<$Res> {
  _$UserSessionCopyWithImpl(this._self, this._then);

  final UserSession _self;
  final $Res Function(UserSession) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userAgent = null,Object? ip = null,Object? startedAt = freezed,Object? lastUsedAt = freezed,Object? current = null,}) {
  return _then(UserSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userAgent: null == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String,ip: null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSession].
extension UserSessionPatterns on UserSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSession value)  $default,){
final _that = this;
switch (_that) {
case _UserSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSession value)?  $default,){
final _that = this;
switch (_that) {
case _UserSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userAgent,  String ip,  DateTime? startedAt,  DateTime? lastUsedAt,  bool current)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that.id,_that.userAgent,_that.ip,_that.startedAt,_that.lastUsedAt,_that.current);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userAgent,  String ip,  DateTime? startedAt,  DateTime? lastUsedAt,  bool current)  $default,) {final _that = this;
switch (_that) {
case _UserSession():
return $default(_that.id,_that.userAgent,_that.ip,_that.startedAt,_that.lastUsedAt,_that.current);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userAgent,  String ip,  DateTime? startedAt,  DateTime? lastUsedAt,  bool current)?  $default,) {final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that.id,_that.userAgent,_that.ip,_that.startedAt,_that.lastUsedAt,_that.current);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSession extends UserSession {
  const _UserSession({required this.id, this.userAgent = '', this.ip = '', this.startedAt, this.lastUsedAt, this.current = false}): super._();
  factory _UserSession.fromJson(Map<String, dynamic> json) => _$UserSessionFromJson(json);

@override final  String id;
@override@JsonKey() final  String userAgent;
@override@JsonKey() final  String ip;
@override final  DateTime? startedAt;
@override final  DateTime? lastUsedAt;
/// Bu isteği yapan oturum ("bu cihaz").
@override@JsonKey() final  bool current;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSessionCopyWith<_UserSession> get copyWith => __$UserSessionCopyWithImpl<_UserSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.current, current) || other.current == current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userAgent,ip,startedAt,lastUsedAt,current);
}

@override
String toString() {
    return 'UserSession(id: $id, userAgent: $userAgent, ip: $ip, startedAt: $startedAt, lastUsedAt: $lastUsedAt, current: $current)';
}


}

/// @nodoc
abstract mixin class _$UserSessionCopyWith<$Res> implements $UserSessionCopyWith<$Res> {
  factory _$UserSessionCopyWith(_UserSession value, $Res Function(_UserSession) _then) = __$UserSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userAgent, String ip, DateTime? startedAt, DateTime? lastUsedAt, bool current
});




}
/// @nodoc
class __$UserSessionCopyWithImpl<$Res>
    implements _$UserSessionCopyWith<$Res> {
  __$UserSessionCopyWithImpl(this._self, this._then);

  final _UserSession _self;
  final $Res Function(_UserSession) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userAgent = null,Object? ip = null,Object? startedAt = freezed,Object? lastUsedAt = freezed,Object? current = null,}) {
  return _then(_UserSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userAgent: null == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String,ip: null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
