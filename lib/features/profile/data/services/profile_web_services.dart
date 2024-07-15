import 'package:dio/dio.dart';
import '../../../../core/helpers/app_local_storage.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio_client.dart';
import '../models/profile_response_body.dart';
import '../models/update_password_request_body.dart';
import '../models/update_profile_request_body.dart';

abstract class ProfileWebServices {
  DioClient dioClient;
  ProfileWebServices({
    required this.dioClient,
  });

  Future<ProfileResponseBody> getUserInfo();
  Future<Response> updateUserInfo(UpdateProfileRequestBody body);
  Future<Response> updatePassword(UpdatePasswordRequestBody body);
}

class ProfileWebServicesImpl extends ProfileWebServices {
  ProfileWebServicesImpl({required super.dioClient});

  @override
  Future<ProfileResponseBody> getUserInfo() async {
    var token = ApplocalStorage.getToken();
    var response = await dioClient.get(
      ApiConstants.authInfo,
      options: Options(
        method: "GET",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return ProfileResponseBody.fromJson(response.data);
  }

  @override
  Future<Response> updateUserInfo(UpdateProfileRequestBody body) async {
    var token = ApplocalStorage.getToken();
    FormData formData = FormData.fromMap(body.toJson());
    var response = await dioClient.post(
      ApiConstants.updateInfo,
      data: formData,
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  }

  @override
  Future<Response> updatePassword(UpdatePasswordRequestBody body) async {
    var token = ApplocalStorage.getToken();
    FormData formData = FormData.fromMap(body.toJson());
    var response = await dioClient.post(
      ApiConstants.updatePassword,
      data: formData,
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  }
}
