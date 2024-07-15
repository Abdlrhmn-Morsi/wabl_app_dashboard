import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_post_state.freezed.dart';

@Freezed()
abstract class CreatePostState<T> with _$CreatePostState<T> {
  const factory CreatePostState.initial() = _Initial;
  const factory CreatePostState.loading() = Loading;
  const factory CreatePostState.success(T data) = Success;
  const factory CreatePostState.error({required String message}) = Error;

  const factory CreatePostState.selectImages() = SelectImages;
}
