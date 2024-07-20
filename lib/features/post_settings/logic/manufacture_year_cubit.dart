import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:wabl_app_dashboard/core/di/dependency_injection.dart';
import 'package:wabl_app_dashboard/core/networking/error_handling/api_error_handler.dart';
import '../../../core/helpers/app_cashed.dart';
import '../../../core/networking/api_result.dart';
import '../data/manufacture_year_model.dart';
import 'manufacture_year_state.dart';

class ManufactureYearCubit extends Cubit<ManufactureYearState> {
  ManufactureYearCubit() : super(const ManufactureYearState.initial());
  static ManufactureYearCubit get get => getIt();
  var manufactureYearsCol =
      FirebaseFirestore.instance.collection('manufacture_years');

//! create =======================================

  Future<ApiResult> _createManufactureYear({
    required String year,
  }) async {
    try {
      var doc = manufactureYearsCol.doc();
      var docId = doc.id;

      await doc.set({
        'id': docId,
        'year': year,
        'created_at': FieldValue.serverTimestamp(),
      });

      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitCreateManufactureYear({
    required String year,
  }) async {
    emit(const ManufactureYearState.cudLoading());
    var response = await _createManufactureYear(year: year);
    response.when(
      success: (v) async {
        emit(
          ManufactureYearState.cudSuccess(
            'manufacture_year_created_successfuly'.tr(),
          ),
        );
        await emitGetAllManufactureYear(isRefresh: true);
      },
      failure: (e) {
        emit(ManufactureYearState.cudError(
            message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //! update  =====================================

  Future<ApiResult> _updateManufactureYear({
    required String manufactureYearId,
    required String year,
  }) async {
    try {
      await manufactureYearsCol.doc(manufactureYearId).update({
        'year': year,
      });
      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitUpdateManufactureYear({
    required String manufactureYearId,
    required String year,
  }) async {
    emit(const ManufactureYearState.cudLoading());
    var response = await _updateManufactureYear(
      manufactureYearId: manufactureYearId,
      year: year,
    );
    response.when(
      success: (v) async {
        emit(
          ManufactureYearState.cudSuccess(
            'manufacture_year_updated_successfuly'.tr(),
          ),
        );
        await emitGetAllManufactureYear(isRefresh: true);
      },
      failure: (e) {
        emit(ManufactureYearState.cudError(
            message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //! delete  =====================================

  Future<ApiResult> _deleteManufactureYear({
    required String manufactureYearId,
  }) async {
    try {
      await manufactureYearsCol.doc(manufactureYearId).delete();
      return const ApiResult.success({});
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitDeleteManufactureYear({
    required String manufactureYearId,
  }) async {
    emit(const ManufactureYearState.cudLoading());
    var response =
        await _deleteManufactureYear(manufactureYearId: manufactureYearId);
    response.when(
      success: (v) async {
        emit(
          ManufactureYearState.cudSuccess(
            'manufacture_year_deleted_successfuly'.tr(),
          ),
        );
        await emitGetAllManufactureYear(isRefresh: true);
      },
      failure: (e) {
        emit(ManufactureYearState.cudError(
            message: e.apiErrorModel.message ?? ''));
      },
    );
  }

  //! read =======================================

  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;
  List<ManufactureYearModel> manufactureYearList = [];
  Future<ApiResult> _getAllManufactureYear(bool isPagination) async {
    try {
      var data = manufactureYearsCol
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

  Future emitGetAllManufactureYear({
    bool isPagination = false,
    bool isRefresh = false,
    bool isLoadingActive = true,
  }) async {
    if (!AppCashe.isManufactureYearCashed() || (isLoadingActive && isRefresh)) {
      emit(const ManufactureYearState.loading());
    }
    if (isPagination) {
      isLoadingMore = true;
      emit(const ManufactureYearState.pagination());
    }
    if (isRefresh) {
      manufactureYearList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }
    if (isRefresh || isPagination || !AppCashe.isManufactureYearCashed()) {
      var response = await _getAllManufactureYear(isPagination);
      response.when(
        success: (data) {
          AppCashe.casheManufactureYear();
          for (var group in data) {
            var data = ManufactureYearModel.fromDocumentSnapshot(group);
            manufactureYearList.add(data);
          }
          isLoadingMore = false;
          emit(const ManufactureYearState.success(''));
        },
        failure: (e) {
          isLoadingMore = false;
          emit(ManufactureYearState.error(
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
    manufactureYearList.clear();
  }
}
