// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssistantStatus _$AssistantStatusFromJson(Map<String, dynamic> json) =>
    _AssistantStatus(enabled: json['enabled'] as bool? ?? false);

Map<String, dynamic> _$AssistantStatusToJson(_AssistantStatus instance) =>
    <String, dynamic>{'enabled': instance.enabled};

_AssistantMessage _$AssistantMessageFromJson(Map<String, dynamic> json) =>
    _AssistantMessage(
      role: json['role'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$AssistantMessageToJson(_AssistantMessage instance) =>
    <String, dynamic>{'role': instance.role, 'text': instance.text};

_AssistantSource _$AssistantSourceFromJson(Map<String, dynamic> json) =>
    _AssistantSource(
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$AssistantSourceToJson(_AssistantSource instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'title': instance.title,
      'url': instance.url,
    };

_AssistantReply _$AssistantReplyFromJson(Map<String, dynamic> json) =>
    _AssistantReply(
      text: json['text'] as String? ?? '',
      sources:
          (json['sources'] as List<dynamic>?)
              ?.map((e) => AssistantSource.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AssistantSource>[],
      handoff: json['handoff'] as bool? ?? false,
    );

Map<String, dynamic> _$AssistantReplyToJson(_AssistantReply instance) =>
    <String, dynamic>{
      'text': instance.text,
      'sources': instance.sources,
      'handoff': instance.handoff,
    };
