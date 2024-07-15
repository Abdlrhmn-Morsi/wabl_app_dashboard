import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_state.freezed.dart';

@Freezed()
abstract class CategoryState<T> with _$CategoryState<T> {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.success(T data) = Success;
  const factory CategoryState.error({required String message}) = Error;

  const factory CategoryState.selectedItem() = SelectedItem;
}
