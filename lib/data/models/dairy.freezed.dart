// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dairy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Dairy {

 String get id; String get name; String get city; String get status;
/// Create a copy of Dairy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DairyCopyWith<Dairy> get copyWith => _$DairyCopyWithImpl<Dairy>(this as Dairy, _$identity);

  /// Serializes this Dairy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Dairy;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dairy&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Dairy;
  return Object.hash(runtimeType,_this.id,_this.name,_this.city,_this.status);
}

@override
String toString() {
  final _this = this as Dairy;
  return 'Dairy(id: ${_this.id}, name: ${_this.name}, city: ${_this.city}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $DairyCopyWith<$Res>  {
  factory $DairyCopyWith(Dairy value, $Res Function(Dairy) _then) = _$DairyCopyWithImpl;
@useResult
$Res call({
 String id, String name, String city, String status
});




}
/// @nodoc
class _$DairyCopyWithImpl<$Res>
    implements $DairyCopyWith<$Res> {
  _$DairyCopyWithImpl(this._self, this._then);

  final Dairy _self;
  final $Res Function(Dairy) _then;

/// Create a copy of Dairy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? city = null,Object? status = null,}) {
  return _then(Dairy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Dairy].
extension DairyPatterns on Dairy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Dairy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Dairy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Dairy value)  $default,){
final _that = this;
switch (_that) {
case _Dairy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Dairy value)?  $default,){
final _that = this;
switch (_that) {
case _Dairy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String city,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Dairy() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String city,  String status)  $default,) {final _that = this;
switch (_that) {
case _Dairy():
return $default(_that.id,_that.name,_that.city,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String city,  String status)?  $default,) {final _that = this;
switch (_that) {
case _Dairy() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Dairy implements Dairy {
  const _Dairy({required this.id, required this.name, this.city = '', this.status = 'active'});
  factory _Dairy.fromJson(Map<String, dynamic> json) => _$DairyFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String city;
@override@JsonKey() final  String status;

/// Create a copy of Dairy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DairyCopyWith<_Dairy> get copyWith => __$DairyCopyWithImpl<_Dairy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DairyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dairy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,city,status);
}

@override
String toString() {
    return 'Dairy(id: $id, name: $name, city: $city, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DairyCopyWith<$Res> implements $DairyCopyWith<$Res> {
  factory _$DairyCopyWith(_Dairy value, $Res Function(_Dairy) _then) = __$DairyCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String city, String status
});




}
/// @nodoc
class __$DairyCopyWithImpl<$Res>
    implements _$DairyCopyWith<$Res> {
  __$DairyCopyWithImpl(this._self, this._then);

  final _Dairy _self;
  final $Res Function(_Dairy) _then;

/// Create a copy of Dairy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? city = null,Object? status = null,}) {
  return _then(_Dairy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DairyShare {

 String get id; String get dairyId; String get dairyName; String get dairyCity; DateTime get grantedAt; String get grantedBy;/// null = süresiz.
 DateTime? get expiresAt; DateTime? get revokedAt;/// active, expired ya da revoked — SUNUCU hesaplar.
 String get status;
/// Create a copy of DairyShare
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DairyShareCopyWith<DairyShare> get copyWith => _$DairyShareCopyWithImpl<DairyShare>(this as DairyShare, _$identity);

  /// Serializes this DairyShare to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DairyShare;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DairyShare&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.dairyId, _this.dairyId) || other.dairyId == _this.dairyId)&&(identical(other.dairyName, _this.dairyName) || other.dairyName == _this.dairyName)&&(identical(other.dairyCity, _this.dairyCity) || other.dairyCity == _this.dairyCity)&&(identical(other.grantedAt, _this.grantedAt) || other.grantedAt == _this.grantedAt)&&(identical(other.grantedBy, _this.grantedBy) || other.grantedBy == _this.grantedBy)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.revokedAt, _this.revokedAt) || other.revokedAt == _this.revokedAt)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DairyShare;
  return Object.hash(runtimeType,_this.id,_this.dairyId,_this.dairyName,_this.dairyCity,_this.grantedAt,_this.grantedBy,_this.expiresAt,_this.revokedAt,_this.status);
}

@override
String toString() {
  final _this = this as DairyShare;
  return 'DairyShare(id: ${_this.id}, dairyId: ${_this.dairyId}, dairyName: ${_this.dairyName}, dairyCity: ${_this.dairyCity}, grantedAt: ${_this.grantedAt}, grantedBy: ${_this.grantedBy}, expiresAt: ${_this.expiresAt}, revokedAt: ${_this.revokedAt}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $DairyShareCopyWith<$Res>  {
  factory $DairyShareCopyWith(DairyShare value, $Res Function(DairyShare) _then) = _$DairyShareCopyWithImpl;
@useResult
$Res call({
 String id, String dairyId, String dairyName, String dairyCity, DateTime grantedAt, String grantedBy, DateTime? expiresAt, DateTime? revokedAt, String status
});




}
/// @nodoc
class _$DairyShareCopyWithImpl<$Res>
    implements $DairyShareCopyWith<$Res> {
  _$DairyShareCopyWithImpl(this._self, this._then);

  final DairyShare _self;
  final $Res Function(DairyShare) _then;

/// Create a copy of DairyShare
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dairyId = null,Object? dairyName = null,Object? dairyCity = null,Object? grantedAt = null,Object? grantedBy = null,Object? expiresAt = freezed,Object? revokedAt = freezed,Object? status = null,}) {
  return _then(DairyShare(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dairyId: null == dairyId ? _self.dairyId : dairyId // ignore: cast_nullable_to_non_nullable
as String,dairyName: null == dairyName ? _self.dairyName : dairyName // ignore: cast_nullable_to_non_nullable
as String,dairyCity: null == dairyCity ? _self.dairyCity : dairyCity // ignore: cast_nullable_to_non_nullable
as String,grantedAt: null == grantedAt ? _self.grantedAt : grantedAt // ignore: cast_nullable_to_non_nullable
as DateTime,grantedBy: null == grantedBy ? _self.grantedBy : grantedBy // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DairyShare].
extension DairySharePatterns on DairyShare {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DairyShare value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DairyShare() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DairyShare value)  $default,){
final _that = this;
switch (_that) {
case _DairyShare():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DairyShare value)?  $default,){
final _that = this;
switch (_that) {
case _DairyShare() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String dairyId,  String dairyName,  String dairyCity,  DateTime grantedAt,  String grantedBy,  DateTime? expiresAt,  DateTime? revokedAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DairyShare() when $default != null:
return $default(_that.id,_that.dairyId,_that.dairyName,_that.dairyCity,_that.grantedAt,_that.grantedBy,_that.expiresAt,_that.revokedAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String dairyId,  String dairyName,  String dairyCity,  DateTime grantedAt,  String grantedBy,  DateTime? expiresAt,  DateTime? revokedAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _DairyShare():
return $default(_that.id,_that.dairyId,_that.dairyName,_that.dairyCity,_that.grantedAt,_that.grantedBy,_that.expiresAt,_that.revokedAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String dairyId,  String dairyName,  String dairyCity,  DateTime grantedAt,  String grantedBy,  DateTime? expiresAt,  DateTime? revokedAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _DairyShare() when $default != null:
return $default(_that.id,_that.dairyId,_that.dairyName,_that.dairyCity,_that.grantedAt,_that.grantedBy,_that.expiresAt,_that.revokedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DairyShare extends DairyShare {
  const _DairyShare({required this.id, required this.dairyId, required this.dairyName, this.dairyCity = '', required this.grantedAt, this.grantedBy = '', this.expiresAt, this.revokedAt, this.status = 'active'}): super._();
  factory _DairyShare.fromJson(Map<String, dynamic> json) => _$DairyShareFromJson(json);

@override final  String id;
@override final  String dairyId;
@override final  String dairyName;
@override@JsonKey() final  String dairyCity;
@override final  DateTime grantedAt;
@override@JsonKey() final  String grantedBy;
/// null = süresiz.
@override final  DateTime? expiresAt;
@override final  DateTime? revokedAt;
/// active, expired ya da revoked — SUNUCU hesaplar.
@override@JsonKey() final  String status;

/// Create a copy of DairyShare
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DairyShareCopyWith<_DairyShare> get copyWith => __$DairyShareCopyWithImpl<_DairyShare>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DairyShareToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DairyShare&&(identical(other.id, id) || other.id == id)&&(identical(other.dairyId, dairyId) || other.dairyId == dairyId)&&(identical(other.dairyName, dairyName) || other.dairyName == dairyName)&&(identical(other.dairyCity, dairyCity) || other.dairyCity == dairyCity)&&(identical(other.grantedAt, grantedAt) || other.grantedAt == grantedAt)&&(identical(other.grantedBy, grantedBy) || other.grantedBy == grantedBy)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,dairyId,dairyName,dairyCity,grantedAt,grantedBy,expiresAt,revokedAt,status);
}

@override
String toString() {
    return 'DairyShare(id: $id, dairyId: $dairyId, dairyName: $dairyName, dairyCity: $dairyCity, grantedAt: $grantedAt, grantedBy: $grantedBy, expiresAt: $expiresAt, revokedAt: $revokedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DairyShareCopyWith<$Res> implements $DairyShareCopyWith<$Res> {
  factory _$DairyShareCopyWith(_DairyShare value, $Res Function(_DairyShare) _then) = __$DairyShareCopyWithImpl;
@override @useResult
$Res call({
 String id, String dairyId, String dairyName, String dairyCity, DateTime grantedAt, String grantedBy, DateTime? expiresAt, DateTime? revokedAt, String status
});




}
/// @nodoc
class __$DairyShareCopyWithImpl<$Res>
    implements _$DairyShareCopyWith<$Res> {
  __$DairyShareCopyWithImpl(this._self, this._then);

  final _DairyShare _self;
  final $Res Function(_DairyShare) _then;

/// Create a copy of DairyShare
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dairyId = null,Object? dairyName = null,Object? dairyCity = null,Object? grantedAt = null,Object? grantedBy = null,Object? expiresAt = freezed,Object? revokedAt = freezed,Object? status = null,}) {
  return _then(_DairyShare(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dairyId: null == dairyId ? _self.dairyId : dairyId // ignore: cast_nullable_to_non_nullable
as String,dairyName: null == dairyName ? _self.dairyName : dairyName // ignore: cast_nullable_to_non_nullable
as String,dairyCity: null == dairyCity ? _self.dairyCity : dairyCity // ignore: cast_nullable_to_non_nullable
as String,grantedAt: null == grantedAt ? _self.grantedAt : grantedAt // ignore: cast_nullable_to_non_nullable
as DateTime,grantedBy: null == grantedBy ? _self.grantedBy : grantedBy // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
