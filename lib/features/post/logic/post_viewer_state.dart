import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_viewer_state.freezed.dart';

@Freezed()
abstract class PostViewerState<T> with _$PostViewerState<T> {
  const factory PostViewerState.initial() = _Initial;
  const factory PostViewerState.loading() = Loading;
  const factory PostViewerState.success(T data) = Success;
  const factory PostViewerState.error({required String message}) = Error;
}
