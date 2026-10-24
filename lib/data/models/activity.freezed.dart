// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityDevice {

 String get id; String get serial; DateTime? get lastSeen;
/// Create a copy of ActivityDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityDeviceCopyWith<ActivityDevice> get copyWith => _$ActivityDeviceCopyWithImpl<ActivityDevice>(this as ActivityDevice, _$identity);

  /// Serializes this ActivityDevice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityDevice;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityDevice&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.serial, _this.serial) || other.serial == _this.serial)&&(identical(other.lastSeen, _this.lastSeen) || other.lastSeen == _this.lastSeen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityDevice;
  return Object.hash(runtimeType,_this.id,_this.serial,_this.lastSeen);
}

@override
String toString() {
  final _this = this as ActivityDevice;
  return 'ActivityDevice(id: ${_this.id}, serial: ${_this.serial}, lastSeen: ${_this.lastSeen})';
}


}

/// @nodoc
abstract mixin class $ActivityDeviceCopyWith<$Res>  {
  factory $ActivityDeviceCopyWith(ActivityDevice value, $Res Function(ActivityDevice) _then) = _$ActivityDeviceCopyWithImpl;
@useResult
$Res call({
 String id, String serial, DateTime? lastSeen
});




}
/// @nodoc
class _$ActivityDeviceCopyWithImpl<$Res>
    implements $ActivityDeviceCopyWith<$Res> {
  _$ActivityDeviceCopyWithImpl(this._self, this._then);

  final ActivityDevice _self;
  final $Res Function(ActivityDevice) _then;

/// Create a copy of ActivityDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serial = null,Object? lastSeen = freezed,}) {
  return _then(ActivityDevice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityDevice].
extension ActivityDevicePatterns on ActivityDevice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityDevice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityDevice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityDevice value)  $default,){
final _that = this;
switch (_that) {
case _ActivityDevice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityDevice value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityDevice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serial,  DateTime? lastSeen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityDevice() when $default != null:
return $default(_that.id,_that.serial,_that.lastSeen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serial,  DateTime? lastSeen)  $default,) {final _that = this;
switch (_that) {
case _ActivityDevice():
return $default(_that.id,_that.serial,_that.lastSeen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serial,  DateTime? lastSeen)?  $default,) {final _that = this;
switch (_that) {
case _ActivityDevice() when $default != null:
return $default(_that.id,_that.serial,_that.lastSeen);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityDevice implements ActivityDevice {
  const _ActivityDevice({required this.id, this.serial = '', this.lastSeen});
  factory _ActivityDevice.fromJson(Map<String, dynamic> json) => _$ActivityDeviceFromJson(json);

@override final  String id;
@override@JsonKey() final  String serial;
@override final  DateTime? lastSeen;

/// Create a copy of ActivityDevice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityDeviceCopyWith<_ActivityDevice> get copyWith => __$ActivityDeviceCopyWithImpl<_ActivityDevice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityDeviceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,serial,lastSeen);
}

@override
String toString() {
    return 'ActivityDevice(id: $id, serial: $serial, lastSeen: $lastSeen)';
}


}

/// @nodoc
abstract mixin class _$ActivityDeviceCopyWith<$Res> implements $ActivityDeviceCopyWith<$Res> {
  factory _$ActivityDeviceCopyWith(_ActivityDevice value, $Res Function(_ActivityDevice) _then) = __$ActivityDeviceCopyWithImpl;
@override @useResult
$Res call({
 String id, String serial, DateTime? lastSeen
});




}
/// @nodoc
class __$ActivityDeviceCopyWithImpl<$Res>
    implements _$ActivityDeviceCopyWith<$Res> {
  __$ActivityDeviceCopyWithImpl(this._self, this._then);

  final _ActivityDevice _self;
  final $Res Function(_ActivityDevice) _then;

/// Create a copy of ActivityDevice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serial = null,Object? lastSeen = freezed,}) {
  return _then(_ActivityDevice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ActivityHour {

 DateTime get hour; int? get steps; double? get activityIndex; double? get ruminationMin;
/// Create a copy of ActivityHour
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityHourCopyWith<ActivityHour> get copyWith => _$ActivityHourCopyWithImpl<ActivityHour>(this as ActivityHour, _$identity);

  /// Serializes this ActivityHour to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityHour;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityHour&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.steps, _this.steps) || other.steps == _this.steps)&&(identical(other.activityIndex, _this.activityIndex) || other.activityIndex == _this.activityIndex)&&(identical(other.ruminationMin, _this.ruminationMin) || other.ruminationMin == _this.ruminationMin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityHour;
  return Object.hash(runtimeType,_this.hour,_this.steps,_this.activityIndex,_this.ruminationMin);
}

@override
String toString() {
  final _this = this as ActivityHour;
  return 'ActivityHour(hour: ${_this.hour}, steps: ${_this.steps}, activityIndex: ${_this.activityIndex}, ruminationMin: ${_this.ruminationMin})';
}


}

/// @nodoc
abstract mixin class $ActivityHourCopyWith<$Res>  {
  factory $ActivityHourCopyWith(ActivityHour value, $Res Function(ActivityHour) _then) = _$ActivityHourCopyWithImpl;
@useResult
$Res call({
 DateTime hour, int? steps, double? activityIndex, double? ruminationMin
});




}
/// @nodoc
class _$ActivityHourCopyWithImpl<$Res>
    implements $ActivityHourCopyWith<$Res> {
  _$ActivityHourCopyWithImpl(this._self, this._then);

  final ActivityHour _self;
  final $Res Function(ActivityHour) _then;

/// Create a copy of ActivityHour
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hour = null,Object? steps = freezed,Object? activityIndex = freezed,Object? ruminationMin = freezed,}) {
  return _then(ActivityHour(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as DateTime,steps: freezed == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as int?,activityIndex: freezed == activityIndex ? _self.activityIndex : activityIndex // ignore: cast_nullable_to_non_nullable
as double?,ruminationMin: freezed == ruminationMin ? _self.ruminationMin : ruminationMin // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityHour].
extension ActivityHourPatterns on ActivityHour {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityHour value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityHour() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityHour value)  $default,){
final _that = this;
switch (_that) {
case _ActivityHour():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityHour value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityHour() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime hour,  int? steps,  double? activityIndex,  double? ruminationMin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityHour() when $default != null:
return $default(_that.hour,_that.steps,_that.activityIndex,_that.ruminationMin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime hour,  int? steps,  double? activityIndex,  double? ruminationMin)  $default,) {final _that = this;
switch (_that) {
case _ActivityHour():
return $default(_that.hour,_that.steps,_that.activityIndex,_that.ruminationMin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime hour,  int? steps,  double? activityIndex,  double? ruminationMin)?  $default,) {final _that = this;
switch (_that) {
case _ActivityHour() when $default != null:
return $default(_that.hour,_that.steps,_that.activityIndex,_that.ruminationMin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityHour implements ActivityHour {
  const _ActivityHour({required this.hour, this.steps, this.activityIndex, this.ruminationMin});
  factory _ActivityHour.fromJson(Map<String, dynamic> json) => _$ActivityHourFromJson(json);

@override final  DateTime hour;
@override final  int? steps;
@override final  double? activityIndex;
@override final  double? ruminationMin;

/// Create a copy of ActivityHour
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityHourCopyWith<_ActivityHour> get copyWith => __$ActivityHourCopyWithImpl<_ActivityHour>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityHourToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityHour&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.activityIndex, activityIndex) || other.activityIndex == activityIndex)&&(identical(other.ruminationMin, ruminationMin) || other.ruminationMin == ruminationMin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,hour,steps,activityIndex,ruminationMin);
}

@override
String toString() {
    return 'ActivityHour(hour: $hour, steps: $steps, activityIndex: $activityIndex, ruminationMin: $ruminationMin)';
}


}

/// @nodoc
abstract mixin class _$ActivityHourCopyWith<$Res> implements $ActivityHourCopyWith<$Res> {
  factory _$ActivityHourCopyWith(_ActivityHour value, $Res Function(_ActivityHour) _then) = __$ActivityHourCopyWithImpl;
@override @useResult
$Res call({
 DateTime hour, int? steps, double? activityIndex, double? ruminationMin
});




}
/// @nodoc
class __$ActivityHourCopyWithImpl<$Res>
    implements _$ActivityHourCopyWith<$Res> {
  __$ActivityHourCopyWithImpl(this._self, this._then);

  final _ActivityHour _self;
  final $Res Function(_ActivityHour) _then;

/// Create a copy of ActivityHour
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? steps = freezed,Object? activityIndex = freezed,Object? ruminationMin = freezed,}) {
  return _then(_ActivityHour(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as DateTime,steps: freezed == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as int?,activityIndex: freezed == activityIndex ? _self.activityIndex : activityIndex // ignore: cast_nullable_to_non_nullable
as double?,ruminationMin: freezed == ruminationMin ? _self.ruminationMin : ruminationMin // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ActivityDay {

 DateTime get day; int? get steps; double? get activityIndex; double? get ruminationMin;
/// Create a copy of ActivityDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityDayCopyWith<ActivityDay> get copyWith => _$ActivityDayCopyWithImpl<ActivityDay>(this as ActivityDay, _$identity);

  /// Serializes this ActivityDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityDay&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.steps, _this.steps) || other.steps == _this.steps)&&(identical(other.activityIndex, _this.activityIndex) || other.activityIndex == _this.activityIndex)&&(identical(other.ruminationMin, _this.ruminationMin) || other.ruminationMin == _this.ruminationMin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityDay;
  return Object.hash(runtimeType,_this.day,_this.steps,_this.activityIndex,_this.ruminationMin);
}

@override
String toString() {
  final _this = this as ActivityDay;
  return 'ActivityDay(day: ${_this.day}, steps: ${_this.steps}, activityIndex: ${_this.activityIndex}, ruminationMin: ${_this.ruminationMin})';
}


}

/// @nodoc
abstract mixin class $ActivityDayCopyWith<$Res>  {
  factory $ActivityDayCopyWith(ActivityDay value, $Res Function(ActivityDay) _then) = _$ActivityDayCopyWithImpl;
@useResult
$Res call({
 DateTime day, int? steps, double? activityIndex, double? ruminationMin
});




}
/// @nodoc
class _$ActivityDayCopyWithImpl<$Res>
    implements $ActivityDayCopyWith<$Res> {
  _$ActivityDayCopyWithImpl(this._self, this._then);

  final ActivityDay _self;
  final $Res Function(ActivityDay) _then;

/// Create a copy of ActivityDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? steps = freezed,Object? activityIndex = freezed,Object? ruminationMin = freezed,}) {
  return _then(ActivityDay(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,steps: freezed == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as int?,activityIndex: freezed == activityIndex ? _self.activityIndex : activityIndex // ignore: cast_nullable_to_non_nullable
as double?,ruminationMin: freezed == ruminationMin ? _self.ruminationMin : ruminationMin // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityDay].
extension ActivityDayPatterns on ActivityDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityDay value)  $default,){
final _that = this;
switch (_that) {
case _ActivityDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityDay value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime day,  int? steps,  double? activityIndex,  double? ruminationMin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityDay() when $default != null:
return $default(_that.day,_that.steps,_that.activityIndex,_that.ruminationMin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime day,  int? steps,  double? activityIndex,  double? ruminationMin)  $default,) {final _that = this;
switch (_that) {
case _ActivityDay():
return $default(_that.day,_that.steps,_that.activityIndex,_that.ruminationMin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime day,  int? steps,  double? activityIndex,  double? ruminationMin)?  $default,) {final _that = this;
switch (_that) {
case _ActivityDay() when $default != null:
return $default(_that.day,_that.steps,_that.activityIndex,_that.ruminationMin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityDay implements ActivityDay {
  const _ActivityDay({required this.day, this.steps, this.activityIndex, this.ruminationMin});
  factory _ActivityDay.fromJson(Map<String, dynamic> json) => _$ActivityDayFromJson(json);

@override final  DateTime day;
@override final  int? steps;
@override final  double? activityIndex;
@override final  double? ruminationMin;

/// Create a copy of ActivityDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityDayCopyWith<_ActivityDay> get copyWith => __$ActivityDayCopyWithImpl<_ActivityDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityDayToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityDay&&(identical(other.day, day) || other.day == day)&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.activityIndex, activityIndex) || other.activityIndex == activityIndex)&&(identical(other.ruminationMin, ruminationMin) || other.ruminationMin == ruminationMin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,day,steps,activityIndex,ruminationMin);
}

@override
String toString() {
    return 'ActivityDay(day: $day, steps: $steps, activityIndex: $activityIndex, ruminationMin: $ruminationMin)';
}


}

/// @nodoc
abstract mixin class _$ActivityDayCopyWith<$Res> implements $ActivityDayCopyWith<$Res> {
  factory _$ActivityDayCopyWith(_ActivityDay value, $Res Function(_ActivityDay) _then) = __$ActivityDayCopyWithImpl;
@override @useResult
$Res call({
 DateTime day, int? steps, double? activityIndex, double? ruminationMin
});




}
/// @nodoc
class __$ActivityDayCopyWithImpl<$Res>
    implements _$ActivityDayCopyWith<$Res> {
  __$ActivityDayCopyWithImpl(this._self, this._then);

  final _ActivityDay _self;
  final $Res Function(_ActivityDay) _then;

/// Create a copy of ActivityDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? steps = freezed,Object? activityIndex = freezed,Object? ruminationMin = freezed,}) {
  return _then(_ActivityDay(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,steps: freezed == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as int?,activityIndex: freezed == activityIndex ? _self.activityIndex : activityIndex // ignore: cast_nullable_to_non_nullable
as double?,ruminationMin: freezed == ruminationMin ? _self.ruminationMin : ruminationMin // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$AnimalActivity {

 String get animalId;/// Bağlı cihaz; tasma takılı değilse null.
 ActivityDevice? get device; List<ActivityHour> get hourly; List<ActivityDay> get daily;/// learning | normal | rising | heat | no_data | pregnant.
 String get status;
/// Create a copy of AnimalActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalActivityCopyWith<AnimalActivity> get copyWith => _$AnimalActivityCopyWithImpl<AnimalActivity>(this as AnimalActivity, _$identity);

  /// Serializes this AnimalActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalActivity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalActivity&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.device, _this.device) || other.device == _this.device)&&const DeepCollectionEquality().equals(other.hourly, _this.hourly)&&const DeepCollectionEquality().equals(other.daily, _this.daily)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalActivity;
  return Object.hash(runtimeType,_this.animalId,_this.device,const DeepCollectionEquality().hash(_this.hourly),const DeepCollectionEquality().hash(_this.daily),_this.status);
}

@override
String toString() {
  final _this = this as AnimalActivity;
  return 'AnimalActivity(animalId: ${_this.animalId}, device: ${_this.device}, hourly: ${_this.hourly}, daily: ${_this.daily}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $AnimalActivityCopyWith<$Res>  {
  factory $AnimalActivityCopyWith(AnimalActivity value, $Res Function(AnimalActivity) _then) = _$AnimalActivityCopyWithImpl;
@useResult
$Res call({
 String animalId, ActivityDevice? device, List<ActivityHour> hourly, List<ActivityDay> daily, String status
});


$ActivityDeviceCopyWith<$Res>? get device;

}
/// @nodoc
class _$AnimalActivityCopyWithImpl<$Res>
    implements $AnimalActivityCopyWith<$Res> {
  _$AnimalActivityCopyWithImpl(this._self, this._then);

  final AnimalActivity _self;
  final $Res Function(AnimalActivity) _then;

/// Create a copy of AnimalActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? device = freezed,Object? hourly = null,Object? daily = null,Object? status = null,}) {
  return _then(AnimalActivity(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,device: freezed == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as ActivityDevice?,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<ActivityHour>,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as List<ActivityDay>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AnimalActivity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityDeviceCopyWith<$Res>? get device {
    if (_self.device == null) {
    return null;
  }

  return $ActivityDeviceCopyWith<$Res>(_self.device!, (value) {
    return _then(_self.copyWith(device: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnimalActivity].
extension AnimalActivityPatterns on AnimalActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalActivity value)  $default,){
final _that = this;
switch (_that) {
case _AnimalActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalActivity value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId,  ActivityDevice? device,  List<ActivityHour> hourly,  List<ActivityDay> daily,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalActivity() when $default != null:
return $default(_that.animalId,_that.device,_that.hourly,_that.daily,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId,  ActivityDevice? device,  List<ActivityHour> hourly,  List<ActivityDay> daily,  String status)  $default,) {final _that = this;
switch (_that) {
case _AnimalActivity():
return $default(_that.animalId,_that.device,_that.hourly,_that.daily,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId,  ActivityDevice? device,  List<ActivityHour> hourly,  List<ActivityDay> daily,  String status)?  $default,) {final _that = this;
switch (_that) {
case _AnimalActivity() when $default != null:
return $default(_that.animalId,_that.device,_that.hourly,_that.daily,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalActivity extends AnimalActivity {
  const _AnimalActivity({required this.animalId, this.device,  List<ActivityHour> hourly = const [],  List<ActivityDay> daily = const [], this.status = 'no_data'}): _hourly = hourly,_daily = daily,super._();
  factory _AnimalActivity.fromJson(Map<String, dynamic> json) => _$AnimalActivityFromJson(json);

@override final  String animalId;
/// Bağlı cihaz; tasma takılı değilse null.
@override final  ActivityDevice? device;
 final  List<ActivityHour> _hourly;
@override@JsonKey() List<ActivityHour> get hourly {
  if (_hourly is EqualUnmodifiableListView) return _hourly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourly);
}

 final  List<ActivityDay> _daily;
@override@JsonKey() List<ActivityDay> get daily {
  if (_daily is EqualUnmodifiableListView) return _daily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daily);
}

/// learning | normal | rising | heat | no_data | pregnant.
@override@JsonKey() final  String status;

/// Create a copy of AnimalActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalActivityCopyWith<_AnimalActivity> get copyWith => __$AnimalActivityCopyWithImpl<_AnimalActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalActivityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalActivity&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.device, device) || other.device == device)&&const DeepCollectionEquality().equals(other.hourly, _hourly)&&const DeepCollectionEquality().equals(other.daily, _daily)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,device,const DeepCollectionEquality().hash(_hourly),const DeepCollectionEquality().hash(_daily),status);
}

@override
String toString() {
    return 'AnimalActivity(animalId: $animalId, device: $device, hourly: $hourly, daily: $daily, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AnimalActivityCopyWith<$Res> implements $AnimalActivityCopyWith<$Res> {
  factory _$AnimalActivityCopyWith(_AnimalActivity value, $Res Function(_AnimalActivity) _then) = __$AnimalActivityCopyWithImpl;
@override @useResult
$Res call({
 String animalId, ActivityDevice? device, List<ActivityHour> hourly, List<ActivityDay> daily, String status
});


@override $ActivityDeviceCopyWith<$Res>? get device;

}
/// @nodoc
class __$AnimalActivityCopyWithImpl<$Res>
    implements _$AnimalActivityCopyWith<$Res> {
  __$AnimalActivityCopyWithImpl(this._self, this._then);

  final _AnimalActivity _self;
  final $Res Function(_AnimalActivity) _then;

/// Create a copy of AnimalActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? device = freezed,Object? hourly = null,Object? daily = null,Object? status = null,}) {
  return _then(_AnimalActivity(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,device: freezed == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as ActivityDevice?,hourly: null == hourly ? _self._hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<ActivityHour>,daily: null == daily ? _self._daily : daily // ignore: cast_nullable_to_non_nullable
as List<ActivityDay>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AnimalActivity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityDeviceCopyWith<$Res>? get device {
    if (_self.device == null) {
    return null;
  }

  return $ActivityDeviceCopyWith<$Res>(_self.device!, (value) {
    return _then(_self.copyWith(device: value));
  });
}
}


/// @nodoc
mixin _$ActivityOverviewRow {

 String get animalId; String get tag; String? get name; String get serial; DateTime? get lastSeen;/// Hayvanın kendi tabanına göre yükseliş yüzdesi; taban yoksa null.
 double? get risePct; String get status; DateTime? get lastHeatDetectedAt;
/// Create a copy of ActivityOverviewRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityOverviewRowCopyWith<ActivityOverviewRow> get copyWith => _$ActivityOverviewRowCopyWithImpl<ActivityOverviewRow>(this as ActivityOverviewRow, _$identity);

  /// Serializes this ActivityOverviewRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityOverviewRow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityOverviewRow&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.serial, _this.serial) || other.serial == _this.serial)&&(identical(other.lastSeen, _this.lastSeen) || other.lastSeen == _this.lastSeen)&&(identical(other.risePct, _this.risePct) || other.risePct == _this.risePct)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.lastHeatDetectedAt, _this.lastHeatDetectedAt) || other.lastHeatDetectedAt == _this.lastHeatDetectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityOverviewRow;
  return Object.hash(runtimeType,_this.animalId,_this.tag,_this.name,_this.serial,_this.lastSeen,_this.risePct,_this.status,_this.lastHeatDetectedAt);
}

@override
String toString() {
  final _this = this as ActivityOverviewRow;
  return 'ActivityOverviewRow(animalId: ${_this.animalId}, tag: ${_this.tag}, name: ${_this.name}, serial: ${_this.serial}, lastSeen: ${_this.lastSeen}, risePct: ${_this.risePct}, status: ${_this.status}, lastHeatDetectedAt: ${_this.lastHeatDetectedAt})';
}


}

/// @nodoc
abstract mixin class $ActivityOverviewRowCopyWith<$Res>  {
  factory $ActivityOverviewRowCopyWith(ActivityOverviewRow value, $Res Function(ActivityOverviewRow) _then) = _$ActivityOverviewRowCopyWithImpl;
@useResult
$Res call({
 String animalId, String tag, String? name, String serial, DateTime? lastSeen, double? risePct, String status, DateTime? lastHeatDetectedAt
});




}
/// @nodoc
class _$ActivityOverviewRowCopyWithImpl<$Res>
    implements $ActivityOverviewRowCopyWith<$Res> {
  _$ActivityOverviewRowCopyWithImpl(this._self, this._then);

  final ActivityOverviewRow _self;
  final $Res Function(ActivityOverviewRow) _then;

/// Create a copy of ActivityOverviewRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? tag = null,Object? name = freezed,Object? serial = null,Object? lastSeen = freezed,Object? risePct = freezed,Object? status = null,Object? lastHeatDetectedAt = freezed,}) {
  return _then(ActivityOverviewRow(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime?,risePct: freezed == risePct ? _self.risePct : risePct // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastHeatDetectedAt: freezed == lastHeatDetectedAt ? _self.lastHeatDetectedAt : lastHeatDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityOverviewRow].
extension ActivityOverviewRowPatterns on ActivityOverviewRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityOverviewRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityOverviewRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityOverviewRow value)  $default,){
final _that = this;
switch (_that) {
case _ActivityOverviewRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityOverviewRow value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityOverviewRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId,  String tag,  String? name,  String serial,  DateTime? lastSeen,  double? risePct,  String status,  DateTime? lastHeatDetectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityOverviewRow() when $default != null:
return $default(_that.animalId,_that.tag,_that.name,_that.serial,_that.lastSeen,_that.risePct,_that.status,_that.lastHeatDetectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId,  String tag,  String? name,  String serial,  DateTime? lastSeen,  double? risePct,  String status,  DateTime? lastHeatDetectedAt)  $default,) {final _that = this;
switch (_that) {
case _ActivityOverviewRow():
return $default(_that.animalId,_that.tag,_that.name,_that.serial,_that.lastSeen,_that.risePct,_that.status,_that.lastHeatDetectedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId,  String tag,  String? name,  String serial,  DateTime? lastSeen,  double? risePct,  String status,  DateTime? lastHeatDetectedAt)?  $default,) {final _that = this;
switch (_that) {
case _ActivityOverviewRow() when $default != null:
return $default(_that.animalId,_that.tag,_that.name,_that.serial,_that.lastSeen,_that.risePct,_that.status,_that.lastHeatDetectedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityOverviewRow implements ActivityOverviewRow {
  const _ActivityOverviewRow({required this.animalId, this.tag = '', this.name, this.serial = '', this.lastSeen, this.risePct, this.status = 'no_data', this.lastHeatDetectedAt});
  factory _ActivityOverviewRow.fromJson(Map<String, dynamic> json) => _$ActivityOverviewRowFromJson(json);

@override final  String animalId;
@override@JsonKey() final  String tag;
@override final  String? name;
@override@JsonKey() final  String serial;
@override final  DateTime? lastSeen;
/// Hayvanın kendi tabanına göre yükseliş yüzdesi; taban yoksa null.
@override final  double? risePct;
@override@JsonKey() final  String status;
@override final  DateTime? lastHeatDetectedAt;

/// Create a copy of ActivityOverviewRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityOverviewRowCopyWith<_ActivityOverviewRow> get copyWith => __$ActivityOverviewRowCopyWithImpl<_ActivityOverviewRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityOverviewRowToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityOverviewRow&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.name, name) || other.name == name)&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen)&&(identical(other.risePct, risePct) || other.risePct == risePct)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastHeatDetectedAt, lastHeatDetectedAt) || other.lastHeatDetectedAt == lastHeatDetectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,tag,name,serial,lastSeen,risePct,status,lastHeatDetectedAt);
}

@override
String toString() {
    return 'ActivityOverviewRow(animalId: $animalId, tag: $tag, name: $name, serial: $serial, lastSeen: $lastSeen, risePct: $risePct, status: $status, lastHeatDetectedAt: $lastHeatDetectedAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityOverviewRowCopyWith<$Res> implements $ActivityOverviewRowCopyWith<$Res> {
  factory _$ActivityOverviewRowCopyWith(_ActivityOverviewRow value, $Res Function(_ActivityOverviewRow) _then) = __$ActivityOverviewRowCopyWithImpl;
@override @useResult
$Res call({
 String animalId, String tag, String? name, String serial, DateTime? lastSeen, double? risePct, String status, DateTime? lastHeatDetectedAt
});




}
/// @nodoc
class __$ActivityOverviewRowCopyWithImpl<$Res>
    implements _$ActivityOverviewRowCopyWith<$Res> {
  __$ActivityOverviewRowCopyWithImpl(this._self, this._then);

  final _ActivityOverviewRow _self;
  final $Res Function(_ActivityOverviewRow) _then;

/// Create a copy of ActivityOverviewRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? tag = null,Object? name = freezed,Object? serial = null,Object? lastSeen = freezed,Object? risePct = freezed,Object? status = null,Object? lastHeatDetectedAt = freezed,}) {
  return _then(_ActivityOverviewRow(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime?,risePct: freezed == risePct ? _self.risePct : risePct // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastHeatDetectedAt: freezed == lastHeatDetectedAt ? _self.lastHeatDetectedAt : lastHeatDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
