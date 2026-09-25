// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Animal {

 String get id; String get speciesId;/// Küpe numarası — hayvanı tanımlayan alan (TÜRKVET formatı).
 String get earTag;/// RFID küpe; cihaz okuyabiliyorsa otomatik eşleştirme bununla yapılır.
 String? get rfid;/// Çiftçinin verdiği ad ("Sarıkız"). Zorunlu değil.
 String? get name; String? get breed; DateTime? get birthDate; DateTime? get lastCalvingDate; int get lactationNo;/// active | dry | sold | slaughtered | dead
 String get status;/// §6.4 sınıflandırması. Analytics hesaplar, uygulama gösterir.
///
/// Bilinmeyen değer `normal`'a düşer: backend ileride yeni bir sınıf
/// eklerse (§6.4 "konfigüre edilebilir") uygulama parse hatası verip
/// hayvan listesini komple kaybetmemeli.
@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass get yieldClass;/// Sınıfın hesaplandığı gün (backend ADR 0055). Gece hesabı yalnızca
/// sağmal hayvanı güncellediği için sağmaldan çıkan hayvanda DONAR:
/// etiket "o gün böyleydi" demektir. Null = hiç hesaplanmadı ya da
/// tarihi bilinmiyor. Formdan GÖNDERİLMEZ (gövdeyi `animalBody` kuruyor);
/// toJson'da durur ki çevrimdışı önbellek tarihi kaybetmesin.
 DateTime? get yieldClassAt;
/// Create a copy of Animal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalCopyWith<Animal> get copyWith => _$AnimalCopyWithImpl<Animal>(this as Animal, _$identity);

  /// Serializes this Animal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Animal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Animal&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.speciesId, _this.speciesId) || other.speciesId == _this.speciesId)&&(identical(other.earTag, _this.earTag) || other.earTag == _this.earTag)&&(identical(other.rfid, _this.rfid) || other.rfid == _this.rfid)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.breed, _this.breed) || other.breed == _this.breed)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.lastCalvingDate, _this.lastCalvingDate) || other.lastCalvingDate == _this.lastCalvingDate)&&(identical(other.lactationNo, _this.lactationNo) || other.lactationNo == _this.lactationNo)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.yieldClass, _this.yieldClass) || other.yieldClass == _this.yieldClass)&&(identical(other.yieldClassAt, _this.yieldClassAt) || other.yieldClassAt == _this.yieldClassAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Animal;
  return Object.hash(runtimeType,_this.id,_this.speciesId,_this.earTag,_this.rfid,_this.name,_this.breed,_this.birthDate,_this.lastCalvingDate,_this.lactationNo,_this.status,_this.yieldClass,_this.yieldClassAt);
}

@override
String toString() {
  final _this = this as Animal;
  return 'Animal(id: ${_this.id}, speciesId: ${_this.speciesId}, earTag: ${_this.earTag}, rfid: ${_this.rfid}, name: ${_this.name}, breed: ${_this.breed}, birthDate: ${_this.birthDate}, lastCalvingDate: ${_this.lastCalvingDate}, lactationNo: ${_this.lactationNo}, status: ${_this.status}, yieldClass: ${_this.yieldClass}, yieldClassAt: ${_this.yieldClassAt})';
}


}

/// @nodoc
abstract mixin class $AnimalCopyWith<$Res>  {
  factory $AnimalCopyWith(Animal value, $Res Function(Animal) _then) = _$AnimalCopyWithImpl;
@useResult
$Res call({
 String id, String speciesId, String earTag, String? rfid, String? name, String? breed, DateTime? birthDate, DateTime? lastCalvingDate, int lactationNo, String status,@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, DateTime? yieldClassAt
});




}
/// @nodoc
class _$AnimalCopyWithImpl<$Res>
    implements $AnimalCopyWith<$Res> {
  _$AnimalCopyWithImpl(this._self, this._then);

  final Animal _self;
  final $Res Function(Animal) _then;

/// Create a copy of Animal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? speciesId = null,Object? earTag = null,Object? rfid = freezed,Object? name = freezed,Object? breed = freezed,Object? birthDate = freezed,Object? lastCalvingDate = freezed,Object? lactationNo = null,Object? status = null,Object? yieldClass = null,Object? yieldClassAt = freezed,}) {
  return _then(Animal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,rfid: freezed == rfid ? _self.rfid : rfid // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastCalvingDate: freezed == lastCalvingDate ? _self.lastCalvingDate : lastCalvingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lactationNo: null == lactationNo ? _self.lactationNo : lactationNo // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,yieldClassAt: freezed == yieldClassAt ? _self.yieldClassAt : yieldClassAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Animal].
extension AnimalPatterns on Animal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Animal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Animal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Animal value)  $default,){
final _that = this;
switch (_that) {
case _Animal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Animal value)?  $default,){
final _that = this;
switch (_that) {
case _Animal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String speciesId,  String earTag,  String? rfid,  String? name,  String? breed,  DateTime? birthDate,  DateTime? lastCalvingDate,  int lactationNo,  String status, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  DateTime? yieldClassAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Animal() when $default != null:
return $default(_that.id,_that.speciesId,_that.earTag,_that.rfid,_that.name,_that.breed,_that.birthDate,_that.lastCalvingDate,_that.lactationNo,_that.status,_that.yieldClass,_that.yieldClassAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String speciesId,  String earTag,  String? rfid,  String? name,  String? breed,  DateTime? birthDate,  DateTime? lastCalvingDate,  int lactationNo,  String status, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  DateTime? yieldClassAt)  $default,) {final _that = this;
switch (_that) {
case _Animal():
return $default(_that.id,_that.speciesId,_that.earTag,_that.rfid,_that.name,_that.breed,_that.birthDate,_that.lastCalvingDate,_that.lactationNo,_that.status,_that.yieldClass,_that.yieldClassAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String speciesId,  String earTag,  String? rfid,  String? name,  String? breed,  DateTime? birthDate,  DateTime? lastCalvingDate,  int lactationNo,  String status, @JsonKey(unknownEnumValue: YieldClass.normal)  YieldClass yieldClass,  DateTime? yieldClassAt)?  $default,) {final _that = this;
switch (_that) {
case _Animal() when $default != null:
return $default(_that.id,_that.speciesId,_that.earTag,_that.rfid,_that.name,_that.breed,_that.birthDate,_that.lastCalvingDate,_that.lactationNo,_that.status,_that.yieldClass,_that.yieldClassAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Animal extends Animal {
  const _Animal({required this.id, required this.speciesId, required this.earTag, this.rfid, this.name, this.breed, this.birthDate, this.lastCalvingDate, this.lactationNo = 0, this.status = 'active', @JsonKey(unknownEnumValue: YieldClass.normal) this.yieldClass = YieldClass.normal, this.yieldClassAt}): super._();
  factory _Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

@override final  String id;
@override final  String speciesId;
/// Küpe numarası — hayvanı tanımlayan alan (TÜRKVET formatı).
@override final  String earTag;
/// RFID küpe; cihaz okuyabiliyorsa otomatik eşleştirme bununla yapılır.
@override final  String? rfid;
/// Çiftçinin verdiği ad ("Sarıkız"). Zorunlu değil.
@override final  String? name;
@override final  String? breed;
@override final  DateTime? birthDate;
@override final  DateTime? lastCalvingDate;
@override@JsonKey() final  int lactationNo;
/// active | dry | sold | slaughtered | dead
@override@JsonKey() final  String status;
/// §6.4 sınıflandırması. Analytics hesaplar, uygulama gösterir.
///
/// Bilinmeyen değer `normal`'a düşer: backend ileride yeni bir sınıf
/// eklerse (§6.4 "konfigüre edilebilir") uygulama parse hatası verip
/// hayvan listesini komple kaybetmemeli.
@override@JsonKey(unknownEnumValue: YieldClass.normal) final  YieldClass yieldClass;
/// Sınıfın hesaplandığı gün (backend ADR 0055). Gece hesabı yalnızca
/// sağmal hayvanı güncellediği için sağmaldan çıkan hayvanda DONAR:
/// etiket "o gün böyleydi" demektir. Null = hiç hesaplanmadı ya da
/// tarihi bilinmiyor. Formdan GÖNDERİLMEZ (gövdeyi `animalBody` kuruyor);
/// toJson'da durur ki çevrimdışı önbellek tarihi kaybetmesin.
@override final  DateTime? yieldClassAt;

/// Create a copy of Animal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalCopyWith<_Animal> get copyWith => __$AnimalCopyWithImpl<_Animal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Animal&&(identical(other.id, id) || other.id == id)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.rfid, rfid) || other.rfid == rfid)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.lastCalvingDate, lastCalvingDate) || other.lastCalvingDate == lastCalvingDate)&&(identical(other.lactationNo, lactationNo) || other.lactationNo == lactationNo)&&(identical(other.status, status) || other.status == status)&&(identical(other.yieldClass, yieldClass) || other.yieldClass == yieldClass)&&(identical(other.yieldClassAt, yieldClassAt) || other.yieldClassAt == yieldClassAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,speciesId,earTag,rfid,name,breed,birthDate,lastCalvingDate,lactationNo,status,yieldClass,yieldClassAt);
}

@override
String toString() {
    return 'Animal(id: $id, speciesId: $speciesId, earTag: $earTag, rfid: $rfid, name: $name, breed: $breed, birthDate: $birthDate, lastCalvingDate: $lastCalvingDate, lactationNo: $lactationNo, status: $status, yieldClass: $yieldClass, yieldClassAt: $yieldClassAt)';
}


}

/// @nodoc
abstract mixin class _$AnimalCopyWith<$Res> implements $AnimalCopyWith<$Res> {
  factory _$AnimalCopyWith(_Animal value, $Res Function(_Animal) _then) = __$AnimalCopyWithImpl;
@override @useResult
$Res call({
 String id, String speciesId, String earTag, String? rfid, String? name, String? breed, DateTime? birthDate, DateTime? lastCalvingDate, int lactationNo, String status,@JsonKey(unknownEnumValue: YieldClass.normal) YieldClass yieldClass, DateTime? yieldClassAt
});




}
/// @nodoc
class __$AnimalCopyWithImpl<$Res>
    implements _$AnimalCopyWith<$Res> {
  __$AnimalCopyWithImpl(this._self, this._then);

  final _Animal _self;
  final $Res Function(_Animal) _then;

/// Create a copy of Animal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? speciesId = null,Object? earTag = null,Object? rfid = freezed,Object? name = freezed,Object? breed = freezed,Object? birthDate = freezed,Object? lastCalvingDate = freezed,Object? lactationNo = null,Object? status = null,Object? yieldClass = null,Object? yieldClassAt = freezed,}) {
  return _then(_Animal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,rfid: freezed == rfid ? _self.rfid : rfid // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastCalvingDate: freezed == lastCalvingDate ? _self.lastCalvingDate : lastCalvingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lactationNo: null == lactationNo ? _self.lactationNo : lactationNo // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,yieldClass: null == yieldClass ? _self.yieldClass : yieldClass // ignore: cast_nullable_to_non_nullable
as YieldClass,yieldClassAt: freezed == yieldClassAt ? _self.yieldClassAt : yieldClassAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
