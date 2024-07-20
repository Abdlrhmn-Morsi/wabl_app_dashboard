import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import 'package:wabl_app_dashboard/features/group/logic/group_cubit.dart';
import '../../../core/helpers/image_crop_config.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../data/goup_model.dart';
import 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final GroupCubit groupCubit;
  CreateGroupCubit(this.groupCubit) : super(const CreateGroupState.initial());
  static CreateGroupCubit get get => getIt();
  final FirebaseStorage storage = FirebaseStorage.instance;
  var groupCol = FirebaseFirestore.instance.collection('groups');
  var nameTEC = TextEditingController();
  var descriptionTEC = TextEditingController();
  GroupModel? groupData;

  //!==== Create Group ===================================================================

  Future<ApiResult> _createGroup() async {
    try {
      var doc = groupCol.doc();
      var docId = doc.id;

      var cover = await uploadImagesToFirestore(docId: docId, img: groupCover);
      var avatar = await uploadImagesToFirestore(
        docId: docId,
        img: groupAvatar,
      );
      await doc.set({
        'id': docId,
        'name': nameTEC.text.toLowerCase(),
        'description': descriptionTEC.text,
        'cover': cover,
        'avatar': avatar,
        'created_at': FieldValue.serverTimestamp(),
      });
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitCreateGroup() async {
    emit(const CreateGroupState.loading());
    var response = await _createGroup();
    response.when(
      success: (v) async {
        resetData();
        emit(CreateGroupState.success('group_created_successfuly'.tr()));
        await groupCubit.emitGetAllGroups(isRefresh: true);
      },
      failure: (e) {
        emit(CreateGroupState.error(message: e.apiErrorModel.message ?? ""));
      },
    );
  }

//! ====== Update Group ======================================================
  Future<ApiResult> _updateGroup() async {
    try {
      var cover = await uploadImagesToFirestore(
        docId: groupData?.id ?? "",
        img: groupCover,
        oldImg: groupData?.cover ?? "",
      );
      var avatar = await uploadImagesToFirestore(
        docId: groupData?.id ?? '',
        img: groupAvatar,
        oldImg: groupData?.avatar ?? "",
      );

      Map<String, dynamic> data = {};

      if (nameTEC.text.isNotEmpty) {
        data['name'] = nameTEC.text.toLowerCase();
      }
      if (descriptionTEC.text.isNotEmpty) {
        data['description'] = descriptionTEC.text;
      }
      if (cover != null && cover.isNotEmpty) {
        data['cover'] = cover;
      }
      if (avatar != null && avatar.isNotEmpty) {
        data['avatar'] = avatar;
      }

      await groupCol.doc(groupData?.id).update(data);
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitUpdateGroup() async {
    emit(const CreateGroupState.loading());
    var response = await _updateGroup();
    response.when(
      success: (v) async {
        resetData();
        emit(CreateGroupState.success('group_updated_successfuly'.tr()));
        await groupCubit.emitGetAllGroups(isRefresh: true);
      },
      failure: (e) {
        emit(CreateGroupState.error(message: e.apiErrorModel.message ?? ""));
      },
    );
  }
//! ============================================================

  initData(GroupModel? group) {
    groupData = group;
    nameTEC.text = groupData?.name ?? "";
    descriptionTEC.text = groupData?.description ?? "";
  }

  File? groupAvatar;
  File? groupCover;
  getGroupAvatar() async {
    groupAvatar = await selectImage(CropStyle.circle);
  }

  getGroupCover() async {
    groupCover = await selectImage(CropStyle.rectangle);
  }

  Future<File?> selectImage(CropStyle? cropStyle) async {
    emit(const CreateGroupState.initial());
    try {
      final pickedImg =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImg == null) return null;
      File? theImg = File(pickedImg.path);
      File? newImg = await ImageCropHelper.cropImg(
        imageFile: theImg,
        cropStyle: cropStyle,
      );
      emit(const CreateGroupState.selectImage());
      return newImg;
    } catch (e) {
      return null;
    }
  }

  Future<String?> uploadImagesToFirestore({
    required String docId,
    File? img,
    String? oldImg,
  }) async {
    try {
      if (img == null) {
        return '';
      } else {
        if (oldImg != null && oldImg.isNotEmpty) {
          Reference oldImageRef = storage.refFromURL(oldImg);
          await oldImageRef.delete();
        }
        String fileName = path.basename(img.path);
        Reference firebaseStorageRef =
            storage.ref().child('groups/images/$fileName');
        await firebaseStorageRef.putFile(img);
        String downloadURL = await firebaseStorageRef.getDownloadURL();
        return (downloadURL);
      }
    } catch (e) {
      return '';
    }
  }

  removeImg({bool isAvatar = false}) {
    emit(const CreateGroupState.initial());
    if (isAvatar) {
      groupAvatar = null;
    } else {
      groupCover = null;
    }
    emit(const CreateGroupState.selectImage());
  }

  resetData() {
    groupAvatar = null;
    groupCover = null;
    nameTEC.clear();
    descriptionTEC.clear();
  }

//! ============ Delete Group ================================================

  Future emitDeleteGroup() async {
    emit(const CreateGroupState.loading());
    var response = await _deleteGroup();
    response.when(
      success: (message) async {
        resetData();
        emit(CreateGroupState.success('group_deleted_successfuly'.tr()));
        await groupCubit.emitGetAllGroups(
          isRefresh: true,
          // isLoadingActive: false,
        );
      },
      failure: (e) {
        emit(CreateGroupState.error(message: e.apiErrorModel.message ?? ""));
      },
    );
  }

  Future<ApiResult> _deleteGroup() async {
    try {
      await deleteImagFromStorage(groupData?.cover ?? "");
      await deleteImagFromStorage(groupData?.avatar ?? "");
      await groupCol.doc(groupData?.id).delete();
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  deleteImagFromStorage(String img) async {
    try {
      if (img.isEmpty) {
        return;
      }
      Reference oldImageRef = storage.refFromURL(img);
      await oldImageRef.delete();
    } catch (e) {
      return;
    }
  }
}
