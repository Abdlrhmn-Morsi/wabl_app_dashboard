// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostRequestBody _$PostRequestBodyFromJson(Map<String, dynamic> json) =>
    PostRequestBody(
      id: json['id'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      relatedToId: json['related_to_id'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'],
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      categoryId: json['category_id'] as String,
    );

Map<String, dynamic> _$PostRequestBodyToJson(PostRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'related_to_id': instance.relatedToId,
      'content': instance.content,
      'created_at': instance.createdAt,
      'images': instance.images,
      'view_count': instance.viewCount,
      'category_id': instance.categoryId,
    };
