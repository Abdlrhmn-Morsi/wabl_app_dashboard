import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../auth/logic/auth_helper.dart';
import '../../group/logic/group_cubit.dart';
import '../data/post_response_body.dart';
import 'current_user_posts_state.dart';

class CurrentUserPostsCubit extends Cubit<CurrentUserPostsState> {
  CurrentUserPostsCubit() : super(const CurrentUserPostsState.initial());

  static CurrentUserPostsCubit get get => getIt();
  var postsCol = FirebaseFirestore.instance.collection('posts');

  int currentIndex = 0;
  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;
  List<PostResponseBody> postsList = [];

  void resetData() {
    pageSize = 10;
    lastDocument = null;
    isLoadingMore = false;
    isReachedEnd = false;
    currentIndex = 0;
    postsList.clear();
  }

  void switchIndicator(int index) {
    emit(const CurrentUserPostsState.initial());
    currentIndex = index;
    emit(const CurrentUserPostsState.switchIndicator());
  }

  Future<ApiResult> getPosts(
    String userId,
    bool isPagination,
  ) async {
    try {
      var data = postsCol
          .where('related_to_id', isEqualTo: userId)
          .orderBy(
            'created_at',
            descending: true,
          )
          .limit(
            pageSize,
          );
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
    required String userId,
  }) async {
    if (!isPagination) emit(const CurrentUserPostsState.loading());
    if (isPagination) {
      isLoadingMore = true;
      emit(const CurrentUserPostsState.pagination());
    }
    if (isRefresh) {
      postsList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }
    var response = await getPosts(
      userId,
      isPagination,
    );
    response.when(
      success: (data) async {
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
            avatar: postOwner.avatar ?? "",
            name: postOwner.name ?? "",
          );
        }

        isLoadingMore = false;
        emit(CurrentUserPostsState.success(postsList));
        await initRealtion();
      },
      failure: (error) {
        isLoadingMore = false;
        emit(
          CurrentUserPostsState.error(
            message: error.apiErrorModel.message ?? '',
          ),
        );
      },
    );
  }

  Future initRealtion() async {
    emit(const CurrentUserPostsState.initial());
    for (var post in postsList) {
      post.group = await GroupCubit.get.getGroup(
        post.groupId ?? "",
      );
    }
    emit(CurrentUserPostsState.success(postsList));
  }
}
