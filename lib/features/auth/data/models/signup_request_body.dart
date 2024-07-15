import 'package:json_annotation/json_annotation.dart';
part 'signup_request_body.g.dart';

@JsonSerializable()
class SignUpRequestBody {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'doc_id')
  String? docId;
  final String name;
  final String? avatar;
  final String email;
  @JsonKey(name: 'phone')
  final String phoneNumber;
  @JsonKey(name: 'country_code')
  final String countryCode;
  final String role;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  SignUpRequestBody({
    required this.userId,
    this.docId,
    this.avatar,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.countryCode,
    required this.role,
    this.createdAt,
  });

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}
