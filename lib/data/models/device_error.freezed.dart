// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceError {

/// Üreticinin hata kodu (E17 gibi), backend'in süzdüğü hâliyle.
 String get code;/// Kodun anlamı, profilin hata kodu tablosundan (backend ADR 0043);
/// tabloda yoksa null ve kod ham gösterilir. Uygulama kendi metnini
/// uydurmaz (§16).
 String? get description; DateTime get at;
/// Create a copy of DeviceError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceErrorCopyWith<DeviceError> get copyWith => _$DeviceErrorCopyWithImpl<DeviceError>(this as DeviceError, _$identity);

  /// Serializes this DeviceError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DeviceError;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceError&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.at, _this.at) || other.at == _this.at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeviceError;
  return Object.hash(runtimeType,_this.code,_this.description,_this.at);
}

@override
String toString() {
  final _this = this as DeviceError;
  return 'DeviceError(code: ${_this.code}, description: ${_this.description}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $DeviceErrorCopyWith<$Res>  {
  factory $DeviceErrorCopyWith(DeviceError value, $Res Function(DeviceError) _then) = _$DeviceErrorCopyWithImpl;
@useResult
$Res call({
 String code, String? description, DateTime at
});




}
/// @nodoc
class _$DeviceErrorCopyWithImpl<$Res>
    implements $DeviceErrorCopyWith<$Res> {
  _$DeviceErrorCopyWithImpl(this._self, this._then);

  final DeviceError _self;
  final $Res Function(DeviceError) _then;

/// Create a copy of DeviceError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? description = freezed,Object? at = null,}) {
  return _then(DeviceError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceError].
extension DeviceErrorPatterns on DeviceError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceError value)  $default,){
final _that = this;
switch (_that) {
case _DeviceError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceError value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String? description,  DateTime at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceError() when $default != null:
return $default(_that.code,_that.description,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String? description,  DateTime at)  $default,) {final _that = this;
switch (_that) {
case _DeviceError():
return $default(_that.code,_that.description,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String? description,  DateTime at)?  $default,) {final _that = this;
switch (_that) {
case _DeviceError() when $default != null:
return $default(_that.code,_that.description,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceError implements DeviceError {
  const _DeviceError({required this.code, this.description, required this.at});
  factory _DeviceError.fromJson(Map<String, dynamic> json) => _$DeviceErrorFromJson(json);

/// Üreticinin hata kodu (E17 gibi), backend'in süzdüğü hâliyle.
@override final  String code;
/// Kodun anlamı, profilin hata kodu tablosundan (backend ADR 0043);
/// tabloda yoksa null ve kod ham gösterilir. Uygulama kendi metnini
/// uydurmaz (§16).
@override final  String? description;
@override final  DateTime at;

/// Create a copy of DeviceError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceErrorCopyWith<_DeviceError> get copyWith => __$DeviceErrorCopyWithImpl<_DeviceError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceErrorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceError&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,description,at);
}

@override
String toString() {
    return 'DeviceError(code: $code, description: $description, at: $at)';
}


}

/// @nodoc
abstract mixin class _$DeviceErrorCopyWith<$Res> implements $DeviceErrorCopyWith<$Res> {
  factory _$DeviceErrorCopyWith(_DeviceError value, $Res Function(_DeviceError) _then) = __$DeviceErrorCopyWithImpl;
@override @useResult
$Res call({
 String code, String? description, DateTime at
});




}
/// @nodoc
class __$DeviceErrorCopyWithImpl<$Res>
    implements _$DeviceErrorCopyWith<$Res> {
  __$DeviceErrorCopyWithImpl(this._self, this._then);

  final _DeviceError _self;
  final $Res Function(_DeviceError) _then;

/// Create a copy of DeviceError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? description = freezed,Object? at = null,}) {
  return _then(_DeviceError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
