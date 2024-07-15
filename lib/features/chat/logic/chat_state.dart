import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_state.freezed.dart';

@Freezed()
class ChatState<T> with _$ChatState<T> {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.loading() = Loading;
  const factory ChatState.success(T data) = Success<T>;
  const factory ChatState.error({required String message}) = Error;

  const factory ChatState.sendLoading() = SendLoading;
  const factory ChatState.sendSuccess(T data) = SendSuccess<T>;
  const factory ChatState.sendError({required String message}) = SendError;

  const factory ChatState.selectMessageImg() = SelectMessageImg;
  const factory ChatState.sendActive() = SendActive;
  const factory ChatState.updateWithNewMessage() = UpdateWithNewMessage;
//
  const factory ChatState.chatLoading() = chatLoading;
  const factory ChatState.chatSuccess(T data) = chatSuccess<T>;
  const factory ChatState.chatError({required String message}) = chatError;

  const factory ChatState.pagination() = Pagination;

  const factory ChatState.deleteLoading() = deleteLoading;
  const factory ChatState.deleteSuccess(T data) = deleteSuccess<T>;
  const factory ChatState.deleteError({required String message}) = deleteError;
}
