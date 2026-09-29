// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal_import.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimalImportReport {

 bool get dryRun;/// `update=true` ile istendi: kayıtlı küpeler güncellenir (ADR 0101).
 bool get updateExisting; int get total;/// Eklenecek (önizleme) ya da eklenen hayvan sayısı.
 int get create;/// Küpesi zaten kayıtlı ve güncelleme istenmedi; kayda DOKUNULMAZ.
 int get exists;/// Kayıtlı; en az bir alanı değişecek (değişti).
 int get update;/// Kayıtlı; dosyadaki dolu hücrelerin hepsi kayıtla aynı.
 int get unchanged;/// Atlanan hatalı satır sayısı.
 int get errors;/// Dosyada adı geçen, işletmede olmayan gruplar; içe aktarmada
/// oluşturulur.
 List<String> get newGroups;/// Tanınmayan, alınmayan sütun başlıkları.
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
  final _this = this as AnimalImportReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalImportReport&&(identical(other.dryRun, _this.dryRun) || other.dryRun == _this.dryRun)&&(identical(other.updateExisting, _this.updateExisting) || other.updateExisting == _this.updateExisting)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.create, _this.create) || other.create == _this.create)&&(identical(other.exists, _this.exists) || other.exists == _this.exists)&&(identical(other.update, _this.update) || other.update == _this.update)&&(identical(other.unchanged, _this.unchanged) || other.unchanged == _this.unchanged)&&(identical(other.errors, _this.errors) || other.errors == _this.errors)&&const DeepCollectionEquality().equals(other.newGroups, _this.newGroups)&&const DeepCollectionEquality().equals(other.ignoredColumns, _this.ignoredColumns)&&const DeepCollectionEquality().equals(other.rows, _this.rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalImportReport;
  return Object.hash(runtimeType,_this.dryRun,_this.updateExisting,_this.total,_this.create,_this.exists,_this.update,_this.unchanged,_this.errors,const DeepCollectionEquality().hash(_this.newGroups),const DeepCollectionEquality().hash(_this.ignoredColumns),const DeepCollectionEquality().hash(_this.rows));
}

@override
String toString() {
  final _this = this as AnimalImportReport;
  return 'AnimalImportReport(dryRun: ${_this.dryRun}, updateExisting: ${_this.updateExisting}, total: ${_this.total}, create: ${_this.create}, exists: ${_this.exists}, update: ${_this.update}, unchanged: ${_this.unchanged}, errors: ${_this.errors}, newGroups: ${_this.newGroups}, ignoredColumns: ${_this.ignoredColumns}, rows: ${_this.rows})';
}


}

/// @nodoc
abstract mixin class $AnimalImportReportCopyWith<$Res>  {
  factory $AnimalImportReportCopyWith(AnimalImportReport value, $Res Function(AnimalImportReport) _then) = _$AnimalImportReportCopyWithImpl;
@useResult
$Res call({
 bool dryRun, bool updateExisting, int total, int create, int exists, int update, int unchanged, int errors, List<String> newGroups, List<String> ignoredColumns, List<AnimalImportRow> rows
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
@pragma('vm:prefer-inline') @override $Res call({Object? dryRun = null,Object? updateExisting = null,Object? total = null,Object? create = null,Object? exists = null,Object? update = null,Object? unchanged = null,Object? errors = null,Object? newGroups = null,Object? ignoredColumns = null,Object? rows = null,}) {
  return _then(AnimalImportReport(
dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,updateExisting: null == updateExisting ? _self.updateExisting : updateExisting // ignore: cast_nullable_to_non_nullable
as bool,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,create: null == create ? _self.create : create // ignore: cast_nullable_to_non_nullable
as int,exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as int,update: null == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,newGroups: null == newGroups ? _self.newGroups : newGroups // ignore: cast_nullable_to_non_nullable
as List<String>,ignoredColumns: null == ignoredColumns ? _self.ignoredColumns : ignoredColumns // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool dryRun,  bool updateExisting,  int total,  int create,  int exists,  int update,  int unchanged,  int errors,  List<String> newGroups,  List<String> ignoredColumns,  List<AnimalImportRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalImportReport() when $default != null:
return $default(_that.dryRun,_that.updateExisting,_that.total,_that.create,_that.exists,_that.update,_that.unchanged,_that.errors,_that.newGroups,_that.ignoredColumns,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool dryRun,  bool updateExisting,  int total,  int create,  int exists,  int update,  int unchanged,  int errors,  List<String> newGroups,  List<String> ignoredColumns,  List<AnimalImportRow> rows)  $default,) {final _that = this;
switch (_that) {
case _AnimalImportReport():
return $default(_that.dryRun,_that.updateExisting,_that.total,_that.create,_that.exists,_that.update,_that.unchanged,_that.errors,_that.newGroups,_that.ignoredColumns,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool dryRun,  bool updateExisting,  int total,  int create,  int exists,  int update,  int unchanged,  int errors,  List<String> newGroups,  List<String> ignoredColumns,  List<AnimalImportRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _AnimalImportReport() when $default != null:
return $default(_that.dryRun,_that.updateExisting,_that.total,_that.create,_that.exists,_that.update,_that.unchanged,_that.errors,_that.newGroups,_that.ignoredColumns,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalImportReport extends AnimalImportReport {
  const _AnimalImportReport({this.dryRun = false, this.updateExisting = false, this.total = 0, this.create = 0, this.exists = 0, this.update = 0, this.unchanged = 0, this.errors = 0,  List<String> newGroups = const <String>[],  List<String> ignoredColumns = const <String>[],  List<AnimalImportRow> rows = const <AnimalImportRow>[]}): _newGroups = newGroups,_ignoredColumns = ignoredColumns,_rows = rows,super._();
  factory _AnimalImportReport.fromJson(Map<String, dynamic> json) => _$AnimalImportReportFromJson(json);

@override@JsonKey() final  bool dryRun;
/// `update=true` ile istendi: kayıtlı küpeler güncellenir (ADR 0101).
@override@JsonKey() final  bool updateExisting;
@override@JsonKey() final  int total;
/// Eklenecek (önizleme) ya da eklenen hayvan sayısı.
@override@JsonKey() final  int create;
/// Küpesi zaten kayıtlı ve güncelleme istenmedi; kayda DOKUNULMAZ.
@override@JsonKey() final  int exists;
/// Kayıtlı; en az bir alanı değişecek (değişti).
@override@JsonKey() final  int update;
/// Kayıtlı; dosyadaki dolu hücrelerin hepsi kayıtla aynı.
@override@JsonKey() final  int unchanged;
/// Atlanan hatalı satır sayısı.
@override@JsonKey() final  int errors;
/// Dosyada adı geçen, işletmede olmayan gruplar; içe aktarmada
/// oluşturulur.
 final  List<String> _newGroups;
/// Dosyada adı geçen, işletmede olmayan gruplar; içe aktarmada
/// oluşturulur.
@override@JsonKey() List<String> get newGroups {
  if (_newGroups is EqualUnmodifiableListView) return _newGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_newGroups);
}

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalImportReport&&(identical(other.dryRun, dryRun) || other.dryRun == dryRun)&&(identical(other.updateExisting, updateExisting) || other.updateExisting == updateExisting)&&(identical(other.total, total) || other.total == total)&&(identical(other.create, create) || other.create == create)&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.update, update) || other.update == update)&&(identical(other.unchanged, unchanged) || other.unchanged == unchanged)&&(identical(other.errors, errors) || other.errors == errors)&&const DeepCollectionEquality().equals(other.newGroups, _newGroups)&&const DeepCollectionEquality().equals(other.ignoredColumns, _ignoredColumns)&&const DeepCollectionEquality().equals(other.rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dryRun,updateExisting,total,create,exists,update,unchanged,errors,const DeepCollectionEquality().hash(_newGroups),const DeepCollectionEquality().hash(_ignoredColumns),const DeepCollectionEquality().hash(_rows));
}

@override
String toString() {
    return 'AnimalImportReport(dryRun: $dryRun, updateExisting: $updateExisting, total: $total, create: $create, exists: $exists, update: $update, unchanged: $unchanged, errors: $errors, newGroups: $newGroups, ignoredColumns: $ignoredColumns, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$AnimalImportReportCopyWith<$Res> implements $AnimalImportReportCopyWith<$Res> {
  factory _$AnimalImportReportCopyWith(_AnimalImportReport value, $Res Function(_AnimalImportReport) _then) = __$AnimalImportReportCopyWithImpl;
@override @useResult
$Res call({
 bool dryRun, bool updateExisting, int total, int create, int exists, int update, int unchanged, int errors, List<String> newGroups, List<String> ignoredColumns, List<AnimalImportRow> rows
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
@override @pragma('vm:prefer-inline') $Res call({Object? dryRun = null,Object? updateExisting = null,Object? total = null,Object? create = null,Object? exists = null,Object? update = null,Object? unchanged = null,Object? errors = null,Object? newGroups = null,Object? ignoredColumns = null,Object? rows = null,}) {
  return _then(_AnimalImportReport(
dryRun: null == dryRun ? _self.dryRun : dryRun // ignore: cast_nullable_to_non_nullable
as bool,updateExisting: null == updateExisting ? _self.updateExisting : updateExisting // ignore: cast_nullable_to_non_nullable
as bool,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,create: null == create ? _self.create : create // ignore: cast_nullable_to_non_nullable
as int,exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as int,update: null == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,newGroups: null == newGroups ? _self._newGroups : newGroups // ignore: cast_nullable_to_non_nullable
as List<String>,ignoredColumns: null == ignoredColumns ? _self._ignoredColumns : ignoredColumns // ignore: cast_nullable_to_non_nullable
as List<String>,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<AnimalImportRow>,
  ));
}


}


/// @nodoc
mixin _$AnimalImportRow {

/// Dosyadaki satır numarası (başlık 1).
 int get line; String get earTag; String? get name;/// "create", "exists", "update", "unchanged" ya da "error". String, enum
/// değil: yeni bir sonuç raporu düşürmesin.
 String get outcome;/// Hata sebebi (Türkçe, olduğu gibi gösterilir).
 String? get message;/// Satırı engellemeyen not ("TR ile başlamıyor").
 String? get warning; String? get animalId;/// "update" satırında değişen alanlar.
 List<AnimalImportChange> get changes;
/// Create a copy of AnimalImportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalImportRowCopyWith<AnimalImportRow> get copyWith => _$AnimalImportRowCopyWithImpl<AnimalImportRow>(this as AnimalImportRow, _$identity);

  /// Serializes this AnimalImportRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalImportRow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalImportRow&&(identical(other.line, _this.line) || other.line == _this.line)&&(identical(other.earTag, _this.earTag) || other.earTag == _this.earTag)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.warning, _this.warning) || other.warning == _this.warning)&&(identical(other.animalId, _this.animalId) || other.animalId == _this.animalId)&&const DeepCollectionEquality().equals(other.changes, _this.changes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalImportRow;
  return Object.hash(runtimeType,_this.line,_this.earTag,_this.name,_this.outcome,_this.message,_this.warning,_this.animalId,const DeepCollectionEquality().hash(_this.changes));
}

@override
String toString() {
  final _this = this as AnimalImportRow;
  return 'AnimalImportRow(line: ${_this.line}, earTag: ${_this.earTag}, name: ${_this.name}, outcome: ${_this.outcome}, message: ${_this.message}, warning: ${_this.warning}, animalId: ${_this.animalId}, changes: ${_this.changes})';
}


}

/// @nodoc
abstract mixin class $AnimalImportRowCopyWith<$Res>  {
  factory $AnimalImportRowCopyWith(AnimalImportRow value, $Res Function(AnimalImportRow) _then) = _$AnimalImportRowCopyWithImpl;
@useResult
$Res call({
 int line, String earTag, String? name, String outcome, String? message, String? warning, String? animalId, List<AnimalImportChange> changes
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
@pragma('vm:prefer-inline') @override $Res call({Object? line = null,Object? earTag = null,Object? name = freezed,Object? outcome = null,Object? message = freezed,Object? warning = freezed,Object? animalId = freezed,Object? changes = null,}) {
  return _then(AnimalImportRow(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,changes: null == changes ? _self.changes : changes // ignore: cast_nullable_to_non_nullable
as List<AnimalImportChange>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int line,  String earTag,  String? name,  String outcome,  String? message,  String? warning,  String? animalId,  List<AnimalImportChange> changes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalImportRow() when $default != null:
return $default(_that.line,_that.earTag,_that.name,_that.outcome,_that.message,_that.warning,_that.animalId,_that.changes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int line,  String earTag,  String? name,  String outcome,  String? message,  String? warning,  String? animalId,  List<AnimalImportChange> changes)  $default,) {final _that = this;
switch (_that) {
case _AnimalImportRow():
return $default(_that.line,_that.earTag,_that.name,_that.outcome,_that.message,_that.warning,_that.animalId,_that.changes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int line,  String earTag,  String? name,  String outcome,  String? message,  String? warning,  String? animalId,  List<AnimalImportChange> changes)?  $default,) {final _that = this;
switch (_that) {
case _AnimalImportRow() when $default != null:
return $default(_that.line,_that.earTag,_that.name,_that.outcome,_that.message,_that.warning,_that.animalId,_that.changes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalImportRow extends AnimalImportRow {
  const _AnimalImportRow({required this.line, this.earTag = '', this.name, required this.outcome, this.message, this.warning, this.animalId,  List<AnimalImportChange> changes = const <AnimalImportChange>[]}): _changes = changes,super._();
  factory _AnimalImportRow.fromJson(Map<String, dynamic> json) => _$AnimalImportRowFromJson(json);

/// Dosyadaki satır numarası (başlık 1).
@override final  int line;
@override@JsonKey() final  String earTag;
@override final  String? name;
/// "create", "exists", "update", "unchanged" ya da "error". String, enum
/// değil: yeni bir sonuç raporu düşürmesin.
@override final  String outcome;
/// Hata sebebi (Türkçe, olduğu gibi gösterilir).
@override final  String? message;
/// Satırı engellemeyen not ("TR ile başlamıyor").
@override final  String? warning;
@override final  String? animalId;
/// "update" satırında değişen alanlar.
 final  List<AnimalImportChange> _changes;
/// "update" satırında değişen alanlar.
@override@JsonKey() List<AnimalImportChange> get changes {
  if (_changes is EqualUnmodifiableListView) return _changes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changes);
}


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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalImportRow&&(identical(other.line, line) || other.line == line)&&(identical(other.earTag, earTag) || other.earTag == earTag)&&(identical(other.name, name) || other.name == name)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.message, message) || other.message == message)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.animalId, animalId) || other.animalId == animalId)&&const DeepCollectionEquality().equals(other.changes, _changes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,line,earTag,name,outcome,message,warning,animalId,const DeepCollectionEquality().hash(_changes));
}

@override
String toString() {
    return 'AnimalImportRow(line: $line, earTag: $earTag, name: $name, outcome: $outcome, message: $message, warning: $warning, animalId: $animalId, changes: $changes)';
}


}

/// @nodoc
abstract mixin class _$AnimalImportRowCopyWith<$Res> implements $AnimalImportRowCopyWith<$Res> {
  factory _$AnimalImportRowCopyWith(_AnimalImportRow value, $Res Function(_AnimalImportRow) _then) = __$AnimalImportRowCopyWithImpl;
@override @useResult
$Res call({
 int line, String earTag, String? name, String outcome, String? message, String? warning, String? animalId, List<AnimalImportChange> changes
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
@override @pragma('vm:prefer-inline') $Res call({Object? line = null,Object? earTag = null,Object? name = freezed,Object? outcome = null,Object? message = freezed,Object? warning = freezed,Object? animalId = freezed,Object? changes = null,}) {
  return _then(_AnimalImportRow(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,earTag: null == earTag ? _self.earTag : earTag // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String?,animalId: freezed == animalId ? _self.animalId : animalId // ignore: cast_nullable_to_non_nullable
as String?,changes: null == changes ? _self._changes : changes // ignore: cast_nullable_to_non_nullable
as List<AnimalImportChange>,
  ));
}


}


/// @nodoc
mixin _$AnimalImportChange {

/// name, breed, rfid, status, birthDate, lastCalvingDate, lactationNo,
/// group. String: tanınmayan alan ham gösterilir.
 String get field; String get from; String get to;
/// Create a copy of AnimalImportChange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimalImportChangeCopyWith<AnimalImportChange> get copyWith => _$AnimalImportChangeCopyWithImpl<AnimalImportChange>(this as AnimalImportChange, _$identity);

  /// Serializes this AnimalImportChange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnimalImportChange;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimalImportChange&&(identical(other.field, _this.field) || other.field == _this.field)&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnimalImportChange;
  return Object.hash(runtimeType,_this.field,_this.from,_this.to);
}

@override
String toString() {
  final _this = this as AnimalImportChange;
  return 'AnimalImportChange(field: ${_this.field}, from: ${_this.from}, to: ${_this.to})';
}


}

/// @nodoc
abstract mixin class $AnimalImportChangeCopyWith<$Res>  {
  factory $AnimalImportChangeCopyWith(AnimalImportChange value, $Res Function(AnimalImportChange) _then) = _$AnimalImportChangeCopyWithImpl;
@useResult
$Res call({
 String field, String from, String to
});




}
/// @nodoc
class _$AnimalImportChangeCopyWithImpl<$Res>
    implements $AnimalImportChangeCopyWith<$Res> {
  _$AnimalImportChangeCopyWithImpl(this._self, this._then);

  final AnimalImportChange _self;
  final $Res Function(AnimalImportChange) _then;

/// Create a copy of AnimalImportChange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? from = null,Object? to = null,}) {
  return _then(AnimalImportChange(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AnimalImportChange].
extension AnimalImportChangePatterns on AnimalImportChange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimalImportChange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimalImportChange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimalImportChange value)  $default,){
final _that = this;
switch (_that) {
case _AnimalImportChange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimalImportChange value)?  $default,){
final _that = this;
switch (_that) {
case _AnimalImportChange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String field,  String from,  String to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimalImportChange() when $default != null:
return $default(_that.field,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String field,  String from,  String to)  $default,) {final _that = this;
switch (_that) {
case _AnimalImportChange():
return $default(_that.field,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String field,  String from,  String to)?  $default,) {final _that = this;
switch (_that) {
case _AnimalImportChange() when $default != null:
return $default(_that.field,_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimalImportChange implements AnimalImportChange {
  const _AnimalImportChange({required this.field, this.from = '', this.to = ''});
  factory _AnimalImportChange.fromJson(Map<String, dynamic> json) => _$AnimalImportChangeFromJson(json);

/// name, breed, rfid, status, birthDate, lastCalvingDate, lactationNo,
/// group. String: tanınmayan alan ham gösterilir.
@override final  String field;
@override@JsonKey() final  String from;
@override@JsonKey() final  String to;

/// Create a copy of AnimalImportChange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimalImportChangeCopyWith<_AnimalImportChange> get copyWith => __$AnimalImportChangeCopyWithImpl<_AnimalImportChange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimalImportChangeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimalImportChange&&(identical(other.field, field) || other.field == field)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,field,from,to);
}

@override
String toString() {
    return 'AnimalImportChange(field: $field, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$AnimalImportChangeCopyWith<$Res> implements $AnimalImportChangeCopyWith<$Res> {
  factory _$AnimalImportChangeCopyWith(_AnimalImportChange value, $Res Function(_AnimalImportChange) _then) = __$AnimalImportChangeCopyWithImpl;
@override @useResult
$Res call({
 String field, String from, String to
});




}
/// @nodoc
class __$AnimalImportChangeCopyWithImpl<$Res>
    implements _$AnimalImportChangeCopyWith<$Res> {
  __$AnimalImportChangeCopyWithImpl(this._self, this._then);

  final _AnimalImportChange _self;
  final $Res Function(_AnimalImportChange) _then;

/// Create a copy of AnimalImportChange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? from = null,Object? to = null,}) {
  return _then(_AnimalImportChange(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
