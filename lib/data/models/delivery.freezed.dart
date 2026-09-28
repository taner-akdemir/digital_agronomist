// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Delivery {

 String get id; DateTime get deliveredOn; int get volumeMl; String get note; String? get authorName; bool get compared; DateTime? get periodFrom; int get meteredMl; int get withheldMl; double get diffPct; bool get mismatch;
/// Create a copy of Delivery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryCopyWith<Delivery> get copyWith => _$DeliveryCopyWithImpl<Delivery>(this as Delivery, _$identity);

  /// Serializes this Delivery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Delivery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Delivery&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.deliveredOn, _this.deliveredOn) || other.deliveredOn == _this.deliveredOn)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.compared, _this.compared) || other.compared == _this.compared)&&(identical(other.periodFrom, _this.periodFrom) || other.periodFrom == _this.periodFrom)&&(identical(other.meteredMl, _this.meteredMl) || other.meteredMl == _this.meteredMl)&&(identical(other.withheldMl, _this.withheldMl) || other.withheldMl == _this.withheldMl)&&(identical(other.diffPct, _this.diffPct) || other.diffPct == _this.diffPct)&&(identical(other.mismatch, _this.mismatch) || other.mismatch == _this.mismatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Delivery;
  return Object.hash(runtimeType,_this.id,_this.deliveredOn,_this.volumeMl,_this.note,_this.authorName,_this.compared,_this.periodFrom,_this.meteredMl,_this.withheldMl,_this.diffPct,_this.mismatch);
}

@override
String toString() {
  final _this = this as Delivery;
  return 'Delivery(id: ${_this.id}, deliveredOn: ${_this.deliveredOn}, volumeMl: ${_this.volumeMl}, note: ${_this.note}, authorName: ${_this.authorName}, compared: ${_this.compared}, periodFrom: ${_this.periodFrom}, meteredMl: ${_this.meteredMl}, withheldMl: ${_this.withheldMl}, diffPct: ${_this.diffPct}, mismatch: ${_this.mismatch})';
}


}

/// @nodoc
abstract mixin class $DeliveryCopyWith<$Res>  {
  factory $DeliveryCopyWith(Delivery value, $Res Function(Delivery) _then) = _$DeliveryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime deliveredOn, int volumeMl, String note, String? authorName, bool compared, DateTime? periodFrom, int meteredMl, int withheldMl, double diffPct, bool mismatch
});




}
/// @nodoc
class _$DeliveryCopyWithImpl<$Res>
    implements $DeliveryCopyWith<$Res> {
  _$DeliveryCopyWithImpl(this._self, this._then);

  final Delivery _self;
  final $Res Function(Delivery) _then;

/// Create a copy of Delivery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deliveredOn = null,Object? volumeMl = null,Object? note = null,Object? authorName = freezed,Object? compared = null,Object? periodFrom = freezed,Object? meteredMl = null,Object? withheldMl = null,Object? diffPct = null,Object? mismatch = null,}) {
  return _then(Delivery(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deliveredOn: null == deliveredOn ? _self.deliveredOn : deliveredOn // ignore: cast_nullable_to_non_nullable
as DateTime,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,compared: null == compared ? _self.compared : compared // ignore: cast_nullable_to_non_nullable
as bool,periodFrom: freezed == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,meteredMl: null == meteredMl ? _self.meteredMl : meteredMl // ignore: cast_nullable_to_non_nullable
as int,withheldMl: null == withheldMl ? _self.withheldMl : withheldMl // ignore: cast_nullable_to_non_nullable
as int,diffPct: null == diffPct ? _self.diffPct : diffPct // ignore: cast_nullable_to_non_nullable
as double,mismatch: null == mismatch ? _self.mismatch : mismatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Delivery].
extension DeliveryPatterns on Delivery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Delivery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Delivery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Delivery value)  $default,){
final _that = this;
switch (_that) {
case _Delivery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Delivery value)?  $default,){
final _that = this;
switch (_that) {
case _Delivery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime deliveredOn,  int volumeMl,  String note,  String? authorName,  bool compared,  DateTime? periodFrom,  int meteredMl,  int withheldMl,  double diffPct,  bool mismatch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Delivery() when $default != null:
return $default(_that.id,_that.deliveredOn,_that.volumeMl,_that.note,_that.authorName,_that.compared,_that.periodFrom,_that.meteredMl,_that.withheldMl,_that.diffPct,_that.mismatch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime deliveredOn,  int volumeMl,  String note,  String? authorName,  bool compared,  DateTime? periodFrom,  int meteredMl,  int withheldMl,  double diffPct,  bool mismatch)  $default,) {final _that = this;
switch (_that) {
case _Delivery():
return $default(_that.id,_that.deliveredOn,_that.volumeMl,_that.note,_that.authorName,_that.compared,_that.periodFrom,_that.meteredMl,_that.withheldMl,_that.diffPct,_that.mismatch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime deliveredOn,  int volumeMl,  String note,  String? authorName,  bool compared,  DateTime? periodFrom,  int meteredMl,  int withheldMl,  double diffPct,  bool mismatch)?  $default,) {final _that = this;
switch (_that) {
case _Delivery() when $default != null:
return $default(_that.id,_that.deliveredOn,_that.volumeMl,_that.note,_that.authorName,_that.compared,_that.periodFrom,_that.meteredMl,_that.withheldMl,_that.diffPct,_that.mismatch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Delivery implements Delivery {
  const _Delivery({required this.id, required this.deliveredOn, required this.volumeMl, this.note = '', this.authorName, this.compared = false, this.periodFrom, this.meteredMl = 0, this.withheldMl = 0, this.diffPct = 0, this.mismatch = false});
  factory _Delivery.fromJson(Map<String, dynamic> json) => _$DeliveryFromJson(json);

@override final  String id;
@override final  DateTime deliveredOn;
@override final  int volumeMl;
@override@JsonKey() final  String note;
@override final  String? authorName;
@override@JsonKey() final  bool compared;
@override final  DateTime? periodFrom;
@override@JsonKey() final  int meteredMl;
@override@JsonKey() final  int withheldMl;
@override@JsonKey() final  double diffPct;
@override@JsonKey() final  bool mismatch;

/// Create a copy of Delivery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryCopyWith<_Delivery> get copyWith => __$DeliveryCopyWithImpl<_Delivery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Delivery&&(identical(other.id, id) || other.id == id)&&(identical(other.deliveredOn, deliveredOn) || other.deliveredOn == deliveredOn)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.note, note) || other.note == note)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.compared, compared) || other.compared == compared)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.meteredMl, meteredMl) || other.meteredMl == meteredMl)&&(identical(other.withheldMl, withheldMl) || other.withheldMl == withheldMl)&&(identical(other.diffPct, diffPct) || other.diffPct == diffPct)&&(identical(other.mismatch, mismatch) || other.mismatch == mismatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,deliveredOn,volumeMl,note,authorName,compared,periodFrom,meteredMl,withheldMl,diffPct,mismatch);
}

@override
String toString() {
    return 'Delivery(id: $id, deliveredOn: $deliveredOn, volumeMl: $volumeMl, note: $note, authorName: $authorName, compared: $compared, periodFrom: $periodFrom, meteredMl: $meteredMl, withheldMl: $withheldMl, diffPct: $diffPct, mismatch: $mismatch)';
}


}

/// @nodoc
abstract mixin class _$DeliveryCopyWith<$Res> implements $DeliveryCopyWith<$Res> {
  factory _$DeliveryCopyWith(_Delivery value, $Res Function(_Delivery) _then) = __$DeliveryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime deliveredOn, int volumeMl, String note, String? authorName, bool compared, DateTime? periodFrom, int meteredMl, int withheldMl, double diffPct, bool mismatch
});




}
/// @nodoc
class __$DeliveryCopyWithImpl<$Res>
    implements _$DeliveryCopyWith<$Res> {
  __$DeliveryCopyWithImpl(this._self, this._then);

  final _Delivery _self;
  final $Res Function(_Delivery) _then;

/// Create a copy of Delivery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deliveredOn = null,Object? volumeMl = null,Object? note = null,Object? authorName = freezed,Object? compared = null,Object? periodFrom = freezed,Object? meteredMl = null,Object? withheldMl = null,Object? diffPct = null,Object? mismatch = null,}) {
  return _then(_Delivery(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deliveredOn: null == deliveredOn ? _self.deliveredOn : deliveredOn // ignore: cast_nullable_to_non_nullable
as DateTime,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,compared: null == compared ? _self.compared : compared // ignore: cast_nullable_to_non_nullable
as bool,periodFrom: freezed == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,meteredMl: null == meteredMl ? _self.meteredMl : meteredMl // ignore: cast_nullable_to_non_nullable
as int,withheldMl: null == withheldMl ? _self.withheldMl : withheldMl // ignore: cast_nullable_to_non_nullable
as int,diffPct: null == diffPct ? _self.diffPct : diffPct // ignore: cast_nullable_to_non_nullable
as double,mismatch: null == mismatch ? _self.mismatch : mismatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Deliveries {

 double get tolerancePct; List<Delivery> get items;
/// Create a copy of Deliveries
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveriesCopyWith<Deliveries> get copyWith => _$DeliveriesCopyWithImpl<Deliveries>(this as Deliveries, _$identity);

  /// Serializes this Deliveries to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Deliveries;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Deliveries&&(identical(other.tolerancePct, _this.tolerancePct) || other.tolerancePct == _this.tolerancePct)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Deliveries;
  return Object.hash(runtimeType,_this.tolerancePct,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as Deliveries;
  return 'Deliveries(tolerancePct: ${_this.tolerancePct}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $DeliveriesCopyWith<$Res>  {
  factory $DeliveriesCopyWith(Deliveries value, $Res Function(Deliveries) _then) = _$DeliveriesCopyWithImpl;
@useResult
$Res call({
 double tolerancePct, List<Delivery> items
});




}
/// @nodoc
class _$DeliveriesCopyWithImpl<$Res>
    implements $DeliveriesCopyWith<$Res> {
  _$DeliveriesCopyWithImpl(this._self, this._then);

  final Deliveries _self;
  final $Res Function(Deliveries) _then;

/// Create a copy of Deliveries
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tolerancePct = null,Object? items = null,}) {
  return _then(Deliveries(
tolerancePct: null == tolerancePct ? _self.tolerancePct : tolerancePct // ignore: cast_nullable_to_non_nullable
as double,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Delivery>,
  ));
}

}


/// Adds pattern-matching-related methods to [Deliveries].
extension DeliveriesPatterns on Deliveries {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Deliveries value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Deliveries() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Deliveries value)  $default,){
final _that = this;
switch (_that) {
case _Deliveries():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Deliveries value)?  $default,){
final _that = this;
switch (_that) {
case _Deliveries() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double tolerancePct,  List<Delivery> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Deliveries() when $default != null:
return $default(_that.tolerancePct,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double tolerancePct,  List<Delivery> items)  $default,) {final _that = this;
switch (_that) {
case _Deliveries():
return $default(_that.tolerancePct,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double tolerancePct,  List<Delivery> items)?  $default,) {final _that = this;
switch (_that) {
case _Deliveries() when $default != null:
return $default(_that.tolerancePct,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Deliveries implements Deliveries {
  const _Deliveries({this.tolerancePct = 5,  List<Delivery> items = const []}): _items = items;
  factory _Deliveries.fromJson(Map<String, dynamic> json) => _$DeliveriesFromJson(json);

@override@JsonKey() final  double tolerancePct;
 final  List<Delivery> _items;
@override@JsonKey() List<Delivery> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of Deliveries
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveriesCopyWith<_Deliveries> get copyWith => __$DeliveriesCopyWithImpl<_Deliveries>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveriesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Deliveries&&(identical(other.tolerancePct, tolerancePct) || other.tolerancePct == tolerancePct)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tolerancePct,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'Deliveries(tolerancePct: $tolerancePct, items: $items)';
}


}

/// @nodoc
abstract mixin class _$DeliveriesCopyWith<$Res> implements $DeliveriesCopyWith<$Res> {
  factory _$DeliveriesCopyWith(_Deliveries value, $Res Function(_Deliveries) _then) = __$DeliveriesCopyWithImpl;
@override @useResult
$Res call({
 double tolerancePct, List<Delivery> items
});




}
/// @nodoc
class __$DeliveriesCopyWithImpl<$Res>
    implements _$DeliveriesCopyWith<$Res> {
  __$DeliveriesCopyWithImpl(this._self, this._then);

  final _Deliveries _self;
  final $Res Function(_Deliveries) _then;

/// Create a copy of Deliveries
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tolerancePct = null,Object? items = null,}) {
  return _then(_Deliveries(
tolerancePct: null == tolerancePct ? _self.tolerancePct : tolerancePct // ignore: cast_nullable_to_non_nullable
as double,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Delivery>,
  ));
}


}


/// @nodoc
mixin _$Milker {

 String? get userId; String get name; int get sessions; int get milkings; int get volumeMl; int get avgDurationSec; int get lowFlowMilkings;
/// Create a copy of Milker
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilkerCopyWith<Milker> get copyWith => _$MilkerCopyWithImpl<Milker>(this as Milker, _$identity);

  /// Serializes this Milker to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Milker;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Milker&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.sessions, _this.sessions) || other.sessions == _this.sessions)&&(identical(other.milkings, _this.milkings) || other.milkings == _this.milkings)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl)&&(identical(other.avgDurationSec, _this.avgDurationSec) || other.avgDurationSec == _this.avgDurationSec)&&(identical(other.lowFlowMilkings, _this.lowFlowMilkings) || other.lowFlowMilkings == _this.lowFlowMilkings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Milker;
  return Object.hash(runtimeType,_this.userId,_this.name,_this.sessions,_this.milkings,_this.volumeMl,_this.avgDurationSec,_this.lowFlowMilkings);
}

@override
String toString() {
  final _this = this as Milker;
  return 'Milker(userId: ${_this.userId}, name: ${_this.name}, sessions: ${_this.sessions}, milkings: ${_this.milkings}, volumeMl: ${_this.volumeMl}, avgDurationSec: ${_this.avgDurationSec}, lowFlowMilkings: ${_this.lowFlowMilkings})';
}


}

/// @nodoc
abstract mixin class $MilkerCopyWith<$Res>  {
  factory $MilkerCopyWith(Milker value, $Res Function(Milker) _then) = _$MilkerCopyWithImpl;
@useResult
$Res call({
 String? userId, String name, int sessions, int milkings, int volumeMl, int avgDurationSec, int lowFlowMilkings
});




}
/// @nodoc
class _$MilkerCopyWithImpl<$Res>
    implements $MilkerCopyWith<$Res> {
  _$MilkerCopyWithImpl(this._self, this._then);

  final Milker _self;
  final $Res Function(Milker) _then;

/// Create a copy of Milker
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? name = null,Object? sessions = null,Object? milkings = null,Object? volumeMl = null,Object? avgDurationSec = null,Object? lowFlowMilkings = null,}) {
  return _then(Milker(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as int,milkings: null == milkings ? _self.milkings : milkings // ignore: cast_nullable_to_non_nullable
as int,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,avgDurationSec: null == avgDurationSec ? _self.avgDurationSec : avgDurationSec // ignore: cast_nullable_to_non_nullable
as int,lowFlowMilkings: null == lowFlowMilkings ? _self.lowFlowMilkings : lowFlowMilkings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Milker].
extension MilkerPatterns on Milker {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Milker value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Milker() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Milker value)  $default,){
final _that = this;
switch (_that) {
case _Milker():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Milker value)?  $default,){
final _that = this;
switch (_that) {
case _Milker() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userId,  String name,  int sessions,  int milkings,  int volumeMl,  int avgDurationSec,  int lowFlowMilkings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Milker() when $default != null:
return $default(_that.userId,_that.name,_that.sessions,_that.milkings,_that.volumeMl,_that.avgDurationSec,_that.lowFlowMilkings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userId,  String name,  int sessions,  int milkings,  int volumeMl,  int avgDurationSec,  int lowFlowMilkings)  $default,) {final _that = this;
switch (_that) {
case _Milker():
return $default(_that.userId,_that.name,_that.sessions,_that.milkings,_that.volumeMl,_that.avgDurationSec,_that.lowFlowMilkings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userId,  String name,  int sessions,  int milkings,  int volumeMl,  int avgDurationSec,  int lowFlowMilkings)?  $default,) {final _that = this;
switch (_that) {
case _Milker() when $default != null:
return $default(_that.userId,_that.name,_that.sessions,_that.milkings,_that.volumeMl,_that.avgDurationSec,_that.lowFlowMilkings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Milker extends Milker {
  const _Milker({this.userId, this.name = '', this.sessions = 0, this.milkings = 0, this.volumeMl = 0, this.avgDurationSec = 0, this.lowFlowMilkings = 0}): super._();
  factory _Milker.fromJson(Map<String, dynamic> json) => _$MilkerFromJson(json);

@override final  String? userId;
@override@JsonKey() final  String name;
@override@JsonKey() final  int sessions;
@override@JsonKey() final  int milkings;
@override@JsonKey() final  int volumeMl;
@override@JsonKey() final  int avgDurationSec;
@override@JsonKey() final  int lowFlowMilkings;

/// Create a copy of Milker
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilkerCopyWith<_Milker> get copyWith => __$MilkerCopyWithImpl<_Milker>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MilkerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Milker&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.sessions, sessions) || other.sessions == sessions)&&(identical(other.milkings, milkings) || other.milkings == milkings)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.avgDurationSec, avgDurationSec) || other.avgDurationSec == avgDurationSec)&&(identical(other.lowFlowMilkings, lowFlowMilkings) || other.lowFlowMilkings == lowFlowMilkings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,name,sessions,milkings,volumeMl,avgDurationSec,lowFlowMilkings);
}

@override
String toString() {
    return 'Milker(userId: $userId, name: $name, sessions: $sessions, milkings: $milkings, volumeMl: $volumeMl, avgDurationSec: $avgDurationSec, lowFlowMilkings: $lowFlowMilkings)';
}


}

/// @nodoc
abstract mixin class _$MilkerCopyWith<$Res> implements $MilkerCopyWith<$Res> {
  factory _$MilkerCopyWith(_Milker value, $Res Function(_Milker) _then) = __$MilkerCopyWithImpl;
@override @useResult
$Res call({
 String? userId, String name, int sessions, int milkings, int volumeMl, int avgDurationSec, int lowFlowMilkings
});




}
/// @nodoc
class __$MilkerCopyWithImpl<$Res>
    implements _$MilkerCopyWith<$Res> {
  __$MilkerCopyWithImpl(this._self, this._then);

  final _Milker _self;
  final $Res Function(_Milker) _then;

/// Create a copy of Milker
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? name = null,Object? sessions = null,Object? milkings = null,Object? volumeMl = null,Object? avgDurationSec = null,Object? lowFlowMilkings = null,}) {
  return _then(_Milker(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as int,milkings: null == milkings ? _self.milkings : milkings // ignore: cast_nullable_to_non_nullable
as int,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,avgDurationSec: null == avgDurationSec ? _self.avgDurationSec : avgDurationSec // ignore: cast_nullable_to_non_nullable
as int,lowFlowMilkings: null == lowFlowMilkings ? _self.lowFlowMilkings : lowFlowMilkings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
