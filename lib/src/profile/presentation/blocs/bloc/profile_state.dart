part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.gettingTajwidTestResults() =
      _GettingTajwidTestResults;

  const factory ProfileState.tajwidTestResultsLoaded({
    required List<TajwidTestResult> results,
  }) = _TajwidTestResultsLoaded;

  const factory ProfileState.getTajwidTestResultsFailed({
    required String message,
  }) = _GetTajwidTestResultsFailed;
}
