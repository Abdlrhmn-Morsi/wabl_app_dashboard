import 'package:json_annotation/json_annotation.dart';
part 'message_request_body.g.dart';

@JsonSerializable()
class MessageRequestBody {
  final String id;
  final String message;
  final String senderId;
  final String receiverId;
  final dynamic createdAt;
  final bool isDeleted;
  MessageRequestBody({
    this.isDeleted = false,
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "message": message,
      "sender_id": senderId,
      "receiver_id": receiverId,
      "created_at": createdAt,
      "is_deleted": isDeleted,
    };
  }
}
