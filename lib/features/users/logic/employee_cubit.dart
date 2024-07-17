import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import 'package:wabl_app_dashboard/core/helpers/app_cashed.dart';

import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../data/models/user_response_body.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(const EmployeeState.initial());

  static EmployeeCubit get get => getIt();
  var usersCol = FirebaseFirestore.instance.collection('users');
  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;
  List<UserResponseBody> employeesList = [];
  Future<ApiResult> getAllEmployees(bool isPagination) async {
    try {
      var data = usersCol
          .where(
            'role',
            isEqualTo: 'admin',
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

  Future emitGetAllEmployees({
    bool isPagination = false,
    bool isRefresh = false,
    bool isLoadingActive = true,
  }) async {
    emit(const EmployeeState.fresh());
    if (!AppCashe.isEmployeeCashed() || (isLoadingActive && isRefresh)) {
      emit(const EmployeeState.loading());
    }
    if (isPagination) {
      isLoadingMore = true;
      emit(const EmployeeState.pagination());
    }
    if (isRefresh) {
      employeesList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }
    if (isRefresh || isPagination || !AppCashe.isEmployeeCashed()) {
      var response = await getAllEmployees(isPagination);
      response.when(
        success: (data) {
          AppCashe.casheEmployee();
          for (var user in data) {
            var data = UserResponseBody.fromDocumentSnapshot(user);
            employeesList.add(data);
          }
          isLoadingMore = false;
          emit(const EmployeeState.success(''));
        },
        failure: (e) {
          isLoadingMore = false;
          emit(EmployeeState.error(message: e.apiErrorModel.message ?? ""));
        },
      );
    }
  }

  void initData() {
    pageSize = 10;
    lastDocument = null;
    isLoadingMore = false;
    isReachedEnd = false;
    employeesList.clear();
  }
}
