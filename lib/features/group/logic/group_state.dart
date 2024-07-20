import 'package:freezed_annotation/freezed_annotation.dart';
part 'group_state.freezed.dart';

@Freezed()
class GroupState<T> with _$GroupState<T> {
  const factory GroupState.initial() = _Initial;
  const factory GroupState.loading() = Loading;
  const factory GroupState.success(T data) = Success;
  const factory GroupState.error({required String error}) = Error;

  const factory GroupState.pagination() = Pagination;
}
