// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionSummary {

 String get sessionId; String get hallName; int get animals; int get volumeMl; int get expectedMl; List<AnimalBrief> get lowYield; List<AnimalBrief> get lowFlow;/// Sağmal olup bu oturumda sağılmayanlar: tek bölgeli işletmede bütün
/// sağmallar, çok bölgelide bu bölgenin önceki oturumunda sağılanlar.
 List<AnimalBrief> get notMilked;
/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSummaryCopyWith<SessionSummary> get copyWith => _$SessionSummaryCopyWithImpl<SessionSummary>(this as SessionSummary, _$identity);

  /// Serializes this SessionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SessionSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSummary&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.hallName, _this.hallName) || other.hallName == _this.hallName)&&(identical(other.animals, _this.animals) || other.animals == _this.animals)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl)&&(identical(other.expectedMl, _this.expectedMl) || other.expectedMl == _this.expectedMl)&&const DeepCollectionEquality().equals(other.lowYield, _this.lowYield)&&const DeepCollectionEquality().equals(other.lowFlow, _this.lowFlow)&&const DeepCollectionEquality().equals(other.notMilked, _this.notMilked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SessionSummary;
  return Object.hash(runtimeType,_this.sessionId,_this.hallName,_this.animals,_this.volumeMl,_this.expectedMl,const DeepCollectionEquality().hash(_this.lowYield),const DeepCollectionEquality().hash(_this.lowFlow),const DeepCollectionEquality().hash(_this.notMilked));
}

@override
String toString() {
  final _this = this as SessionSummary;
  return 'SessionSummary(sessionId: ${_this.sessionId}, hallName: ${_this.hallName}, animals: ${_this.animals}, volumeMl: ${_this.volumeMl}, expectedMl: ${_this.expectedMl}, lowYield: ${_this.lowYield}, lowFlow: ${_this.lowFlow}, notMilked: ${_this.notMilked})';
}


}

/// @nodoc
abstract mixin class $SessionSummaryCopyWith<$Res>  {
  factory $SessionSummaryCopyWith(SessionSummary value, $Res Function(SessionSummary) _then) = _$SessionSummaryCopyWithImpl;
@useResult
$Res call({
 String sessionId, String hallName, int animals, int volumeMl, int expectedMl, List<AnimalBrief> lowYield, List<AnimalBrief> lowFlow, List<AnimalBrief> notMilked
});




}
/// @nodoc
class _$SessionSummaryCopyWithImpl<$Res>
    implements $SessionSummaryCopyWith<$Res> {
  _$SessionSummaryCopyWithImpl(this._self, this._then);

  final SessionSummary _self;
  final $Res Function(SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? hallName = null,Object? animals = null,Object? volumeMl = null,Object? expectedMl = null,Object? lowYield = null,Object? lowFlow = null,Object? notMilked = null,}) {
  return _then(SessionSummary(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,hallName: null == hallName ? _self.hallName : hallName // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,lowYield: null == lowYield ? _self.lowYield : lowYield // ignore: cast_nullable_to_non_nullable
as List<AnimalBrief>,lowFlow: null == lowFlow ? _self.lowFlow : lowFlow // ignore: cast_nullable_to_non_nullable
as List<AnimalBrief>,notMilked: null == notMilked ? _self.notMilked : notMilked // ignore: cast_nullable_to_non_nullable
as List<AnimalBrief>,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionSummary].
extension SessionSummaryPatterns on SessionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionSummary value)  $default,){
final _that = this;
switch (_that) {
case _SessionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String hallName,  int animals,  int volumeMl,  int expectedMl,  List<AnimalBrief> lowYield,  List<AnimalBrief> lowFlow,  List<AnimalBrief> notMilked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.sessionId,_that.hallName,_that.animals,_that.volumeMl,_that.expectedMl,_that.lowYield,_that.lowFlow,_that.notMilked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String hallName,  int animals,  int volumeMl,  int expectedMl,  List<AnimalBrief> lowYield,  List<AnimalBrief> lowFlow,  List<AnimalBrief> notMilked)  $default,) {final _that = this;
switch (_that) {
case _SessionSummary():
return $default(_that.sessionId,_that.hallName,_that.animals,_that.volumeMl,_that.expectedMl,_that.lowYield,_that.lowFlow,_that.notMilked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String hallName,  int animals,  int volumeMl,  int expectedMl,  List<AnimalBrief> lowYield,  List<AnimalBrief> lowFlow,  List<AnimalBrief> notMilked)?  $default,) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.sessionId,_that.hallName,_that.animals,_that.volumeMl,_that.expectedMl,_that.lowYield,_that.lowFlow,_that.notMilked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionSummary implements SessionSummary {
  const _SessionSummary({required this.sessionId, this.hallName = '', this.animals = 0, this.volumeMl = 0, this.expectedMl = 0,  List<AnimalBrief> lowYield = const <AnimalBrief>[],  List<AnimalBrief> lowFlow = const <AnimalBrief>[],  List<AnimalBrief> notMilked = const <AnimalBrief>[]}): _lowYield = lowYield,_lowFlow = lowFlow,_notMilked = notMilked;
  factory _SessionSummary.fromJson(Map<String, dynamic> json) => _$SessionSummaryFromJson(json);

@override final  String sessionId;
@override@JsonKey() final  String hallName;
@override@JsonKey() final  int animals;
@override@JsonKey() final  int volumeMl;
@override@JsonKey() final  int expectedMl;
 final  List<AnimalBrief> _lowYield;
@override@JsonKey() List<AnimalBrief> get lowYield {
  if (_lowYield is EqualUnmodifiableListView) return _lowYield;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lowYield);
}

 final  List<AnimalBrief> _lowFlow;
@override@JsonKey() List<AnimalBrief> get lowFlow {
  if (_lowFlow is EqualUnmodifiableListView) return _lowFlow;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lowFlow);
}

/// Sağmal olup bu oturumda sağılmayanlar: tek bölgeli işletmede bütün
/// sağmallar, çok bölgelide bu bölgenin önceki oturumunda sağılanlar.
 final  List<AnimalBrief> _notMilked;
/// Sağmal olup bu oturumda sağılmayanlar: tek bölgeli işletmede bütün
/// sağmallar, çok bölgelide bu bölgenin önceki oturumunda sağılanlar.
@override@JsonKey() List<AnimalBrief> get notMilked {
  if (_notMilked is EqualUnmodifiableListView) return _notMilked;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notMilked);
}


/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionSummaryCopyWith<_SessionSummary> get copyWith => __$SessionSummaryCopyWithImpl<_SessionSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionSummary&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.hallName, hallName) || other.hallName == hallName)&&(identical(other.animals, animals) || other.animals == animals)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.expectedMl, expectedMl) || other.expectedMl == expectedMl)&&const DeepCollectionEquality().equals(other.lowYield, _lowYield)&&const DeepCollectionEquality().equals(other.lowFlow, _lowFlow)&&const DeepCollectionEquality().equals(other.notMilked, _notMilked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,hallName,animals,volumeMl,expectedMl,const DeepCollectionEquality().hash(_lowYield),const DeepCollectionEquality().hash(_lowFlow),const DeepCollectionEquality().hash(_notMilked));
}

@override
String toString() {
    return 'SessionSummary(sessionId: $sessionId, hallName: $hallName, animals: $animals, volumeMl: $volumeMl, expectedMl: $expectedMl, lowYield: $lowYield, lowFlow: $lowFlow, notMilked: $notMilked)';
}


}

/// @nodoc
abstract mixin class _$SessionSummaryCopyWith<$Res> implements $SessionSummaryCopyWith<$Res> {
  factory _$SessionSummaryCopyWith(_SessionSummary value, $Res Function(_SessionSummary) _then) = __$SessionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String hallName, int animals, int volumeMl, int expectedMl, List<AnimalBrief> lowYield, List<AnimalBrief> lowFlow, List<AnimalBrief> notMilked
});




}
/// @nodoc
class __$SessionSummaryCopyWithImpl<$Res>
    implements _$SessionSummaryCopyWith<$Res> {
  __$SessionSummaryCopyWithImpl(this._self, this._then);

  final _SessionSummary _self;
  final $Res Function(_SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? hallName = null,Object? animals = null,Object? volumeMl = null,Object? expectedMl = null,Object? lowYield = null,Object? lowFlow = null,Object? notMilked = null,}) {
  return _then(_SessionSummary(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,hallName: null == hallName ? _self.hallName : hallName // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,lowYield: null == lowYield ? _self._lowYield : lowYield // ignore: cast_nullable_to_non_nullable
as List<AnimalBrief>,lowFlow: null == lowFlow ? _self._lowFlow : lowFlow // ignore: cast_nullable_to_non_nullable
as List<AnimalBrief>,notMilked: null == notMilked ? _self._notMilked : notMilked // ignore: cast_nullable_to_non_nullable
as List<AnimalBrief>,
  ));
}


}


/// @nodoc
mixin _$AnimalBrief {

 String get animalId; String get earTag; String get name; int get volumeMl; int get expectedMl;
/// Create a copy of AnimalBrief
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalBriefCopyWith<AnimalBrief> get copyWith => _$AnimalBriefCopyWithImpl<AnimalBrief>(this as AnimalBrief, _$identity);

  /// Serializes this AnimalBrief to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalBrief;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalBrief&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&(identical(other.earTag, _this.earTag) || other.earTag == _this.earTag)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.volumeMl, _this.volumeMl) || other.volumeMl == _this.volumeMl)&&(identical(other.expectedMl, _this.expectedMl) || other.expectedMl == _this.expectedMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalBrief;
  return Object.hash(runtimeType,_this.animalId,_this.earTag,_this.name,_this.volumeMl,_this.expectedMl);
}

@override
String toString() {
  final _this = this as AnimalBrief;
  return 'AnimalBrief(animalId: ${_this.animalId}, earTag: ${_this.earTag}, name: ${_this.name}, volumeMl: ${_this.volumeMl}, expectedMl: ${_this.expectedMl})';
}


}

/// @nodoc
abstract mixin class $AnimalBriefCopyWith<$Res>  {
  factory $AnimalBriefCopyWith(AnimalBrief value, $Res Function(AnimalBrief) _then) = _$AnimalBriefCopyWithImpl;
@useResult
$Res call({
 String animalId, String earTag, String name, int volumeMl, int expectedMl
});




}
/// @nodoc
class _$AnimalBriefCopyWithImpl<$Res>
    implements $AnimalBriefCopyWith<$Res> {
  _$AnimalBriefCopyWithImpl(this._self, this._then);

  final AnimalBrief _self;
  final $Res Function(AnimalBrief) _then;

/// Create a copy of AnimalBrief
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animalId = null,Object? earTag = null,Object? name = null,Object? volumeMl = null,Object? expectedMl = null,}) {
  return _then(AnimalBrief(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalBrief].
extension AnimalBriefPatterns on AnimalBrief {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalBrief value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalBrief() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalBrief value)  $default,){
final _that = this;
switch (_that) {
case _AnimalBrief():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalBrief value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalBrief() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String animalId,  String earTag,  String name,  int volumeMl,  int expectedMl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalBrief() when $default != null:
return $default(_that.animalId,_that.earTag,_that.name,_that.volumeMl,_that.expectedMl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String animalId,  String earTag,  String name,  int volumeMl,  int expectedMl)  $default,) {final _that = this;
switch (_that) {
case _AnimalBrief():
return $default(_that.animalId,_that.earTag,_that.name,_that.volumeMl,_that.expectedMl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String animalId,  String earTag,  String name,  int volumeMl,  int expectedMl)?  $default,) {final _that = this;
switch (_that) {
case _AnimalBrief() when $default != null:
return $default(_that.animalId,_that.earTag,_that.name,_that.volumeMl,_that.expectedMl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalBrief extends AnimalBrief {
  const _AnimalBrief({required this.animalId, required this.earTag, this.name = '', this.volumeMl = 0, this.expectedMl = 0}): super._();
  factory _AnimalBrief.fromJson(Map<String, dynamic> json) => _$AnimalBriefFromJson(json);

@override final  String animalId;
@override final  String earTag;
@override@JsonKey() final  String name;
@override@JsonKey() final  int volumeMl;
@override@JsonKey() final  int expectedMl;

/// Create a copy of AnimalBrief
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalBriefCopyWith<_AnimalBrief> get copyWith => __$AnimalBriefCopyWithImpl<_AnimalBrief>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalBriefToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalBrief&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.name, name) || other.name == name)&&(identical(other.volumeMl, volumeMl) || other.volumeMl == volumeMl)&&(identical(other.expectedMl, expectedMl) || other.expectedMl == expectedMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,animalId,earTag,name,volumeMl,expectedMl);
}

@override
String toString() {
    return 'AnimalBrief(animalId: $animalId, earTag: $earTag, name: $name, volumeMl: $volumeMl, expectedMl: $expectedMl)';
}


}

/// @nodoc
abstract mixin class _$AnimalBriefCopyWith<$Res> implements $AnimalBriefCopyWith<$Res> {
  factory _$AnimalBriefCopyWith(_AnimalBrief value, $Res Function(_AnimalBrief) _then) = __$AnimalBriefCopyWithImpl;
@override @useResult
$Res call({
 String animalId, String earTag, String name, int volumeMl, int expectedMl
});




}
/// @nodoc
class __$AnimalBriefCopyWithImpl<$Res>
    implements _$AnimalBriefCopyWith<$Res> {
  __$AnimalBriefCopyWithImpl(this._self, this._then);

  final _AnimalBrief _self;
  final $Res Function(_AnimalBrief) _then;

/// Create a copy of AnimalBrief
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animalId = null,Object? earTag = null,Object? name = null,Object? volumeMl = null,Object? expectedMl = null,}) {
  return _then(_AnimalBrief(
animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,volumeMl: null == volumeMl ? _self.volumeMl : volumeMl // ignore: cast_nullable_to_non_nullable
as int,expectedMl: null == expectedMl ? _self.expectedMl : expectedMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
