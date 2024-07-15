// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/app_local_storage.dart';
import '../../../core/helpers/app_saved_key.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../bottom_nav_bar/logic/bottom_nav_bar_cubit.dart';
import '../data/models/signup_request_body.dart';
import '../data/repos/auth_repo.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo _authRepo;
  SignupCubit(this._authRepo) : super(const SignupState.initial());

  var usersCol = FirebaseFirestore.instance.collection('users');
  static SignupCubit get get => getIt();

  var nameTEC = TextEditingController();
  var emailTEC = TextEditingController();
  var countryCodeTEC = TextEditingController();
  var phoneNumberTEC = TextEditingController();
  var passwordTEC = TextEditingController();
  var confirmPasswordTEC = TextEditingController();

  Future<UserCredential?> emitSignUpFirebase() async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTEC.text,
        password: passwordTEC.text,
      );
    } on FirebaseAuthException catch (e) {
      emit(SignupState.error(message: e.message ?? ''));
    }
    return credential;
  }

  Future<ApiResult> emitSaveToFirestore(
    SignUpRequestBody body,
    String userId,
  ) async {
    try {
      var doc = usersCol.doc(userId);
      body.docId = doc.id;
      await doc.set(body.toJson());
      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  void emitSignUp() async {
    //!
    BottomNavBarCubit.get.changeIndex(0);
    //!
    emit(const SignupState.loading());
    var userCredential = await emitSignUpFirebase();
    var userId = userCredential!.user!.uid;

    var body = SignUpRequestBody(
      userId: userId,
      name: nameTEC.text,
      email: emailTEC.text.trim(),
      countryCode:
          countryCodeTEC.text.isEmpty ? '20' : countryCodeTEC.text.trim(),
      phoneNumber: phoneNumberTEC.text.trim(),
      role: "user",
      createdAt: DateTime.now().toIso8601String(),
    );
    var response = await emitSaveToFirestore(body, userId);
    response.when(
      success: (v) async {
        var token = userCredential.user!.uid;
        await ApplocalStorage.saveString(AppSavedKey.token, token);
        clearTEC();
        emit(SignupState.success(v));
      },
      failure: (v) {
        emit(
          SignupState.error(
            message: v.apiErrorModel.message ?? "Error",
          ),
        );
      },
    );
  }

  void clearTEC() {
    emailTEC.clear();
    nameTEC.clear();
    countryCodeTEC.clear();
    phoneNumberTEC.clear();
    passwordTEC.clear();
    confirmPasswordTEC.clear();
  }
}
