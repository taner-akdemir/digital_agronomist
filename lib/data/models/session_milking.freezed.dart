// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_milking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionMilking {

 String get animalId; String get earTag; String? get spoutId; DateTime get startedAt; DateTime? get endedAt; int get volumeMl;
/// Create a copy of SessionMilking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionMilkingCopyWith<SessionMilking> get copyWith => _$SessionMilkingCopyWithImpl<SessionMilking>(this as SessionMilking, _$identity);

  /// Serializes this SessionMilking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SessionMilking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionMilking&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.earTag, _this.earTag) || other.earTag == _this.earTag)&&(identical(other.spoutId, _this.spoutId) || other.spoutId == _this.spoutId)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SessionMilking;
  return Object.hash(runtimeType,_this.animalId,_this.earTag,_this.spoutId,_this.startedAt,_this.endedAt,_this.volumeMl);
}

@override
String toString() {
  final _this = this as SessionMilking;
  return 'SessionMilking(animalId: ${_this.animalId}, earTag: ${_this.earTag}, spoutId: ${_this.spoutId}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt}, volumeMl: ${_this.volumeMl})';
}


}

/// @nodoc
abstract mixin class $SessionMilkingCopyWith<$Res>  {
  factory $SessionMilkingCopyWith(SessionMilking value, $Res Function(SessionMilking) _then) = _$SessionMilkingCopyWithImpl;
@useResult
$Res call({
 String animalId, String earTag, String? spoutId, DateTime startedAt, DateTime? endedAt, int volumeMl
});




}
/// @nodoc
class _$SessionMilkingCopyWithImpl<$Res>
    implements $SessionMilkingCopyWith<$Res> {
  _$SessionMilkingCopyWithImpl(this._self, this._then);

  final SessionMilking _self;
  final $Res Function(SessionMilking) _then;

/// Create a copy of SessionMilking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? earTag = null,Object? spoutId = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? volumeMl = null,}) {
  return _then(SessionMilking(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,spoutId: freezed == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionMilking].
extension SessionMilkingPatterns on SessionMilking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionMilking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionMilking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionMilking value)  $default,){
final _that = this;
switch (_that) {
case _SessionMilking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionMilking value)?  $default,){
final _that = this;
switch (_that) {
case _SessionMilking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId,  String earTag,  String? spoutId,  DateTime startedAt,  DateTime? endedAt,  int volumeMl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionMilking() when $default != null:
return $default(_that.animalId,_that.earTag,_that.spoutId,_that.startedAt,_that.endedAt,_that.volumeMl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId,  String earTag,  String? spoutId,  DateTime startedAt,  DateTime? endedAt,  int volumeMl)  $default,) {final _that = this;
switch (_that) {
case _SessionMilking():
return $default(_that.animalId,_that.earTag,_that.spoutId,_that.startedAt,_that.endedAt,_that.volumeMl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId,  String earTag,  String? spoutId,  DateTime startedAt,  DateTime? endedAt,  int volumeMl)?  $default,) {final _that = this;
switch (_that) {
case _SessionMilking() when $default != null:
return $default(_that.animalId,_that.earTag,_that.spoutId,_that.startedAt,_that.endedAt,_that.volumeMl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionMilking implements SessionMilking {
  const _SessionMilking({required this.animalId, required this.earTag, this.spoutId, required this.startedAt, this.endedAt, this.volumeMl = 0});
  factory _SessionMilking.fromJson(Map<String, dynamic> json) => _$SessionMilkingFromJson(json);

@override final  String animalId;
@override final  String earTag;
@override final  String? spoutId;
@override final  DateTime startedAt;
@override final  DateTime? endedAt;
@override@JsonKey() final  int volumeMl;

/// Create a copy of SessionMilking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionMilkingCopyWith<_SessionMilking> get copyWith => __$SessionMilkingCopyWithImpl<_SessionMilking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionMilkingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionMilking&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,earTag,spoutId,startedAt,endedAt,volumeMl);
}

@override
String toString() {
    return 'SessionMilking(animalId: $animalId, earTag: $earTag, spoutId: $spoutId, startedAt: $startedAt, endedAt: $endedAt, volumeMl: $volumeMl)';
}


}

/// @nodoc
abstract mixin class _$SessionMilkingCopyWith<$Res> implements $SessionMilkingCopyWith<$Res> {
  factory _$SessionMilkingCopyWith(_SessionMilking value, $Res Function(_SessionMilking) _then) = __$SessionMilkingCopyWithImpl;
@override @useResult
$Res call({
 String animalId, String earTag, String? spoutId, DateTime startedAt, DateTime? endedAt, int volumeMl
});




}
/// @nodoc
class __$SessionMilkingCopyWithImpl<$Res>
    implements _$SessionMilkingCopyWith<$Res> {
  __$SessionMilkingCopyWithImpl(this._self, this._then);

  final _SessionMilking _self;
  final $Res Function(_SessionMilking) _then;

/// Create a copy of SessionMilking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? earTag = null,Object? spoutId = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? volumeMl = null,}) {
  return _then(_SessionMilking(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,spoutId: freezed == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
