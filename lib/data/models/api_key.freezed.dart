// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiKey {

 String get id; String get name; String get prefix; DateTime? get createdAt; DateTime? get lastUsedAt; String get createdBy;
/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiKeyCopyWith<ApiKey> get copyWith => _$ApiKeyCopyWithImpl<ApiKey>(this as ApiKey, _$identity);

  /// Serializes this ApiKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiKey;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiKey&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.prefix, _this.prefix) || other.prefix == _this.prefix)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.lastUsedAt, _this.lastUsedAt) || other.lastUsedAt == _this.lastUsedAt)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiKey;
  return Object.hash(runtimeType,_this.id,_this.name,_this.prefix,_this.createdAt,_this.lastUsedAt,_this.createdBy);
}

@override
String toString() {
  final _this = this as ApiKey;
  return 'ApiKey(id: ${_this.id}, name: ${_this.name}, prefix: ${_this.prefix}, createdAt: ${_this.createdAt}, lastUsedAt: ${_this.lastUsedAt}, createdBy: ${_this.createdBy})';
}


}

/// @nodoc
abstract mixin class $ApiKeyCopyWith<$Res>  {
  factory $ApiKeyCopyWith(ApiKey value, $Res Function(ApiKey) _then) = _$ApiKeyCopyWithImpl;
@useResult
$Res call({
 String id, String name, String prefix, DateTime? createdAt, DateTime? lastUsedAt, String createdBy
});




}
/// @nodoc
class _$ApiKeyCopyWithImpl<$Res>
    implements $ApiKeyCopyWith<$Res> {
  _$ApiKeyCopyWithImpl(this._self, this._then);

  final ApiKey _self;
  final $Res Function(ApiKey) _then;

/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? prefix = null,Object? createdAt = freezed,Object? lastUsedAt = freezed,Object? createdBy = null,}) {
  return _then(ApiKey(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiKey].
extension ApiKeyPatterns on ApiKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiKey value)  $default,){
final _that = this;
switch (_that) {
case _ApiKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiKey value)?  $default,){
final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String prefix,  DateTime? createdAt,  DateTime? lastUsedAt,  String createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
return $default(_that.id,_that.name,_that.prefix,_that.createdAt,_that.lastUsedAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String prefix,  DateTime? createdAt,  DateTime? lastUsedAt,  String createdBy)  $default,) {final _that = this;
switch (_that) {
case _ApiKey():
return $default(_that.id,_that.name,_that.prefix,_that.createdAt,_that.lastUsedAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String prefix,  DateTime? createdAt,  DateTime? lastUsedAt,  String createdBy)?  $default,) {final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
return $default(_that.id,_that.name,_that.prefix,_that.createdAt,_that.lastUsedAt,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiKey extends ApiKey {
  const _ApiKey({required this.id, required this.name, required this.prefix, this.createdAt, this.lastUsedAt, this.createdBy = ''}): super._();
  factory _ApiKey.fromJson(Map<String, dynamic> json) => _$ApiKeyFromJson(json);

@override final  String id;
@override final  String name;
@override final  String prefix;
@override final  DateTime? createdAt;
@override final  DateTime? lastUsedAt;
@override@JsonKey() final  String createdBy;

/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiKeyCopyWith<_ApiKey> get copyWith => __$ApiKeyCopyWithImpl<_ApiKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiKeyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiKey&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.prefix, prefix) || other.prefix == prefix)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,prefix,createdAt,lastUsedAt,createdBy);
}

@override
String toString() {
    return 'ApiKey(id: $id, name: $name, prefix: $prefix, createdAt: $createdAt, lastUsedAt: $lastUsedAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$ApiKeyCopyWith<$Res> implements $ApiKeyCopyWith<$Res> {
  factory _$ApiKeyCopyWith(_ApiKey value, $Res Function(_ApiKey) _then) = __$ApiKeyCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String prefix, DateTime? createdAt, DateTime? lastUsedAt, String createdBy
});




}
/// @nodoc
class __$ApiKeyCopyWithImpl<$Res>
    implements _$ApiKeyCopyWith<$Res> {
  __$ApiKeyCopyWithImpl(this._self, this._then);

  final _ApiKey _self;
  final $Res Function(_ApiKey) _then;

/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? prefix = null,Object? createdAt = freezed,Object? lastUsedAt = freezed,Object? createdBy = null,}) {
  return _then(_ApiKey(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ApiKeyCreated {

 ApiKey get key; String get token;
/// Create a copy of ApiKeyCreated
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiKeyCreatedCopyWith<ApiKeyCreated> get copyWith => _$ApiKeyCreatedCopyWithImpl<ApiKeyCreated>(this as ApiKeyCreated, _$identity);

  /// Serializes this ApiKeyCreated to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiKeyCreated;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiKeyCreated&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.token, _this.token) || other.token == _this.token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiKeyCreated;
  return Object.hash(runtimeType,_this.key,_this.token);
}

@override
String toString() {
  final _this = this as ApiKeyCreated;
  return 'ApiKeyCreated(key: ${_this.key}, token: ${_this.token})';
}


}

/// @nodoc
abstract mixin class $ApiKeyCreatedCopyWith<$Res>  {
  factory $ApiKeyCreatedCopyWith(ApiKeyCreated value, $Res Function(ApiKeyCreated) _then) = _$ApiKeyCreatedCopyWithImpl;
@useResult
$Res call({
 ApiKey key, String token
});


$ApiKeyCopyWith<$Res> get key;

}
/// @nodoc
class _$ApiKeyCreatedCopyWithImpl<$Res>
    implements $ApiKeyCreatedCopyWith<$Res> {
  _$ApiKeyCreatedCopyWithImpl(this._self, this._then);

  final ApiKeyCreated _self;
  final $Res Function(ApiKeyCreated) _then;

/// Create a copy of ApiKeyCreated
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? token = null,}) {
  return _then(ApiKeyCreated(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as ApiKey,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ApiKeyCreated
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiKeyCopyWith<$Res> get key {
  
  return $ApiKeyCopyWith<$Res>(_self.key, (value) {
    return _then(_self.copyWith(key: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApiKeyCreated].
extension ApiKeyCreatedPatterns on ApiKeyCreated {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiKeyCreated value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiKeyCreated() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiKeyCreated value)  $default,){
final _that = this;
switch (_that) {
case _ApiKeyCreated():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiKeyCreated value)?  $default,){
final _that = this;
switch (_that) {
case _ApiKeyCreated() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiKey key,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiKeyCreated() when $default != null:
return $default(_that.key,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiKey key,  String token)  $default,) {final _that = this;
switch (_that) {
case _ApiKeyCreated():
return $default(_that.key,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiKey key,  String token)?  $default,) {final _that = this;
switch (_that) {
case _ApiKeyCreated() when $default != null:
return $default(_that.key,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiKeyCreated implements ApiKeyCreated {
  const _ApiKeyCreated({required this.key, required this.token});
  factory _ApiKeyCreated.fromJson(Map<String, dynamic> json) => _$ApiKeyCreatedFromJson(json);

@override final  ApiKey key;
@override final  String token;

/// Create a copy of ApiKeyCreated
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiKeyCreatedCopyWith<_ApiKeyCreated> get copyWith => __$ApiKeyCreatedCopyWithImpl<_ApiKeyCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiKeyCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiKeyCreated&&(identical(other.key, key) || other.key == key)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,key,token);
}

@override
String toString() {
    return 'ApiKeyCreated(key: $key, token: $token)';
}


}

/// @nodoc
abstract mixin class _$ApiKeyCreatedCopyWith<$Res> implements $ApiKeyCreatedCopyWith<$Res> {
  factory _$ApiKeyCreatedCopyWith(_ApiKeyCreated value, $Res Function(_ApiKeyCreated) _then) = __$ApiKeyCreatedCopyWithImpl;
@override @useResult
$Res call({
 ApiKey key, String token
});


@override $ApiKeyCopyWith<$Res> get key;

}
/// @nodoc
class __$ApiKeyCreatedCopyWithImpl<$Res>
    implements _$ApiKeyCreatedCopyWith<$Res> {
  __$ApiKeyCreatedCopyWithImpl(this._self, this._then);

  final _ApiKeyCreated _self;
  final $Res Function(_ApiKeyCreated) _then;

/// Create a copy of ApiKeyCreated
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? token = null,}) {
  return _then(_ApiKeyCreated(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as ApiKey,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ApiKeyCreated
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiKeyCopyWith<$Res> get key {
  
  return $ApiKeyCopyWith<$Res>(_self.key, (value) {
    return _then(_self.copyWith(key: value));
  });
}
}

// dart format on
