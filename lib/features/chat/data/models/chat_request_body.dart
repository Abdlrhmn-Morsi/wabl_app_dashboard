class ChatRequestBody {
  final String id;
  final List<String> users;
  final dynamic createdAt;
  ChatRequestBody({
    required this.id,
    required this.users,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "users": users,
      "created_at": createdAt,
    };
  }
}
