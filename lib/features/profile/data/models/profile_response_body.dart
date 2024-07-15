import 'package:json_annotation/json_annotation.dart';
part 'profile_response_body.g.dart';

@JsonSerializable()
class ProfileResponseBody {
  @JsonKey(name: 'data')
  final ProfileData? profileData;
  final String? message;
  final int? status;
  ProfileResponseBody({
    this.profileData,
    this.message,
    this.status,
  });
  factory ProfileResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseBodyFromJson(json);
}

@JsonSerializable()
class ProfileData {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'doc_id')
  final String? docId;
  final String? name;
  final String? avatar;
  final String? email;
  final String? phone;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final String? role;
  ProfileData({
    this.role,
    this.docId,
    this.userId,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.countryCode,
    this.createdAt,
  });
  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
