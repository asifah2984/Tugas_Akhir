part of 'bookmark_bloc.dart';

@freezed
class BookmarkEvent with _$BookmarkEvent {
  const factory BookmarkEvent.getBookmarksEvent({
    required String userId,
  }) = _GetBookmarksEvent;

  const factory BookmarkEvent.createBookmarkEvent({
    required Bookmark bookmark,
  }) = _CreateBookmarkEvent;

  const factory BookmarkEvent.deleteBookmarkEvent({
    required int id,
  }) = _DeleteBookmarkEvent;
}
