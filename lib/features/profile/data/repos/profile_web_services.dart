import 'package:dio/dio.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/error_handling/api_error_handler.dart';
import '../models/profile_response_body.dart';
import '../models/update_password_request_body.dart';
import '../models/update_profile_request_body.dart';
import '../services/profile_web_services.dart';

class ProfileRepo {
  final ProfileWebServices _profileWebServices;
  ProfileRepo(this._profileWebServices);

  Future<ApiResult<ProfileResponseBody>> getUserInfo() async {
    try {
      var response = await _profileWebServices.getUserInfo();
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<Response>> updateUserInfo(
    UpdateProfileRequestBody body,
  ) async {
    try {
      var response = await _profileWebServices.updateUserInfo(body);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<Response>> updatePassword(
    UpdatePasswordRequestBody body,
  ) async {
    try {
      var response = await _profileWebServices.updatePassword(body);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
