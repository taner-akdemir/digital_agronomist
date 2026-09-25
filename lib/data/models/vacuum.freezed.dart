// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacuum.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Vacuum {

 String get id; String get hallId; String get name; int get totalSpouts;
/// Create a copy of Vacuum
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacuumCopyWith<Vacuum> get copyWith => _$VacuumCopyWithImpl<Vacuum>(this as Vacuum, _$identity);

  /// Serializes this Vacuum to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Vacuum;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vacuum&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.hallId, _this.hallId) || other.hallId == _this.hallId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.totalSpouts, _this.totalSpouts) || other.totalSpouts == _this.totalSpouts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Vacuum;
  return Object.hash(runtimeType,_this.id,_this.hallId,_this.name,_this.totalSpouts);
}

@override
String toString() {
  final _this = this as Vacuum;
  return 'Vacuum(id: ${_this.id}, hallId: ${_this.hallId}, name: ${_this.name}, totalSpouts: ${_this.totalSpouts})';
}


}

/// @nodoc
abstract mixin class $VacuumCopyWith<$Res>  {
  factory $VacuumCopyWith(Vacuum value, $Res Function(Vacuum) _then) = _$VacuumCopyWithImpl;
@useResult
$Res call({
 String id, String hallId, String name, int totalSpouts
});




}
/// @nodoc
class _$VacuumCopyWithImpl<$Res>
    implements $VacuumCopyWith<$Res> {
  _$VacuumCopyWithImpl(this._self, this._then);

  final Vacuum _self;
  final $Res Function(Vacuum) _then;

/// Create a copy of Vacuum
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hallId = null,Object? name = null,Object? totalSpouts = null,}) {
  return _then(Vacuum(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hallId: null == hallId ? _self.hallId : hallId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalSpouts: null == totalSpouts ? _self.totalSpouts : totalSpouts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Vacuum].
extension VacuumPatterns on Vacuum {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vacuum value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vacuum() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vacuum value)  $default,){
final _that = this;
switch (_that) {
case _Vacuum():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vacuum value)?  $default,){
final _that = this;
switch (_that) {
case _Vacuum() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String hallId,  String name,  int totalSpouts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vacuum() when $default != null:
return $default(_that.id,_that.hallId,_that.name,_that.totalSpouts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String hallId,  String name,  int totalSpouts)  $default,) {final _that = this;
switch (_that) {
case _Vacuum():
return $default(_that.id,_that.hallId,_that.name,_that.totalSpouts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String hallId,  String name,  int totalSpouts)?  $default,) {final _that = this;
switch (_that) {
case _Vacuum() when $default != null:
return $default(_that.id,_that.hallId,_that.name,_that.totalSpouts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Vacuum implements Vacuum {
  const _Vacuum({required this.id, required this.hallId, required this.name, this.totalSpouts = 0});
  factory _Vacuum.fromJson(Map<String, dynamic> json) => _$VacuumFromJson(json);

@override final  String id;
@override final  String hallId;
@override final  String name;
@override@JsonKey() final  int totalSpouts;

/// Create a copy of Vacuum
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacuumCopyWith<_Vacuum> get copyWith => __$VacuumCopyWithImpl<_Vacuum>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VacuumToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vacuum&&(identical(other.id, id) || other.id == id)&&(identical(other.hallId, hallId) || other.hallId == hallId)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalSpouts, totalSpouts) || other.totalSpouts == totalSpouts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,hallId,name,totalSpouts);
}

@override
String toString() {
    return 'Vacuum(id: $id, hallId: $hallId, name: $name, totalSpouts: $totalSpouts)';
}


}

/// @nodoc
abstract mixin class _$VacuumCopyWith<$Res> implements $VacuumCopyWith<$Res> {
  factory _$VacuumCopyWith(_Vacuum value, $Res Function(_Vacuum) _then) = __$VacuumCopyWithImpl;
@override @useResult
$Res call({
 String id, String hallId, String name, int totalSpouts
});




}
/// @nodoc
class __$VacuumCopyWithImpl<$Res>
    implements _$VacuumCopyWith<$Res> {
  __$VacuumCopyWithImpl(this._self, this._then);

  final _Vacuum _self;
  final $Res Function(_Vacuum) _then;

/// Create a copy of Vacuum
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hallId = null,Object? name = null,Object? totalSpouts = null,}) {
  return _then(_Vacuum(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hallId: null == hallId ? _self.hallId : hallId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalSpouts: null == totalSpouts ? _self.totalSpouts : totalSpouts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
