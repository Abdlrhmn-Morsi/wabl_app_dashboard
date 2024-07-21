import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/app_cashed.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../auth/logic/auth_helper.dart';
import '../../group/logic/group_cubit.dart';
import '../data/post_response_body.dart';
import 'post_state.dart';
import 'post_viewer_cubit.dart';

class PostCubit extends Cubit<PostState> {
  final PostViewerCubit postViewerCubit;
  PostCubit(
    this.postViewerCubit,
  ) : super(const PostState.initial());
  static PostCubit get get => getIt();
  var postsCol = FirebaseFirestore.instance.collection('posts');

  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;

  List<PostResponseBody> postsList = [];
  Future<ApiResult> getPosts(
    bool isPagination, {
    bool isEnabled = false,
  }) async {
    try {
      var data = postsCol
          .where(
            'is_enabled',
            isEqualTo: isEnabled,
          )
          .orderBy(
            'created_at',
            descending: true,
          )
          .limit(pageSize);
      if (lastDocument != null) {
        data = data.startAfterDocument(lastDocument!);
      }
      var response = await data.get();
      var docs = response.docs;
      if (response.docs.isNotEmpty) {
        lastDocument = response.docs.last;
      }
      isReachedEnd = isPagination && docs.length < pageSize;
      return ApiResult.success(docs);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitGetPosts({
    bool isRefresh = false,
    bool isPagination = false,
    bool isEnabled = false,
  }) async {
    if (!isPagination && !AppCashe.isPostCashed() || isRefresh) {
      emit(const PostState.loading());
    }
    if (isPagination) {
      isLoadingMore = true;
      emit(const PostState.pagination());
    }
    if (isRefresh) {
      postsList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }

    if (!AppCashe.isPostCashed() || isRefresh || isPagination) {
      var response = await getPosts(isPagination, isEnabled: isEnabled);
      response.when(
        success: (data) async {
          AppCashe.cashePost();
          //! get posts
          for (var post in data) {
            var data = PostResponseBody.fromDocumentSnapshot(post);
            postsList.add(data);
          }

          //! get user data
          for (var post in postsList) {
            var postOwner = await AuthHelper.currentUserData(
              id: post.relatedToId ?? "",
            );
            post.postOwner = PostOwner(
              id: post.relatedToId ?? "",
              avatar: postOwner.avatar ?? "",
              name: postOwner.name ?? "",
            );
          }
          isLoadingMore = false;
          emit(PostState.success(postsList));
          //! increase view count
          await emitIncreaseViewCountAndCheckSaved();
        },
        failure: (error) {
          isLoadingMore = false;

          emit(
            PostState.error(
              message: error.apiErrorModel.message ?? '',
            ),
          );
        },
      );
    }
  }

  Future emitIncreaseViewCountAndCheckSaved() async {
    emit(const PostState.initial());
    for (var post in postsList) {
      if (post.groupId != null && post.groupId!.isNotEmpty) {
        post.group = await GroupCubit.get.getGroup(
          post.groupId ?? "",
        );
      }
      await postViewerCubit.emitIncreaseViewCount(
        postId: post.id ?? "",
        post: post,
      );
    }
    emit(PostState.success(postsList));
  }

  ///!
  int lastTapedIndex = 0;
  getLastIndex(int index) {
    emit(const PostState.initial());

    lastTapedIndex = index;
    emit(const PostState.getLastIndex());
  }
}
