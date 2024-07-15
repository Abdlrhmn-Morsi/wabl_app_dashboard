import 'package:freezed_annotation/freezed_annotation.dart';
part 'current_user_posts_state.freezed.dart';

@Freezed()
abstract class CurrentUserPostsState<T> with _$CurrentUserPostsState<T> {
  const factory CurrentUserPostsState.initial() = _Initial;
  const factory CurrentUserPostsState.loading() = Loading;
  const factory CurrentUserPostsState.success(T data) = Success;
  const factory CurrentUserPostsState.error({required String message}) = Error;

  const factory CurrentUserPostsState.pagination() = Pagination;
  const factory CurrentUserPostsState.switchIndicator() = SwitchIndicator;
}
