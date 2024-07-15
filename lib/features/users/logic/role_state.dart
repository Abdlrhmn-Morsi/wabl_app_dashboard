import 'package:freezed_annotation/freezed_annotation.dart';
part 'role_state.freezed.dart';

@Freezed()
class RoleState<T> with _$RoleState<T> {
  const factory RoleState.initial() = _Initial;
  const factory RoleState.loading() = Loading;
  const factory RoleState.success(T data) = Success;
  const factory RoleState.error({required String message}) = Error;
}
