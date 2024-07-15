import 'package:json_annotation/json_annotation.dart';
part 'check_reset_code_response_body.g.dart';

@JsonSerializable()
class CheckResetCodeResponseBody {
  @JsonKey(name: 'token')
  final String? tempToken;
  final String? message;
  final int? status;
  const CheckResetCodeResponseBody({
    this.tempToken,
    this.status,
    this.message,
  });
  factory CheckResetCodeResponseBody.fromJson(Map<String, dynamic> json) =>
      _$CheckResetCodeResponseBodyFromJson(json);
}
