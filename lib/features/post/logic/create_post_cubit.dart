import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../../core/widgets/app_toast.dart';
import '../../auth/logic/auth_helper.dart';
import '../../category/logic/category_cubit.dart';
import '../data/post_request_body.dart';
import 'create_post_state.dart';
import 'post_cubit.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostCubit postCubit;
  final CategoryCubit categoryCubit;
  CreatePostCubit(
    this.postCubit,
    this.categoryCubit,
  ) : super(const CreatePostState.initial());
  static CreatePostCubit get get => getIt();
  var postsCol = FirebaseFirestore.instance.collection('posts');
  final FirebaseStorage storage = FirebaseStorage.instance;

  var contentTEC = TextEditingController();
  Future<ApiResult> createPost(PostRequestBody data) async {
    emit(const CreatePostState.initial());
    try {
      var postDoc = postsCol.doc();
      var postDocId = postDoc.id;
      var images = await uploadImagesToFirestore(postDocId);
      images.map(
        success: (v) async {
          data.id = postDocId;
          data.images = v.data;
          await postDoc.set(data.toJson());
        },
        failure: (v) {},
      );
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  void emitCreatePost({required BuildContext context}) async {
    if (contentTEC.text.isEmpty) {
      AppToast.show(
        context: context,
        message: 'Content is required',
        isError: true,
      );
      return;
    }
    if (categoryCubit.selectedCategoryAddPostAndSearch?.id == null) {
      AppToast.show(
        context: context,
        message: 'Category is required',
        isError: true,
      );
      return;
    }
    emit(const CreatePostState.loading());
    var body = PostRequestBody(
      relatedToId: AuthHelper.userId(),
      content: contentTEC.text,
      createdAt: FieldValue.serverTimestamp(),
      categoryId: categoryCubit.selectedCategoryAddPostAndSearch?.id ?? "",
    );
    var response = await createPost(body);
    response.when(
      success: (v) async {
        clearData();
        context.pop();
        emit(const CreatePostState.success(''));
        categoryCubit.resetSeletedItem();
        await postCubit.emitGetPosts(isRefresh: true);
      },
      failure: (v) {
        emit(CreatePostState.error(message: v.apiErrorModel.message ?? ''));
      },
    );
  }

  void clearData() {
    contentTEC.clear();
    selectedImages.clear();
  }

  //! select images
  List<File> selectedImages = [];
  void selectImages({required BuildContext context}) async {
    const maxImages = 6;
    emit(const CreatePostState.initial());
    try {
      if (selectedImages.length >= maxImages) {
        AppToast.show(
          context: context,
          message: 'You can not select more than 6 images',
          isError: true,
        );
        return;
      }
      List<XFile> imgs = [];
      if (maxImages - selectedImages.length == 1) {
        var v = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (v == null) return;
        imgs.add(v);
      } else {
        imgs = await ImagePicker().pickMultiImage(
          limit: maxImages - selectedImages.length,
        );
      }
      selectedImages.addAll(imgs.map((e) => File(e.path)).toList());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    emit(const CreatePostState.selectImages());
  }

  void removeImgFromList(int index) {
    emit(const CreatePostState.initial());
    selectedImages.removeAt(index);
    emit(const CreatePostState.selectImages());
  }

  Future<ApiResult<List<String>>> uploadImagesToFirestore(
    String docId,
  ) async {
    try {
      if (selectedImages.isEmpty) {
        return const ApiResult.success([]);
      } else {
        List<String> urls = [];
        for (var img in selectedImages) {
          String fileName = path.basename(img.path);
          Reference firebaseStorageRef =
              storage.ref().child('posts/images/$fileName');
          await firebaseStorageRef.putFile(img);
          String downloadURL = await firebaseStorageRef.getDownloadURL();
          urls.add(downloadURL);
        }
        return ApiResult.success(urls);
        //! upload new image
      }
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
