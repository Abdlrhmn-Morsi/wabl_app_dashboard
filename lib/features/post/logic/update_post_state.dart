import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_post_state.freezed.dart';

@Freezed()
abstract class UpdatePostState<T> with _$UpdatePostState<T> {
  const factory UpdatePostState.initial() = _Initial;
  const factory UpdatePostState.loading() = Loading;
  const factory UpdatePostState.success(T data) = Success;
  const factory UpdatePostState.error({required String message}) = Error;

  const factory UpdatePostState.deleteLoading() = DeleteLoading;
  const factory UpdatePostState.deleteSuccess(T data) = DeleteSuccess;
  const factory UpdatePostState.deleteError({required String message}) =
      DeleteError;

  const factory UpdatePostState.selectImages() = SelectImages;
}
