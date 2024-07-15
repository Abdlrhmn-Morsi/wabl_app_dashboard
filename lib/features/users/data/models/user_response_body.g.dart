// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseBody _$UserResponseBodyFromJson(Map<String, dynamic> json) =>
    UserResponseBody(
      docId: json['doc_id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['country_code'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$UserResponseBodyToJson(UserResponseBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'doc_id': instance.docId,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phone,
      'country_code': instance.countryCode,
      'created_at': instance.createdAt,
    };
