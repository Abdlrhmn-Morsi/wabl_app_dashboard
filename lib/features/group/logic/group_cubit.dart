import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import 'package:wabl_app_dashboard/core/networking/error_handling/api_error_handler.dart';
import 'package:wabl_app_dashboard/features/group/logic/group_state.dart';

import '../../../core/helpers/app_cashed.dart';
import '../../../core/networking/api_result.dart';
import '../data/goup_model.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(const GroupState.initial());

  static GroupCubit get get => getIt();
  var groupsCol = FirebaseFirestore.instance.collection('groups');
  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;
  List<GroupModel> groupsList = [];
  Future<ApiResult> _getAllGroups(bool isPagination) async {
    try {
      var data = groupsCol
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

  Future emitGetAllGroups({
    bool isPagination = false,
    bool isRefresh = false,
    bool isLoadingActive = true,
  }) async {
    if (!AppCashe.isGroupsCashed() || (isLoadingActive && isRefresh)) {
      emit(const GroupState.loading());
    }
    if (isPagination) {
      isLoadingMore = true;
      emit(const GroupState.pagination());
    }
    if (isRefresh) {
      groupsList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }
    if (isRefresh || isPagination || !AppCashe.isGroupsCashed()) {
      var response = await _getAllGroups(isPagination);
      response.when(
        success: (data) {
          AppCashe.casheGroups();
          for (var group in data) {
            var data = GroupModel.fromDocumentSnapshot(group);
            groupsList.add(data);
          }
          isLoadingMore = false;
          emit(const GroupState.success(''));
        },
        failure: (e) {
          isLoadingMore = false;
          emit(GroupState.error(error: e.apiErrorModel.message ?? ""));
        },
      );
    }
  }

  void initData() {
    pageSize = 10;
    lastDocument = null;
    isLoadingMore = false;
    isReachedEnd = false;
    groupsList.clear();
  }

  Future<GroupModel> getGroup(String id) async {
    var response = await groupsCol.doc(id).get();
    return GroupModel.fromDocumentSnapshot(response);
  }
}
