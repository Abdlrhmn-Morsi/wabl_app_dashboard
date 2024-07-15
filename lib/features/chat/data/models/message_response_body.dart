import 'package:cloud_firestore/cloud_firestore.dart';

class MessageResponseBody {
  final String? id;
  final String? message;
  final String? senderId;
  final String? receiverId;
  final bool? isDeleted;
  final Timestamp? createdAt;
  MessageResponseBody({
    this.isDeleted,
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });
  factory MessageResponseBody.fromDocument(DocumentSnapshot doc) {
    return MessageResponseBody(
      id: doc.id,
      senderId: doc['sender_id'],
      receiverId: doc['receiver_id'],
      message: doc['message'],
      createdAt: doc['created_at'],
      isDeleted: doc['is_deleted'],
    );
  }
}
