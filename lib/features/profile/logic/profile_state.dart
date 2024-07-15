import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_state.freezed.dart';

@Freezed()
class ProfileState<T> with _$ProfileState<T> {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.getUserInfoLoading() = GetUserInfoLoading;
  const factory ProfileState.getUserInfoSuccess(T data) = GetUserInfoSuccess<T>;
  const factory ProfileState.getUserInfoError({required String message}) =
      GetUserInfoError;

  const factory ProfileState.updateUserInfoLoading() = UpdateUserInfoLoading;
  const factory ProfileState.updateUserInfoSuccess(T data) =
      UpdateUserInfoSuccess<T>;
  const factory ProfileState.updateUserInfoError({required String message}) =
      UpdateUserInfoError;

  const factory ProfileState.imagePacked() = ImagePacked;
}
