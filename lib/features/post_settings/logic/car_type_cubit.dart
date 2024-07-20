import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import 'package:wabl_app_dashboard/core/networking/error_handling/api_error_handler.dart';
import 'package:wabl_app_dashboard/features/post_settings/data/car_type_model.dart';
import 'package:wabl_app_dashboard/features/post_settings/logic/car_type_state.dart';
import '../../../core/helpers/app_cashed.dart';
import '../../../core/networking/api_result.dart';

class CarTypeCubit extends Cubit<CarTypeState> {
  CarTypeCubit() : super(const CarTypeState.initial());
  static CarTypeCubit get get => getIt();
  var carTypesCol = FirebaseFirestore.instance.collection('car_types');

//! create =======================================

  Future<ApiResult> _createCarType({
    required String type,
  }) async {
    try {
      var doc = carTypesCol.doc();
      var docId = doc.id;

      await doc.set({
        'id': docId,
        'type': type,
        'created_at': FieldValue.serverTimestamp(),
      });

      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitCreateCarType({
    required String type,
  }) async {
    emit(const CarTypeState.cudLoading());
    var response = await _createCarType(type: type);
    response.when(
      success: (v) async {
        emit(
          CarTypeState.cudSuccess(
            'car_type_created_successfuly'.tr(),
          ),
        );
        await emitGetAllCarTypes(isRefresh: true);
      },
      failure: (e) {
        emit(CarTypeState.cudError(message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //! update  =====================================

  Future<ApiResult> _updateCarType({
    required String id,
    required String type,
  }) async {
    try {
      await carTypesCol.doc(id).update({
        'type': type,
      });
      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitUpdateCarType({
    required String id,
    required String type,
  }) async {
    emit(const CarTypeState.cudLoading());
    var response = await _updateCarType(
      id: id,
      type: type,
    );
    response.when(
      success: (v) async {
        emit(
          CarTypeState.cudSuccess(
            'car_type_updated_successfuly'.tr(),
          ),
        );
        await emitGetAllCarTypes(isRefresh: true);
      },
      failure: (e) {
        emit(CarTypeState.cudError(message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //! delete  =====================================

  Future<ApiResult> _deleteCarType({
    required String id,
  }) async {
    try {
      await carTypesCol.doc(id).delete();
      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitDeleteCarType({
    required String id,
  }) async {
    emit(const CarTypeState.cudLoading());
    var response = await _deleteCarType(id: id);
    response.when(
      success: (v) async {
        emit(
          CarTypeState.cudSuccess(
            'car_type_deleted_successfuly'.tr(),
          ),
        );
        await emitGetAllCarTypes(isRefresh: true);
      },
      failure: (e) {
        emit(CarTypeState.cudError(message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //! read =======================================

  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;
  List<CarTypeModel> carTypesList = [];
  Future<ApiResult> _getAllCarType(bool isPagination) async {
    try {
      var data = carTypesCol
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

  Future emitGetAllCarTypes({
    bool isPagination = false,
    bool isRefresh = false,
    bool isLoadingActive = true,
  }) async {
    if (!AppCashe.isCarTypeCashed() || (isLoadingActive && isRefresh)) {
      emit(const CarTypeState.loading());
    }
    if (isPagination) {
      isLoadingMore = true;
      emit(const CarTypeState.pagination());
    }
    if (isRefresh) {
      carTypesList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }
    if (isRefresh || isPagination || !AppCashe.isCarTypeCashed()) {
      var response = await _getAllCarType(isPagination);
      response.when(
        success: (data) {
          AppCashe.casheCarType();
          for (var group in data) {
            var data = CarTypeModel.fromDocumentSnapshot(group);
            carTypesList.add(data);
          }
          isLoadingMore = false;
          emit(const CarTypeState.success(''));
        },
        failure: (e) {
          isLoadingMore = false;
          emit(CarTypeState.error(
            message: e.apiErrorModel.message ?? "",
          ));
        },
      );
    }
  }

  void initData() {
    pageSize = 10;
    lastDocument = null;
    isLoadingMore = false;
    isReachedEnd = false;
    carTypesList.clear();
  }
}
