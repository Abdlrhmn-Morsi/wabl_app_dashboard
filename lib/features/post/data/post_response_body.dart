import 'package:cloud_firestore/cloud_firestore.dart';

import '../../group/data/goup_model.dart';

class PostResponseBody {
  String? id;
  String? relatedToId;
  String? content;
  List<String>? images;
  PostOwner? postOwner;
  bool? isSaved;
  bool? isFavorite;
  int? viewCount;
  int? favoriteCount;
  Timestamp? createdAt;
  String? categoryId;
  String? carType;
  String? manufactureYear;
  String? price;
  GroupModel? group;
  String? groupId;
  bool? isEnabled;
  PostResponseBody({
    this.id,
    required this.relatedToId,
    required this.content,
    required this.images,
    this.postOwner,
    this.isSaved = false,
    this.isFavorite = false,
    this.isEnabled = false,
    this.viewCount = 0,
    this.favoriteCount = 0,
    required this.createdAt,
    this.categoryId,
    this.carType,
    this.manufactureYear,
    this.price,
    this.group,
    this.groupId,
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
    favoriteCount = doc['favorite_count'];
    carType = doc['car_type'];
    manufactureYear = doc['manufacture_year'];
    price = doc['price'];
    groupId = doc['group_id'];
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
    carType = doc['car_type'];
    manufactureYear = doc['manufacture_year'];
    price = doc['price'];
    groupId = doc['group_id'];
    favoriteCount = doc['favorite_count'];
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
