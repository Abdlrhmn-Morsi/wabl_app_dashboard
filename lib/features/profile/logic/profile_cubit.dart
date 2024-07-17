// ignore_for_file: unused_field
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wabl_app_dashboard/core/helpers/app_cashed.dart';
import 'package:wabl_app_dashboard/core/helpers/app_local_storage.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/app_helper_functions.dart';
import '../../../core/helpers/image_crop_config.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../../core/widgets/app_toast.dart';
import '../../auth/logic/auth_helper.dart';
import '../data/models/profile_response_body.dart';
import '../data/models/update_profile_request_body.dart';
import '../data/repos/profile_web_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit(this._profileRepo) : super(const ProfileState.initial());
  static ProfileCubit get get => getIt();
  var profileData = ProfileData();
  var usersCol = FirebaseFirestore.instance.collection('users');

  Future<ApiResult<ProfileData>> getUserFirebase() async {
    try {
      var user =
          await AuthHelper.currentUserData(id: ApplocalStorage.getToken());
      return ApiResult.success(user);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future getUserInfo({
    required BuildContext context,
    bool isRefresh = false,
  }) async {
    if (!AppCashe.isUserDataCashed() || isRefresh) {
      profileData = ProfileData();
    }
    if (!AppCashe.isUserDataCashed() || isRefresh) {
      emit(const ProfileState.getUserInfoLoading());
      var response = await getUserFirebase();
      response.when(
        success: (user) {
          AppCashe.casheUserData();
          profileData = user;
          emit(ProfileState.getUserInfoSuccess(user));
        },
        failure: (e) {
          AppToast.show(
            context: context,
            message: e.apiErrorModel.message ?? "",
            isError: true,
          );
          emit(
            ProfileState.getUserInfoError(
              message: e.apiErrorModel.message ?? "",
            ),
          );
        },
      );
    }
  }

  Future<ApiResult> updateUserInfoFirebase(
    UpdateProfileRequestBody body,
  ) async {
    try {
      //! reomve null
      Map<String, dynamic> data = AppHelperFunctions.removeNulls(body.toJson());
      await usersCol.doc(AuthHelper.userId()).update(data);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitUpdateUserInfo({
    required BuildContext context,
    String? countryCode,
    String? name,
    String? phone,
  }) async {
    emit(const ProfileState.updateUserInfoLoading());
    var body = UpdateProfileRequestBody(
      name: name,
      countryCode: countryCode,
      phone: phone,
      avatar: userimagePickedHolder,
    );
    var response = await updateUserInfoFirebase(body);
    response.when(
      success: (v) async {
        emit(ProfileState.updateUserInfoSuccess(v));
        personImg = null;
        userimagePickedHolder = null;
        await getUserInfo(context: context);
      },
      failure: (e) {
        emit(
          ProfileState.updateUserInfoError(
            message: e.apiErrorModel.message ?? "",
          ),
        );
      },
    );
  }

  //!==================  select an image ==========================================
  //?=============================================================================
  final FirebaseStorage storage = FirebaseStorage.instance;
  MultipartFile? userimagePickedHolder;
  File? personImg;
  Future<ApiResult<String>> uploadImageToFirebase() async {
    try {
      if (personImg == null) {
        FirebaseException e = FirebaseException(
          plugin: 'firebase_storage',
          code: 'file-not-found',
          message: 'No file found',
        );
        return ApiResult.failure(ErrorHandler.handle(e));
      } else {
        if (profileData.avatar != null) {
          //! delete old image
          Reference oldImageRef = storage.refFromURL(profileData.avatar ?? "");
          await oldImageRef.delete();
        }
        //! upload new image
        String fileName = path.basename(personImg!.path);
        Reference firebaseStorageRef = storage.ref().child('avatars/$fileName');
        await firebaseStorageRef.putFile(personImg!);
        String downloadURL = await firebaseStorageRef.getDownloadURL();
        await usersCol.doc(profileData.docId).update({
          'avatar': downloadURL,
        });
        return ApiResult.success(downloadURL);
      }
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitUploadImage({required BuildContext context}) async {
    emit(const ProfileState.updateUserInfoLoading());
    var response = await uploadImageToFirebase();
    response.when(
      success: (url) async {
        emit(ProfileState.updateUserInfoSuccess(url));
        personImg = null;
        userimagePickedHolder = null;
        await getUserInfo(context: context);
      },
      failure: (e) {
        emit(
          ProfileState.updateUserInfoError(
            message: e.apiErrorModel.message ?? "",
          ),
        );
      },
    );
  }

  Future<void> selectPersonImage() async {
    emit(const ProfileState.initial());
    try {
      final pickedImg =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImg == null) return;
      File? theImg = File(pickedImg.path);
      File? newImg = await ImageCropHelper.cropImg(
        imageFile: theImg,
        cropStyle: CropStyle.circle,
      );
      personImg = newImg;
      userimagePickedHolder = await fileToMultipartFile(newImg);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    emit(const ProfileState.imagePacked());
  }

  Future<MultipartFile> fileToMultipartFile(File? file) async {
    if (file == null) null;
    String fileName = file!.path.split('/').last;
    return await MultipartFile.fromFile(file.path, filename: fileName);
  }
}
