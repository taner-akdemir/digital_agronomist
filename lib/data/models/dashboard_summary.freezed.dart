// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardSummary {

/// Özetin ait olduğu gün.
 DateTime? get date;/// Bugün şu ana kadar alınan toplam süt, mL (§3 birim kuralı).
 int get totalMl;/// Bugün kapanan hayvan sağımı sayısı ve sağılan ayrı hayvan sayısı.
 int get milkingCount; int get animalCount;/// Şu an açık olan sağım oturumu sayısı.
 int get activeSessions;/// Okunmamış uyarı sayısı.
 int get openAlerts; List<SpeciesTotal> get bySpecies;/// §6.4 sınıf dağılımı. Sayısı sıfır olan sınıflar da gelir ki ekran
/// "bu sınıfta hiç yok" ile "bu sınıf hiç hesaplanmadı"yı ayırabilsin.
 List<YieldClassCount> get classDistribution;
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<DashboardSummary> get copyWith => _$DashboardSummaryCopyWithImpl<DashboardSummary>(this as DashboardSummary, _$identity);

  /// Serializes this DashboardSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSummary&&(identical(other.date, date) || other.date == date)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl)&&(identical(other.milkingCount, milkingCount) || other.milkingCount == milkingCount)&&(identical(other.animalCount, animalCount) || other.animalCount == animalCount)&&(identical(other.activeSessions, activeSessions) || other.activeSessions == activeSessions)&&(identical(other.openAlerts, openAlerts) || other.openAlerts == openAlerts)&&const DeepCollectionEquality().equals(other.bySpecies, bySpecies)&&const DeepCollectionEquality().equals(other.classDistribution, classDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,totalMl,milkingCount,animalCount,activeSessions,openAlerts,const DeepCollectionEquality().hash(bySpecies),const DeepCollectionEquality().hash(classDistribution));

@override
String toString() {
  return 'DashboardSummary(date: $date, totalMl: $totalMl, milkingCount: $milkingCount, animalCount: $animalCount, activeSessions: $activeSessions, openAlerts: $openAlerts, bySpecies: $bySpecies, classDistribution: $classDistribution)';
}


}

/// @nodoc
abstract mixin class $DashboardSummaryCopyWith<$Res>  {
  factory $DashboardSummaryCopyWith(DashboardSummary value, $Res Function(DashboardSummary) _then) = _$DashboardSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime? date, int totalMl, int milkingCount, int animalCount, int activeSessions, int openAlerts, List<SpeciesTotal> bySpecies, List<YieldClassCount> classDistribution
});




}
/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._self, this._then);

  final DashboardSummary _self;
  final $Res Function(DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? totalMl = null,Object? milkingCount = null,Object? animalCount = null,Object? activeSessions = null,Object? openAlerts = null,Object? bySpecies = null,Object? classDistribution = null,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,animalCount: null == animalCount ? _self.animalCount : animalCount // ignore: cast_nullable_to_non_nullable
as int,activeSessions: null == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int,openAlerts: null == openAlerts ? _self.openAlerts : openAlerts // ignore: cast_nullable_to_non_nullable
as int,bySpecies: null == bySpecies ? _self.bySpecies : bySpecies // ignore: cast_nullable_to_non_nullable
as List<SpeciesTotal>,classDistribution: null == classDistribution ? _self.classDistribution : classDistribution // ignore: cast_nullable_to_non_nullable
as List<YieldClassCount>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardSummary].
extension DashboardSummaryPatterns on DashboardSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardSummary value)  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? date,  int totalMl,  int milkingCount,  int animalCount,  int activeSessions,  int openAlerts,  List<SpeciesTotal> bySpecies,  List<YieldClassCount> classDistribution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.animalCount,_that.activeSessions,_that.openAlerts,_that.bySpecies,_that.classDistribution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? date,  int totalMl,  int milkingCount,  int animalCount,  int activeSessions,  int openAlerts,  List<SpeciesTotal> bySpecies,  List<YieldClassCount> classDistribution)  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary():
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.animalCount,_that.activeSessions,_that.openAlerts,_that.bySpecies,_that.classDistribution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? date,  int totalMl,  int milkingCount,  int animalCount,  int activeSessions,  int openAlerts,  List<SpeciesTotal> bySpecies,  List<YieldClassCount> classDistribution)?  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.animalCount,_that.activeSessions,_that.openAlerts,_that.bySpecies,_that.classDistribution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardSummary implements DashboardSummary {
  const _DashboardSummary({this.date, this.totalMl = 0, this.milkingCount = 0, this.animalCount = 0, this.activeSessions = 0, this.openAlerts = 0, final  List<SpeciesTotal> bySpecies = const <SpeciesTotal>[], final  List<YieldClassCount> classDistribution = const <YieldClassCount>[]}): _bySpecies = bySpecies,_classDistribution = classDistribution;
  factory _DashboardSummary.fromJson(Map<String, dynamic> json) => _$DashboardSummaryFromJson(json);

/// Özetin ait olduğu gün.
@override final  DateTime? date;
/// Bugün şu ana kadar alınan toplam süt, mL (§3 birim kuralı).
@override@JsonKey() final  int totalMl;
/// Bugün kapanan hayvan sağımı sayısı ve sağılan ayrı hayvan sayısı.
@override@JsonKey() final  int milkingCount;
@override@JsonKey() final  int animalCount;
/// Şu an açık olan sağım oturumu sayısı.
@override@JsonKey() final  int activeSessions;
/// Okunmamış uyarı sayısı.
@override@JsonKey() final  int openAlerts;
 final  List<SpeciesTotal> _bySpecies;
@override@JsonKey() List<SpeciesTotal> get bySpecies {
  if (_bySpecies is EqualUnmodifiableListView) return _bySpecies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bySpecies);
}

/// §6.4 sınıf dağılımı. Sayısı sıfır olan sınıflar da gelir ki ekran
/// "bu sınıfta hiç yok" ile "bu sınıf hiç hesaplanmadı"yı ayırabilsin.
 final  List<YieldClassCount> _classDistribution;
/// §6.4 sınıf dağılımı. Sayısı sıfır olan sınıflar da gelir ki ekran
/// "bu sınıfta hiç yok" ile "bu sınıf hiç hesaplanmadı"yı ayırabilsin.
@override@JsonKey() List<YieldClassCount> get classDistribution {
  if (_classDistribution is EqualUnmodifiableListView) return _classDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classDistribution);
}


/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardSummaryCopyWith<_DashboardSummary> get copyWith => __$DashboardSummaryCopyWithImpl<_DashboardSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSummary&&(identical(other.date, date) || other.date == date)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl)&&(identical(other.milkingCount, milkingCount) || other.milkingCount == milkingCount)&&(identical(other.animalCount, animalCount) || other.animalCount == animalCount)&&(identical(other.activeSessions, activeSessions) || other.activeSessions == activeSessions)&&(identical(other.openAlerts, openAlerts) || other.openAlerts == openAlerts)&&const DeepCollectionEquality().equals(other._bySpecies, _bySpecies)&&const DeepCollectionEquality().equals(other._classDistribution, _classDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,totalMl,milkingCount,animalCount,activeSessions,openAlerts,const DeepCollectionEquality().hash(_bySpecies),const DeepCollectionEquality().hash(_classDistribution));

@override
String toString() {
  return 'DashboardSummary(date: $date, totalMl: $totalMl, milkingCount: $milkingCount, animalCount: $animalCount, activeSessions: $activeSessions, openAlerts: $openAlerts, bySpecies: $bySpecies, classDistribution: $classDistribution)';
}


}

/// @nodoc
abstract mixin class _$DashboardSummaryCopyWith<$Res> implements $DashboardSummaryCopyWith<$Res> {
  factory _$DashboardSummaryCopyWith(_DashboardSummary value, $Res Function(_DashboardSummary) _then) = __$DashboardSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? date, int totalMl, int milkingCount, int animalCount, int activeSessions, int openAlerts, List<SpeciesTotal> bySpecies, List<YieldClassCount> classDistribution
});




}
/// @nodoc
class __$DashboardSummaryCopyWithImpl<$Res>
    implements _$DashboardSummaryCopyWith<$Res> {
  __$DashboardSummaryCopyWithImpl(this._self, this._then);

  final _DashboardSummary _self;
  final $Res Function(_DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? totalMl = null,Object? milkingCount = null,Object? animalCount = null,Object? activeSessions = null,Object? openAlerts = null,Object? bySpecies = null,Object? classDistribution = null,}) {
  return _then(_DashboardSummary(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,animalCount: null == animalCount ? _self.animalCount : animalCount // ignore: cast_nullable_to_non_nullable
as int,activeSessions: null == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int,openAlerts: null == openAlerts ? _self.openAlerts : openAlerts // ignore: cast_nullable_to_non_nullable
as int,bySpecies: null == bySpecies ? _self._bySpecies : bySpecies // ignore: cast_nullable_to_non_nullable
as List<SpeciesTotal>,classDistribution: null == classDistribution ? _self._classDistribution : classDistribution // ignore: cast_nullable_to_non_nullable
as List<YieldClassCount>,
  ));
}


}


/// @nodoc
mixin _$SpeciesTotal {

 String get speciesId; int get totalMl; int get animalCount;
/// Create a copy of SpeciesTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeciesTotalCopyWith<SpeciesTotal> get copyWith => _$SpeciesTotalCopyWithImpl<SpeciesTotal>(this as SpeciesTotal, _$identity);

  /// Serializes this SpeciesTotal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeciesTotal&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl)&&(identical(other.animalCount, animalCount) || other.animalCount == animalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,totalMl,animalCount);

@override
String toString() {
  return 'SpeciesTotal(speciesId: $speciesId, totalMl: $totalMl, animalCount: $animalCount)';
}


}

/// @nodoc
abstract mixin class $SpeciesTotalCopyWith<$Res>  {
  factory $SpeciesTotalCopyWith(SpeciesTotal value, $Res Function(SpeciesTotal) _then) = _$SpeciesTotalCopyWithImpl;
@useResult
$Res call({
 String speciesId, int totalMl, int animalCount
});




}
/// @nodoc
class _$SpeciesTotalCopyWithImpl<$Res>
    implements $SpeciesTotalCopyWith<$Res> {
  _$SpeciesTotalCopyWithImpl(this._self, this._then);

  final SpeciesTotal _self;
  final $Res Function(SpeciesTotal) _then;

/// Create a copy of SpeciesTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speciesId = null,Object? totalMl = null,Object? animalCount = null,}) {
  return _then(_self.copyWith(
speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,animalCount: null == animalCount ? _self.animalCount : animalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeciesTotal].
extension SpeciesTotalPatterns on SpeciesTotal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeciesTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeciesTotal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeciesTotal value)  $default,){
final _that = this;
switch (_that) {
case _SpeciesTotal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeciesTotal value)?  $default,){
final _that = this;
switch (_that) {
case _SpeciesTotal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String speciesId,  int totalMl,  int animalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeciesTotal() when $default != null:
return $default(_that.speciesId,_that.totalMl,_that.animalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String speciesId,  int totalMl,  int animalCount)  $default,) {final _that = this;
switch (_that) {
case _SpeciesTotal():
return $default(_that.speciesId,_that.totalMl,_that.animalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String speciesId,  int totalMl,  int animalCount)?  $default,) {final _that = this;
switch (_that) {
case _SpeciesTotal() when $default != null:
return $default(_that.speciesId,_that.totalMl,_that.animalCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeciesTotal implements SpeciesTotal {
  const _SpeciesTotal({required this.speciesId, this.totalMl = 0, this.animalCount = 0});
  factory _SpeciesTotal.fromJson(Map<String, dynamic> json) => _$SpeciesTotalFromJson(json);

@override final  String speciesId;
@override@JsonKey() final  int totalMl;
@override@JsonKey() final  int animalCount;

/// Create a copy of SpeciesTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeciesTotalCopyWith<_SpeciesTotal> get copyWith => __$SpeciesTotalCopyWithImpl<_SpeciesTotal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeciesTotalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeciesTotal&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl)&&(identical(other.animalCount, animalCount) || other.animalCount == animalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,totalMl,animalCount);

@override
String toString() {
  return 'SpeciesTotal(speciesId: $speciesId, totalMl: $totalMl, animalCount: $animalCount)';
}


}

/// @nodoc
abstract mixin class _$SpeciesTotalCopyWith<$Res> implements $SpeciesTotalCopyWith<$Res> {
  factory _$SpeciesTotalCopyWith(_SpeciesTotal value, $Res Function(_SpeciesTotal) _then) = __$SpeciesTotalCopyWithImpl;
@override @useResult
$Res call({
 String speciesId, int totalMl, int animalCount
});




}
/// @nodoc
class __$SpeciesTotalCopyWithImpl<$Res>
    implements _$SpeciesTotalCopyWith<$Res> {
  __$SpeciesTotalCopyWithImpl(this._self, this._then);

  final _SpeciesTotal _self;
  final $Res Function(_SpeciesTotal) _then;

/// Create a copy of SpeciesTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speciesId = null,Object? totalMl = null,Object? animalCount = null,}) {
  return _then(_SpeciesTotal(
speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,animalCount: null == animalCount ? _self.animalCount : animalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$YieldClassCount {

@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass get yieldClass; int get count;
/// Create a copy of YieldClassCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YieldClassCountCopyWith<YieldClassCount> get copyWith => _$YieldClassCountCopyWithImpl<YieldClassCount>(this as YieldClassCount, _$identity);

  /// Serializes this YieldClassCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YieldClassCount&&(identical(other.yieldClass, yieldClass) || other.yieldClass == yieldClass)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,yieldClass,count);

@override
String toString() {
  return 'YieldClassCount(yieldClass: $yieldClass, count: $count)';
}


}

/// @nodoc
abstract mixin class $YieldClassCountCopyWith<$Res>  {
  factory $YieldClassCountCopyWith(YieldClassCount value, $Res Function(YieldClassCount) _then) = _$YieldClassCountCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, int count
});




}
/// @nodoc
class _$YieldClassCountCopyWithImpl<$Res>
    implements $YieldClassCountCopyWith<$Res> {
  _$YieldClassCountCopyWithImpl(this._self, this._then);

  final YieldClassCount _self;
  final $Res Function(YieldClassCount) _then;

/// Create a copy of YieldClassCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? yieldClass = null,Object? count = null,}) {
  return _then(_self.copyWith(
yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [YieldClassCount].
extension YieldClassCountPatterns on YieldClassCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YieldClassCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YieldClassCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YieldClassCount value)  $default,){
final _that = this;
switch (_that) {
case _YieldClassCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YieldClassCount value)?  $default,){
final _that = this;
switch (_that) {
case _YieldClassCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YieldClassCount() when $default != null:
return $default(_that.yieldClass,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int count)  $default,) {final _that = this;
switch (_that) {
case _YieldClassCount():
return $default(_that.yieldClass,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  int count)?  $default,) {final _that = this;
switch (_that) {
case _YieldClassCount() when $default != null:
return $default(_that.yieldClass,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YieldClassCount implements YieldClassCount {
  const _YieldClassCount({@JsonKey(unknownEnumValue: YieldClass.normal) required this.yieldClass, this.count = 0});
  factory _YieldClassCount.fromJson(Map<String, dynamic> json) => _$YieldClassCountFromJson(json);

@override@JsonKey(unknownEnumValue: YieldClass.normal) final  YieldClass yieldClass;
@override@JsonKey() final  int count;

/// Create a copy of YieldClassCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YieldClassCountCopyWith<_YieldClassCount> get copyWith => __$YieldClassCountCopyWithImpl<_YieldClassCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YieldClassCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _YieldClassCount&&(identical(other.yieldClass, yieldClass) || other.yieldClass == yieldClass)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,yieldClass,count);

@override
String toString() {
  return 'YieldClassCount(yieldClass: $yieldClass, count: $count)';
}


}

/// @nodoc
abstract mixin class _$YieldClassCountCopyWith<$Res> implements $YieldClassCountCopyWith<$Res> {
  factory _$YieldClassCountCopyWith(_YieldClassCount value, $Res Function(_YieldClassCount) _then) = __$YieldClassCountCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, int count
});




}
/// @nodoc
class __$YieldClassCountCopyWithImpl<$Res>
    implements _$YieldClassCountCopyWith<$Res> {
  __$YieldClassCountCopyWithImpl(this._self, this._then);

  final _YieldClassCount _self;
  final $Res Function(_YieldClassCount) _then;

/// Create a copy of YieldClassCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? yieldClass = null,Object? count = null,}) {
  return _then(_YieldClassCount(
yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
