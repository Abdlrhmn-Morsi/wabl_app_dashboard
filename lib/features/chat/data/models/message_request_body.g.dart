// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRequestBody _$MessageRequestBodyFromJson(Map<String, dynamic> json) =>
    MessageRequestBody(
      isDeleted: json['isDeleted'] as bool? ?? false,
      id: json['id'] as String,
      message: json['message'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$MessageRequestBodyToJson(MessageRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'createdAt': instance.createdAt,
      'isDeleted': instance.isDeleted,
    };
