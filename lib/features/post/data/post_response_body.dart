import 'package:cloud_firestore/cloud_firestore.dart';

class PostResponseBody {
  String? id;
  String? relatedToId;
  String? content;
  List<String>? images;
  PostOwner? postOwner;
  bool? isSaved;
  int? viewCount;
  Timestamp? createdAt;
  String? categoryId;
  bool? isEnabled;
  PostResponseBody({
    this.postOwner,
    this.id,
    required this.relatedToId,
    required this.content,
    required this.createdAt,
    required this.images,
    this.isSaved = false,
    this.viewCount = 0,
    this.categoryId,
    this.isEnabled,
  });
  PostResponseBody.fromMapQueryDocumentSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    id = doc.id;
    relatedToId = doc['related_to_id'];
    content = doc['content'];
    images = List<String>.from(doc['images']);
    createdAt = doc['created_at'];
    viewCount = doc['view_count'];
    categoryId = doc['category_id'];
    isEnabled = doc['is_enabled'];
  }
  PostResponseBody.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    id = doc.id;
    relatedToId = doc['related_to_id'];
    content = doc['content'];
    images = List<String>.from(doc['images']);
    createdAt = doc['created_at'];
    viewCount = doc['view_count'];
    categoryId = doc['category_id'];
    isEnabled = doc['is_enabled'];
  }
}

class PostOwner {
  String? id;
  String? avatar;
  String? name;
  PostOwner({
    this.avatar,
    this.id,
    this.name,
  });

  factory PostOwner.fromJson(Map<String, dynamic> json) => PostOwner(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
      );
}
