import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../category/logic/category_cubit.dart';
import '../data/post_response_body.dart';
import 'post_cubit.dart';
import 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  final CategoryCubit categoryCubit;
  final PostCubit postCubit;
  UpdatePostCubit(
    this.categoryCubit,
    this.postCubit,
  ) : super(const UpdatePostState.initial());
  static UpdatePostCubit get get => getIt();

  var postsCol = FirebaseFirestore.instance.collection('posts');
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<ApiResult> updatePost({
    required bool isEnabled,
    required String postId,
  }) async {
    try {
      var data = {
        'is_enabled': isEnabled,
      };
      await postsCol.doc(postId).update(data);
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  void updatePostIsEnable({
    required PostResponseBody post,
    required bool isEnabled,
  }) {
    post.isEnabled = isEnabled;
  }

  Future emitUpdatePost({
    required BuildContext context,
    required bool isEnabled,
    required String postId,
    required PostResponseBody post,
  }) async {
    emit(const UpdatePostState.loading());
    var response = await updatePost(
      isEnabled: isEnabled,
      postId: postId,
    );
    response.when(
      success: (v) async {
        updatePostIsEnable(post: post, isEnabled: isEnabled);
        emit(const UpdatePostState.success(''));
      },
      failure: (e) {
        emit(UpdatePostState.error(message: e.apiErrorModel.message ?? ''));
      },
    );
  }
}
