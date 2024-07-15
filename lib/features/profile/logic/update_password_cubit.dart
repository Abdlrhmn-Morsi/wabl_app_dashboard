import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../data/repos/profile_web_services.dart';
import 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final ProfileRepo profileRepo;
  UpdatePasswordCubit(this.profileRepo)
      : super(const UpdatePasswordState.initial());
  static UpdatePasswordCubit get get => getIt();

  void emitUpdatePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(const UpdatePasswordState.loading());
    final response = await updatePasswordFirebase(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    response.when(
      success: (v) {
        emit(UpdatePasswordState.success(v));
      },
      failure: (e) {
        emit(UpdatePasswordState.error(message: e.apiErrorModel.message ?? ""));
      },
    );
  }

  Future<ApiResult> updatePasswordFirebase({
    required String oldPassword,
    required String newPassword,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    try {
      if (currentUser == null) {
        FirebaseException e = FirebaseException(
          plugin: 'firebase_auth',
          code: 'user-not-found',
          message: 'No user found',
        );
        return ApiResult.failure(ErrorHandler.handle(e));
      } else {
        var credential = EmailAuthProvider.credential(
          email: currentUser.email ?? '',
          password: oldPassword,
        );
        await currentUser
            .reauthenticateWithCredential(credential)
            .then((value) async {
          await currentUser.updatePassword(newPassword);
        });
        return const ApiResult.success({});
      }
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
