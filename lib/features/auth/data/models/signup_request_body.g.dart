// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestBody _$SignUpRequestBodyFromJson(Map<String, dynamic> json) =>
    SignUpRequestBody(
      userId: json['user_id'] as String,
      docId: json['doc_id'] as String?,
      avatar: json['avatar'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone'] as String,
      countryCode: json['country_code'] as String,
      role: json['role'] as String,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$SignUpRequestBodyToJson(SignUpRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'doc_id': instance.docId,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phoneNumber,
      'country_code': instance.countryCode,
      'role': instance.role,
      'created_at': instance.createdAt,
    };
