import 'package:freezed_annotation/freezed_annotation.dart';
part 'manufacture_year_state.freezed.dart';

@Freezed()
abstract class ManufactureYearState<T> with _$ManufactureYearState<T> {
  const factory ManufactureYearState.initial() = _Initial;
  const factory ManufactureYearState.loading() = Loading;
  const factory ManufactureYearState.success(T data) = Success;
  const factory ManufactureYearState.error({required String message}) = Error;

  const factory ManufactureYearState.pagination() = Pagination;

//! CUD create update delete
  const factory ManufactureYearState.cudLoading() = CudLoading;
  const factory ManufactureYearState.cudSuccess(T data) = CudSuccess;
  const factory ManufactureYearState.cudError({required String message}) =
      CudError;
}
