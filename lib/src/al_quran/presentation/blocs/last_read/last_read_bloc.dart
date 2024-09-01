import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/get_last_read.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'last_read_event.dart';
part 'last_read_state.dart';
part 'last_read_bloc.freezed.dart';

@injectable
class LastReadBloc extends Bloc<LastReadEvent, LastReadState> {
  LastReadBloc({
    required GetLastRead getLastRead,
  })  : _getLastRead = getLastRead,
        super(const _Initial()) {
    on<_GetLastReadEvent>(_getLastReadHandler);
  }

  final GetLastRead _getLastRead;

  Future<void> _getLastReadHandler(
    _GetLastReadEvent event,
    Emitter<LastReadState> emit,
  ) async {
    emit(const _GettingLastRead());

    final result = await _getLastRead(
      GetLastReadParams(userId: event.userId),
    );

    result.fold(
      (failure) => emit(_GetLastReadFailed(message: failure.errorMessage)),
      (lastReadBookmark) {
        if (lastReadBookmark == null) {
          emit(const _LastReadEmpty());
          return;
        }

        emit(_LastReadLoaded(lastReadBookmark: lastReadBookmark));
      },
    );
  }
}
