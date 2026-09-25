// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimalNote {

 String get id; String get animalId; String get note;/// Yazanın adı; kullanıcı silindiyse boş.
 String? get authorName; DateTime get createdAt;/// "manual" (elle yazılan), "status" (durum değişikliği, backend ADR
/// 0057) ya da "calving" (buzağılama, ADR 0060). String, enum değil: yeni tür listeyi
/// düşürmesin.
 String get kind;
/// Create a copy of AnimalNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalNoteCopyWith<AnimalNote> get copyWith => _$AnimalNoteCopyWithImpl<AnimalNote>(this as AnimalNote, _$identity);

  /// Serializes this AnimalNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalNote&&(identical(other.id, id) || other.id == id)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.note, note) || other.note == note)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.kind, kind) || other.kind == kind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,animalId,note,authorName,createdAt,kind);

@override
String toString() {
  return 'AnimalNote(id: $id, animalId: $animalId, note: $note, authorName: $authorName, createdAt: $createdAt, kind: $kind)';
}


}

/// @nodoc
abstract mixin class $AnimalNoteCopyWith<$Res>  {
  factory $AnimalNoteCopyWith(AnimalNote value, $Res Function(AnimalNote) _then) = _$AnimalNoteCopyWithImpl;
@useResult
$Res call({
 String id, String animalId, String note, String? authorName, DateTime createdAt, String kind
});




}
/// @nodoc
class _$AnimalNoteCopyWithImpl<$Res>
    implements $AnimalNoteCopyWith<$Res> {
  _$AnimalNoteCopyWithImpl(this._self, this._then);

  final AnimalNote _self;
  final $Res Function(AnimalNote) _then;

/// Create a copy of AnimalNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? animalId = null,Object? note = null,Object? authorName = freezed,Object? createdAt = null,Object? kind = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalNote].
extension AnimalNotePatterns on AnimalNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalNote value)  $default,){
final _that = this;
switch (_that) {
case _AnimalNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalNote value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String animalId,  String note,  String? authorName,  DateTime createdAt,  String kind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalNote() when $default != null:
return $default(_that.id,_that.animalId,_that.note,_that.authorName,_that.createdAt,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String animalId,  String note,  String? authorName,  DateTime createdAt,  String kind)  $default,) {final _that = this;
switch (_that) {
case _AnimalNote():
return $default(_that.id,_that.animalId,_that.note,_that.authorName,_that.createdAt,_that.kind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String animalId,  String note,  String? authorName,  DateTime createdAt,  String kind)?  $default,) {final _that = this;
switch (_that) {
case _AnimalNote() when $default != null:
return $default(_that.id,_that.animalId,_that.note,_that.authorName,_that.createdAt,_that.kind);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalNote extends AnimalNote {
  const _AnimalNote({required this.id, required this.animalId, required this.note, this.authorName, required this.createdAt, this.kind = 'manual'}): super._();
  factory _AnimalNote.fromJson(Map<String, dynamic> json) => _$AnimalNoteFromJson(json);

@override final  String id;
@override final  String animalId;
@override final  String note;
/// Yazanın adı; kullanıcı silindiyse boş.
@override final  String? authorName;
@override final  DateTime createdAt;
/// "manual" (elle yazılan), "status" (durum değişikliği, backend ADR
/// 0057) ya da "calving" (buzağılama, ADR 0060). String, enum değil: yeni tür listeyi
/// düşürmesin.
@override@JsonKey() final  String kind;

/// Create a copy of AnimalNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalNoteCopyWith<_AnimalNote> get copyWith => __$AnimalNoteCopyWithImpl<_AnimalNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalNote&&(identical(other.id, id) || other.id == id)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&(identical(other.note, note) || other.note == note)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.kind, kind) || other.kind == kind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,animalId,note,authorName,createdAt,kind);

@override
String toString() {
  return 'AnimalNote(id: $id, animalId: $animalId, note: $note, authorName: $authorName, createdAt: $createdAt, kind: $kind)';
}


}

/// @nodoc
abstract mixin class _$AnimalNoteCopyWith<$Res> implements $AnimalNoteCopyWith<$Res> {
  factory _$AnimalNoteCopyWith(_AnimalNote value, $Res Function(_AnimalNote) _then) = __$AnimalNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String animalId, String note, String? authorName, DateTime createdAt, String kind
});




}
/// @nodoc
class __$AnimalNoteCopyWithImpl<$Res>
    implements _$AnimalNoteCopyWith<$Res> {
  __$AnimalNoteCopyWithImpl(this._self, this._then);

  final _AnimalNote _self;
  final $Res Function(_AnimalNote) _then;

/// Create a copy of AnimalNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? animalId = null,Object? note = null,Object? authorName = freezed,Object? createdAt = null,Object? kind = null,}) {
  return _then(_AnimalNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,animalId: null == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
