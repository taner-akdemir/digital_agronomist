// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unmatched_tag_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnmatchedTagRow {

 String get rfid; String? get lastSessionId;/// En son okunduğu nokta; ekranda "Ünite A-1 · Nokta 7" olarak çizilir.
 String? get lastSpoutId; DateTime get firstSeenAt; DateTime get lastSeenAt; int get readCount;
/// Create a copy of UnmatchedTagRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnmatchedTagRowCopyWith<UnmatchedTagRow> get copyWith => _$UnmatchedTagRowCopyWithImpl<UnmatchedTagRow>(this as UnmatchedTagRow, _$identity);

  /// Serializes this UnmatchedTagRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnmatchedTagRow&&(identical(other.rfid, rfid) || other.rfid == rfid)&&(identical(other.lastSessionId, lastSessionId) || other.lastSessionId == lastSessionId)&&(identical(other.lastSpoutId, lastSpoutId) || other.lastSpoutId == lastSpoutId)&&(identical(other.firstSeenAt, firstSeenAt) || other.firstSeenAt == firstSeenAt)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.readCount, readCount) || other.readCount == readCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rfid,lastSessionId,lastSpoutId,firstSeenAt,lastSeenAt,readCount);

@override
String toString() {
  return 'UnmatchedTagRow(rfid: $rfid, lastSessionId: $lastSessionId, lastSpoutId: $lastSpoutId, firstSeenAt: $firstSeenAt, lastSeenAt: $lastSeenAt, readCount: $readCount)';
}


}

/// @nodoc
abstract mixin class $UnmatchedTagRowCopyWith<$Res>  {
  factory $UnmatchedTagRowCopyWith(UnmatchedTagRow value, $Res Function(UnmatchedTagRow) _then) = _$UnmatchedTagRowCopyWithImpl;
@useResult
$Res call({
 String rfid, String? lastSessionId, String? lastSpoutId, DateTime firstSeenAt, DateTime lastSeenAt, int readCount
});




}
/// @nodoc
class _$UnmatchedTagRowCopyWithImpl<$Res>
    implements $UnmatchedTagRowCopyWith<$Res> {
  _$UnmatchedTagRowCopyWithImpl(this._self, this._then);

  final UnmatchedTagRow _self;
  final $Res Function(UnmatchedTagRow) _then;

/// Create a copy of UnmatchedTagRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rfid = null,Object? lastSessionId = freezed,Object? lastSpoutId = freezed,Object? firstSeenAt = null,Object? lastSeenAt = null,Object? readCount = null,}) {
  return _then(_self.copyWith(
rfid: null == rfid ? _self.rfid : rfid // ignore: cast_nullable_to_non_nullable
as String,lastSessionId: freezed == lastSessionId ? _self.lastSessionId : lastSessionId // ignore: cast_nullable_to_non_nullable
as String?,lastSpoutId: freezed == lastSpoutId ? _self.lastSpoutId : lastSpoutId // ignore: cast_nullable_to_non_nullable
as String?,firstSeenAt: null == firstSeenAt ? _self.firstSeenAt : firstSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UnmatchedTagRow].
extension UnmatchedTagRowPatterns on UnmatchedTagRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnmatchedTagRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnmatchedTagRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnmatchedTagRow value)  $default,){
final _that = this;
switch (_that) {
case _UnmatchedTagRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnmatchedTagRow value)?  $default,){
final _that = this;
switch (_that) {
case _UnmatchedTagRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rfid,  String? lastSessionId,  String? lastSpoutId,  DateTime firstSeenAt,  DateTime lastSeenAt,  int readCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnmatchedTagRow() when $default != null:
return $default(_that.rfid,_that.lastSessionId,_that.lastSpoutId,_that.firstSeenAt,_that.lastSeenAt,_that.readCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rfid,  String? lastSessionId,  String? lastSpoutId,  DateTime firstSeenAt,  DateTime lastSeenAt,  int readCount)  $default,) {final _that = this;
switch (_that) {
case _UnmatchedTagRow():
return $default(_that.rfid,_that.lastSessionId,_that.lastSpoutId,_that.firstSeenAt,_that.lastSeenAt,_that.readCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rfid,  String? lastSessionId,  String? lastSpoutId,  DateTime firstSeenAt,  DateTime lastSeenAt,  int readCount)?  $default,) {final _that = this;
switch (_that) {
case _UnmatchedTagRow() when $default != null:
return $default(_that.rfid,_that.lastSessionId,_that.lastSpoutId,_that.firstSeenAt,_that.lastSeenAt,_that.readCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnmatchedTagRow implements UnmatchedTagRow {
  const _UnmatchedTagRow({required this.rfid, this.lastSessionId, this.lastSpoutId, required this.firstSeenAt, required this.lastSeenAt, this.readCount = 1});
  factory _UnmatchedTagRow.fromJson(Map<String, dynamic> json) => _$UnmatchedTagRowFromJson(json);

@override final  String rfid;
@override final  String? lastSessionId;
/// En son okunduğu nokta; ekranda "Ünite A-1 · Nokta 7" olarak çizilir.
@override final  String? lastSpoutId;
@override final  DateTime firstSeenAt;
@override final  DateTime lastSeenAt;
@override@JsonKey() final  int readCount;

/// Create a copy of UnmatchedTagRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnmatchedTagRowCopyWith<_UnmatchedTagRow> get copyWith => __$UnmatchedTagRowCopyWithImpl<_UnmatchedTagRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnmatchedTagRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnmatchedTagRow&&(identical(other.rfid, rfid) || other.rfid == rfid)&&(identical(other.lastSessionId, lastSessionId) || other.lastSessionId == lastSessionId)&&(identical(other.lastSpoutId, lastSpoutId) || other.lastSpoutId == lastSpoutId)&&(identical(other.firstSeenAt, firstSeenAt) || other.firstSeenAt == firstSeenAt)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.readCount, readCount) || other.readCount == readCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rfid,lastSessionId,lastSpoutId,firstSeenAt,lastSeenAt,readCount);

@override
String toString() {
  return 'UnmatchedTagRow(rfid: $rfid, lastSessionId: $lastSessionId, lastSpoutId: $lastSpoutId, firstSeenAt: $firstSeenAt, lastSeenAt: $lastSeenAt, readCount: $readCount)';
}


}

/// @nodoc
abstract mixin class _$UnmatchedTagRowCopyWith<$Res> implements $UnmatchedTagRowCopyWith<$Res> {
  factory _$UnmatchedTagRowCopyWith(_UnmatchedTagRow value, $Res Function(_UnmatchedTagRow) _then) = __$UnmatchedTagRowCopyWithImpl;
@override @useResult
$Res call({
 String rfid, String? lastSessionId, String? lastSpoutId, DateTime firstSeenAt, DateTime lastSeenAt, int readCount
});




}
/// @nodoc
class __$UnmatchedTagRowCopyWithImpl<$Res>
    implements _$UnmatchedTagRowCopyWith<$Res> {
  __$UnmatchedTagRowCopyWithImpl(this._self, this._then);

  final _UnmatchedTagRow _self;
  final $Res Function(_UnmatchedTagRow) _then;

/// Create a copy of UnmatchedTagRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rfid = null,Object? lastSessionId = freezed,Object? lastSpoutId = freezed,Object? firstSeenAt = null,Object? lastSeenAt = null,Object? readCount = null,}) {
  return _then(_UnmatchedTagRow(
rfid: null == rfid ? _self.rfid : rfid // ignore: cast_nullable_to_non_nullable
as String,lastSessionId: freezed == lastSessionId ? _self.lastSessionId : lastSessionId // ignore: cast_nullable_to_non_nullable
as String?,lastSpoutId: freezed == lastSpoutId ? _self.lastSpoutId : lastSpoutId // ignore: cast_nullable_to_non_nullable
as String?,firstSeenAt: null == firstSeenAt ? _self.firstSeenAt : firstSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
