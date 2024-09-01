import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/create_bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/delete_bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/get_bookmarks.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';
part 'bookmark_bloc.freezed.dart';

@injectable
class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc({
    required GetBookmarks getBookmarks,
    required CreateBookmark createBookmark,
    required DeleteBookmark deleteBookmark,
  })  : _getBookmarks = getBookmarks,
        _createBookmark = createBookmark,
        _deleteBookmark = deleteBookmark,
        super(const _Initial()) {
    on<_GetBookmarksEvent>(_getBookmarksHandler);
    on<_CreateBookmarkEvent>(_createBookmarkHandler);
    on<_DeleteBookmarkEvent>(_deleteBookmarkHandler);
  }

  final GetBookmarks _getBookmarks;
  final CreateBookmark _createBookmark;
  final DeleteBookmark _deleteBookmark;

  List<Bookmark>? _bookmarks;

  List<Bookmark>? get bookmarks => _bookmarks;

  Future<void> _getBookmarksHandler(
    _GetBookmarksEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const _GettingBookmarks());

    final result = await _getBookmarks(
      GetBookmarksParams(
        userId: event.userId,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetBookmarksFailed(message: failure.errorMessage)),
      (bookmarks) => emit(_BookmarksLoaded(bookmarks: bookmarks)),
    );
  }

  Future<void> _createBookmarkHandler(
    _CreateBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const _CreatingBookmark());

    final result = await _createBookmark(
      CreateBookmarkParams(
        bookmark: event.bookmark,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_CreateBookmarkFailed(message: failure.errorMessage)),
      (_) => emit(const _BookmarkCreated()),
    );
  }

  Future<void> _deleteBookmarkHandler(
    _DeleteBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const _DeletingBookmark());

    final result = await _deleteBookmark(
      DeleteBookmarkParams(
        id: event.id,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_DeleteBookmarkFailed(message: failure.errorMessage)),
      (_) => emit(const _BookmarkDeleted()),
    );
  }
}
