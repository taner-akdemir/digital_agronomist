// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_placements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionPlacements {

 String get sessionId; DateTime get startedAt; List<Placement> get placements;
/// Create a copy of SessionPlacements
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionPlacementsCopyWith<SessionPlacements> get copyWith => _$SessionPlacementsCopyWithImpl<SessionPlacements>(this as SessionPlacements, _$identity);

  /// Serializes this SessionPlacements to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SessionPlacements;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionPlacements&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&const DeepCollectionEquality().equals(other.placements, _this.placements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SessionPlacements;
  return Object.hash(runtimeType,_this.sessionId,_this.startedAt,const DeepCollectionEquality().hash(_this.placements));
}

@override
String toString() {
  final _this = this as SessionPlacements;
  return 'SessionPlacements(sessionId: ${_this.sessionId}, startedAt: ${_this.startedAt}, placements: ${_this.placements})';
}


}

/// @nodoc
abstract mixin class $SessionPlacementsCopyWith<$Res>  {
  factory $SessionPlacementsCopyWith(SessionPlacements value, $Res Function(SessionPlacements) _then) = _$SessionPlacementsCopyWithImpl;
@useResult
$Res call({
 String sessionId, DateTime startedAt, List<Placement> placements
});




}
/// @nodoc
class _$SessionPlacementsCopyWithImpl<$Res>
    implements $SessionPlacementsCopyWith<$Res> {
  _$SessionPlacementsCopyWithImpl(this._self, this._then);

  final SessionPlacements _self;
  final $Res Function(SessionPlacements) _then;

/// Create a copy of SessionPlacements
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? startedAt = null,Object? placements = null,}) {
  return _then(SessionPlacements(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,placements: null == placements ? _self.placements : placements // ignore: cast_nullable_to_non_nullable
as List<Placement>,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionPlacements].
extension SessionPlacementsPatterns on SessionPlacements {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionPlacements value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionPlacements() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionPlacements value)  $default,){
final _that = this;
switch (_that) {
case _SessionPlacements():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionPlacements value)?  $default,){
final _that = this;
switch (_that) {
case _SessionPlacements() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  DateTime startedAt,  List<Placement> placements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionPlacements() when $default != null:
return $default(_that.sessionId,_that.startedAt,_that.placements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  DateTime startedAt,  List<Placement> placements)  $default,) {final _that = this;
switch (_that) {
case _SessionPlacements():
return $default(_that.sessionId,_that.startedAt,_that.placements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  DateTime startedAt,  List<Placement> placements)?  $default,) {final _that = this;
switch (_that) {
case _SessionPlacements() when $default != null:
return $default(_that.sessionId,_that.startedAt,_that.placements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionPlacements implements SessionPlacements {
  const _SessionPlacements({required this.sessionId, required this.startedAt,  List<Placement> placements = const <Placement>[]}): _placements = placements;
  factory _SessionPlacements.fromJson(Map<String, dynamic> json) => _$SessionPlacementsFromJson(json);

@override final  String sessionId;
@override final  DateTime startedAt;
 final  List<Placement> _placements;
@override@JsonKey() List<Placement> get placements {
  if (_placements is EqualUnmodifiableListView) return _placements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placements);
}


/// Create a copy of SessionPlacements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionPlacementsCopyWith<_SessionPlacements> get copyWith => __$SessionPlacementsCopyWithImpl<_SessionPlacements>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionPlacementsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionPlacements&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&const DeepCollectionEquality().equals(other.placements, _placements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,startedAt,const DeepCollectionEquality().hash(_placements));
}

@override
String toString() {
    return 'SessionPlacements(sessionId: $sessionId, startedAt: $startedAt, placements: $placements)';
}


}

/// @nodoc
abstract mixin class _$SessionPlacementsCopyWith<$Res> implements $SessionPlacementsCopyWith<$Res> {
  factory _$SessionPlacementsCopyWith(_SessionPlacements value, $Res Function(_SessionPlacements) _then) = __$SessionPlacementsCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, DateTime startedAt, List<Placement> placements
});




}
/// @nodoc
class __$SessionPlacementsCopyWithImpl<$Res>
    implements _$SessionPlacementsCopyWith<$Res> {
  __$SessionPlacementsCopyWithImpl(this._self, this._then);

  final _SessionPlacements _self;
  final $Res Function(_SessionPlacements) _then;

/// Create a copy of SessionPlacements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? startedAt = null,Object? placements = null,}) {
  return _then(_SessionPlacements(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,placements: null == placements ? _self._placements : placements // ignore: cast_nullable_to_non_nullable
as List<Placement>,
  ));
}


}


/// @nodoc
mixin _$Placement {

 String get spoutId; String get animalId;
/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacementCopyWith<Placement> get copyWith => _$PlacementCopyWithImpl<Placement>(this as Placement, _$identity);

  /// Serializes this Placement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Placement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Placement&&(identical(other.spoutId, _this.spoutId) || other.spoutId == _this.spoutId)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Placement;
  return Object.hash(runtimeType,_this.spoutId,_this.animalId);
}

@override
String toString() {
  final _this = this as Placement;
  return 'Placement(spoutId: ${_this.spoutId}, animalId: ${_this.animalId})';
}


}

/// @nodoc
abstract mixin class $PlacementCopyWith<$Res>  {
  factory $PlacementCopyWith(Placement value, $Res Function(Placement) _then) = _$PlacementCopyWithImpl;
@useResult
$Res call({
 String spoutId, String animalId
});




}
/// @nodoc
class _$PlacementCopyWithImpl<$Res>
    implements $PlacementCopyWith<$Res> {
  _$PlacementCopyWithImpl(this._self, this._then);

  final Placement _self;
  final $Res Function(Placement) _then;

/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spoutId = null,Object? animalId = null,}) {
  return _then(Placement(
spoutId: null == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Placement].
extension PlacementPatterns on Placement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Placement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Placement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Placement value)  $default,){
final _that = this;
switch (_that) {
case _Placement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Placement value)?  $default,){
final _that = this;
switch (_that) {
case _Placement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String spoutId,  String animalId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Placement() when $default != null:
return $default(_that.spoutId,_that.animalId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String spoutId,  String animalId)  $default,) {final _that = this;
switch (_that) {
case _Placement():
return $default(_that.spoutId,_that.animalId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String spoutId,  String animalId)?  $default,) {final _that = this;
switch (_that) {
case _Placement() when $default != null:
return $default(_that.spoutId,_that.animalId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Placement implements Placement {
  const _Placement({required this.spoutId, required this.animalId});
  factory _Placement.fromJson(Map<String, dynamic> json) => _$PlacementFromJson(json);

@override final  String spoutId;
@override final  String animalId;

/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacementCopyWith<_Placement> get copyWith => __$PlacementCopyWithImpl<_Placement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Placement&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.animalId, animalId) || other.animalId == animalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,spoutId,animalId);
}

@override
String toString() {
    return 'Placement(spoutId: $spoutId, animalId: $animalId)';
}


}

/// @nodoc
abstract mixin class _$PlacementCopyWith<$Res> implements $PlacementCopyWith<$Res> {
  factory _$PlacementCopyWith(_Placement value, $Res Function(_Placement) _then) = __$PlacementCopyWithImpl;
@override @useResult
$Res call({
 String spoutId, String animalId
});




}
/// @nodoc
class __$PlacementCopyWithImpl<$Res>
    implements _$PlacementCopyWith<$Res> {
  __$PlacementCopyWithImpl(this._self, this._then);

  final _Placement _self;
  final $Res Function(_Placement) _then;

/// Create a copy of Placement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spoutId = null,Object? animalId = null,}) {
  return _then(_Placement(
spoutId: null == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
