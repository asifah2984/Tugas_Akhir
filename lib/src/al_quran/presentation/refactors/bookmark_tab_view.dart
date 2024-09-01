import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/juz_bloc/juz_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/views/surah_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookmarkTabView extends StatefulWidget {
  const BookmarkTabView({super.key});

  @override
  State<BookmarkTabView> createState() => _BookmarkTabViewState();
}

class _BookmarkTabViewState extends State<BookmarkTabView>
    with AutomaticKeepAliveClientMixin {
  void _getBookmarks() {
    final userId = context.read<UserNotifier>().user!.id;

    context.read<BookmarkBloc>().add(
          BookmarkEvent.getBookmarksEvent(userId: userId),
        );
  }

  void _getToDetail(Bookmark bookmark) {
    if (bookmark.type == 'surah') {
      context.pushNamed(
        SurahDetailScreen.name,
        extra: {
          'title': bookmark.title,
          'bloc': context.read<BookmarkBloc>(),
        },
        pathParameters: {'number': '${bookmark.surahOrJuzId}'},
      );
    }

    if (bookmark.type == 'juz') {
      context.read<JuzBloc>().add(
            JuzEvent.getJuzEvent(
              juz: bookmark.surahOrJuzId,
            ),
          );
    }
  }

  void _deleteBookmark(int id) {
    context.read<BookmarkBloc>().add(
          BookmarkEvent.deleteBookmarkEvent(id: id),
        );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getBookmarks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<BookmarkBloc, BookmarkState>(
      listener: (context, state) {
        state.whenOrNull(
          bookmarkDeleted: () {
            _getBookmarks();
            CoreUtils.showSnackBar(
              context: context,
              message: 'Berhasil menghapus bookmark',
              type: SnackBarType.success,
            );
          },
          deleteBookmarkFailed: (message) {
            _getBookmarks();
            CoreUtils.showSnackBar(
              context: context,
              message: message,
              type: SnackBarType.error,
            );
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          gettingBookmarks: _buildLoading,
          getBookmarksFailed: _buildError,
          bookmarksLoaded: _buildContent,
          deletingBookmark: () {
            final bookmarks = context.read<BookmarkBloc>().bookmarks;
            return _buildContent(bookmarks ?? []);
          },
          orElse: Container.new,
        );
      },
    );
  }

  Widget _buildContent(List<Bookmark> bookmarks) {
    if (bookmarks.isEmpty) {
      return const Center(
        child: Text('Tidak ada bookmark'),
      );
    }

    return ListView.builder(
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarks[index];
        return ListTile(
          onTap: () => _getToDetail(bookmark),
          leading: Text('${index + 1}'),
          title: Text(
            bookmark.title,
            style: Typographies.regular16.copyWith(
              color: context.colorScheme.secondary,
            ),
          ),
          subtitle: Text(
            'Ayah ${bookmark.ayah}',
            style: Typographies.regular13.copyWith(color: Colours.greyText),
          ),
          trailing: IconButton(
            onPressed: () => _deleteBookmark(bookmark.id),
            icon: Icon(
              Icons.delete_rounded,
              color: context.colorScheme.error.withOpacity(0.7),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildError(String message) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 12),
          ReloadButton(
            label: 'Muat Ulang',
            onPressed: _getBookmarks,
          ),
        ],
      ),
    );
  }
}
