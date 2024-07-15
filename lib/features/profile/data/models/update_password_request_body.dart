import 'package:json_annotation/json_annotation.dart';
part 'update_password_request_body.g.dart';

@JsonSerializable()
class UpdatePasswordRequestBody {
  @JsonKey(name: "old_password")
  final String oldPassword;
  @JsonKey(name: "new_password")
  final String newPassword;
  @JsonKey(name: "new_password_confirmation")
  final String newPasswordConfirmation;
  UpdatePasswordRequestBody({
    required this.oldPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  Map<String, dynamic> toJson() => _$UpdatePasswordRequestBodyToJson(this);
}
