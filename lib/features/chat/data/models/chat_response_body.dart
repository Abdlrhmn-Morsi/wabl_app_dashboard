import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_response_body.dart';

class ChatResponseBody {
  final String id;
  ChatWith? chatWith;
  final List<String> users;
  final dynamic createdAt;
  MessageResponseBody? lastMessage;
  ChatResponseBody({
    this.lastMessage,
    required this.users,
    required this.id,
    this.chatWith,
    required this.createdAt,
  });

  factory ChatResponseBody.fromDocument(DocumentSnapshot doc) {
    return ChatResponseBody(
      id: doc.id,
      createdAt: doc['created_at'],
      users: List<String>.from(doc['users']),
    );
  }
}

class ChatWith {
  final String? id;
  final String? name;
  final String? avatar;
  ChatWith({
    this.id,
    this.name,
    this.avatar,
  });

  factory ChatWith.fromJson(Map<String, dynamic> json) {
    return ChatWith(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
