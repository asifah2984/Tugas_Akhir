part of 'bookmark_bloc.dart';

@freezed
class BookmarkState with _$BookmarkState {
  const factory BookmarkState.initial() = _Initial;

  const factory BookmarkState.gettingBookmarks() = _GettingBookmarks;

  const factory BookmarkState.bookmarksLoaded({
    required List<Bookmark> bookmarks,
  }) = _BookmarksLoaded;

  const factory BookmarkState.getBookmarksFailed({
    required String message,
  }) = _GetBookmarksFailed;

  const factory BookmarkState.creatingBookmark() = _CreatingBookmark;

  const factory BookmarkState.bookmarkCreated() = _BookmarkCreated;

  const factory BookmarkState.createBookmarkFailed({
    required String message,
  }) = _CreateBookmarkFailed;

  const factory BookmarkState.deletingBookmark() = _DeletingBookmark;

  const factory BookmarkState.bookmarkDeleted() = _BookmarkDeleted;

  const factory BookmarkState.deleteBookmarkFailed({
    required String message,
  }) = _DeleteBookmarkFailed;
}
