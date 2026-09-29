// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'farm_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FarmSummary {

 String get tenantId; String get name; String get role; int get todayMl; int get todayAnimals; int get openAlerts; int get vaccinationsDue;
/// Create a copy of FarmSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FarmSummaryCopyWith<FarmSummary> get copyWith => _$FarmSummaryCopyWithImpl<FarmSummary>(this as FarmSummary, _$identity);

  /// Serializes this FarmSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FarmSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FarmSummary&&(identical(other.tenantId, _this.tenantId) || other.tenantId == _this.tenantId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.todayMl, _this.todayMl) || other.todayMl == _this.todayMl)&&(identical(other.todayAnimals, _this.todayAnimals) || other.todayAnimals == _this.todayAnimals)&&(identical(other.openAlerts, _this.openAlerts) || other.openAlerts == _this.openAlerts)&&(identical(other.vaccinationsDue, _this.vaccinationsDue) || other.vaccinationsDue == _this.vaccinationsDue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FarmSummary;
  return Object.hash(runtimeType,_this.tenantId,_this.name,_this.role,_this.todayMl,_this.todayAnimals,_this.openAlerts,_this.vaccinationsDue);
}

@override
String toString() {
  final _this = this as FarmSummary;
  return 'FarmSummary(tenantId: ${_this.tenantId}, name: ${_this.name}, role: ${_this.role}, todayMl: ${_this.todayMl}, todayAnimals: ${_this.todayAnimals}, openAlerts: ${_this.openAlerts}, vaccinationsDue: ${_this.vaccinationsDue})';
}


}

/// @nodoc
abstract mixin class $FarmSummaryCopyWith<$Res>  {
  factory $FarmSummaryCopyWith(FarmSummary value, $Res Function(FarmSummary) _then) = _$FarmSummaryCopyWithImpl;
@useResult
$Res call({
 String tenantId, String name, String role, int todayMl, int todayAnimals, int openAlerts, int vaccinationsDue
});




}
/// @nodoc
class _$FarmSummaryCopyWithImpl<$Res>
    implements $FarmSummaryCopyWith<$Res> {
  _$FarmSummaryCopyWithImpl(this._self, this._then);

  final FarmSummary _self;
  final $Res Function(FarmSummary) _then;

/// Create a copy of FarmSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenantId = null,Object? name = null,Object? role = null,Object? todayMl = null,Object? todayAnimals = null,Object? openAlerts = null,Object? vaccinationsDue = null,}) {
  return _then(FarmSummary(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,todayMl: null == todayMl ? _self.todayMl : todayMl // ignore: cast_nullable_to_non_nullable
as int,todayAnimals: null == todayAnimals ? _self.todayAnimals : todayAnimals // ignore: cast_nullable_to_non_nullable
as int,openAlerts: null == openAlerts ? _self.openAlerts : openAlerts // ignore: cast_nullable_to_non_nullable
as int,vaccinationsDue: null == vaccinationsDue ? _self.vaccinationsDue : vaccinationsDue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FarmSummary].
extension FarmSummaryPatterns on FarmSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FarmSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FarmSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FarmSummary value)  $default,){
final _that = this;
switch (_that) {
case _FarmSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FarmSummary value)?  $default,){
final _that = this;
switch (_that) {
case _FarmSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tenantId,  String name,  String role,  int todayMl,  int todayAnimals,  int openAlerts,  int vaccinationsDue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FarmSummary() when $default != null:
return $default(_that.tenantId,_that.name,_that.role,_that.todayMl,_that.todayAnimals,_that.openAlerts,_that.vaccinationsDue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tenantId,  String name,  String role,  int todayMl,  int todayAnimals,  int openAlerts,  int vaccinationsDue)  $default,) {final _that = this;
switch (_that) {
case _FarmSummary():
return $default(_that.tenantId,_that.name,_that.role,_that.todayMl,_that.todayAnimals,_that.openAlerts,_that.vaccinationsDue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tenantId,  String name,  String role,  int todayMl,  int todayAnimals,  int openAlerts,  int vaccinationsDue)?  $default,) {final _that = this;
switch (_that) {
case _FarmSummary() when $default != null:
return $default(_that.tenantId,_that.name,_that.role,_that.todayMl,_that.todayAnimals,_that.openAlerts,_that.vaccinationsDue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FarmSummary implements FarmSummary {
  const _FarmSummary({required this.tenantId, required this.name, this.role = '', this.todayMl = 0, this.todayAnimals = 0, this.openAlerts = 0, this.vaccinationsDue = 0});
  factory _FarmSummary.fromJson(Map<String, dynamic> json) => _$FarmSummaryFromJson(json);

@override final  String tenantId;
@override final  String name;
@override@JsonKey() final  String role;
@override@JsonKey() final  int todayMl;
@override@JsonKey() final  int todayAnimals;
@override@JsonKey() final  int openAlerts;
@override@JsonKey() final  int vaccinationsDue;

/// Create a copy of FarmSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FarmSummaryCopyWith<_FarmSummary> get copyWith => __$FarmSummaryCopyWithImpl<_FarmSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FarmSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FarmSummary&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.todayMl, todayMl) || other.todayMl == todayMl)&&(identical(other.todayAnimals, todayAnimals) || other.todayAnimals == todayAnimals)&&(identical(other.openAlerts, openAlerts) || other.openAlerts == openAlerts)&&(identical(other.vaccinationsDue, vaccinationsDue) || other.vaccinationsDue == vaccinationsDue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tenantId,name,role,todayMl,todayAnimals,openAlerts,vaccinationsDue);
}

@override
String toString() {
    return 'FarmSummary(tenantId: $tenantId, name: $name, role: $role, todayMl: $todayMl, todayAnimals: $todayAnimals, openAlerts: $openAlerts, vaccinationsDue: $vaccinationsDue)';
}


}

/// @nodoc
abstract mixin class _$FarmSummaryCopyWith<$Res> implements $FarmSummaryCopyWith<$Res> {
  factory _$FarmSummaryCopyWith(_FarmSummary value, $Res Function(_FarmSummary) _then) = __$FarmSummaryCopyWithImpl;
@override @useResult
$Res call({
 String tenantId, String name, String role, int todayMl, int todayAnimals, int openAlerts, int vaccinationsDue
});




}
/// @nodoc
class __$FarmSummaryCopyWithImpl<$Res>
    implements _$FarmSummaryCopyWith<$Res> {
  __$FarmSummaryCopyWithImpl(this._self, this._then);

  final _FarmSummary _self;
  final $Res Function(_FarmSummary) _then;

/// Create a copy of FarmSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenantId = null,Object? name = null,Object? role = null,Object? todayMl = null,Object? todayAnimals = null,Object? openAlerts = null,Object? vaccinationsDue = null,}) {
  return _then(_FarmSummary(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,todayMl: null == todayMl ? _self.todayMl : todayMl // ignore: cast_nullable_to_non_nullable
as int,todayAnimals: null == todayAnimals ? _self.todayAnimals : todayAnimals // ignore: cast_nullable_to_non_nullable
as int,openAlerts: null == openAlerts ? _self.openAlerts : openAlerts // ignore: cast_nullable_to_non_nullable
as int,vaccinationsDue: null == vaccinationsDue ? _self.vaccinationsDue : vaccinationsDue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
