import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import 'package:wabl_app_dashboard/core/networking/api_result.dart';
import 'package:wabl_app_dashboard/core/networking/error_handling/api_error_handler.dart';
import 'package:wabl_app_dashboard/features/users/data/models/user_response_body.dart';
import 'package:wabl_app_dashboard/features/users/logic/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.initial());
  static UserCubit get get => getIt();
  var usersCol = FirebaseFirestore.instance.collection('users');
  var searchController = TextEditingController();
  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;
  List<UserResponseBody> usersList = [];
  Future<ApiResult> getAllUsers(
    bool isPagination,
  ) async {
    try {
      var data = searchController.text.isNotEmpty
          ? usersCol
              .where('role', isEqualTo: 'user')
              .where(
                'email',
                isGreaterThanOrEqualTo: searchController.text,
                isLessThan: '${searchController.text}z',
              )
              .orderBy(
                'created_at',
                descending: true,
              )
              .limit(pageSize)
          : usersCol
              .where(
                'role',
                isEqualTo: 'user',
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
      if (docs.isNotEmpty) {
        lastDocument = docs.last;
      }
      isReachedEnd = isPagination && docs.length < pageSize;
      return ApiResult.success(docs);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitGetAllUsers({
    bool isPagination = false,
    bool isRefresh = false,
    bool isLoadingActive = true,
  }) async {
    if (!isPagination && isLoadingActive) emit(const UserState.loading());
    if (isPagination) {
      isLoadingMore = true;
      emit(const UserState.pagination());
    }
    if (isRefresh) {
      usersList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }
    var response = await getAllUsers(
      isPagination,
    );
    response.when(
      success: (data) {
        for (var user in data) {
          var data = UserResponseBody.fromDocumentSnapshot(user);
          usersList.add(data);
        }
        isLoadingMore = false;
        emit(const UserState.success(''));
      },
      failure: (e) {
        isLoadingMore = false;
        emit(UserState.error(message: e.apiErrorModel.message ?? ""));
      },
    );
  }

  bool isSearchResultEmpty() {
    return usersList.isEmpty && searchController.text.isNotEmpty;
  }

  void initData() {
    emit(const UserState.initial());
    pageSize = 10;
    lastDocument = null;
    isLoadingMore = false;
    isReachedEnd = false;
    searchController.clear();
    usersList.clear();
    emit(const UserState.success(''));
  }
}
