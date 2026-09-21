// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Device {

 String get id;/// Seri numarası; cihazı tanımlayan tek alan (§9.2 topic'lerinde geçer).
 String get serialNo;/// Takılı olduğu nokta; stokta bekleyen cihazda null.
 String? get spoutId; String get status; String? get firmware; double get calibrationFactor; DateTime? get lastSeenAt; bool get isSimulated;
/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceCopyWith<Device> get copyWith => _$DeviceCopyWithImpl<Device>(this as Device, _$identity);

  /// Serializes this Device to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Device&&(identical(other.id, id) || other.id == id)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.status, status) || other.status == status)&&(identical(other.firmware, firmware) || other.firmware == firmware)&&(identical(other.calibrationFactor, calibrationFactor) || other.calibrationFactor == calibrationFactor)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.isSimulated, isSimulated) || other.isSimulated == isSimulated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serialNo,spoutId,status,firmware,calibrationFactor,lastSeenAt,isSimulated);

@override
String toString() {
  return 'Device(id: $id, serialNo: $serialNo, spoutId: $spoutId, status: $status, firmware: $firmware, calibrationFactor: $calibrationFactor, lastSeenAt: $lastSeenAt, isSimulated: $isSimulated)';
}


}

/// @nodoc
abstract mixin class $DeviceCopyWith<$Res>  {
  factory $DeviceCopyWith(Device value, $Res Function(Device) _then) = _$DeviceCopyWithImpl;
@useResult
$Res call({
 String id, String serialNo, String? spoutId, String status, String? firmware, double calibrationFactor, DateTime? lastSeenAt, bool isSimulated
});




}
/// @nodoc
class _$DeviceCopyWithImpl<$Res>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._self, this._then);

  final Device _self;
  final $Res Function(Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serialNo = null,Object? spoutId = freezed,Object? status = null,Object? firmware = freezed,Object? calibrationFactor = null,Object? lastSeenAt = freezed,Object? isSimulated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as String,spoutId: freezed == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,firmware: freezed == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String?,calibrationFactor: null == calibrationFactor ? _self.calibrationFactor : calibrationFactor // ignore: cast_nullable_to_non_nullable
as double,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSimulated: null == isSimulated ? _self.isSimulated : isSimulated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Device].
extension DevicePatterns on Device {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Device value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Device() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Device value)  $default,){
final _that = this;
switch (_that) {
case _Device():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Device value)?  $default,){
final _that = this;
switch (_that) {
case _Device() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serialNo,  String? spoutId,  String status,  String? firmware,  double calibrationFactor,  DateTime? lastSeenAt,  bool isSimulated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.id,_that.serialNo,_that.spoutId,_that.status,_that.firmware,_that.calibrationFactor,_that.lastSeenAt,_that.isSimulated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serialNo,  String? spoutId,  String status,  String? firmware,  double calibrationFactor,  DateTime? lastSeenAt,  bool isSimulated)  $default,) {final _that = this;
switch (_that) {
case _Device():
return $default(_that.id,_that.serialNo,_that.spoutId,_that.status,_that.firmware,_that.calibrationFactor,_that.lastSeenAt,_that.isSimulated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serialNo,  String? spoutId,  String status,  String? firmware,  double calibrationFactor,  DateTime? lastSeenAt,  bool isSimulated)?  $default,) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.id,_that.serialNo,_that.spoutId,_that.status,_that.firmware,_that.calibrationFactor,_that.lastSeenAt,_that.isSimulated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Device implements Device {
  const _Device({required this.id, required this.serialNo, this.spoutId, this.status = 'unknown', this.firmware, this.calibrationFactor = 1.0, this.lastSeenAt, this.isSimulated = false});
  factory _Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

@override final  String id;
/// Seri numarası; cihazı tanımlayan tek alan (§9.2 topic'lerinde geçer).
@override final  String serialNo;
/// Takılı olduğu nokta; stokta bekleyen cihazda null.
@override final  String? spoutId;
@override@JsonKey() final  String status;
@override final  String? firmware;
@override@JsonKey() final  double calibrationFactor;
@override final  DateTime? lastSeenAt;
@override@JsonKey() final  bool isSimulated;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceCopyWith<_Device> get copyWith => __$DeviceCopyWithImpl<_Device>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Device&&(identical(other.id, id) || other.id == id)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.spoutId, spoutId) || other.spoutId == spoutId)&&(identical(other.status, status) || other.status == status)&&(identical(other.firmware, firmware) || other.firmware == firmware)&&(identical(other.calibrationFactor, calibrationFactor) || other.calibrationFactor == calibrationFactor)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.isSimulated, isSimulated) || other.isSimulated == isSimulated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serialNo,spoutId,status,firmware,calibrationFactor,lastSeenAt,isSimulated);

@override
String toString() {
  return 'Device(id: $id, serialNo: $serialNo, spoutId: $spoutId, status: $status, firmware: $firmware, calibrationFactor: $calibrationFactor, lastSeenAt: $lastSeenAt, isSimulated: $isSimulated)';
}


}

/// @nodoc
abstract mixin class _$DeviceCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceCopyWith(_Device value, $Res Function(_Device) _then) = __$DeviceCopyWithImpl;
@override @useResult
$Res call({
 String id, String serialNo, String? spoutId, String status, String? firmware, double calibrationFactor, DateTime? lastSeenAt, bool isSimulated
});




}
/// @nodoc
class __$DeviceCopyWithImpl<$Res>
    implements _$DeviceCopyWith<$Res> {
  __$DeviceCopyWithImpl(this._self, this._then);

  final _Device _self;
  final $Res Function(_Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serialNo = null,Object? spoutId = freezed,Object? status = null,Object? firmware = freezed,Object? calibrationFactor = null,Object? lastSeenAt = freezed,Object? isSimulated = null,}) {
  return _then(_Device(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as String,spoutId: freezed == spoutId ? _self.spoutId : spoutId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,firmware: freezed == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String?,calibrationFactor: null == calibrationFactor ? _self.calibrationFactor : calibrationFactor // ignore: cast_nullable_to_non_nullable
as double,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSimulated: null == isSimulated ? _self.isSimulated : isSimulated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
