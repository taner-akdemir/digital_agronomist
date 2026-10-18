// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assistant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssistantStatus {

 bool get enabled; int get limit; int get remainingToday;
/// Create a copy of AssistantStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssistantStatusCopyWith<AssistantStatus> get copyWith => _$AssistantStatusCopyWithImpl<AssistantStatus>(this as AssistantStatus, _$identity);

  /// Serializes this AssistantStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AssistantStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssistantStatus&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.limit, _this.limit) || other.limit == _this.limit)&&(identical(other.remainingToday, _this.remainingToday) || other.remainingToday == _this.remainingToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AssistantStatus;
  return Object.hash(runtimeType,_this.enabled,_this.limit,_this.remainingToday);
}

@override
String toString() {
  final _this = this as AssistantStatus;
  return 'AssistantStatus(enabled: ${_this.enabled}, limit: ${_this.limit}, remainingToday: ${_this.remainingToday})';
}


}

/// @nodoc
abstract mixin class $AssistantStatusCopyWith<$Res>  {
  factory $AssistantStatusCopyWith(AssistantStatus value, $Res Function(AssistantStatus) _then) = _$AssistantStatusCopyWithImpl;
@useResult
$Res call({
 bool enabled, int limit, int remainingToday
});




}
/// @nodoc
class _$AssistantStatusCopyWithImpl<$Res>
    implements $AssistantStatusCopyWith<$Res> {
  _$AssistantStatusCopyWithImpl(this._self, this._then);

  final AssistantStatus _self;
  final $Res Function(AssistantStatus) _then;

/// Create a copy of AssistantStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? limit = null,Object? remainingToday = null,}) {
  return _then(AssistantStatus(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,remainingToday: null == remainingToday ? _self.remainingToday : remainingToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AssistantStatus].
extension AssistantStatusPatterns on AssistantStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssistantStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssistantStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssistantStatus value)  $default,){
final _that = this;
switch (_that) {
case _AssistantStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssistantStatus value)?  $default,){
final _that = this;
switch (_that) {
case _AssistantStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int limit,  int remainingToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssistantStatus() when $default != null:
return $default(_that.enabled,_that.limit,_that.remainingToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int limit,  int remainingToday)  $default,) {final _that = this;
switch (_that) {
case _AssistantStatus():
return $default(_that.enabled,_that.limit,_that.remainingToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int limit,  int remainingToday)?  $default,) {final _that = this;
switch (_that) {
case _AssistantStatus() when $default != null:
return $default(_that.enabled,_that.limit,_that.remainingToday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssistantStatus implements AssistantStatus {
  const _AssistantStatus({this.enabled = false, this.limit = 0, this.remainingToday = 0});
  factory _AssistantStatus.fromJson(Map<String, dynamic> json) => _$AssistantStatusFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int limit;
@override@JsonKey() final  int remainingToday;

/// Create a copy of AssistantStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssistantStatusCopyWith<_AssistantStatus> get copyWith => __$AssistantStatusCopyWithImpl<_AssistantStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssistantStatusToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssistantStatus&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.remainingToday, remainingToday) || other.remainingToday == remainingToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enabled,limit,remainingToday);
}

@override
String toString() {
    return 'AssistantStatus(enabled: $enabled, limit: $limit, remainingToday: $remainingToday)';
}


}

/// @nodoc
abstract mixin class _$AssistantStatusCopyWith<$Res> implements $AssistantStatusCopyWith<$Res> {
  factory _$AssistantStatusCopyWith(_AssistantStatus value, $Res Function(_AssistantStatus) _then) = __$AssistantStatusCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int limit, int remainingToday
});




}
/// @nodoc
class __$AssistantStatusCopyWithImpl<$Res>
    implements _$AssistantStatusCopyWith<$Res> {
  __$AssistantStatusCopyWithImpl(this._self, this._then);

  final _AssistantStatus _self;
  final $Res Function(_AssistantStatus) _then;

/// Create a copy of AssistantStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? limit = null,Object? remainingToday = null,}) {
  return _then(_AssistantStatus(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,remainingToday: null == remainingToday ? _self.remainingToday : remainingToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AssistantMessage {

 String get role; String get text;
/// Create a copy of AssistantMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssistantMessageCopyWith<AssistantMessage> get copyWith => _$AssistantMessageCopyWithImpl<AssistantMessage>(this as AssistantMessage, _$identity);

  /// Serializes this AssistantMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AssistantMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssistantMessage&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.text, _this.text) || other.text == _this.text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AssistantMessage;
  return Object.hash(runtimeType,_this.role,_this.text);
}

@override
String toString() {
  final _this = this as AssistantMessage;
  return 'AssistantMessage(role: ${_this.role}, text: ${_this.text})';
}


}

/// @nodoc
abstract mixin class $AssistantMessageCopyWith<$Res>  {
  factory $AssistantMessageCopyWith(AssistantMessage value, $Res Function(AssistantMessage) _then) = _$AssistantMessageCopyWithImpl;
@useResult
$Res call({
 String role, String text
});




}
/// @nodoc
class _$AssistantMessageCopyWithImpl<$Res>
    implements $AssistantMessageCopyWith<$Res> {
  _$AssistantMessageCopyWithImpl(this._self, this._then);

  final AssistantMessage _self;
  final $Res Function(AssistantMessage) _then;

/// Create a copy of AssistantMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? text = null,}) {
  return _then(AssistantMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AssistantMessage].
extension AssistantMessagePatterns on AssistantMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssistantMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssistantMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssistantMessage value)  $default,){
final _that = this;
switch (_that) {
case _AssistantMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssistantMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AssistantMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssistantMessage() when $default != null:
return $default(_that.role,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String text)  $default,) {final _that = this;
switch (_that) {
case _AssistantMessage():
return $default(_that.role,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String text)?  $default,) {final _that = this;
switch (_that) {
case _AssistantMessage() when $default != null:
return $default(_that.role,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssistantMessage implements AssistantMessage {
  const _AssistantMessage({required this.role, required this.text});
  factory _AssistantMessage.fromJson(Map<String, dynamic> json) => _$AssistantMessageFromJson(json);

@override final  String role;
@override final  String text;

/// Create a copy of AssistantMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssistantMessageCopyWith<_AssistantMessage> get copyWith => __$AssistantMessageCopyWithImpl<_AssistantMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssistantMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssistantMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,role,text);
}

@override
String toString() {
    return 'AssistantMessage(role: $role, text: $text)';
}


}

/// @nodoc
abstract mixin class _$AssistantMessageCopyWith<$Res> implements $AssistantMessageCopyWith<$Res> {
  factory _$AssistantMessageCopyWith(_AssistantMessage value, $Res Function(_AssistantMessage) _then) = __$AssistantMessageCopyWithImpl;
@override @useResult
$Res call({
 String role, String text
});




}
/// @nodoc
class __$AssistantMessageCopyWithImpl<$Res>
    implements _$AssistantMessageCopyWith<$Res> {
  __$AssistantMessageCopyWithImpl(this._self, this._then);

  final _AssistantMessage _self;
  final $Res Function(_AssistantMessage) _then;

/// Create a copy of AssistantMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? text = null,}) {
  return _then(_AssistantMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AssistantSource {

 String get slug; String get title; String get url;
/// Create a copy of AssistantSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssistantSourceCopyWith<AssistantSource> get copyWith => _$AssistantSourceCopyWithImpl<AssistantSource>(this as AssistantSource, _$identity);

  /// Serializes this AssistantSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AssistantSource;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssistantSource&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AssistantSource;
  return Object.hash(runtimeType,_this.slug,_this.title,_this.url);
}

@override
String toString() {
  final _this = this as AssistantSource;
  return 'AssistantSource(slug: ${_this.slug}, title: ${_this.title}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $AssistantSourceCopyWith<$Res>  {
  factory $AssistantSourceCopyWith(AssistantSource value, $Res Function(AssistantSource) _then) = _$AssistantSourceCopyWithImpl;
@useResult
$Res call({
 String slug, String title, String url
});




}
/// @nodoc
class _$AssistantSourceCopyWithImpl<$Res>
    implements $AssistantSourceCopyWith<$Res> {
  _$AssistantSourceCopyWithImpl(this._self, this._then);

  final AssistantSource _self;
  final $Res Function(AssistantSource) _then;

/// Create a copy of AssistantSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? title = null,Object? url = null,}) {
  return _then(AssistantSource(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AssistantSource].
extension AssistantSourcePatterns on AssistantSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssistantSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssistantSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssistantSource value)  $default,){
final _that = this;
switch (_that) {
case _AssistantSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssistantSource value)?  $default,){
final _that = this;
switch (_that) {
case _AssistantSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String title,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssistantSource() when $default != null:
return $default(_that.slug,_that.title,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String title,  String url)  $default,) {final _that = this;
switch (_that) {
case _AssistantSource():
return $default(_that.slug,_that.title,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String title,  String url)?  $default,) {final _that = this;
switch (_that) {
case _AssistantSource() when $default != null:
return $default(_that.slug,_that.title,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssistantSource implements AssistantSource {
  const _AssistantSource({this.slug = '', this.title = '', this.url = ''});
  factory _AssistantSource.fromJson(Map<String, dynamic> json) => _$AssistantSourceFromJson(json);

@override@JsonKey() final  String slug;
@override@JsonKey() final  String title;
@override@JsonKey() final  String url;

/// Create a copy of AssistantSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssistantSourceCopyWith<_AssistantSource> get copyWith => __$AssistantSourceCopyWithImpl<_AssistantSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssistantSourceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssistantSource&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,slug,title,url);
}

@override
String toString() {
    return 'AssistantSource(slug: $slug, title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class _$AssistantSourceCopyWith<$Res> implements $AssistantSourceCopyWith<$Res> {
  factory _$AssistantSourceCopyWith(_AssistantSource value, $Res Function(_AssistantSource) _then) = __$AssistantSourceCopyWithImpl;
@override @useResult
$Res call({
 String slug, String title, String url
});




}
/// @nodoc
class __$AssistantSourceCopyWithImpl<$Res>
    implements _$AssistantSourceCopyWith<$Res> {
  __$AssistantSourceCopyWithImpl(this._self, this._then);

  final _AssistantSource _self;
  final $Res Function(_AssistantSource) _then;

/// Create a copy of AssistantSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? title = null,Object? url = null,}) {
  return _then(_AssistantSource(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AssistantReply {

 String get text; List<AssistantSource> get sources; bool get handoff; int get remainingToday;
/// Create a copy of AssistantReply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssistantReplyCopyWith<AssistantReply> get copyWith => _$AssistantReplyCopyWithImpl<AssistantReply>(this as AssistantReply, _$identity);

  /// Serializes this AssistantReply to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AssistantReply;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssistantReply&&(identical(other.text, _this.text) || other.text == _this.text)&&const DeepCollectionEquality().equals(other.sources, _this.sources)&&(identical(other.handoff, _this.handoff) || other.handoff == _this.handoff)&&(identical(other.remainingToday, _this.remainingToday) || other.remainingToday == _this.remainingToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AssistantReply;
  return Object.hash(runtimeType,_this.text,const DeepCollectionEquality().hash(_this.sources),_this.handoff,_this.remainingToday);
}

@override
String toString() {
  final _this = this as AssistantReply;
  return 'AssistantReply(text: ${_this.text}, sources: ${_this.sources}, handoff: ${_this.handoff}, remainingToday: ${_this.remainingToday})';
}


}

/// @nodoc
abstract mixin class $AssistantReplyCopyWith<$Res>  {
  factory $AssistantReplyCopyWith(AssistantReply value, $Res Function(AssistantReply) _then) = _$AssistantReplyCopyWithImpl;
@useResult
$Res call({
 String text, List<AssistantSource> sources, bool handoff, int remainingToday
});




}
/// @nodoc
class _$AssistantReplyCopyWithImpl<$Res>
    implements $AssistantReplyCopyWith<$Res> {
  _$AssistantReplyCopyWithImpl(this._self, this._then);

  final AssistantReply _self;
  final $Res Function(AssistantReply) _then;

/// Create a copy of AssistantReply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? sources = null,Object? handoff = null,Object? remainingToday = null,}) {
  return _then(AssistantReply(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<AssistantSource>,handoff: null == handoff ? _self.handoff : handoff // ignore: cast_nullable_to_non_nullable
as bool,remainingToday: null == remainingToday ? _self.remainingToday : remainingToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AssistantReply].
extension AssistantReplyPatterns on AssistantReply {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssistantReply value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssistantReply() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssistantReply value)  $default,){
final _that = this;
switch (_that) {
case _AssistantReply():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssistantReply value)?  $default,){
final _that = this;
switch (_that) {
case _AssistantReply() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  List<AssistantSource> sources,  bool handoff,  int remainingToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssistantReply() when $default != null:
return $default(_that.text,_that.sources,_that.handoff,_that.remainingToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  List<AssistantSource> sources,  bool handoff,  int remainingToday)  $default,) {final _that = this;
switch (_that) {
case _AssistantReply():
return $default(_that.text,_that.sources,_that.handoff,_that.remainingToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  List<AssistantSource> sources,  bool handoff,  int remainingToday)?  $default,) {final _that = this;
switch (_that) {
case _AssistantReply() when $default != null:
return $default(_that.text,_that.sources,_that.handoff,_that.remainingToday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssistantReply implements AssistantReply {
  const _AssistantReply({this.text = '',  List<AssistantSource> sources = const <AssistantSource>[], this.handoff = false, this.remainingToday = 0}): _sources = sources;
  factory _AssistantReply.fromJson(Map<String, dynamic> json) => _$AssistantReplyFromJson(json);

@override@JsonKey() final  String text;
 final  List<AssistantSource> _sources;
@override@JsonKey() List<AssistantSource> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

@override@JsonKey() final  bool handoff;
@override@JsonKey() final  int remainingToday;

/// Create a copy of AssistantReply
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssistantReplyCopyWith<_AssistantReply> get copyWith => __$AssistantReplyCopyWithImpl<_AssistantReply>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssistantReplyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssistantReply&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.sources, _sources)&&(identical(other.handoff, handoff) || other.handoff == handoff)&&(identical(other.remainingToday, remainingToday) || other.remainingToday == remainingToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_sources),handoff,remainingToday);
}

@override
String toString() {
    return 'AssistantReply(text: $text, sources: $sources, handoff: $handoff, remainingToday: $remainingToday)';
}


}

/// @nodoc
abstract mixin class _$AssistantReplyCopyWith<$Res> implements $AssistantReplyCopyWith<$Res> {
  factory _$AssistantReplyCopyWith(_AssistantReply value, $Res Function(_AssistantReply) _then) = __$AssistantReplyCopyWithImpl;
@override @useResult
$Res call({
 String text, List<AssistantSource> sources, bool handoff, int remainingToday
});




}
/// @nodoc
class __$AssistantReplyCopyWithImpl<$Res>
    implements _$AssistantReplyCopyWith<$Res> {
  __$AssistantReplyCopyWithImpl(this._self, this._then);

  final _AssistantReply _self;
  final $Res Function(_AssistantReply) _then;

/// Create a copy of AssistantReply
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? sources = null,Object? handoff = null,Object? remainingToday = null,}) {
  return _then(_AssistantReply(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<AssistantSource>,handoff: null == handoff ? _self.handoff : handoff // ignore: cast_nullable_to_non_nullable
as bool,remainingToday: null == remainingToday ? _self.remainingToday : remainingToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
