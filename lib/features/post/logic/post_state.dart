import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_state.freezed.dart';

@Freezed()
abstract class PostState<T> with _$PostState<T> {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = Loading;
  const factory PostState.success(T data) = Success;
  const factory PostState.error({required String message}) = Error;
  const factory PostState.pagination() = Pagination;

  const factory PostState.switchIndicator() = SwitchIndicator;
  const factory PostState.getLastIndex() = GetLastIndex;
}
