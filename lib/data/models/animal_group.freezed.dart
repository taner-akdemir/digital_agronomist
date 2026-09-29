// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimalGroup {

 String get id; String get name;/// Gruptaki sağmal hayvan sayısı.
 int get animals;
/// Create a copy of AnimalGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalGroupCopyWith<AnimalGroup> get copyWith => _$AnimalGroupCopyWithImpl<AnimalGroup>(this as AnimalGroup, _$identity);

  /// Serializes this AnimalGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalGroup;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalGroup&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.animals, _this.animals) || other.animals == _this.animals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalGroup;
  return Object.hash(runtimeType,_this.id,_this.name,_this.animals);
}

@override
String toString() {
  final _this = this as AnimalGroup;
  return 'AnimalGroup(id: ${_this.id}, name: ${_this.name}, animals: ${_this.animals})';
}


}

/// @nodoc
abstract mixin class $AnimalGroupCopyWith<$Res>  {
  factory $AnimalGroupCopyWith(AnimalGroup value, $Res Function(AnimalGroup) _then) = _$AnimalGroupCopyWithImpl;
@useResult
$Res call({
 String id, String name, int animals
});




}
/// @nodoc
class _$AnimalGroupCopyWithImpl<$Res>
    implements $AnimalGroupCopyWith<$Res> {
  _$AnimalGroupCopyWithImpl(this._self, this._then);

  final AnimalGroup _self;
  final $Res Function(AnimalGroup) _then;

/// Create a copy of AnimalGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? animals = null,}) {
  return _then(AnimalGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalGroup].
extension AnimalGroupPatterns on AnimalGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalGroup value)  $default,){
final _that = this;
switch (_that) {
case _AnimalGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalGroup value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int animals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalGroup() when $default != null:
return $default(_that.id,_that.name,_that.animals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int animals)  $default,) {final _that = this;
switch (_that) {
case _AnimalGroup():
return $default(_that.id,_that.name,_that.animals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int animals)?  $default,) {final _that = this;
switch (_that) {
case _AnimalGroup() when $default != null:
return $default(_that.id,_that.name,_that.animals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalGroup implements AnimalGroup {
  const _AnimalGroup({required this.id, required this.name, this.animals = 0});
  factory _AnimalGroup.fromJson(Map<String, dynamic> json) => _$AnimalGroupFromJson(json);

@override final  String id;
@override final  String name;
/// Gruptaki sağmal hayvan sayısı.
@override@JsonKey() final  int animals;

/// Create a copy of AnimalGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalGroupCopyWith<_AnimalGroup> get copyWith => __$AnimalGroupCopyWithImpl<_AnimalGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalGroupToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.animals, animals) || other.animals == animals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,animals);
}

@override
String toString() {
    return 'AnimalGroup(id: $id, name: $name, animals: $animals)';
}


}

/// @nodoc
abstract mixin class _$AnimalGroupCopyWith<$Res> implements $AnimalGroupCopyWith<$Res> {
  factory _$AnimalGroupCopyWith(_AnimalGroup value, $Res Function(_AnimalGroup) _then) = __$AnimalGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int animals
});




}
/// @nodoc
class __$AnimalGroupCopyWithImpl<$Res>
    implements _$AnimalGroupCopyWith<$Res> {
  __$AnimalGroupCopyWithImpl(this._self, this._then);

  final _AnimalGroup _self;
  final $Res Function(_AnimalGroup) _then;

/// Create a copy of AnimalGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? animals = null,}) {
  return _then(_AnimalGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
