// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_reset_code_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckResetCodeResponseBody _$CheckResetCodeResponseBodyFromJson(
        Map<String, dynamic> json) =>
    CheckResetCodeResponseBody(
      tempToken: json['token'] as String?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CheckResetCodeResponseBodyToJson(
        CheckResetCodeResponseBody instance) =>
    <String, dynamic>{
      'token': instance.tempToken,
      'message': instance.message,
      'status': instance.status,
    };
