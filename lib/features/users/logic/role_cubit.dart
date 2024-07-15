import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  RoleCubit() : super(const RoleState.initial());
  static RoleCubit get get => getIt();
  var usersCol = FirebaseFirestore.instance.collection('users');

  //!
  Future<ApiResult> updateRole({
    required String userId,
    required String role,
  }) async {
    try {
      await usersCol.doc(userId).update({'role': role});
      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitUpdateRole({
    required String userId,
    required String role,
  }) async {
    emit(const RoleState.loading());
    var response = await updateRole(userId: userId, role: role);
    response.when(
      success: (data) {
        emit(RoleState.success(
          role == 'admin'
              ? "Employee added successfully"
              : "Employee Removed successfully",
        ));
      },
      failure: (e) {
        emit(RoleState.error(message: e.apiErrorModel.message ?? ""));
      },
    );
  }
}
