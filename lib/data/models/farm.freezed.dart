// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'farm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Farm {

 String get id; String get name; String? get tenantId; String? get city; String? get district;/// Konum (backend ADR 0119): ısı stresi tahmininin girdisi; ikisi
/// birlikte dolu ya da boş.
 double? get latitude; double? get longitude;
/// Create a copy of Farm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FarmCopyWith<Farm> get copyWith => _$FarmCopyWithImpl<Farm>(this as Farm, _$identity);

  /// Serializes this Farm to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Farm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Farm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.tenantId, _this.tenantId) || other.tenantId == _this.tenantId)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.district, _this.district) || other.district == _this.district)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Farm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.tenantId,_this.city,_this.district,_this.latitude,_this.longitude);
}

@override
String toString() {
  final _this = this as Farm;
  return 'Farm(id: ${_this.id}, name: ${_this.name}, tenantId: ${_this.tenantId}, city: ${_this.city}, district: ${_this.district}, latitude: ${_this.latitude}, longitude: ${_this.longitude})';
}


}

/// @nodoc
abstract mixin class $FarmCopyWith<$Res>  {
  factory $FarmCopyWith(Farm value, $Res Function(Farm) _then) = _$FarmCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? tenantId, String? city, String? district, double? latitude, double? longitude
});




}
/// @nodoc
class _$FarmCopyWithImpl<$Res>
    implements $FarmCopyWith<$Res> {
  _$FarmCopyWithImpl(this._self, this._then);

  final Farm _self;
  final $Res Function(Farm) _then;

/// Create a copy of Farm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? tenantId = freezed,Object? city = freezed,Object? district = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(Farm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Farm].
extension FarmPatterns on Farm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Farm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Farm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Farm value)  $default,){
final _that = this;
switch (_that) {
case _Farm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Farm value)?  $default,){
final _that = this;
switch (_that) {
case _Farm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? tenantId,  String? city,  String? district,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Farm() when $default != null:
return $default(_that.id,_that.name,_that.tenantId,_that.city,_that.district,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? tenantId,  String? city,  String? district,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _Farm():
return $default(_that.id,_that.name,_that.tenantId,_that.city,_that.district,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? tenantId,  String? city,  String? district,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _Farm() when $default != null:
return $default(_that.id,_that.name,_that.tenantId,_that.city,_that.district,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Farm implements Farm {
  const _Farm({required this.id, required this.name, this.tenantId, this.city, this.district, this.latitude, this.longitude});
  factory _Farm.fromJson(Map<String, dynamic> json) => _$FarmFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? tenantId;
@override final  String? city;
@override final  String? district;
/// Konum (backend ADR 0119): ısı stresi tahmininin girdisi; ikisi
/// birlikte dolu ya da boş.
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of Farm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FarmCopyWith<_Farm> get copyWith => __$FarmCopyWithImpl<_Farm>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FarmToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Farm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,tenantId,city,district,latitude,longitude);
}

@override
String toString() {
    return 'Farm(id: $id, name: $name, tenantId: $tenantId, city: $city, district: $district, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$FarmCopyWith<$Res> implements $FarmCopyWith<$Res> {
  factory _$FarmCopyWith(_Farm value, $Res Function(_Farm) _then) = __$FarmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? tenantId, String? city, String? district, double? latitude, double? longitude
});




}
/// @nodoc
class __$FarmCopyWithImpl<$Res>
    implements _$FarmCopyWith<$Res> {
  __$FarmCopyWithImpl(this._self, this._then);

  final _Farm _self;
  final $Res Function(_Farm) _then;

/// Create a copy of Farm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? tenantId = freezed,Object? city = freezed,Object? district = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_Farm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
