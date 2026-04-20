// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      role: json['role'] as String,
      description: json['description'] as String,
      techStack:
          (json['techStack'] as List<dynamic>).map((e) => e as String).toList(),
      impactMetrics: (json['impactMetrics'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      liveLink: json['liveLink'] as String,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'role': instance.role,
      'description': instance.description,
      'techStack': instance.techStack,
      'impactMetrics': instance.impactMetrics,
      'liveLink': instance.liveLink,
      'order': instance.order,
    };
