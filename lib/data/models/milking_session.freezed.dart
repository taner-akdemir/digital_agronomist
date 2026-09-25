// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milking_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MilkingSession {

 String get id; String get hallId;/// morning | evening | other. Beklenen verim hesabı oturum tipine göre
/// ayrışır: sabah sağımı akşamdan düzenli olarak yüksektir (§6.3).
 String get type; DateTime? get startedAt; DateTime? get endedAt; String get status;
/// Create a copy of MilkingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilkingSessionCopyWith<MilkingSession> get copyWith => _$MilkingSessionCopyWithImpl<MilkingSession>(this as MilkingSession, _$identity);

  /// Serializes this MilkingSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MilkingSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilkingSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.hallId, _this.hallId) || other.hallId == _this.hallId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MilkingSession;
  return Object.hash(runtimeType,_this.id,_this.hallId,_this.type,_this.startedAt,_this.endedAt,_this.status);
}

@override
String toString() {
  final _this = this as MilkingSession;
  return 'MilkingSession(id: ${_this.id}, hallId: ${_this.hallId}, type: ${_this.type}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $MilkingSessionCopyWith<$Res>  {
  factory $MilkingSessionCopyWith(MilkingSession value, $Res Function(MilkingSession) _then) = _$MilkingSessionCopyWithImpl;
@useResult
$Res call({
 String id, String hallId, String type, DateTime? startedAt, DateTime? endedAt, String status
});




}
/// @nodoc
class _$MilkingSessionCopyWithImpl<$Res>
    implements $MilkingSessionCopyWith<$Res> {
  _$MilkingSessionCopyWithImpl(this._self, this._then);

  final MilkingSession _self;
  final $Res Function(MilkingSession) _then;

/// Create a copy of MilkingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hallId = null,Object? type = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? status = null,}) {
  return _then(MilkingSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hallId: null == hallId ? _self.hallId : hallId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MilkingSession].
extension MilkingSessionPatterns on MilkingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MilkingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MilkingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MilkingSession value)  $default,){
final _that = this;
switch (_that) {
case _MilkingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MilkingSession value)?  $default,){
final _that = this;
switch (_that) {
case _MilkingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String hallId,  String type,  DateTime? startedAt,  DateTime? endedAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MilkingSession() when $default != null:
return $default(_that.id,_that.hallId,_that.type,_that.startedAt,_that.endedAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String hallId,  String type,  DateTime? startedAt,  DateTime? endedAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _MilkingSession():
return $default(_that.id,_that.hallId,_that.type,_that.startedAt,_that.endedAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String hallId,  String type,  DateTime? startedAt,  DateTime? endedAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _MilkingSession() when $default != null:
return $default(_that.id,_that.hallId,_that.type,_that.startedAt,_that.endedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MilkingSession implements MilkingSession {
  const _MilkingSession({required this.id, required this.hallId, this.type = 'morning', this.startedAt, this.endedAt, this.status = 'active'});
  factory _MilkingSession.fromJson(Map<String, dynamic> json) => _$MilkingSessionFromJson(json);

@override final  String id;
@override final  String hallId;
/// morning | evening | other. Beklenen verim hesabı oturum tipine göre
/// ayrışır: sabah sağımı akşamdan düzenli olarak yüksektir (§6.3).
@override@JsonKey() final  String type;
@override final  DateTime? startedAt;
@override final  DateTime? endedAt;
@override@JsonKey() final  String status;

/// Create a copy of MilkingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilkingSessionCopyWith<_MilkingSession> get copyWith => __$MilkingSessionCopyWithImpl<_MilkingSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MilkingSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilkingSession&&(identical(other.id, id) || other.id == id)&&(identical(other.hallId, hallId) || other.hallId == hallId)&&(identical(other.type, type) || other.type == type)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,hallId,type,startedAt,endedAt,status);
}

@override
String toString() {
    return 'MilkingSession(id: $id, hallId: $hallId, type: $type, startedAt: $startedAt, endedAt: $endedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MilkingSessionCopyWith<$Res> implements $MilkingSessionCopyWith<$Res> {
  factory _$MilkingSessionCopyWith(_MilkingSession value, $Res Function(_MilkingSession) _then) = __$MilkingSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String hallId, String type, DateTime? startedAt, DateTime? endedAt, String status
});




}
/// @nodoc
class __$MilkingSessionCopyWithImpl<$Res>
    implements _$MilkingSessionCopyWith<$Res> {
  __$MilkingSessionCopyWithImpl(this._self, this._then);

  final _MilkingSession _self;
  final $Res Function(_MilkingSession) _then;

/// Create a copy of MilkingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hallId = null,Object? type = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? status = null,}) {
  return _then(_MilkingSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hallId: null == hallId ? _self.hallId : hallId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LiveSession {

 MilkingSession get session; List<SpoutUpdate> get updates;
/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveSessionCopyWith<LiveSession> get copyWith => _$LiveSessionCopyWithImpl<LiveSession>(this as LiveSession, _$identity);

  /// Serializes this LiveSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LiveSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveSession&&(identical(other.session, _this.session) || other.session == _this.session)&&const DeepCollectionEquality().equals(other.updates, _this.updates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LiveSession;
  return Object.hash(runtimeType,_this.session,const DeepCollectionEquality().hash(_this.updates));
}

@override
String toString() {
  final _this = this as LiveSession;
  return 'LiveSession(session: ${_this.session}, updates: ${_this.updates})';
}


}

/// @nodoc
abstract mixin class $LiveSessionCopyWith<$Res>  {
  factory $LiveSessionCopyWith(LiveSession value, $Res Function(LiveSession) _then) = _$LiveSessionCopyWithImpl;
@useResult
$Res call({
 MilkingSession session, List<SpoutUpdate> updates
});


$MilkingSessionCopyWith<$Res> get session;

}
/// @nodoc
class _$LiveSessionCopyWithImpl<$Res>
    implements $LiveSessionCopyWith<$Res> {
  _$LiveSessionCopyWithImpl(this._self, this._then);

  final LiveSession _self;
  final $Res Function(LiveSession) _then;

/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? updates = null,}) {
  return _then(LiveSession(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as MilkingSession,updates: null == updates ? _self.updates : updates // ignore: cast_nullable_to_non_nullable
as List<SpoutUpdate>,
  ));
}
/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MilkingSessionCopyWith<$Res> get session {
  
  return $MilkingSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveSession].
extension LiveSessionPatterns on LiveSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveSession value)  $default,){
final _that = this;
switch (_that) {
case _LiveSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveSession value)?  $default,){
final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MilkingSession session,  List<SpoutUpdate> updates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
return $default(_that.session,_that.updates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MilkingSession session,  List<SpoutUpdate> updates)  $default,) {final _that = this;
switch (_that) {
case _LiveSession():
return $default(_that.session,_that.updates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MilkingSession session,  List<SpoutUpdate> updates)?  $default,) {final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
return $default(_that.session,_that.updates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveSession implements LiveSession {
  const _LiveSession({required this.session,  List<SpoutUpdate> updates = const <SpoutUpdate>[]}): _updates = updates;
  factory _LiveSession.fromJson(Map<String, dynamic> json) => _$LiveSessionFromJson(json);

@override final  MilkingSession session;
 final  List<SpoutUpdate> _updates;
@override@JsonKey() List<SpoutUpdate> get updates {
  if (_updates is EqualUnmodifiableListView) return _updates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_updates);
}


/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveSessionCopyWith<_LiveSession> get copyWith => __$LiveSessionCopyWithImpl<_LiveSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveSession&&(identical(other.session, session) || other.session == session)&&const DeepCollectionEquality().equals(other.updates, _updates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,session,const DeepCollectionEquality().hash(_updates));
}

@override
String toString() {
    return 'LiveSession(session: $session, updates: $updates)';
}


}

/// @nodoc
abstract mixin class _$LiveSessionCopyWith<$Res> implements $LiveSessionCopyWith<$Res> {
  factory _$LiveSessionCopyWith(_LiveSession value, $Res Function(_LiveSession) _then) = __$LiveSessionCopyWithImpl;
@override @useResult
$Res call({
 MilkingSession session, List<SpoutUpdate> updates
});


@override $MilkingSessionCopyWith<$Res> get session;

}
/// @nodoc
class __$LiveSessionCopyWithImpl<$Res>
    implements _$LiveSessionCopyWith<$Res> {
  __$LiveSessionCopyWithImpl(this._self, this._then);

  final _LiveSession _self;
  final $Res Function(_LiveSession) _then;

/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? updates = null,}) {
  return _then(_LiveSession(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as MilkingSession,updates: null == updates ? _self._updates : updates // ignore: cast_nullable_to_non_nullable
as List<SpoutUpdate>,
  ));
}

/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MilkingSessionCopyWith<$Res> get session {
  
  return $MilkingSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
