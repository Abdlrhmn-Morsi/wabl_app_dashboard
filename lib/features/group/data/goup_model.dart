import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? id;
  String? cover;
  String? avatar;
  String? name;
  String? description;
  GroupModel({
    this.id,
    this.cover,
    this.avatar,
    this.name,
    this.description,
  });

  GroupModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    id = doc['id'];
    name = doc['name'];
    description = doc['description'];
    cover = doc['cover'];
    avatar = doc['avatar'];
  }
}
