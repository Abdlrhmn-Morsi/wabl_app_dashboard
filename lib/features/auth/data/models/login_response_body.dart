import 'package:json_annotation/json_annotation.dart';
part 'login_response_body.g.dart';

@JsonSerializable()
class LoginResponseBody {
  @JsonKey(name: 'data')
  UserData? userData;
  String? message;
  int? status;
  LoginResponseBody({
    this.userData,
    this.message,
    this.status,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);
}

@JsonSerializable()
class UserData {
  int? id;
  String? avatar;
  String? name;
  String? email;
  String? phone;
  @JsonKey(name: 'country_code')
  String? countryCode;
  String? token;
  UserData({
    this.id,
    this.avatar,
    this.name,
    this.email,
    this.phone,
    this.countryCode,
    this.token,
  });
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
