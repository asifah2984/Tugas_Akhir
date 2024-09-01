part of 'last_read_bloc.dart';

@freezed
class LastReadState with _$LastReadState {
  const factory LastReadState.initial() = _Initial;

  const factory LastReadState.gettingLastRead() = _GettingLastRead;

  const factory LastReadState.lastReadLoaded({
    required Bookmark lastReadBookmark,
  }) = _LastReadLoaded;

  const factory LastReadState.lastReadEmpty() = _LastReadEmpty;

  const factory LastReadState.getLastReadFailed({
    required String message,
  }) = _GetLastReadFailed;
}
