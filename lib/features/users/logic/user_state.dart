import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_state.freezed.dart';

@Freezed()
class UserState<T> with _$UserState<T> {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = Loading;
  const factory UserState.success(T data) = Success;
  const factory UserState.error({required String message}) = Error;

  const factory UserState.updateLoading() = UpdateLoading;
  const factory UserState.updateSuccess(T data) = UpdateSuccess;
  const factory UserState.updateError({required String message}) = UpdateError;

  const factory UserState.pagination() = Pagination;
}
