import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/app_local_storage.dart';
import '../../../core/helpers/app_saved_key.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../data/repos/auth_repo.dart';
import 'auth_helper.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepo _authRepo;
  ForgetPasswordCubit(
    this._authRepo,
  ) : super(const ForgetPasswordState.initial());

  static ForgetPasswordCubit get get => getIt();

  //* reset password firebase
  Future<ApiResult> resetPasswordFirebase() async {
    bool isExists = await AuthHelper.isExists(
      key: 'email',
      value: emailTEC.text,
      collection: FirebaseFirestore.instance.collection('users'),
    );
    try {
      if (!isExists) {
        FirebaseAuthException e = FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found',
        );
        return ApiResult.failure(ErrorHandler.handle(e));
      } else {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailTEC.text);
        return const ApiResult.success({});
      }
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitResetPasswordFirebase() async {
    emit(const ForgetPasswordState.loading());
    var response = await resetPasswordFirebase();
    response.when(
      success: (v) {
        emailTEC.clear();
        emit(ForgetPasswordState.success(v));
      },
      failure: (e) {
        emit(ForgetPasswordState.error(message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //!======================================

  //*ForgetPassword
  var emailTEC = TextEditingController();
  Future emitForgetPassword() async {
    emit(const ForgetPasswordState.loading());
    var response = await _authRepo.forgetPassword(emailTEC.text);
    response.when(
      success: (v) {
        emit(ForgetPasswordState.success(v));
      },
      failure: (e) {
        emit(ForgetPasswordState.error(message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //*CheckResetCode
  var resetCodeTEC = TextEditingController();

  Future emitCheckResetCode() async {
    emit(const ForgetPasswordState.loading());
    var response = await _authRepo.checkResetCode(
      emailTEC.text,
      resetCodeTEC.text,
    );
    response.when(
      success: (v) {
        var tempToken = v.tempToken ?? "";
        ApplocalStorage.saveString(AppSavedKey.resetToken, tempToken);
        emit(ForgetPasswordState.success(v));
      },
      failure: (e) {
        emit(ForgetPasswordState.error(message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //*ResetPassword

  Future emitResetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(const ForgetPasswordState.loading());
    var response = await _authRepo.resetPassword(
      newPassword,
      confirmPassword,
    );
    response.when(
      success: (v) {
        emit(ForgetPasswordState.success(v));
      },
      failure: (e) {
        emit(ForgetPasswordState.error(message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  void clearTEC() {
    emailTEC.clear();
    resetCodeTEC.clear();
  }
}
