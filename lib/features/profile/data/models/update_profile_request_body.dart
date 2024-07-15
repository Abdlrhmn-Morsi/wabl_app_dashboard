import 'package:dio/dio.dart';

class UpdateProfileRequestBody {
  String? name;
  MultipartFile? avatar;
  String? phone;
  String? countryCode;

  UpdateProfileRequestBody({
    this.avatar,
    this.name,
    this.phone,
    this.countryCode,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'phone': phone,
      'country_code': countryCode,
    };
  }
}
