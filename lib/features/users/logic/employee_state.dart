import 'package:freezed_annotation/freezed_annotation.dart';
part 'employee_state.freezed.dart';

@Freezed()
class EmployeeState<T> with _$EmployeeState<T> {
  const factory EmployeeState.initial() = _Initial;
  const factory EmployeeState.loading() = Loading;
  const factory EmployeeState.success(T data) = Success;
  const factory EmployeeState.error({required String message}) = Error;

  const factory EmployeeState.fresh() = Fresh;

  const factory EmployeeState.pagination() = Pagination;
}
