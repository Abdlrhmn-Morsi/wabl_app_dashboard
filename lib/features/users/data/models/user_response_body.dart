import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponseBody {
  String? userId;
  String? docId;
  String? name;
  String? avatar;
  String? email;
  String? phone;
  String? countryCode;
  Timestamp? createdAt;
  UserResponseBody({
    this.docId,
    this.userId,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.countryCode,
    this.createdAt,
  });
  UserResponseBody.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    userId = doc['user_id'];
    docId = doc['doc_id'];
    name = doc['name'];
    avatar = doc['avatar'];
    email = doc['email'];
    phone = doc['phone'];
    countryCode = doc['country_code'];
    createdAt = doc['created_at'];
  }
  // factory UserResponseBody.fromJson(Map<String, dynamic> json) =>
  //     _$UserResponseBodyFromJson(json);
  // Map<String, dynamic> toJson() => _$UserResponseBodyToJson(this);
}
