import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_password_state.freezed.dart';

@Freezed()
abstract class UpdatePasswordState<T> with _$UpdatePasswordState<T> {
  const factory UpdatePasswordState.initial() = _Initial;
  const factory UpdatePasswordState.loading() = Loading;
  const factory UpdatePasswordState.success(T data) = Success<T>;
  const factory UpdatePasswordState.error({required String message}) = Error;
}
