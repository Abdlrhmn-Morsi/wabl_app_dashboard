import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response_body.g.dart';

@JsonSerializable()
class UserResponseBody {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'doc_id')
  String? docId;
  String? name;
  String? avatar;
  String? email;
  String? phone;
  @JsonKey(name: 'country_code')
  String? countryCode;
  @JsonKey(name: 'created_at')
  String? createdAt;
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
  factory UserResponseBody.fromJson(Map<String, dynamic> json) =>
      _$UserResponseBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseBodyToJson(this);
}
