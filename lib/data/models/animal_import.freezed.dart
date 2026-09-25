// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal_import.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimalImportReport {

 bool get dryRun; int get total;/// Eklenecek (önizleme) ya da eklenen hayvan sayısı.
 int get create;/// Küpesi zaten kayıtlı; kayda DOKUNULMAZ.
 int get exists;/// Atlanan hatalı satır sayısı.
 int get errors;/// Tanınmayan, alınmayan sütun başlıkları.
 List<String> get ignoredColumns; List<AnimalImportRow> get rows;
/// Create a copy of AnimalImportReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalImportReportCopyWith<AnimalImportReport> get copyWith => _$AnimalImportReportCopyWithImpl<AnimalImportReport>(this as AnimalImportReport, _$identity);

  /// Serializes this AnimalImportReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalImportReport&&(identical(other.dryRun, dryRun) || other.dryRun == dryRun)&&(identical(other.total, total) || other.total == total)&&(identical(other.create, create) || other.create == create)&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.errors, errors) || other.errors == errors)&&const DeepCollectionEquality().equals(other.ignoredColumns, ignoredColumns)&&const DeepCollectionEquality().equals(other.rows, rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dryRun,total,create,exists,errors,const DeepCollectionEquality().hash(ignoredColumns),const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'AnimalImportReport(dryRun: $dryRun, total: $total, create: $create, exists: $exists, errors: $errors, ignoredColumns: $ignoredColumns, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $AnimalImportReportCopyWith<$Res>  {
  factory $AnimalImportReportCopyWith(AnimalImportReport value, $Res Function(AnimalImportReport) _then) = _$AnimalImportReportCopyWithImpl;
@useResult
$Res call({
 bool dryRun, int total, int create, int exists, int errors, List<String> ignoredColumns, List<AnimalImportRow> rows
});




}
/// @nodoc
class _$AnimalImportReportCopyWithImpl<$Res>
    implements $AnimalImportReportCopyWith<$Res> {
  _$AnimalImportReportCopyWithImpl(this._self, this._then);

  final AnimalImportReport _self;
  final $Res Function(AnimalImportReport) _then;

/// Create a copy of AnimalImportReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dryRun = null,Object? total = null,Object? create = null,Object? exists = null,Object? errors = null,Object? ignoredColumns = null,Object? rows = null,}) {
  return _then(_self.copyWith(
dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,create: null == create ? _self.create : create // ignore: cast_nullable_to_non_nullable
as int,exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,ignoredColumns: null == ignoredColumns ? _self.ignoredColumns : ignoredColumns // ignore: cast_nullable_to_non_nullable
as List<String>,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<AnimalImportRow>,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalImportReport].
extension AnimalImportReportPatterns on AnimalImportReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalImportReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalImportReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalImportReport value)  $default,){
final _that = this;
switch (_that) {
case _AnimalImportReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalImportReport value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalImportReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool dryRun,  int total,  int create,  int exists,  int errors,  List<String> ignoredColumns,  List<AnimalImportRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalImportReport() when $default != null:
return $default(_that.dryRun,_that.total,_that.create,_that.exists,_that.errors,_that.ignoredColumns,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool dryRun,  int total,  int create,  int exists,  int errors,  List<String> ignoredColumns,  List<AnimalImportRow> rows)  $default,) {final _that = this;
switch (_that) {
case _AnimalImportReport():
return $default(_that.dryRun,_that.total,_that.create,_that.exists,_that.errors,_that.ignoredColumns,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool dryRun,  int total,  int create,  int exists,  int errors,  List<String> ignoredColumns,  List<AnimalImportRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _AnimalImportReport() when $default != null:
return $default(_that.dryRun,_that.total,_that.create,_that.exists,_that.errors,_that.ignoredColumns,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalImportReport implements AnimalImportReport {
  const _AnimalImportReport({this.dryRun = false, this.total = 0, this.create = 0, this.exists = 0, this.errors = 0, final  List<String> ignoredColumns = const <String>[], final  List<AnimalImportRow> rows = const <AnimalImportRow>[]}): _ignoredColumns = ignoredColumns,_rows = rows;
  factory _AnimalImportReport.fromJson(Map<String, dynamic> json) => _$AnimalImportReportFromJson(json);

@override@JsonKey() final  bool dryRun;
@override@JsonKey() final  int total;
/// Eklenecek (önizleme) ya da eklenen hayvan sayısı.
@override@JsonKey() final  int create;
/// Küpesi zaten kayıtlı; kayda DOKUNULMAZ.
@override@JsonKey() final  int exists;
/// Atlanan hatalı satır sayısı.
@override@JsonKey() final  int errors;
/// Tanınmayan, alınmayan sütun başlıkları.
 final  List<String> _ignoredColumns;
/// Tanınmayan, alınmayan sütun başlıkları.
@override@JsonKey() List<String> get ignoredColumns {
  if (_ignoredColumns is EqualUnmodifiableListView) return _ignoredColumns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ignoredColumns);
}

 final  List<AnimalImportRow> _rows;
@override@JsonKey() List<AnimalImportRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of AnimalImportReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalImportReportCopyWith<_AnimalImportReport> get copyWith => __$AnimalImportReportCopyWithImpl<_AnimalImportReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalImportReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalImportReport&&(identical(other.dryRun, dryRun) || other.dryRun == dryRun)&&(identical(other.total, total) || other.total == total)&&(identical(other.create, create) || other.create == create)&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.errors, errors) || other.errors == errors)&&const DeepCollectionEquality().equals(other._ignoredColumns, _ignoredColumns)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dryRun,total,create,exists,errors,const DeepCollectionEquality().hash(_ignoredColumns),const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'AnimalImportReport(dryRun: $dryRun, total: $total, create: $create, exists: $exists, errors: $errors, ignoredColumns: $ignoredColumns, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$AnimalImportReportCopyWith<$Res> implements $AnimalImportReportCopyWith<$Res> {
  factory _$AnimalImportReportCopyWith(_AnimalImportReport value, $Res Function(_AnimalImportReport) _then) = __$AnimalImportReportCopyWithImpl;
@override @useResult
$Res call({
 bool dryRun, int total, int create, int exists, int errors, List<String> ignoredColumns, List<AnimalImportRow> rows
});




}
/// @nodoc
class __$AnimalImportReportCopyWithImpl<$Res>
    implements _$AnimalImportReportCopyWith<$Res> {
  __$AnimalImportReportCopyWithImpl(this._self, this._then);

  final _AnimalImportReport _self;
  final $Res Function(_AnimalImportReport) _then;

/// Create a copy of AnimalImportReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dryRun = null,Object? total = null,Object? create = null,Object? exists = null,Object? errors = null,Object? ignoredColumns = null,Object? rows = null,}) {
  return _then(_AnimalImportReport(
dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,create: null == create ? _self.create : create // ignore: cast_nullable_to_non_nullable
as int,exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,ignoredColumns: null == ignoredColumns ? _self._ignoredColumns : ignoredColumns // ignore: cast_nullable_to_non_nullable
as List<String>,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<AnimalImportRow>,
  ));
}


}


/// @nodoc
mixin _$AnimalImportRow {

/// Dosyadaki satır numarası (başlık 1).
 int get line; String get earTag; String? get name;/// "create", "exists" ya da "error". String, enum değil: yeni bir sonuç
/// raporu düşürmesin.
 String get outcome;/// Hata sebebi (Türkçe, olduğu gibi gösterilir).
 String? get message;/// Satırı engellemeyen not ("TR ile başlamıyor").
 String? get warning; String? get animalId;
/// Create a copy of AnimalImportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalImportRowCopyWith<AnimalImportRow> get copyWith => _$AnimalImportRowCopyWithImpl<AnimalImportRow>(this as AnimalImportRow, _$identity);

  /// Serializes this AnimalImportRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalImportRow&&(identical(other.line, line) || other.line == line)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.name, name) || other.name == name)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.message, message) || other.message == message)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.animalId, animalId) || other.animalId == animalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line,earTag,name,outcome,message,warning,animalId);

@override
String toString() {
  return 'AnimalImportRow(line: $line, earTag: $earTag, name: $name, outcome: $outcome, message: $message, warning: $warning, animalId: $animalId)';
}


}

/// @nodoc
abstract mixin class $AnimalImportRowCopyWith<$Res>  {
  factory $AnimalImportRowCopyWith(AnimalImportRow value, $Res Function(AnimalImportRow) _then) = _$AnimalImportRowCopyWithImpl;
@useResult
$Res call({
 int line, String earTag, String? name, String outcome, String? message, String? warning, String? animalId
});




}
/// @nodoc
class _$AnimalImportRowCopyWithImpl<$Res>
    implements $AnimalImportRowCopyWith<$Res> {
  _$AnimalImportRowCopyWithImpl(this._self, this._then);

  final AnimalImportRow _self;
  final $Res Function(AnimalImportRow) _then;

/// Create a copy of AnimalImportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line = null,Object? earTag = null,Object? name = freezed,Object? outcome = null,Object? message = freezed,Object? warning = freezed,Object? animalId = freezed,}) {
  return _then(_self.copyWith(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalImportRow].
extension AnimalImportRowPatterns on AnimalImportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalImportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalImportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalImportRow value)  $default,){
final _that = this;
switch (_that) {
case _AnimalImportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalImportRow value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalImportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int line,  String earTag,  String? name,  String outcome,  String? message,  String? warning,  String? animalId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalImportRow() when $default != null:
return $default(_that.line,_that.earTag,_that.name,_that.outcome,_that.message,_that.warning,_that.animalId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int line,  String earTag,  String? name,  String outcome,  String? message,  String? warning,  String? animalId)  $default,) {final _that = this;
switch (_that) {
case _AnimalImportRow():
return $default(_that.line,_that.earTag,_that.name,_that.outcome,_that.message,_that.warning,_that.animalId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int line,  String earTag,  String? name,  String outcome,  String? message,  String? warning,  String? animalId)?  $default,) {final _that = this;
switch (_that) {
case _AnimalImportRow() when $default != null:
return $default(_that.line,_that.earTag,_that.name,_that.outcome,_that.message,_that.warning,_that.animalId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalImportRow extends AnimalImportRow {
  const _AnimalImportRow({required this.line, this.earTag = '', this.name, required this.outcome, this.message, this.warning, this.animalId}): super._();
  factory _AnimalImportRow.fromJson(Map<String, dynamic> json) => _$AnimalImportRowFromJson(json);

/// Dosyadaki satır numarası (başlık 1).
@override final  int line;
@override@JsonKey() final  String earTag;
@override final  String? name;
/// "create", "exists" ya da "error". String, enum değil: yeni bir sonuç
/// raporu düşürmesin.
@override final  String outcome;
/// Hata sebebi (Türkçe, olduğu gibi gösterilir).
@override final  String? message;
/// Satırı engellemeyen not ("TR ile başlamıyor").
@override final  String? warning;
@override final  String? animalId;

/// Create a copy of AnimalImportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalImportRowCopyWith<_AnimalImportRow> get copyWith => __$AnimalImportRowCopyWithImpl<_AnimalImportRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalImportRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalImportRow&&(identical(other.line, line) || other.line == line)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.name, name) || other.name == name)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.message, message) || other.message == message)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.animalId, animalId) || other.animalId == animalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line,earTag,name,outcome,message,warning,animalId);

@override
String toString() {
  return 'AnimalImportRow(line: $line, earTag: $earTag, name: $name, outcome: $outcome, message: $message, warning: $warning, animalId: $animalId)';
}


}

/// @nodoc
abstract mixin class _$AnimalImportRowCopyWith<$Res> implements $AnimalImportRowCopyWith<$Res> {
  factory _$AnimalImportRowCopyWith(_AnimalImportRow value, $Res Function(_AnimalImportRow) _then) = __$AnimalImportRowCopyWithImpl;
@override @useResult
$Res call({
 int line, String earTag, String? name, String outcome, String? message, String? warning, String? animalId
});




}
/// @nodoc
class __$AnimalImportRowCopyWithImpl<$Res>
    implements _$AnimalImportRowCopyWith<$Res> {
  __$AnimalImportRowCopyWithImpl(this._self, this._then);

  final _AnimalImportRow _self;
  final $Res Function(_AnimalImportRow) _then;

/// Create a copy of AnimalImportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line = null,Object? earTag = null,Object? name = freezed,Object? outcome = null,Object? message = freezed,Object? warning = freezed,Object? animalId = freezed,}) {
  return _then(_AnimalImportRow(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
