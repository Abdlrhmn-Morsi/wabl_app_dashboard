// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordRequestBody _$UpdatePasswordRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordRequestBody(
      oldPassword: json['old_password'] as String,
      newPassword: json['new_password'] as String,
      newPasswordConfirmation: json['new_password_confirmation'] as String,
    );

Map<String, dynamic> _$UpdatePasswordRequestBodyToJson(
        UpdatePasswordRequestBody instance) =>
    <String, dynamic>{
      'old_password': instance.oldPassword,
      'new_password': instance.newPassword,
      'new_password_confirmation': instance.newPasswordConfirmation,
    };
