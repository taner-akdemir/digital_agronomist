// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeterCheck {

 String get id; String get milkingId; String? get deviceId; String get earTag; int get meteredMl; int get manualMl; double get deviationPct; String get authorName; DateTime? get createdAt;
/// Create a copy of MeterCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeterCheckCopyWith<MeterCheck> get copyWith => _$MeterCheckCopyWithImpl<MeterCheck>(this as MeterCheck, _$identity);

  /// Serializes this MeterCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeterCheck;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeterCheck&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.milkingId, _this.milkingId) || other.milkingId == _this.milkingId)&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.earTag, _this.earTag) || other.earTag == _this.earTag)&&(identical(other.meteredMl, _this.meteredMl) || other.meteredMl == _this.meteredMl)&&(identical(other.manualMl, _this.manualMl) || other.manualMl == _this.manualMl)&&(identical(other.deviationPct, _this.deviationPct) || other.deviationPct == _this.deviationPct)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeterCheck;
  return Object.hash(runtimeType,_this.id,_this.milkingId,_this.deviceId,_this.earTag,_this.meteredMl,_this.manualMl,_this.deviationPct,_this.authorName,_this.createdAt);
}

@override
String toString() {
  final _this = this as MeterCheck;
  return 'MeterCheck(id: ${_this.id}, milkingId: ${_this.milkingId}, deviceId: ${_this.deviceId}, earTag: ${_this.earTag}, meteredMl: ${_this.meteredMl}, manualMl: ${_this.manualMl}, deviationPct: ${_this.deviationPct}, authorName: ${_this.authorName}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $MeterCheckCopyWith<$Res>  {
  factory $MeterCheckCopyWith(MeterCheck value, $Res Function(MeterCheck) _then) = _$MeterCheckCopyWithImpl;
@useResult
$Res call({
 String id, String milkingId, String? deviceId, String earTag, int meteredMl, int manualMl, double deviationPct, String authorName, DateTime? createdAt
});




}
/// @nodoc
class _$MeterCheckCopyWithImpl<$Res>
    implements $MeterCheckCopyWith<$Res> {
  _$MeterCheckCopyWithImpl(this._self, this._then);

  final MeterCheck _self;
  final $Res Function(MeterCheck) _then;

/// Create a copy of MeterCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? milkingId = null,Object? deviceId = freezed,Object? earTag = null,Object? meteredMl = null,Object? manualMl = null,Object? deviationPct = null,Object? authorName = null,Object? createdAt = freezed,}) {
  return _then(MeterCheck(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,milkingId: null == milkingId ? _self.milkingId : milkingId // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,meteredMl: null == meteredMl ? _self.meteredMl : meteredMl // ignore: cast_nullable_to_non_nullable
as int,manualMl: null == manualMl ? _self.manualMl : manualMl // ignore: cast_nullable_to_non_nullable
as int,deviationPct: null == deviationPct ? _self.deviationPct : deviationPct // ignore: cast_nullable_to_non_nullable
as double,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeterCheck].
extension MeterCheckPatterns on MeterCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeterCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeterCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeterCheck value)  $default,){
final _that = this;
switch (_that) {
case _MeterCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeterCheck value)?  $default,){
final _that = this;
switch (_that) {
case _MeterCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String milkingId,  String? deviceId,  String earTag,  int meteredMl,  int manualMl,  double deviationPct,  String authorName,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeterCheck() when $default != null:
return $default(_that.id,_that.milkingId,_that.deviceId,_that.earTag,_that.meteredMl,_that.manualMl,_that.deviationPct,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String milkingId,  String? deviceId,  String earTag,  int meteredMl,  int manualMl,  double deviationPct,  String authorName,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MeterCheck():
return $default(_that.id,_that.milkingId,_that.deviceId,_that.earTag,_that.meteredMl,_that.manualMl,_that.deviationPct,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String milkingId,  String? deviceId,  String earTag,  int meteredMl,  int manualMl,  double deviationPct,  String authorName,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MeterCheck() when $default != null:
return $default(_that.id,_that.milkingId,_that.deviceId,_that.earTag,_that.meteredMl,_that.manualMl,_that.deviationPct,_that.authorName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeterCheck implements MeterCheck {
  const _MeterCheck({required this.id, required this.milkingId, this.deviceId, this.earTag = '', this.meteredMl = 0, this.manualMl = 0, this.deviationPct = 0, this.authorName = '', this.createdAt});
  factory _MeterCheck.fromJson(Map<String, dynamic> json) => _$MeterCheckFromJson(json);

@override final  String id;
@override final  String milkingId;
@override final  String? deviceId;
@override@JsonKey() final  String earTag;
@override@JsonKey() final  int meteredMl;
@override@JsonKey() final  int manualMl;
@override@JsonKey() final  double deviationPct;
@override@JsonKey() final  String authorName;
@override final  DateTime? createdAt;

/// Create a copy of MeterCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeterCheckCopyWith<_MeterCheck> get copyWith => __$MeterCheckCopyWithImpl<_MeterCheck>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeterCheckToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeterCheck&&(identical(other.id, id) || other.id == id)&&(identical(other.milkingId, milkingId) || other.milkingId == milkingId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.meteredMl, meteredMl) || other.meteredMl == meteredMl)&&(identical(other.manualMl, manualMl) || other.manualMl == manualMl)&&(identical(other.deviationPct, deviationPct) || other.deviationPct == deviationPct)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,milkingId,deviceId,earTag,meteredMl,manualMl,deviationPct,authorName,createdAt);
}

@override
String toString() {
    return 'MeterCheck(id: $id, milkingId: $milkingId, deviceId: $deviceId, earTag: $earTag, meteredMl: $meteredMl, manualMl: $manualMl, deviationPct: $deviationPct, authorName: $authorName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MeterCheckCopyWith<$Res> implements $MeterCheckCopyWith<$Res> {
  factory _$MeterCheckCopyWith(_MeterCheck value, $Res Function(_MeterCheck) _then) = __$MeterCheckCopyWithImpl;
@override @useResult
$Res call({
 String id, String milkingId, String? deviceId, String earTag, int meteredMl, int manualMl, double deviationPct, String authorName, DateTime? createdAt
});




}
/// @nodoc
class __$MeterCheckCopyWithImpl<$Res>
    implements _$MeterCheckCopyWith<$Res> {
  __$MeterCheckCopyWithImpl(this._self, this._then);

  final _MeterCheck _self;
  final $Res Function(_MeterCheck) _then;

/// Create a copy of MeterCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? milkingId = null,Object? deviceId = freezed,Object? earTag = null,Object? meteredMl = null,Object? manualMl = null,Object? deviationPct = null,Object? authorName = null,Object? createdAt = freezed,}) {
  return _then(_MeterCheck(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,milkingId: null == milkingId ? _self.milkingId : milkingId // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,meteredMl: null == meteredMl ? _self.meteredMl : meteredMl // ignore: cast_nullable_to_non_nullable
as int,manualMl: null == manualMl ? _self.manualMl : manualMl // ignore: cast_nullable_to_non_nullable
as int,deviationPct: null == deviationPct ? _self.deviationPct : deviationPct // ignore: cast_nullable_to_non_nullable
as double,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$MeterSummary {

 String get deviceId; String get serialNo; int get checks; double get avgDeviationPct; bool get needsCalibration;
/// Create a copy of MeterSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeterSummaryCopyWith<MeterSummary> get copyWith => _$MeterSummaryCopyWithImpl<MeterSummary>(this as MeterSummary, _$identity);

  /// Serializes this MeterSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeterSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeterSummary&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.serialNo, _this.serialNo) || other.serialNo == _this.serialNo)&&(identical(other.checks, _this.checks) || other.checks == _this.checks)&&(identical(other.avgDeviationPct, _this.avgDeviationPct) || other.avgDeviationPct == _this.avgDeviationPct)&&(identical(other.needsCalibration, _this.needsCalibration) || other.needsCalibration == _this.needsCalibration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeterSummary;
  return Object.hash(runtimeType,_this.deviceId,_this.serialNo,_this.checks,_this.avgDeviationPct,_this.needsCalibration);
}

@override
String toString() {
  final _this = this as MeterSummary;
  return 'MeterSummary(deviceId: ${_this.deviceId}, serialNo: ${_this.serialNo}, checks: ${_this.checks}, avgDeviationPct: ${_this.avgDeviationPct}, needsCalibration: ${_this.needsCalibration})';
}


}

/// @nodoc
abstract mixin class $MeterSummaryCopyWith<$Res>  {
  factory $MeterSummaryCopyWith(MeterSummary value, $Res Function(MeterSummary) _then) = _$MeterSummaryCopyWithImpl;
@useResult
$Res call({
 String deviceId, String serialNo, int checks, double avgDeviationPct, bool needsCalibration
});




}
/// @nodoc
class _$MeterSummaryCopyWithImpl<$Res>
    implements $MeterSummaryCopyWith<$Res> {
  _$MeterSummaryCopyWithImpl(this._self, this._then);

  final MeterSummary _self;
  final $Res Function(MeterSummary) _then;

/// Create a copy of MeterSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? serialNo = null,Object? checks = null,Object? avgDeviationPct = null,Object? needsCalibration = null,}) {
  return _then(MeterSummary(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as String,checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as int,avgDeviationPct: null == avgDeviationPct ? _self.avgDeviationPct : avgDeviationPct // ignore: cast_nullable_to_non_nullable
as double,needsCalibration: null == needsCalibration ? _self.needsCalibration : needsCalibration // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MeterSummary].
extension MeterSummaryPatterns on MeterSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeterSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeterSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeterSummary value)  $default,){
final _that = this;
switch (_that) {
case _MeterSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeterSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MeterSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String serialNo,  int checks,  double avgDeviationPct,  bool needsCalibration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeterSummary() when $default != null:
return $default(_that.deviceId,_that.serialNo,_that.checks,_that.avgDeviationPct,_that.needsCalibration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String serialNo,  int checks,  double avgDeviationPct,  bool needsCalibration)  $default,) {final _that = this;
switch (_that) {
case _MeterSummary():
return $default(_that.deviceId,_that.serialNo,_that.checks,_that.avgDeviationPct,_that.needsCalibration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String serialNo,  int checks,  double avgDeviationPct,  bool needsCalibration)?  $default,) {final _that = this;
switch (_that) {
case _MeterSummary() when $default != null:
return $default(_that.deviceId,_that.serialNo,_that.checks,_that.avgDeviationPct,_that.needsCalibration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeterSummary implements MeterSummary {
  const _MeterSummary({this.deviceId = '', this.serialNo = '', this.checks = 0, this.avgDeviationPct = 0, this.needsCalibration = false});
  factory _MeterSummary.fromJson(Map<String, dynamic> json) => _$MeterSummaryFromJson(json);

@override@JsonKey() final  String deviceId;
@override@JsonKey() final  String serialNo;
@override@JsonKey() final  int checks;
@override@JsonKey() final  double avgDeviationPct;
@override@JsonKey() final  bool needsCalibration;

/// Create a copy of MeterSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeterSummaryCopyWith<_MeterSummary> get copyWith => __$MeterSummaryCopyWithImpl<_MeterSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeterSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeterSummary&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.checks, checks) || other.checks == checks)&&(identical(other.avgDeviationPct, avgDeviationPct) || other.avgDeviationPct == avgDeviationPct)&&(identical(other.needsCalibration, needsCalibration) || other.needsCalibration == needsCalibration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,deviceId,serialNo,checks,avgDeviationPct,needsCalibration);
}

@override
String toString() {
    return 'MeterSummary(deviceId: $deviceId, serialNo: $serialNo, checks: $checks, avgDeviationPct: $avgDeviationPct, needsCalibration: $needsCalibration)';
}


}

/// @nodoc
abstract mixin class _$MeterSummaryCopyWith<$Res> implements $MeterSummaryCopyWith<$Res> {
  factory _$MeterSummaryCopyWith(_MeterSummary value, $Res Function(_MeterSummary) _then) = __$MeterSummaryCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String serialNo, int checks, double avgDeviationPct, bool needsCalibration
});




}
/// @nodoc
class __$MeterSummaryCopyWithImpl<$Res>
    implements _$MeterSummaryCopyWith<$Res> {
  __$MeterSummaryCopyWithImpl(this._self, this._then);

  final _MeterSummary _self;
  final $Res Function(_MeterSummary) _then;

/// Create a copy of MeterSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? serialNo = null,Object? checks = null,Object? avgDeviationPct = null,Object? needsCalibration = null,}) {
  return _then(_MeterSummary(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as String,checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as int,avgDeviationPct: null == avgDeviationPct ? _self.avgDeviationPct : avgDeviationPct // ignore: cast_nullable_to_non_nullable
as double,needsCalibration: null == needsCalibration ? _self.needsCalibration : needsCalibration // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MeterChecks {

 MeterSummary get summary; List<MeterCheck> get items;
/// Create a copy of MeterChecks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeterChecksCopyWith<MeterChecks> get copyWith => _$MeterChecksCopyWithImpl<MeterChecks>(this as MeterChecks, _$identity);

  /// Serializes this MeterChecks to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeterChecks;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeterChecks&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeterChecks;
  return Object.hash(runtimeType,_this.summary,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as MeterChecks;
  return 'MeterChecks(summary: ${_this.summary}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $MeterChecksCopyWith<$Res>  {
  factory $MeterChecksCopyWith(MeterChecks value, $Res Function(MeterChecks) _then) = _$MeterChecksCopyWithImpl;
@useResult
$Res call({
 MeterSummary summary, List<MeterCheck> items
});


$MeterSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$MeterChecksCopyWithImpl<$Res>
    implements $MeterChecksCopyWith<$Res> {
  _$MeterChecksCopyWithImpl(this._self, this._then);

  final MeterChecks _self;
  final $Res Function(MeterChecks) _then;

/// Create a copy of MeterChecks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? items = null,}) {
  return _then(MeterChecks(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MeterSummary,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MeterCheck>,
  ));
}
/// Create a copy of MeterChecks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterSummaryCopyWith<$Res> get summary {
  
  return $MeterSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeterChecks].
extension MeterChecksPatterns on MeterChecks {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeterChecks value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeterChecks() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeterChecks value)  $default,){
final _that = this;
switch (_that) {
case _MeterChecks():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeterChecks value)?  $default,){
final _that = this;
switch (_that) {
case _MeterChecks() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MeterSummary summary,  List<MeterCheck> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeterChecks() when $default != null:
return $default(_that.summary,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MeterSummary summary,  List<MeterCheck> items)  $default,) {final _that = this;
switch (_that) {
case _MeterChecks():
return $default(_that.summary,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MeterSummary summary,  List<MeterCheck> items)?  $default,) {final _that = this;
switch (_that) {
case _MeterChecks() when $default != null:
return $default(_that.summary,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeterChecks implements MeterChecks {
  const _MeterChecks({this.summary = const MeterSummary(),  List<MeterCheck> items = const <MeterCheck>[]}): _items = items;
  factory _MeterChecks.fromJson(Map<String, dynamic> json) => _$MeterChecksFromJson(json);

@override@JsonKey() final  MeterSummary summary;
 final  List<MeterCheck> _items;
@override@JsonKey() List<MeterCheck> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MeterChecks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeterChecksCopyWith<_MeterChecks> get copyWith => __$MeterChecksCopyWithImpl<_MeterChecks>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeterChecksToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeterChecks&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'MeterChecks(summary: $summary, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MeterChecksCopyWith<$Res> implements $MeterChecksCopyWith<$Res> {
  factory _$MeterChecksCopyWith(_MeterChecks value, $Res Function(_MeterChecks) _then) = __$MeterChecksCopyWithImpl;
@override @useResult
$Res call({
 MeterSummary summary, List<MeterCheck> items
});


@override $MeterSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$MeterChecksCopyWithImpl<$Res>
    implements _$MeterChecksCopyWith<$Res> {
  __$MeterChecksCopyWithImpl(this._self, this._then);

  final _MeterChecks _self;
  final $Res Function(_MeterChecks) _then;

/// Create a copy of MeterChecks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? items = null,}) {
  return _then(_MeterChecks(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MeterSummary,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MeterCheck>,
  ));
}

/// Create a copy of MeterChecks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterSummaryCopyWith<$Res> get summary {
  
  return $MeterSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$MeterCheckResult {

 MeterCheck get check; MeterSummary get summary;
/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeterCheckResultCopyWith<MeterCheckResult> get copyWith => _$MeterCheckResultCopyWithImpl<MeterCheckResult>(this as MeterCheckResult, _$identity);

  /// Serializes this MeterCheckResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeterCheckResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeterCheckResult&&(identical(other.check, _this.check) || other.check == _this.check)&&(identical(other.summary, _this.summary) || other.summary == _this.summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeterCheckResult;
  return Object.hash(runtimeType,_this.check,_this.summary);
}

@override
String toString() {
  final _this = this as MeterCheckResult;
  return 'MeterCheckResult(check: ${_this.check}, summary: ${_this.summary})';
}


}

/// @nodoc
abstract mixin class $MeterCheckResultCopyWith<$Res>  {
  factory $MeterCheckResultCopyWith(MeterCheckResult value, $Res Function(MeterCheckResult) _then) = _$MeterCheckResultCopyWithImpl;
@useResult
$Res call({
 MeterCheck check, MeterSummary summary
});


$MeterCheckCopyWith<$Res> get check;$MeterSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$MeterCheckResultCopyWithImpl<$Res>
    implements $MeterCheckResultCopyWith<$Res> {
  _$MeterCheckResultCopyWithImpl(this._self, this._then);

  final MeterCheckResult _self;
  final $Res Function(MeterCheckResult) _then;

/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? check = null,Object? summary = null,}) {
  return _then(MeterCheckResult(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as MeterCheck,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MeterSummary,
  ));
}
/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterCheckCopyWith<$Res> get check {
  
  return $MeterCheckCopyWith<$Res>(_self.check, (value) {
    return _then(_self.copyWith(check: value));
  });
}/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterSummaryCopyWith<$Res> get summary {
  
  return $MeterSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeterCheckResult].
extension MeterCheckResultPatterns on MeterCheckResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeterCheckResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeterCheckResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeterCheckResult value)  $default,){
final _that = this;
switch (_that) {
case _MeterCheckResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeterCheckResult value)?  $default,){
final _that = this;
switch (_that) {
case _MeterCheckResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MeterCheck check,  MeterSummary summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeterCheckResult() when $default != null:
return $default(_that.check,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MeterCheck check,  MeterSummary summary)  $default,) {final _that = this;
switch (_that) {
case _MeterCheckResult():
return $default(_that.check,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MeterCheck check,  MeterSummary summary)?  $default,) {final _that = this;
switch (_that) {
case _MeterCheckResult() when $default != null:
return $default(_that.check,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeterCheckResult implements MeterCheckResult {
  const _MeterCheckResult({required this.check, this.summary = const MeterSummary()});
  factory _MeterCheckResult.fromJson(Map<String, dynamic> json) => _$MeterCheckResultFromJson(json);

@override final  MeterCheck check;
@override@JsonKey() final  MeterSummary summary;

/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeterCheckResultCopyWith<_MeterCheckResult> get copyWith => __$MeterCheckResultCopyWithImpl<_MeterCheckResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeterCheckResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeterCheckResult&&(identical(other.check, check) || other.check == check)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,check,summary);
}

@override
String toString() {
    return 'MeterCheckResult(check: $check, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$MeterCheckResultCopyWith<$Res> implements $MeterCheckResultCopyWith<$Res> {
  factory _$MeterCheckResultCopyWith(_MeterCheckResult value, $Res Function(_MeterCheckResult) _then) = __$MeterCheckResultCopyWithImpl;
@override @useResult
$Res call({
 MeterCheck check, MeterSummary summary
});


@override $MeterCheckCopyWith<$Res> get check;@override $MeterSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$MeterCheckResultCopyWithImpl<$Res>
    implements _$MeterCheckResultCopyWith<$Res> {
  __$MeterCheckResultCopyWithImpl(this._self, this._then);

  final _MeterCheckResult _self;
  final $Res Function(_MeterCheckResult) _then;

/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? check = null,Object? summary = null,}) {
  return _then(_MeterCheckResult(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as MeterCheck,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MeterSummary,
  ));
}

/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterCheckCopyWith<$Res> get check {
  
  return $MeterCheckCopyWith<$Res>(_self.check, (value) {
    return _then(_self.copyWith(check: value));
  });
}/// Create a copy of MeterCheckResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterSummaryCopyWith<$Res> get summary {
  
  return $MeterSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
