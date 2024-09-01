import 'package:alquran_app/src/profile/domain/entities/tajwid_test_result.dart';
import 'package:alquran_app/src/profile/domain/usecases/get_tajwid_test_results.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetTajwidTestResults getTajwidTestResults,
  })  : _getTajwidTestResults = getTajwidTestResults,
        super(const _Initial()) {
    on<_GetTajwidTestResultsEvent>(_getTajwidTestResultsHandler);
  }

  final GetTajwidTestResults _getTajwidTestResults;

  Future<void> _getTajwidTestResultsHandler(
    _GetTajwidTestResultsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const _GettingTajwidTestResults());

    final result = await _getTajwidTestResults();

    result.fold(
      (failure) =>
          emit(_GetTajwidTestResultsFailed(message: failure.errorMessage)),
      (results) => emit(_TajwidTestResultsLoaded(results: results)),
    );
  }
}
