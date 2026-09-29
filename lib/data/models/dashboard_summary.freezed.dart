// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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
 List<YieldClassCount> get classDistribution;/// Grupların bugünkü toplamı (backend ADR 0092); grup yoksa boş.
 List<GroupTotal> get byGroup;/// Son 12 ayın üreme verimliliği (backend ADR 0120); örnek yoksa null.
 BreedingKpi? get breeding;
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<DashboardSummary> get copyWith => _$DashboardSummaryCopyWithImpl<DashboardSummary>(this as DashboardSummary, _$identity);

  /// Serializes this DashboardSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DashboardSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSummary&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.totalMl, _this.totalMl) || other.totalMl == _this.totalMl)&&(identical(other.milkingCount, _this.milkingCount) || other.milkingCount == _this.milkingCount)&&(identical(other.animalCount, _this.animalCount) || other.animalCount == _this.animalCount)&&(identical(other.activeSessions, _this.activeSessions) || other.activeSessions == _this.activeSessions)&&(identical(other.openAlerts, _this.openAlerts) || other.openAlerts == _this.openAlerts)&&const DeepCollectionEquality().equals(other.bySpecies, _this.bySpecies)&&const DeepCollectionEquality().equals(other.classDistribution, _this.classDistribution)&&const DeepCollectionEquality().equals(other.byGroup, _this.byGroup)&&(identical(other.breeding, _this.breeding) || other.breeding == _this.breeding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DashboardSummary;
  return Object.hash(runtimeType,_this.date,_this.totalMl,_this.milkingCount,_this.animalCount,_this.activeSessions,_this.openAlerts,const DeepCollectionEquality().hash(_this.bySpecies),const DeepCollectionEquality().hash(_this.classDistribution),const DeepCollectionEquality().hash(_this.byGroup),_this.breeding);
}

@override
String toString() {
  final _this = this as DashboardSummary;
  return 'DashboardSummary(date: ${_this.date}, totalMl: ${_this.totalMl}, milkingCount: ${_this.milkingCount}, animalCount: ${_this.animalCount}, activeSessions: ${_this.activeSessions}, openAlerts: ${_this.openAlerts}, bySpecies: ${_this.bySpecies}, classDistribution: ${_this.classDistribution}, byGroup: ${_this.byGroup}, breeding: ${_this.breeding})';
}


}

/// @nodoc
abstract mixin class $DashboardSummaryCopyWith<$Res>  {
  factory $DashboardSummaryCopyWith(DashboardSummary value, $Res Function(DashboardSummary) _then) = _$DashboardSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime? date, int totalMl, int milkingCount, int animalCount, int activeSessions, int openAlerts, List<SpeciesTotal> bySpecies, List<YieldClassCount> classDistribution, List<GroupTotal> byGroup, BreedingKpi? breeding
});


$BreedingKpiCopyWith<$Res>? get breeding;

}
/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._self, this._then);

  final DashboardSummary _self;
  final $Res Function(DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? totalMl = null,Object? milkingCount = null,Object? animalCount = null,Object? activeSessions = null,Object? openAlerts = null,Object? bySpecies = null,Object? classDistribution = null,Object? byGroup = null,Object? breeding = freezed,}) {
  return _then(DashboardSummary(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,animalCount: null == animalCount ? _self.animalCount : animalCount // ignore: cast_nullable_to_non_nullable
as int,activeSessions: null == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int,openAlerts: null == openAlerts ? _self.openAlerts : openAlerts // ignore: cast_nullable_to_non_nullable
as int,bySpecies: null == bySpecies ? _self.bySpecies : bySpecies // ignore: cast_nullable_to_non_nullable
as List<SpeciesTotal>,classDistribution: null == classDistribution ? _self.classDistribution : classDistribution // ignore: cast_nullable_to_non_nullable
as List<YieldClassCount>,byGroup: null == byGroup ? _self.byGroup : byGroup // ignore: cast_nullable_to_non_nullable
as List<GroupTotal>,breeding: freezed == breeding ? _self.breeding : breeding // ignore: cast_nullable_to_non_nullable
as BreedingKpi?,
  ));
}
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BreedingKpiCopyWith<$Res>? get breeding {
    if (_self.breeding == null) {
    return null;
  }

  return $BreedingKpiCopyWith<$Res>(_self.breeding!, (value) {
    return _then(_self.copyWith(breeding: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? date,  int totalMl,  int milkingCount,  int animalCount,  int activeSessions,  int openAlerts,  List<SpeciesTotal> bySpecies,  List<YieldClassCount> classDistribution,  List<GroupTotal> byGroup,  BreedingKpi? breeding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.animalCount,_that.activeSessions,_that.openAlerts,_that.bySpecies,_that.classDistribution,_that.byGroup,_that.breeding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? date,  int totalMl,  int milkingCount,  int animalCount,  int activeSessions,  int openAlerts,  List<SpeciesTotal> bySpecies,  List<YieldClassCount> classDistribution,  List<GroupTotal> byGroup,  BreedingKpi? breeding)  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary():
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.animalCount,_that.activeSessions,_that.openAlerts,_that.bySpecies,_that.classDistribution,_that.byGroup,_that.breeding);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? date,  int totalMl,  int milkingCount,  int animalCount,  int activeSessions,  int openAlerts,  List<SpeciesTotal> bySpecies,  List<YieldClassCount> classDistribution,  List<GroupTotal> byGroup,  BreedingKpi? breeding)?  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.date,_that.totalMl,_that.milkingCount,_that.animalCount,_that.activeSessions,_that.openAlerts,_that.bySpecies,_that.classDistribution,_that.byGroup,_that.breeding);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardSummary implements DashboardSummary {
  const _DashboardSummary({this.date, this.totalMl = 0, this.milkingCount = 0, this.animalCount = 0, this.activeSessions = 0, this.openAlerts = 0,  List<SpeciesTotal> bySpecies = const <SpeciesTotal>[],  List<YieldClassCount> classDistribution = const <YieldClassCount>[],  List<GroupTotal> byGroup = const <GroupTotal>[], this.breeding}): _bySpecies = bySpecies,_classDistribution = classDistribution,_byGroup = byGroup;
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

/// Grupların bugünkü toplamı (backend ADR 0092); grup yoksa boş.
 final  List<GroupTotal> _byGroup;
/// Grupların bugünkü toplamı (backend ADR 0092); grup yoksa boş.
@override@JsonKey() List<GroupTotal> get byGroup {
  if (_byGroup is EqualUnmodifiableListView) return _byGroup;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byGroup);
}

/// Son 12 ayın üreme verimliliği (backend ADR 0120); örnek yoksa null.
@override final  BreedingKpi? breeding;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSummary&&(identical(other.date, date) || other.date == date)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl)&&(identical(other.milkingCount, milkingCount) || other.milkingCount == milkingCount)&&(identical(other.animalCount, animalCount) || other.animalCount == animalCount)&&(identical(other.activeSessions, activeSessions) || other.activeSessions == activeSessions)&&(identical(other.openAlerts, openAlerts) || other.openAlerts == openAlerts)&&const DeepCollectionEquality().equals(other.bySpecies, _bySpecies)&&const DeepCollectionEquality().equals(other.classDistribution, _classDistribution)&&const DeepCollectionEquality().equals(other.byGroup, _byGroup)&&(identical(other.breeding, breeding) || other.breeding == breeding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,totalMl,milkingCount,animalCount,activeSessions,openAlerts,const DeepCollectionEquality().hash(_bySpecies),const DeepCollectionEquality().hash(_classDistribution),const DeepCollectionEquality().hash(_byGroup),breeding);
}

@override
String toString() {
    return 'DashboardSummary(date: $date, totalMl: $totalMl, milkingCount: $milkingCount, animalCount: $animalCount, activeSessions: $activeSessions, openAlerts: $openAlerts, bySpecies: $bySpecies, classDistribution: $classDistribution, byGroup: $byGroup, breeding: $breeding)';
}


}

/// @nodoc
abstract mixin class _$DashboardSummaryCopyWith<$Res> implements $DashboardSummaryCopyWith<$Res> {
  factory _$DashboardSummaryCopyWith(_DashboardSummary value, $Res Function(_DashboardSummary) _then) = __$DashboardSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime? date, int totalMl, int milkingCount, int animalCount, int activeSessions, int openAlerts, List<SpeciesTotal> bySpecies, List<YieldClassCount> classDistribution, List<GroupTotal> byGroup, BreedingKpi? breeding
});


@override $BreedingKpiCopyWith<$Res>? get breeding;

}
/// @nodoc
class __$DashboardSummaryCopyWithImpl<$Res>
    implements _$DashboardSummaryCopyWith<$Res> {
  __$DashboardSummaryCopyWithImpl(this._self, this._then);

  final _DashboardSummary _self;
  final $Res Function(_DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? totalMl = null,Object? milkingCount = null,Object? animalCount = null,Object? activeSessions = null,Object? openAlerts = null,Object? bySpecies = null,Object? classDistribution = null,Object? byGroup = null,Object? breeding = freezed,}) {
  return _then(_DashboardSummary(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,milkingCount: null == milkingCount ? _self.milkingCount : milkingCount // ignore: cast_nullable_to_non_nullable
as int,animalCount: null == animalCount ? _self.animalCount : animalCount // ignore: cast_nullable_to_non_nullable
as int,activeSessions: null == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int,openAlerts: null == openAlerts ? _self.openAlerts : openAlerts // ignore: cast_nullable_to_non_nullable
as int,bySpecies: null == bySpecies ? _self._bySpecies : bySpecies // ignore: cast_nullable_to_non_nullable
as List<SpeciesTotal>,classDistribution: null == classDistribution ? _self._classDistribution : classDistribution // ignore: cast_nullable_to_non_nullable
as List<YieldClassCount>,byGroup: null == byGroup ? _self._byGroup : byGroup // ignore: cast_nullable_to_non_nullable
as List<GroupTotal>,breeding: freezed == breeding ? _self.breeding : breeding // ignore: cast_nullable_to_non_nullable
as BreedingKpi?,
  ));
}

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BreedingKpiCopyWith<$Res>? get breeding {
    if (_self.breeding == null) {
    return null;
  }

  return $BreedingKpiCopyWith<$Res>(_self.breeding!, (value) {
    return _then(_self.copyWith(breeding: value));
  });
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
  final _this = this as SpeciesTotal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeciesTotal&&(identical(other.speciesId, _this.speciesId) || other.speciesId == _this.speciesId)&&(identical(other.totalMl, _this.totalMl) || other.totalMl == _this.totalMl)&&(identical(other.animalCount, _this.animalCount) || other.animalCount == _this.animalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpeciesTotal;
  return Object.hash(runtimeType,_this.speciesId,_this.totalMl,_this.animalCount);
}

@override
String toString() {
  final _this = this as SpeciesTotal;
  return 'SpeciesTotal(speciesId: ${_this.speciesId}, totalMl: ${_this.totalMl}, animalCount: ${_this.animalCount})';
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
  return _then(SpeciesTotal(
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
int get hashCode {
    return Object.hash(runtimeType,speciesId,totalMl,animalCount);
}

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
  final _this = this as YieldClassCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YieldClassCount&&(identical(other.yieldClass, _this.yieldClass) || other.yieldClass == _this.yieldClass)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YieldClassCount;
  return Object.hash(runtimeType,_this.yieldClass,_this.count);
}

@override
String toString() {
  final _this = this as YieldClassCount;
  return 'YieldClassCount(yieldClass: ${_this.yieldClass}, count: ${_this.count})';
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
  return _then(YieldClassCount(
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
int get hashCode {
    return Object.hash(runtimeType,yieldClass,count);
}

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


/// @nodoc
mixin _$GroupTotal {

 String get groupId; String get name;/// Gruptaki sağmal hayvan sayısı.
 int get animals;/// Bugün sağılan.
 int get milked; int get totalMl;
/// Create a copy of GroupTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupTotalCopyWith<GroupTotal> get copyWith => _$GroupTotalCopyWithImpl<GroupTotal>(this as GroupTotal, _$identity);

  /// Serializes this GroupTotal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GroupTotal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupTotal&&(identical(other.groupId, _this.groupId) || other.groupId == _this.groupId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.animals, _this.animals) || other.animals == _this.animals)&&(identical(other.milked, _this.milked) || other.milked == _this.milked)&&(identical(other.totalMl, _this.totalMl) || other.totalMl == _this.totalMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GroupTotal;
  return Object.hash(runtimeType,_this.groupId,_this.name,_this.animals,_this.milked,_this.totalMl);
}

@override
String toString() {
  final _this = this as GroupTotal;
  return 'GroupTotal(groupId: ${_this.groupId}, name: ${_this.name}, animals: ${_this.animals}, milked: ${_this.milked}, totalMl: ${_this.totalMl})';
}


}

/// @nodoc
abstract mixin class $GroupTotalCopyWith<$Res>  {
  factory $GroupTotalCopyWith(GroupTotal value, $Res Function(GroupTotal) _then) = _$GroupTotalCopyWithImpl;
@useResult
$Res call({
 String groupId, String name, int animals, int milked, int totalMl
});




}
/// @nodoc
class _$GroupTotalCopyWithImpl<$Res>
    implements $GroupTotalCopyWith<$Res> {
  _$GroupTotalCopyWithImpl(this._self, this._then);

  final GroupTotal _self;
  final $Res Function(GroupTotal) _then;

/// Create a copy of GroupTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupId = null,Object? name = null,Object? animals = null,Object? milked = null,Object? totalMl = null,}) {
  return _then(GroupTotal(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,milked: null == milked ? _self.milked : milked // ignore: cast_nullable_to_non_nullable
as int,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupTotal].
extension GroupTotalPatterns on GroupTotal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupTotal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupTotal value)  $default,){
final _that = this;
switch (_that) {
case _GroupTotal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupTotal value)?  $default,){
final _that = this;
switch (_that) {
case _GroupTotal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String groupId,  String name,  int animals,  int milked,  int totalMl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupTotal() when $default != null:
return $default(_that.groupId,_that.name,_that.animals,_that.milked,_that.totalMl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String groupId,  String name,  int animals,  int milked,  int totalMl)  $default,) {final _that = this;
switch (_that) {
case _GroupTotal():
return $default(_that.groupId,_that.name,_that.animals,_that.milked,_that.totalMl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String groupId,  String name,  int animals,  int milked,  int totalMl)?  $default,) {final _that = this;
switch (_that) {
case _GroupTotal() when $default != null:
return $default(_that.groupId,_that.name,_that.animals,_that.milked,_that.totalMl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupTotal extends GroupTotal {
  const _GroupTotal({required this.groupId, required this.name, this.animals = 0, this.milked = 0, this.totalMl = 0}): super._();
  factory _GroupTotal.fromJson(Map<String, dynamic> json) => _$GroupTotalFromJson(json);

@override final  String groupId;
@override final  String name;
/// Gruptaki sağmal hayvan sayısı.
@override@JsonKey() final  int animals;
/// Bugün sağılan.
@override@JsonKey() final  int milked;
@override@JsonKey() final  int totalMl;

/// Create a copy of GroupTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupTotalCopyWith<_GroupTotal> get copyWith => __$GroupTotalCopyWithImpl<_GroupTotal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupTotalToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupTotal&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.name, name) || other.name == name)&&(identical(other.animals, animals) || other.animals == animals)&&(identical(other.milked, milked) || other.milked == milked)&&(identical(other.totalMl, totalMl) || other.totalMl == totalMl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,groupId,name,animals,milked,totalMl);
}

@override
String toString() {
    return 'GroupTotal(groupId: $groupId, name: $name, animals: $animals, milked: $milked, totalMl: $totalMl)';
}


}

/// @nodoc
abstract mixin class _$GroupTotalCopyWith<$Res> implements $GroupTotalCopyWith<$Res> {
  factory _$GroupTotalCopyWith(_GroupTotal value, $Res Function(_GroupTotal) _then) = __$GroupTotalCopyWithImpl;
@override @useResult
$Res call({
 String groupId, String name, int animals, int milked, int totalMl
});




}
/// @nodoc
class __$GroupTotalCopyWithImpl<$Res>
    implements _$GroupTotalCopyWith<$Res> {
  __$GroupTotalCopyWithImpl(this._self, this._then);

  final _GroupTotal _self;
  final $Res Function(_GroupTotal) _then;

/// Create a copy of GroupTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? name = null,Object? animals = null,Object? milked = null,Object? totalMl = null,}) {
  return _then(_GroupTotal(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,animals: null == animals ? _self.animals : animals // ignore: cast_nullable_to_non_nullable
as int,milked: null == milked ? _self.milked : milked // ignore: cast_nullable_to_non_nullable
as int,totalMl: null == totalMl ? _self.totalMl : totalMl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BreedingKpi {

 double? get calvingIntervalDays; int get calvingIntervals; double? get firstServicePct; int get firstServices; double? get daysOpen; int get daysOpenN;
/// Create a copy of BreedingKpi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BreedingKpiCopyWith<BreedingKpi> get copyWith => _$BreedingKpiCopyWithImpl<BreedingKpi>(this as BreedingKpi, _$identity);

  /// Serializes this BreedingKpi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BreedingKpi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BreedingKpi&&(identical(other.calvingIntervalDays, _this.calvingIntervalDays) || other.calvingIntervalDays == _this.calvingIntervalDays)&&(identical(other.calvingIntervals, _this.calvingIntervals) || other.calvingIntervals == _this.calvingIntervals)&&(identical(other.firstServicePct, _this.firstServicePct) || other.firstServicePct == _this.firstServicePct)&&(identical(other.firstServices, _this.firstServices) || other.firstServices == _this.firstServices)&&(identical(other.daysOpen, _this.daysOpen) || other.daysOpen == _this.daysOpen)&&(identical(other.daysOpenN, _this.daysOpenN) || other.daysOpenN == _this.daysOpenN));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BreedingKpi;
  return Object.hash(runtimeType,_this.calvingIntervalDays,_this.calvingIntervals,_this.firstServicePct,_this.firstServices,_this.daysOpen,_this.daysOpenN);
}

@override
String toString() {
  final _this = this as BreedingKpi;
  return 'BreedingKpi(calvingIntervalDays: ${_this.calvingIntervalDays}, calvingIntervals: ${_this.calvingIntervals}, firstServicePct: ${_this.firstServicePct}, firstServices: ${_this.firstServices}, daysOpen: ${_this.daysOpen}, daysOpenN: ${_this.daysOpenN})';
}


}

/// @nodoc
abstract mixin class $BreedingKpiCopyWith<$Res>  {
  factory $BreedingKpiCopyWith(BreedingKpi value, $Res Function(BreedingKpi) _then) = _$BreedingKpiCopyWithImpl;
@useResult
$Res call({
 double? calvingIntervalDays, int calvingIntervals, double? firstServicePct, int firstServices, double? daysOpen, int daysOpenN
});




}
/// @nodoc
class _$BreedingKpiCopyWithImpl<$Res>
    implements $BreedingKpiCopyWith<$Res> {
  _$BreedingKpiCopyWithImpl(this._self, this._then);

  final BreedingKpi _self;
  final $Res Function(BreedingKpi) _then;

/// Create a copy of BreedingKpi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calvingIntervalDays = freezed,Object? calvingIntervals = null,Object? firstServicePct = freezed,Object? firstServices = null,Object? daysOpen = freezed,Object? daysOpenN = null,}) {
  return _then(BreedingKpi(
calvingIntervalDays: freezed == calvingIntervalDays ? _self.calvingIntervalDays : calvingIntervalDays // ignore: cast_nullable_to_non_nullable
as double?,calvingIntervals: null == calvingIntervals ? _self.calvingIntervals : calvingIntervals // ignore: cast_nullable_to_non_nullable
as int,firstServicePct: freezed == firstServicePct ? _self.firstServicePct : firstServicePct // ignore: cast_nullable_to_non_nullable
as double?,firstServices: null == firstServices ? _self.firstServices : firstServices // ignore: cast_nullable_to_non_nullable
as int,daysOpen: freezed == daysOpen ? _self.daysOpen : daysOpen // ignore: cast_nullable_to_non_nullable
as double?,daysOpenN: null == daysOpenN ? _self.daysOpenN : daysOpenN // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BreedingKpi].
extension BreedingKpiPatterns on BreedingKpi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BreedingKpi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BreedingKpi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BreedingKpi value)  $default,){
final _that = this;
switch (_that) {
case _BreedingKpi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BreedingKpi value)?  $default,){
final _that = this;
switch (_that) {
case _BreedingKpi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? calvingIntervalDays,  int calvingIntervals,  double? firstServicePct,  int firstServices,  double? daysOpen,  int daysOpenN)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BreedingKpi() when $default != null:
return $default(_that.calvingIntervalDays,_that.calvingIntervals,_that.firstServicePct,_that.firstServices,_that.daysOpen,_that.daysOpenN);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? calvingIntervalDays,  int calvingIntervals,  double? firstServicePct,  int firstServices,  double? daysOpen,  int daysOpenN)  $default,) {final _that = this;
switch (_that) {
case _BreedingKpi():
return $default(_that.calvingIntervalDays,_that.calvingIntervals,_that.firstServicePct,_that.firstServices,_that.daysOpen,_that.daysOpenN);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? calvingIntervalDays,  int calvingIntervals,  double? firstServicePct,  int firstServices,  double? daysOpen,  int daysOpenN)?  $default,) {final _that = this;
switch (_that) {
case _BreedingKpi() when $default != null:
return $default(_that.calvingIntervalDays,_that.calvingIntervals,_that.firstServicePct,_that.firstServices,_that.daysOpen,_that.daysOpenN);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BreedingKpi implements BreedingKpi {
  const _BreedingKpi({this.calvingIntervalDays, this.calvingIntervals = 0, this.firstServicePct, this.firstServices = 0, this.daysOpen, this.daysOpenN = 0});
  factory _BreedingKpi.fromJson(Map<String, dynamic> json) => _$BreedingKpiFromJson(json);

@override final  double? calvingIntervalDays;
@override@JsonKey() final  int calvingIntervals;
@override final  double? firstServicePct;
@override@JsonKey() final  int firstServices;
@override final  double? daysOpen;
@override@JsonKey() final  int daysOpenN;

/// Create a copy of BreedingKpi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BreedingKpiCopyWith<_BreedingKpi> get copyWith => __$BreedingKpiCopyWithImpl<_BreedingKpi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BreedingKpiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BreedingKpi&&(identical(other.calvingIntervalDays, calvingIntervalDays) || other.calvingIntervalDays == calvingIntervalDays)&&(identical(other.calvingIntervals, calvingIntervals) || other.calvingIntervals == calvingIntervals)&&(identical(other.firstServicePct, firstServicePct) || other.firstServicePct == firstServicePct)&&(identical(other.firstServices, firstServices) || other.firstServices == firstServices)&&(identical(other.daysOpen, daysOpen) || other.daysOpen == daysOpen)&&(identical(other.daysOpenN, daysOpenN) || other.daysOpenN == daysOpenN));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,calvingIntervalDays,calvingIntervals,firstServicePct,firstServices,daysOpen,daysOpenN);
}

@override
String toString() {
    return 'BreedingKpi(calvingIntervalDays: $calvingIntervalDays, calvingIntervals: $calvingIntervals, firstServicePct: $firstServicePct, firstServices: $firstServices, daysOpen: $daysOpen, daysOpenN: $daysOpenN)';
}


}

/// @nodoc
abstract mixin class _$BreedingKpiCopyWith<$Res> implements $BreedingKpiCopyWith<$Res> {
  factory _$BreedingKpiCopyWith(_BreedingKpi value, $Res Function(_BreedingKpi) _then) = __$BreedingKpiCopyWithImpl;
@override @useResult
$Res call({
 double? calvingIntervalDays, int calvingIntervals, double? firstServicePct, int firstServices, double? daysOpen, int daysOpenN
});




}
/// @nodoc
class __$BreedingKpiCopyWithImpl<$Res>
    implements _$BreedingKpiCopyWith<$Res> {
  __$BreedingKpiCopyWithImpl(this._self, this._then);

  final _BreedingKpi _self;
  final $Res Function(_BreedingKpi) _then;

/// Create a copy of BreedingKpi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calvingIntervalDays = freezed,Object? calvingIntervals = null,Object? firstServicePct = freezed,Object? firstServices = null,Object? daysOpen = freezed,Object? daysOpenN = null,}) {
  return _then(_BreedingKpi(
calvingIntervalDays: freezed == calvingIntervalDays ? _self.calvingIntervalDays : calvingIntervalDays // ignore: cast_nullable_to_non_nullable
as double?,calvingIntervals: null == calvingIntervals ? _self.calvingIntervals : calvingIntervals // ignore: cast_nullable_to_non_nullable
as int,firstServicePct: freezed == firstServicePct ? _self.firstServicePct : firstServicePct // ignore: cast_nullable_to_non_nullable
as double?,firstServices: null == firstServices ? _self.firstServices : firstServices // ignore: cast_nullable_to_non_nullable
as int,daysOpen: freezed == daysOpen ? _self.daysOpen : daysOpen // ignore: cast_nullable_to_non_nullable
as double?,daysOpenN: null == daysOpenN ? _self.daysOpenN : daysOpenN // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
