import 'package:dio/dio.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/error_handling/api_error_handler.dart';
import '../models/check_reset_code_response_body.dart';
import '../models/login_request_body.dart';
import '../models/login_response_body.dart';
import '../models/signup_request_body.dart';
import '../services/auth_web_service.dart';

class AuthRepo {
  final AuthWebService _apiService;
  AuthRepo(this._apiService);

  Future<ApiResult<LoginResponseBody>> login(LoginRequestBody body) async {
    try {
      final response = await _apiService.login(body);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LoginResponseBody>> signUp(SignUpRequestBody body) async {
    try {
      final response = await _apiService.signUp(body);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<Response>> forgetPassword(
    String email,
  ) async {
    try {
      final response = await _apiService.forgetPassword(email);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CheckResetCodeResponseBody>> checkResetCode(
    String email,
    String resetCode,
  ) async {
    try {
      final response = await _apiService.checkResetCode(email, resetCode);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<Response>> resetPassword(
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      final response = await _apiService.resetPassword(
        newPassword,
        newPasswordConfirmation,
      );
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
