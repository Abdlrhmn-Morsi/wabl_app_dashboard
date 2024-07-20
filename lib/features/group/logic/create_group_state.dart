import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_group_state.freezed.dart';

@Freezed()
class CreateGroupState<T> with _$CreateGroupState<T> {
  const factory CreateGroupState.initial() = _Initial;
  const factory CreateGroupState.loading() = Loading;
  const factory CreateGroupState.success(T data) = Success;
  const factory CreateGroupState.error({required String message}) = Error;

  const factory CreateGroupState.selectImage() = SelectImage;
}
