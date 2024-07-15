import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../auth/logic/auth_helper.dart';
import '../data/post_response_body.dart';
import 'post_viewer_state.dart';

class PostViewerCubit extends Cubit<PostViewerState> {
  PostViewerCubit() : super(const PostViewerState.initial());
  var postsCol = FirebaseFirestore.instance.collection('posts');

  static PostViewerCubit get get => getIt();

  Future<ApiResult> increaseViewCount({
    required String postId,
    required PostResponseBody targetPost,
  }) async {
    try {
      var post = postsCol.doc(postId);
      var viewer = post.collection('viewers').doc(AuthHelper.userId);
      var data = await viewer.get();
      if (!data.exists) {
        await viewer.set({
          'id': AuthHelper.userId,
          'viewed_at': FieldValue.serverTimestamp(),
        });
        await post.update({
          'view_count': FieldValue.increment(1),
        });
        targetPost.viewCount = (targetPost.viewCount ?? 0) + 1;
      }
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitIncreaseViewCount({
    required String postId,
    required PostResponseBody post,
  }) async {
    emit(const PostViewerState.loading());
    var response = await increaseViewCount(
      postId: postId,
      targetPost: post,
    );
    response.when(
      success: (v) {
        emit(const PostViewerState.success(''));
      },
      failure: (e) {
        emit(PostViewerState.error(message: e.apiErrorModel.message ?? ''));
      },
    );
  }
}
