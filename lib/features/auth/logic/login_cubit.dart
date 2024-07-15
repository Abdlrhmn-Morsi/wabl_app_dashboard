// ignore_for_file: unused_field
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/features/auth/logic/auth_helper.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/app_cashed.dart';
import '../../../core/helpers/app_local_storage.dart';
import '../../../core/helpers/app_saved_key.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/app_loading.dart';
import '../../bottom_nav_bar/logic/bottom_nav_bar_cubit.dart';
import '../data/models/login_request_body.dart';
import '../data/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  static LoginCubit get get => getIt();

  var emailTEC = TextEditingController();
  var passwordTEC = TextEditingController();
  Future<ApiResult<UserCredential>> loginToFirebase(
    LoginRequestBody body,
  ) async {
    try {
      var userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: body.email,
        password: body.password,
      );

      return ApiResult.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  void emitLogin() async {
    //!
    BottomNavBarCubit.get.changeIndex(0);
    //!
    var body = LoginRequestBody(
      email: emailTEC.text.trim(),
      password: passwordTEC.text.trim(),
    );
    emit(const LoginState.loading());
    var response = await loginToFirebase(body);
    response.when(
      success: (v) async {
        var isAuthorized = await AuthHelper.isAuthorized(v.user!.uid);
        if (isAuthorized) {
          var token = v.user!.uid;
          await ApplocalStorage.saveString(AppSavedKey.token, token);
          // var token = v.userData?.token ?? "";
          // String userId = '${v.userData?.id ?? ""}';
          // await ApplocalStorage.saveString(AppSavedKey.token, token);
          // await ApplocalStorage.saveString(AppSavedKey.userId, userId);
          clearTEC();
          emit(LoginState.success(v));
        } else {
          emit(
            const LoginState.error(
              message: 'Unauthorized',
            ),
          );
        }
      },
      failure: (v) {
        emit(
          LoginState.error(
            message: v.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  void logout({required BuildContext context}) async {
    AppLoading.loading(context);
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      await FirebaseAuth.instance.signOut().then((value) {
        Navigator.pop(context);
        ApplocalStorage.clear();
        AppCashe.reset();
        context.pushAndReplaceAllNamed(Routes.logInScreen);
      });
    });
  }

  void clearTEC() {
    emailTEC.clear();
    passwordTEC.clear();
  }
}
