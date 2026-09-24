// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationChannel {

 String get id; String get name;/// email | slack | teams | webhook | sms | ivr
 String get kind;/// smtp | sendgrid | slack | teams | webhook | twilio | netgsm | ...
 String get provider; String? get tenantId; Map<String, String> get config; Map<String, bool> get secrets;/// E-posta adresleri ya da E.164 numaralar; Slack/Teams/webhook'ta boş.
 List<String> get recipients;/// info | warning | critical: bu kanala gidecek en düşük önem.
 String get minSeverity; bool get sendResolved; bool get enabled;/// ops (sistem alarmları) | summary (sağım özeti) | herd (her sürü
/// uyarısı ayrı)
 List<String> get sources;/// Günde en çok kaç bildirim; null ise türün varsayılanı.
 int? get dailyLimit;/// Uygulanan sınır (ayarlı değer ya da varsayılan); 0 sınırsız.
 int get effectiveDailyLimit; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of NotificationChannel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationChannelCopyWith<NotificationChannel> get copyWith => _$NotificationChannelCopyWithImpl<NotificationChannel>(this as NotificationChannel, _$identity);

  /// Serializes this NotificationChannel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&const DeepCollectionEquality().equals(other.config, config)&&const DeepCollectionEquality().equals(other.secrets, secrets)&&const DeepCollectionEquality().equals(other.recipients, recipients)&&(identical(other.minSeverity, minSeverity) || other.minSeverity == minSeverity)&&(identical(other.sendResolved, sendResolved) || other.sendResolved == sendResolved)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.sources, sources)&&(identical(other.dailyLimit, dailyLimit) || other.dailyLimit == dailyLimit)&&(identical(other.effectiveDailyLimit, effectiveDailyLimit) || other.effectiveDailyLimit == effectiveDailyLimit)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,provider,tenantId,const DeepCollectionEquality().hash(config),const DeepCollectionEquality().hash(secrets),const DeepCollectionEquality().hash(recipients),minSeverity,sendResolved,enabled,const DeepCollectionEquality().hash(sources),dailyLimit,effectiveDailyLimit,createdAt,updatedAt);

@override
String toString() {
  return 'NotificationChannel(id: $id, name: $name, kind: $kind, provider: $provider, tenantId: $tenantId, config: $config, secrets: $secrets, recipients: $recipients, minSeverity: $minSeverity, sendResolved: $sendResolved, enabled: $enabled, sources: $sources, dailyLimit: $dailyLimit, effectiveDailyLimit: $effectiveDailyLimit, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $NotificationChannelCopyWith<$Res>  {
  factory $NotificationChannelCopyWith(NotificationChannel value, $Res Function(NotificationChannel) _then) = _$NotificationChannelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String kind, String provider, String? tenantId, Map<String, String> config, Map<String, bool> secrets, List<String> recipients, String minSeverity, bool sendResolved, bool enabled, List<String> sources, int? dailyLimit, int effectiveDailyLimit, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$NotificationChannelCopyWithImpl<$Res>
    implements $NotificationChannelCopyWith<$Res> {
  _$NotificationChannelCopyWithImpl(this._self, this._then);

  final NotificationChannel _self;
  final $Res Function(NotificationChannel) _then;

/// Create a copy of NotificationChannel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? provider = null,Object? tenantId = freezed,Object? config = null,Object? secrets = null,Object? recipients = null,Object? minSeverity = null,Object? sendResolved = null,Object? enabled = null,Object? sources = null,Object? dailyLimit = freezed,Object? effectiveDailyLimit = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, String>,secrets: null == secrets ? _self.secrets : secrets // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,recipients: null == recipients ? _self.recipients : recipients // ignore: cast_nullable_to_non_nullable
as List<String>,minSeverity: null == minSeverity ? _self.minSeverity : minSeverity // ignore: cast_nullable_to_non_nullable
as String,sendResolved: null == sendResolved ? _self.sendResolved : sendResolved // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<String>,dailyLimit: freezed == dailyLimit ? _self.dailyLimit : dailyLimit // ignore: cast_nullable_to_non_nullable
as int?,effectiveDailyLimit: null == effectiveDailyLimit ? _self.effectiveDailyLimit : effectiveDailyLimit // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationChannel].
extension NotificationChannelPatterns on NotificationChannel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationChannel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationChannel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationChannel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationChannel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationChannel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationChannel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String kind,  String provider,  String? tenantId,  Map<String, String> config,  Map<String, bool> secrets,  List<String> recipients,  String minSeverity,  bool sendResolved,  bool enabled,  List<String> sources,  int? dailyLimit,  int effectiveDailyLimit,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationChannel() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.provider,_that.tenantId,_that.config,_that.secrets,_that.recipients,_that.minSeverity,_that.sendResolved,_that.enabled,_that.sources,_that.dailyLimit,_that.effectiveDailyLimit,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String kind,  String provider,  String? tenantId,  Map<String, String> config,  Map<String, bool> secrets,  List<String> recipients,  String minSeverity,  bool sendResolved,  bool enabled,  List<String> sources,  int? dailyLimit,  int effectiveDailyLimit,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _NotificationChannel():
return $default(_that.id,_that.name,_that.kind,_that.provider,_that.tenantId,_that.config,_that.secrets,_that.recipients,_that.minSeverity,_that.sendResolved,_that.enabled,_that.sources,_that.dailyLimit,_that.effectiveDailyLimit,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String kind,  String provider,  String? tenantId,  Map<String, String> config,  Map<String, bool> secrets,  List<String> recipients,  String minSeverity,  bool sendResolved,  bool enabled,  List<String> sources,  int? dailyLimit,  int effectiveDailyLimit,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _NotificationChannel() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.provider,_that.tenantId,_that.config,_that.secrets,_that.recipients,_that.minSeverity,_that.sendResolved,_that.enabled,_that.sources,_that.dailyLimit,_that.effectiveDailyLimit,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationChannel implements NotificationChannel {
  const _NotificationChannel({required this.id, required this.name, required this.kind, required this.provider, this.tenantId, final  Map<String, String> config = const <String, String>{}, final  Map<String, bool> secrets = const <String, bool>{}, final  List<String> recipients = const <String>[], this.minSeverity = 'warning', this.sendResolved = true, this.enabled = true, final  List<String> sources = const <String>['ops', 'summary'], this.dailyLimit, this.effectiveDailyLimit = 0, this.createdAt, this.updatedAt}): _config = config,_secrets = secrets,_recipients = recipients,_sources = sources;
  factory _NotificationChannel.fromJson(Map<String, dynamic> json) => _$NotificationChannelFromJson(json);

@override final  String id;
@override final  String name;
/// email | slack | teams | webhook | sms | ivr
@override final  String kind;
/// smtp | sendgrid | slack | teams | webhook | twilio | netgsm | ...
@override final  String provider;
@override final  String? tenantId;
 final  Map<String, String> _config;
@override@JsonKey() Map<String, String> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}

 final  Map<String, bool> _secrets;
@override@JsonKey() Map<String, bool> get secrets {
  if (_secrets is EqualUnmodifiableMapView) return _secrets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_secrets);
}

/// E-posta adresleri ya da E.164 numaralar; Slack/Teams/webhook'ta boş.
 final  List<String> _recipients;
/// E-posta adresleri ya da E.164 numaralar; Slack/Teams/webhook'ta boş.
@override@JsonKey() List<String> get recipients {
  if (_recipients is EqualUnmodifiableListView) return _recipients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipients);
}

/// info | warning | critical: bu kanala gidecek en düşük önem.
@override@JsonKey() final  String minSeverity;
@override@JsonKey() final  bool sendResolved;
@override@JsonKey() final  bool enabled;
/// ops (sistem alarmları) | summary (sağım özeti) | herd (her sürü
/// uyarısı ayrı)
 final  List<String> _sources;
/// ops (sistem alarmları) | summary (sağım özeti) | herd (her sürü
/// uyarısı ayrı)
@override@JsonKey() List<String> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

/// Günde en çok kaç bildirim; null ise türün varsayılanı.
@override final  int? dailyLimit;
/// Uygulanan sınır (ayarlı değer ya da varsayılan); 0 sınırsız.
@override@JsonKey() final  int effectiveDailyLimit;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of NotificationChannel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationChannelCopyWith<_NotificationChannel> get copyWith => __$NotificationChannelCopyWithImpl<_NotificationChannel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationChannelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&const DeepCollectionEquality().equals(other._config, _config)&&const DeepCollectionEquality().equals(other._secrets, _secrets)&&const DeepCollectionEquality().equals(other._recipients, _recipients)&&(identical(other.minSeverity, minSeverity) || other.minSeverity == minSeverity)&&(identical(other.sendResolved, sendResolved) || other.sendResolved == sendResolved)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._sources, _sources)&&(identical(other.dailyLimit, dailyLimit) || other.dailyLimit == dailyLimit)&&(identical(other.effectiveDailyLimit, effectiveDailyLimit) || other.effectiveDailyLimit == effectiveDailyLimit)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,provider,tenantId,const DeepCollectionEquality().hash(_config),const DeepCollectionEquality().hash(_secrets),const DeepCollectionEquality().hash(_recipients),minSeverity,sendResolved,enabled,const DeepCollectionEquality().hash(_sources),dailyLimit,effectiveDailyLimit,createdAt,updatedAt);

@override
String toString() {
  return 'NotificationChannel(id: $id, name: $name, kind: $kind, provider: $provider, tenantId: $tenantId, config: $config, secrets: $secrets, recipients: $recipients, minSeverity: $minSeverity, sendResolved: $sendResolved, enabled: $enabled, sources: $sources, dailyLimit: $dailyLimit, effectiveDailyLimit: $effectiveDailyLimit, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationChannelCopyWith<$Res> implements $NotificationChannelCopyWith<$Res> {
  factory _$NotificationChannelCopyWith(_NotificationChannel value, $Res Function(_NotificationChannel) _then) = __$NotificationChannelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String kind, String provider, String? tenantId, Map<String, String> config, Map<String, bool> secrets, List<String> recipients, String minSeverity, bool sendResolved, bool enabled, List<String> sources, int? dailyLimit, int effectiveDailyLimit, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$NotificationChannelCopyWithImpl<$Res>
    implements _$NotificationChannelCopyWith<$Res> {
  __$NotificationChannelCopyWithImpl(this._self, this._then);

  final _NotificationChannel _self;
  final $Res Function(_NotificationChannel) _then;

/// Create a copy of NotificationChannel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? provider = null,Object? tenantId = freezed,Object? config = null,Object? secrets = null,Object? recipients = null,Object? minSeverity = null,Object? sendResolved = null,Object? enabled = null,Object? sources = null,Object? dailyLimit = freezed,Object? effectiveDailyLimit = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_NotificationChannel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, String>,secrets: null == secrets ? _self._secrets : secrets // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,recipients: null == recipients ? _self._recipients : recipients // ignore: cast_nullable_to_non_nullable
as List<String>,minSeverity: null == minSeverity ? _self.minSeverity : minSeverity // ignore: cast_nullable_to_non_nullable
as String,sendResolved: null == sendResolved ? _self.sendResolved : sendResolved // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<String>,dailyLimit: freezed == dailyLimit ? _self.dailyLimit : dailyLimit // ignore: cast_nullable_to_non_nullable
as int?,effectiveDailyLimit: null == effectiveDailyLimit ? _self.effectiveDailyLimit : effectiveDailyLimit // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$NotificationProvider {

 String get kind; String get provider;/// email | phone | none
 String get recipients; List<ProviderField> get fields;/// Günlük sınır ayarlanmazsa uygulanan; 0 sınırsız (SMS 50, arama 20).
 int get defaultDailyLimit;
/// Create a copy of NotificationProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationProviderCopyWith<NotificationProvider> get copyWith => _$NotificationProviderCopyWithImpl<NotificationProvider>(this as NotificationProvider, _$identity);

  /// Serializes this NotificationProvider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationProvider&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.recipients, recipients) || other.recipients == recipients)&&const DeepCollectionEquality().equals(other.fields, fields)&&(identical(other.defaultDailyLimit, defaultDailyLimit) || other.defaultDailyLimit == defaultDailyLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,provider,recipients,const DeepCollectionEquality().hash(fields),defaultDailyLimit);

@override
String toString() {
  return 'NotificationProvider(kind: $kind, provider: $provider, recipients: $recipients, fields: $fields, defaultDailyLimit: $defaultDailyLimit)';
}


}

/// @nodoc
abstract mixin class $NotificationProviderCopyWith<$Res>  {
  factory $NotificationProviderCopyWith(NotificationProvider value, $Res Function(NotificationProvider) _then) = _$NotificationProviderCopyWithImpl;
@useResult
$Res call({
 String kind, String provider, String recipients, List<ProviderField> fields, int defaultDailyLimit
});




}
/// @nodoc
class _$NotificationProviderCopyWithImpl<$Res>
    implements $NotificationProviderCopyWith<$Res> {
  _$NotificationProviderCopyWithImpl(this._self, this._then);

  final NotificationProvider _self;
  final $Res Function(NotificationProvider) _then;

/// Create a copy of NotificationProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? provider = null,Object? recipients = null,Object? fields = null,Object? defaultDailyLimit = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,recipients: null == recipients ? _self.recipients : recipients // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<ProviderField>,defaultDailyLimit: null == defaultDailyLimit ? _self.defaultDailyLimit : defaultDailyLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationProvider].
extension NotificationProviderPatterns on NotificationProvider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationProvider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationProvider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationProvider value)  $default,){
final _that = this;
switch (_that) {
case _NotificationProvider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationProvider value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationProvider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kind,  String provider,  String recipients,  List<ProviderField> fields,  int defaultDailyLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationProvider() when $default != null:
return $default(_that.kind,_that.provider,_that.recipients,_that.fields,_that.defaultDailyLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kind,  String provider,  String recipients,  List<ProviderField> fields,  int defaultDailyLimit)  $default,) {final _that = this;
switch (_that) {
case _NotificationProvider():
return $default(_that.kind,_that.provider,_that.recipients,_that.fields,_that.defaultDailyLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kind,  String provider,  String recipients,  List<ProviderField> fields,  int defaultDailyLimit)?  $default,) {final _that = this;
switch (_that) {
case _NotificationProvider() when $default != null:
return $default(_that.kind,_that.provider,_that.recipients,_that.fields,_that.defaultDailyLimit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationProvider implements NotificationProvider {
  const _NotificationProvider({required this.kind, required this.provider, this.recipients = 'none', final  List<ProviderField> fields = const <ProviderField>[], this.defaultDailyLimit = 0}): _fields = fields;
  factory _NotificationProvider.fromJson(Map<String, dynamic> json) => _$NotificationProviderFromJson(json);

@override final  String kind;
@override final  String provider;
/// email | phone | none
@override@JsonKey() final  String recipients;
 final  List<ProviderField> _fields;
@override@JsonKey() List<ProviderField> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}

/// Günlük sınır ayarlanmazsa uygulanan; 0 sınırsız (SMS 50, arama 20).
@override@JsonKey() final  int defaultDailyLimit;

/// Create a copy of NotificationProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationProviderCopyWith<_NotificationProvider> get copyWith => __$NotificationProviderCopyWithImpl<_NotificationProvider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationProviderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationProvider&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.recipients, recipients) || other.recipients == recipients)&&const DeepCollectionEquality().equals(other._fields, _fields)&&(identical(other.defaultDailyLimit, defaultDailyLimit) || other.defaultDailyLimit == defaultDailyLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,provider,recipients,const DeepCollectionEquality().hash(_fields),defaultDailyLimit);

@override
String toString() {
  return 'NotificationProvider(kind: $kind, provider: $provider, recipients: $recipients, fields: $fields, defaultDailyLimit: $defaultDailyLimit)';
}


}

/// @nodoc
abstract mixin class _$NotificationProviderCopyWith<$Res> implements $NotificationProviderCopyWith<$Res> {
  factory _$NotificationProviderCopyWith(_NotificationProvider value, $Res Function(_NotificationProvider) _then) = __$NotificationProviderCopyWithImpl;
@override @useResult
$Res call({
 String kind, String provider, String recipients, List<ProviderField> fields, int defaultDailyLimit
});




}
/// @nodoc
class __$NotificationProviderCopyWithImpl<$Res>
    implements _$NotificationProviderCopyWith<$Res> {
  __$NotificationProviderCopyWithImpl(this._self, this._then);

  final _NotificationProvider _self;
  final $Res Function(_NotificationProvider) _then;

/// Create a copy of NotificationProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? provider = null,Object? recipients = null,Object? fields = null,Object? defaultDailyLimit = null,}) {
  return _then(_NotificationProvider(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,recipients: null == recipients ? _self.recipients : recipients // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<ProviderField>,defaultDailyLimit: null == defaultDailyLimit ? _self.defaultDailyLimit : defaultDailyLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProviderField {

 String get name; bool get required; bool get secret;
/// Create a copy of ProviderField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderFieldCopyWith<ProviderField> get copyWith => _$ProviderFieldCopyWithImpl<ProviderField>(this as ProviderField, _$identity);

  /// Serializes this ProviderField to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderField&&(identical(other.name, name) || other.name == name)&&(identical(other.required, required) || other.required == required)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,required,secret);

@override
String toString() {
  return 'ProviderField(name: $name, required: $required, secret: $secret)';
}


}

/// @nodoc
abstract mixin class $ProviderFieldCopyWith<$Res>  {
  factory $ProviderFieldCopyWith(ProviderField value, $Res Function(ProviderField) _then) = _$ProviderFieldCopyWithImpl;
@useResult
$Res call({
 String name, bool required, bool secret
});




}
/// @nodoc
class _$ProviderFieldCopyWithImpl<$Res>
    implements $ProviderFieldCopyWith<$Res> {
  _$ProviderFieldCopyWithImpl(this._self, this._then);

  final ProviderField _self;
  final $Res Function(ProviderField) _then;

/// Create a copy of ProviderField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? required = null,Object? secret = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderField].
extension ProviderFieldPatterns on ProviderField {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderField value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderField() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderField value)  $default,){
final _that = this;
switch (_that) {
case _ProviderField():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderField value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderField() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  bool required,  bool secret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderField() when $default != null:
return $default(_that.name,_that.required,_that.secret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  bool required,  bool secret)  $default,) {final _that = this;
switch (_that) {
case _ProviderField():
return $default(_that.name,_that.required,_that.secret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  bool required,  bool secret)?  $default,) {final _that = this;
switch (_that) {
case _ProviderField() when $default != null:
return $default(_that.name,_that.required,_that.secret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderField implements ProviderField {
  const _ProviderField({required this.name, this.required = false, this.secret = false});
  factory _ProviderField.fromJson(Map<String, dynamic> json) => _$ProviderFieldFromJson(json);

@override final  String name;
@override@JsonKey() final  bool required;
@override@JsonKey() final  bool secret;

/// Create a copy of ProviderField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderFieldCopyWith<_ProviderField> get copyWith => __$ProviderFieldCopyWithImpl<_ProviderField>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderFieldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderField&&(identical(other.name, name) || other.name == name)&&(identical(other.required, required) || other.required == required)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,required,secret);

@override
String toString() {
  return 'ProviderField(name: $name, required: $required, secret: $secret)';
}


}

/// @nodoc
abstract mixin class _$ProviderFieldCopyWith<$Res> implements $ProviderFieldCopyWith<$Res> {
  factory _$ProviderFieldCopyWith(_ProviderField value, $Res Function(_ProviderField) _then) = __$ProviderFieldCopyWithImpl;
@override @useResult
$Res call({
 String name, bool required, bool secret
});




}
/// @nodoc
class __$ProviderFieldCopyWithImpl<$Res>
    implements _$ProviderFieldCopyWith<$Res> {
  __$ProviderFieldCopyWithImpl(this._self, this._then);

  final _ProviderField _self;
  final $Res Function(_ProviderField) _then;

/// Create a copy of ProviderField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? required = null,Object? secret = null,}) {
  return _then(_ProviderField(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
