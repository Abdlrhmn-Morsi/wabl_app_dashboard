import 'package:freezed_annotation/freezed_annotation.dart';
part 'car_type_state.freezed.dart';

@Freezed()
abstract class CarTypeState<T> with _$CarTypeState<T> {
  const factory CarTypeState.initial() = _Initial;
  const factory CarTypeState.loading() = Loading;
  const factory CarTypeState.success(T data) = Success;
  const factory CarTypeState.error({required String message}) = Error;

  const factory CarTypeState.pagination() = Pagination;

//! CUD create update delete
  const factory CarTypeState.cudLoading() = CudLoading;
  const factory CarTypeState.cudSuccess(T data) = CudSuccess;
  const factory CarTypeState.cudError({required String message}) = CudError;
}
