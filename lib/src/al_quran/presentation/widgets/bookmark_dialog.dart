import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookmarkDialog extends StatelessWidget {
  const BookmarkDialog({
    required this.verse,
    required this.type,
    this.surah,
    this.surahId,
    super.key,
  });

  final Verse verse;
  final String type;
  final String? surah;
  final int? surahId;

  void _createBookmark(
    BuildContext context, {
    int isLastRead = 0,
  }) {
    final bookmark = Bookmark(
      type: type,
      title: surah != null ? surah! : 'Juz ${verse.meta.juz}',
      ayah: verse.number.inSurah,
      surahOrJuzId: surahId != null ? surahId! : verse.meta.juz,
      userId: context.read<UserNotifier>().user!.id,
      isLastRead: isLastRead,
    );

    context.read<BookmarkBloc>().add(
          BookmarkEvent.createBookmarkEvent(bookmark: bookmark),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookmarkBloc, BookmarkState>(
      listener: (context, state) {
        state.whenOrNull(
          bookmarkCreated: () {
            context
              ..pop()
              ..read<BookmarkBloc>().add(
                BookmarkEvent.getBookmarksEvent(
                  userId: context.read<UserNotifier>().user!.id,
                ),
              );
            CoreUtils.showSnackBar(
              context: context,
              message: 'Bookmark berhasil dibuat',
              type: SnackBarType.success,
            );
          },
          createBookmarkFailed: (message) {
            context
              ..pop()
              ..read<BookmarkBloc>().add(
                BookmarkEvent.getBookmarksEvent(
                  userId: context.read<UserNotifier>().user!.id,
                ),
              );
            CoreUtils.showSnackBar(
              context: context,
              message: message,
              type: SnackBarType.error,
            );
          },
        );
      },
      child: AlertDialog.adaptive(
        title: const Text('Bookmark'),
        content: const Text('Pilih jenis bookmark'),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () => _createBookmark(context, isLastRead: 1),
            child: const Text('Last Read'),
          ),
          const SizedBox(width: 4),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: context.colorScheme.onPrimary,
              backgroundColor: context.colorScheme.primary,
            ),
            onPressed: () => _createBookmark(context),
            child: const Text('Bookmark'),
          ),
        ],
      ),
    );
  }
}
