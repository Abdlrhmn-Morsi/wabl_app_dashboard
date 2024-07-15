import 'package:freezed_annotation/freezed_annotation.dart';
part 'statistics_state.freezed.dart';

@Freezed()
class StatisticsState<T> with _$StatisticsState<T> {
  const factory StatisticsState.initial() = _Initial;
  const factory StatisticsState.loading() = Loading;
  const factory StatisticsState.success(T data) = Success;
  const factory StatisticsState.error({required String message}) = Error;
}
