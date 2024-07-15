import 'package:dio/dio.dart';
import '../../../../core/helpers/app_local_storage.dart';
import '../../../../core/helpers/app_saved_key.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio_client.dart';
import '../models/check_reset_code_response_body.dart';
import '../models/login_request_body.dart';
import '../models/login_response_body.dart';
import '../models/signup_request_body.dart';

abstract class AuthWebService {
  DioClient dioClient;
  AuthWebService({
    required this.dioClient,
  });

  //* Auth
  Future<LoginResponseBody> login(
    LoginRequestBody body,
  );
  Future<LoginResponseBody> signUp(
    SignUpRequestBody body,
  );
  Future<Response> forgetPassword(
    String email,
  );

  Future<CheckResetCodeResponseBody> checkResetCode(
    String email,
    String resetCode,
  );
  Future<Response> resetPassword(
    String newPassword,
    String newPasswordConfirmation,
  );
  //
}

class AuthWebServiceImp extends AuthWebService {
  AuthWebServiceImp({required super.dioClient});
  //
  @override
  Future<LoginResponseBody> login(LoginRequestBody body) async {
    var response = await dioClient.post(
      ApiConstants.login,
      data: body.toJson(),
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return LoginResponseBody.fromJson(response.data);
  }

  @override
  Future<LoginResponseBody> signUp(SignUpRequestBody body) async {
    var response = await dioClient.post(
      ApiConstants.signup,
      data: body.toJson(),
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return LoginResponseBody.fromJson(response.data);
  }

  @override
  Future<Response> forgetPassword(String email) async {
    var data = {'email': email};
    var response = await dioClient.post(
      ApiConstants.forgetPassword,
      data: data,
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return response;
  }

  @override
  Future<CheckResetCodeResponseBody> checkResetCode(
    String email,
    String resetCode,
  ) async {
    var data = {
      'email': email,
      'reset_code': resetCode,
    };
    var response = await dioClient.post(
      ApiConstants.checkResetCode,
      data: data,
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return CheckResetCodeResponseBody.fromJson(response.data);
  }

  @override
  Future<Response> resetPassword(
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    var resetToken = ApplocalStorage.getString(AppSavedKey.resetToken);
    var data = {
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };
    var response = await dioClient.post(
      ApiConstants.resetPassword,
      data: data,
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $resetToken',
        },
      ),
    );
    return response;
  }
}
