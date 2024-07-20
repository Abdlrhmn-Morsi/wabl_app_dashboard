import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_group_state.freezed.dart';

@Freezed()
class UpdateGroupState<T> with _$UpdateGroupState<T> {
  const factory UpdateGroupState.initial() = _Initial;
  const factory UpdateGroupState.loading() = Loading;
  const factory UpdateGroupState.success(T data) = Success;
  const factory UpdateGroupState.error({required String message}) = Error;
}
