// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceProfile {

 String get id;/// Üretici kodu, ör. `MILKTRACE`, `ORNEK-URETICI`.
 String get vendor; String get model;/// mqtt | modbus-rtu | modbus-tcp | http (§9.0)
 String get protocol; int get version;/// approved | draft | deprecated
 String get status;
/// Create a copy of DeviceProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceProfileCopyWith<DeviceProfile> get copyWith => _$DeviceProfileCopyWithImpl<DeviceProfile>(this as DeviceProfile, _$identity);

  /// Serializes this DeviceProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.model, model) || other.model == model)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.version, version) || other.version == version)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vendor,model,protocol,version,status);

@override
String toString() {
  return 'DeviceProfile(id: $id, vendor: $vendor, model: $model, protocol: $protocol, version: $version, status: $status)';
}


}

/// @nodoc
abstract mixin class $DeviceProfileCopyWith<$Res>  {
  factory $DeviceProfileCopyWith(DeviceProfile value, $Res Function(DeviceProfile) _then) = _$DeviceProfileCopyWithImpl;
@useResult
$Res call({
 String id, String vendor, String model, String protocol, int version, String status
});




}
/// @nodoc
class _$DeviceProfileCopyWithImpl<$Res>
    implements $DeviceProfileCopyWith<$Res> {
  _$DeviceProfileCopyWithImpl(this._self, this._then);

  final DeviceProfile _self;
  final $Res Function(DeviceProfile) _then;

/// Create a copy of DeviceProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vendor = null,Object? model = null,Object? protocol = null,Object? version = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceProfile].
extension DeviceProfilePatterns on DeviceProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceProfile value)  $default,){
final _that = this;
switch (_that) {
case _DeviceProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceProfile value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vendor,  String model,  String protocol,  int version,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceProfile() when $default != null:
return $default(_that.id,_that.vendor,_that.model,_that.protocol,_that.version,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vendor,  String model,  String protocol,  int version,  String status)  $default,) {final _that = this;
switch (_that) {
case _DeviceProfile():
return $default(_that.id,_that.vendor,_that.model,_that.protocol,_that.version,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vendor,  String model,  String protocol,  int version,  String status)?  $default,) {final _that = this;
switch (_that) {
case _DeviceProfile() when $default != null:
return $default(_that.id,_that.vendor,_that.model,_that.protocol,_that.version,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceProfile extends DeviceProfile {
  const _DeviceProfile({required this.id, this.vendor = '', this.model = '', this.protocol = '', this.version = 1, this.status = 'approved'}): super._();
  factory _DeviceProfile.fromJson(Map<String, dynamic> json) => _$DeviceProfileFromJson(json);

@override final  String id;
/// Üretici kodu, ör. `MILKTRACE`, `ORNEK-URETICI`.
@override@JsonKey() final  String vendor;
@override@JsonKey() final  String model;
/// mqtt | modbus-rtu | modbus-tcp | http (§9.0)
@override@JsonKey() final  String protocol;
@override@JsonKey() final  int version;
/// approved | draft | deprecated
@override@JsonKey() final  String status;

/// Create a copy of DeviceProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceProfileCopyWith<_DeviceProfile> get copyWith => __$DeviceProfileCopyWithImpl<_DeviceProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.model, model) || other.model == model)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.version, version) || other.version == version)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vendor,model,protocol,version,status);

@override
String toString() {
  return 'DeviceProfile(id: $id, vendor: $vendor, model: $model, protocol: $protocol, version: $version, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DeviceProfileCopyWith<$Res> implements $DeviceProfileCopyWith<$Res> {
  factory _$DeviceProfileCopyWith(_DeviceProfile value, $Res Function(_DeviceProfile) _then) = __$DeviceProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String vendor, String model, String protocol, int version, String status
});




}
/// @nodoc
class __$DeviceProfileCopyWithImpl<$Res>
    implements _$DeviceProfileCopyWith<$Res> {
  __$DeviceProfileCopyWithImpl(this._self, this._then);

  final _DeviceProfile _self;
  final $Res Function(_DeviceProfile) _then;

/// Create a copy of DeviceProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vendor = null,Object? model = null,Object? protocol = null,Object? version = null,Object? status = null,}) {
  return _then(_DeviceProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
