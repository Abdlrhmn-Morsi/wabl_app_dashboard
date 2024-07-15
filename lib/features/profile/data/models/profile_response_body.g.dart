// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponseBody _$ProfileResponseBodyFromJson(Map<String, dynamic> json) =>
    ProfileResponseBody(
      profileData: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileResponseBodyToJson(
        ProfileResponseBody instance) =>
    <String, dynamic>{
      'data': instance.profileData,
      'message': instance.message,
      'status': instance.status,
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      role: json['role'] as String?,
      docId: json['doc_id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['country_code'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'doc_id': instance.docId,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'phone': instance.phone,
      'country_code': instance.countryCode,
      'created_at': instance.createdAt,
      'role': instance.role,
    };
