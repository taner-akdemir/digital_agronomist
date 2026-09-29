// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breeding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Pregnancy {

/// open | inseminated | pregnant. String: yeni durum ekranı düşürmesin.
 String get status; DateTime? get lastInsemination; DateTime? get expectedCalving; DateTime? get dryOffDate;/// Son kızgınlık ve beklenen sonraki (21. gün; 18–24) — backend ADR 0121.
 DateTime? get lastHeat; DateTime? get expectedHeat;
/// Create a copy of Pregnancy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PregnancyCopyWith<Pregnancy> get copyWith => _$PregnancyCopyWithImpl<Pregnancy>(this as Pregnancy, _$identity);

  /// Serializes this Pregnancy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Pregnancy;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pregnancy&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.lastInsemination, _this.lastInsemination) || other.lastInsemination == _this.lastInsemination)&&(identical(other.expectedCalving, _this.expectedCalving) || other.expectedCalving == _this.expectedCalving)&&(identical(other.dryOffDate, _this.dryOffDate) || other.dryOffDate == _this.dryOffDate)&&(identical(other.lastHeat, _this.lastHeat) || other.lastHeat == _this.lastHeat)&&(identical(other.expectedHeat, _this.expectedHeat) || other.expectedHeat == _this.expectedHeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Pregnancy;
  return Object.hash(runtimeType,_this.status,_this.lastInsemination,_this.expectedCalving,_this.dryOffDate,_this.lastHeat,_this.expectedHeat);
}

@override
String toString() {
  final _this = this as Pregnancy;
  return 'Pregnancy(status: ${_this.status}, lastInsemination: ${_this.lastInsemination}, expectedCalving: ${_this.expectedCalving}, dryOffDate: ${_this.dryOffDate}, lastHeat: ${_this.lastHeat}, expectedHeat: ${_this.expectedHeat})';
}


}

/// @nodoc
abstract mixin class $PregnancyCopyWith<$Res>  {
  factory $PregnancyCopyWith(Pregnancy value, $Res Function(Pregnancy) _then) = _$PregnancyCopyWithImpl;
@useResult
$Res call({
 String status, DateTime? lastInsemination, DateTime? expectedCalving, DateTime? dryOffDate, DateTime? lastHeat, DateTime? expectedHeat
});




}
/// @nodoc
class _$PregnancyCopyWithImpl<$Res>
    implements $PregnancyCopyWith<$Res> {
  _$PregnancyCopyWithImpl(this._self, this._then);

  final Pregnancy _self;
  final $Res Function(Pregnancy) _then;

/// Create a copy of Pregnancy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? lastInsemination = freezed,Object? expectedCalving = freezed,Object? dryOffDate = freezed,Object? lastHeat = freezed,Object? expectedHeat = freezed,}) {
  return _then(Pregnancy(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastInsemination: freezed == lastInsemination ? _self.lastInsemination : lastInsemination // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedCalving: freezed == expectedCalving ? _self.expectedCalving : expectedCalving // ignore: cast_nullable_to_non_nullable
as DateTime?,dryOffDate: freezed == dryOffDate ? _self.dryOffDate : dryOffDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastHeat: freezed == lastHeat ? _self.lastHeat : lastHeat // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedHeat: freezed == expectedHeat ? _self.expectedHeat : expectedHeat // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Pregnancy].
extension PregnancyPatterns on Pregnancy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pregnancy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pregnancy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pregnancy value)  $default,){
final _that = this;
switch (_that) {
case _Pregnancy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pregnancy value)?  $default,){
final _that = this;
switch (_that) {
case _Pregnancy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  DateTime? lastInsemination,  DateTime? expectedCalving,  DateTime? dryOffDate,  DateTime? lastHeat,  DateTime? expectedHeat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pregnancy() when $default != null:
return $default(_that.status,_that.lastInsemination,_that.expectedCalving,_that.dryOffDate,_that.lastHeat,_that.expectedHeat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  DateTime? lastInsemination,  DateTime? expectedCalving,  DateTime? dryOffDate,  DateTime? lastHeat,  DateTime? expectedHeat)  $default,) {final _that = this;
switch (_that) {
case _Pregnancy():
return $default(_that.status,_that.lastInsemination,_that.expectedCalving,_that.dryOffDate,_that.lastHeat,_that.expectedHeat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  DateTime? lastInsemination,  DateTime? expectedCalving,  DateTime? dryOffDate,  DateTime? lastHeat,  DateTime? expectedHeat)?  $default,) {final _that = this;
switch (_that) {
case _Pregnancy() when $default != null:
return $default(_that.status,_that.lastInsemination,_that.expectedCalving,_that.dryOffDate,_that.lastHeat,_that.expectedHeat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pregnancy extends Pregnancy {
  const _Pregnancy({required this.status, this.lastInsemination, this.expectedCalving, this.dryOffDate, this.lastHeat, this.expectedHeat}): super._();
  factory _Pregnancy.fromJson(Map<String, dynamic> json) => _$PregnancyFromJson(json);

/// open | inseminated | pregnant. String: yeni durum ekranı düşürmesin.
@override final  String status;
@override final  DateTime? lastInsemination;
@override final  DateTime? expectedCalving;
@override final  DateTime? dryOffDate;
/// Son kızgınlık ve beklenen sonraki (21. gün; 18–24) — backend ADR 0121.
@override final  DateTime? lastHeat;
@override final  DateTime? expectedHeat;

/// Create a copy of Pregnancy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PregnancyCopyWith<_Pregnancy> get copyWith => __$PregnancyCopyWithImpl<_Pregnancy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PregnancyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pregnancy&&(identical(other.status, status) || other.status == status)&&(identical(other.lastInsemination, lastInsemination) || other.lastInsemination == lastInsemination)&&(identical(other.expectedCalving, expectedCalving) || other.expectedCalving == expectedCalving)&&(identical(other.dryOffDate, dryOffDate) || other.dryOffDate == dryOffDate)&&(identical(other.lastHeat, lastHeat) || other.lastHeat == lastHeat)&&(identical(other.expectedHeat, expectedHeat) || other.expectedHeat == expectedHeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,lastInsemination,expectedCalving,dryOffDate,lastHeat,expectedHeat);
}

@override
String toString() {
    return 'Pregnancy(status: $status, lastInsemination: $lastInsemination, expectedCalving: $expectedCalving, dryOffDate: $dryOffDate, lastHeat: $lastHeat, expectedHeat: $expectedHeat)';
}


}

/// @nodoc
abstract mixin class _$PregnancyCopyWith<$Res> implements $PregnancyCopyWith<$Res> {
  factory _$PregnancyCopyWith(_Pregnancy value, $Res Function(_Pregnancy) _then) = __$PregnancyCopyWithImpl;
@override @useResult
$Res call({
 String status, DateTime? lastInsemination, DateTime? expectedCalving, DateTime? dryOffDate, DateTime? lastHeat, DateTime? expectedHeat
});




}
/// @nodoc
class __$PregnancyCopyWithImpl<$Res>
    implements _$PregnancyCopyWith<$Res> {
  __$PregnancyCopyWithImpl(this._self, this._then);

  final _Pregnancy _self;
  final $Res Function(_Pregnancy) _then;

/// Create a copy of Pregnancy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? lastInsemination = freezed,Object? expectedCalving = freezed,Object? dryOffDate = freezed,Object? lastHeat = freezed,Object? expectedHeat = freezed,}) {
  return _then(_Pregnancy(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastInsemination: freezed == lastInsemination ? _self.lastInsemination : lastInsemination // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedCalving: freezed == expectedCalving ? _self.expectedCalving : expectedCalving // ignore: cast_nullable_to_non_nullable
as DateTime?,dryOffDate: freezed == dryOffDate ? _self.dryOffDate : dryOffDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastHeat: freezed == lastHeat ? _self.lastHeat : lastHeat // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedHeat: freezed == expectedHeat ? _self.expectedHeat : expectedHeat // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$BreedingEvent {

 String get id; String get animalId;/// insemination | pregnancy_check.
 String get kind; DateTime get eventDate; String get sire;/// pregnancy_check'te pregnant | open.
 String? get result; String get note; String? get authorName;
/// Create a copy of BreedingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BreedingEventCopyWith<BreedingEvent> get copyWith => _$BreedingEventCopyWithImpl<BreedingEvent>(this as BreedingEvent, _$identity);

  /// Serializes this BreedingEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BreedingEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BreedingEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.eventDate, _this.eventDate) || other.eventDate == _this.eventDate)&&(identical(other.sire, _this.sire) || other.sire == _this.sire)&&(identical(other.result, _this.result) || other.result == _this.result)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BreedingEvent;
  return Object.hash(runtimeType,_this.id,_this.animalId,_this.kind,_this.eventDate,_this.sire,_this.result,_this.note,_this.authorName);
}

@override
String toString() {
  final _this = this as BreedingEvent;
  return 'BreedingEvent(id: ${_this.id}, animalId: ${_this.animalId}, kind: ${_this.kind}, eventDate: ${_this.eventDate}, sire: ${_this.sire}, result: ${_this.result}, note: ${_this.note}, authorName: ${_this.authorName})';
}


}

/// @nodoc
abstract mixin class $BreedingEventCopyWith<$Res>  {
  factory $BreedingEventCopyWith(BreedingEvent value, $Res Function(BreedingEvent) _then) = _$BreedingEventCopyWithImpl;
@useResult
$Res call({
 String id, String animalId, String kind, DateTime eventDate, String sire, String? result, String note, String? authorName
});




}
/// @nodoc
class _$BreedingEventCopyWithImpl<$Res>
    implements $BreedingEventCopyWith<$Res> {
  _$BreedingEventCopyWithImpl(this._self, this._then);

  final BreedingEvent _self;
  final $Res Function(BreedingEvent) _then;

/// Create a copy of BreedingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? animalId = null,Object? kind = null,Object? eventDate = null,Object? sire = null,Object? result = freezed,Object? note = null,Object? authorName = freezed,}) {
  return _then(BreedingEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,sire: null == sire ? _self.sire : sire // ignore: cast_nullable_to_non_nullable
as String,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BreedingEvent].
extension BreedingEventPatterns on BreedingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BreedingEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BreedingEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BreedingEvent value)  $default,){
final _that = this;
switch (_that) {
case _BreedingEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BreedingEvent value)?  $default,){
final _that = this;
switch (_that) {
case _BreedingEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String animalId,  String kind,  DateTime eventDate,  String sire,  String? result,  String note,  String? authorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BreedingEvent() when $default != null:
return $default(_that.id,_that.animalId,_that.kind,_that.eventDate,_that.sire,_that.result,_that.note,_that.authorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String animalId,  String kind,  DateTime eventDate,  String sire,  String? result,  String note,  String? authorName)  $default,) {final _that = this;
switch (_that) {
case _BreedingEvent():
return $default(_that.id,_that.animalId,_that.kind,_that.eventDate,_that.sire,_that.result,_that.note,_that.authorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String animalId,  String kind,  DateTime eventDate,  String sire,  String? result,  String note,  String? authorName)?  $default,) {final _that = this;
switch (_that) {
case _BreedingEvent() when $default != null:
return $default(_that.id,_that.animalId,_that.kind,_that.eventDate,_that.sire,_that.result,_that.note,_that.authorName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BreedingEvent extends BreedingEvent {
  const _BreedingEvent({required this.id, required this.animalId, required this.kind, required this.eventDate, this.sire = '', this.result, this.note = '', this.authorName}): super._();
  factory _BreedingEvent.fromJson(Map<String, dynamic> json) => _$BreedingEventFromJson(json);

@override final  String id;
@override final  String animalId;
/// insemination | pregnancy_check.
@override final  String kind;
@override final  DateTime eventDate;
@override@JsonKey() final  String sire;
/// pregnancy_check'te pregnant | open.
@override final  String? result;
@override@JsonKey() final  String note;
@override final  String? authorName;

/// Create a copy of BreedingEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BreedingEventCopyWith<_BreedingEvent> get copyWith => __$BreedingEventCopyWithImpl<_BreedingEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BreedingEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BreedingEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.sire, sire) || other.sire == sire)&&(identical(other.result, result) || other.result == result)&&(identical(other.note, note) || other.note == note)&&(identical(other.authorName, authorName) || other.authorName == authorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,animalId,kind,eventDate,sire,result,note,authorName);
}

@override
String toString() {
    return 'BreedingEvent(id: $id, animalId: $animalId, kind: $kind, eventDate: $eventDate, sire: $sire, result: $result, note: $note, authorName: $authorName)';
}


}

/// @nodoc
abstract mixin class _$BreedingEventCopyWith<$Res> implements $BreedingEventCopyWith<$Res> {
  factory _$BreedingEventCopyWith(_BreedingEvent value, $Res Function(_BreedingEvent) _then) = __$BreedingEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String animalId, String kind, DateTime eventDate, String sire, String? result, String note, String? authorName
});




}
/// @nodoc
class __$BreedingEventCopyWithImpl<$Res>
    implements _$BreedingEventCopyWith<$Res> {
  __$BreedingEventCopyWithImpl(this._self, this._then);

  final _BreedingEvent _self;
  final $Res Function(_BreedingEvent) _then;

/// Create a copy of BreedingEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? animalId = null,Object? kind = null,Object? eventDate = null,Object? sire = null,Object? result = freezed,Object? note = null,Object? authorName = freezed,}) {
  return _then(_BreedingEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,sire: null == sire ? _self.sire : sire // ignore: cast_nullable_to_non_nullable
as String,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpcomingBreeding {

 String get animalId; String get earTag; String? get name;/// calving | dry_off.
 String get event; DateTime get date; String get status;
/// Create a copy of UpcomingBreeding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingBreedingCopyWith<UpcomingBreeding> get copyWith => _$UpcomingBreedingCopyWithImpl<UpcomingBreeding>(this as UpcomingBreeding, _$identity);

  /// Serializes this UpcomingBreeding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpcomingBreeding;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingBreeding&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.earTag, _this.earTag) || other.earTag == _this.earTag)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.event, _this.event) || other.event == _this.event)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpcomingBreeding;
  return Object.hash(runtimeType,_this.animalId,_this.earTag,_this.name,_this.event,_this.date,_this.status);
}

@override
String toString() {
  final _this = this as UpcomingBreeding;
  return 'UpcomingBreeding(animalId: ${_this.animalId}, earTag: ${_this.earTag}, name: ${_this.name}, event: ${_this.event}, date: ${_this.date}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $UpcomingBreedingCopyWith<$Res>  {
  factory $UpcomingBreedingCopyWith(UpcomingBreeding value, $Res Function(UpcomingBreeding) _then) = _$UpcomingBreedingCopyWithImpl;
@useResult
$Res call({
 String animalId, String earTag, String? name, String event, DateTime date, String status
});




}
/// @nodoc
class _$UpcomingBreedingCopyWithImpl<$Res>
    implements $UpcomingBreedingCopyWith<$Res> {
  _$UpcomingBreedingCopyWithImpl(this._self, this._then);

  final UpcomingBreeding _self;
  final $Res Function(UpcomingBreeding) _then;

/// Create a copy of UpcomingBreeding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? earTag = null,Object? name = freezed,Object? event = null,Object? date = null,Object? status = null,}) {
  return _then(UpcomingBreeding(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingBreeding].
extension UpcomingBreedingPatterns on UpcomingBreeding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingBreeding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingBreeding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingBreeding value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingBreeding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingBreeding value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingBreeding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId,  String earTag,  String? name,  String event,  DateTime date,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingBreeding() when $default != null:
return $default(_that.animalId,_that.earTag,_that.name,_that.event,_that.date,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId,  String earTag,  String? name,  String event,  DateTime date,  String status)  $default,) {final _that = this;
switch (_that) {
case _UpcomingBreeding():
return $default(_that.animalId,_that.earTag,_that.name,_that.event,_that.date,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId,  String earTag,  String? name,  String event,  DateTime date,  String status)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingBreeding() when $default != null:
return $default(_that.animalId,_that.earTag,_that.name,_that.event,_that.date,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpcomingBreeding extends UpcomingBreeding {
  const _UpcomingBreeding({required this.animalId, required this.earTag, this.name, required this.event, required this.date, this.status = ''}): super._();
  factory _UpcomingBreeding.fromJson(Map<String, dynamic> json) => _$UpcomingBreedingFromJson(json);

@override final  String animalId;
@override final  String earTag;
@override final  String? name;
/// calving | dry_off.
@override final  String event;
@override final  DateTime date;
@override@JsonKey() final  String status;

/// Create a copy of UpcomingBreeding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingBreedingCopyWith<_UpcomingBreeding> get copyWith => __$UpcomingBreedingCopyWithImpl<_UpcomingBreeding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpcomingBreedingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingBreeding&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.name, name) || other.name == name)&&(identical(other.event, event) || other.event == event)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,earTag,name,event,date,status);
}

@override
String toString() {
    return 'UpcomingBreeding(animalId: $animalId, earTag: $earTag, name: $name, event: $event, date: $date, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UpcomingBreedingCopyWith<$Res> implements $UpcomingBreedingCopyWith<$Res> {
  factory _$UpcomingBreedingCopyWith(_UpcomingBreeding value, $Res Function(_UpcomingBreeding) _then) = __$UpcomingBreedingCopyWithImpl;
@override @useResult
$Res call({
 String animalId, String earTag, String? name, String event, DateTime date, String status
});




}
/// @nodoc
class __$UpcomingBreedingCopyWithImpl<$Res>
    implements _$UpcomingBreedingCopyWith<$Res> {
  __$UpcomingBreedingCopyWithImpl(this._self, this._then);

  final _UpcomingBreeding _self;
  final $Res Function(_UpcomingBreeding) _then;

/// Create a copy of UpcomingBreeding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? earTag = null,Object? name = freezed,Object? event = null,Object? date = null,Object? status = null,}) {
  return _then(_UpcomingBreeding(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
