import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/media.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/juz_bloc/juz_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/last_read/last_read_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/views/juz_detail_screen.dart';
import 'package:alquran_app/src/al_quran/presentation/views/surah_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LastReadCard extends StatefulWidget {
  const LastReadCard({
    super.key,
  });

  @override
  State<LastReadCard> createState() => _LastReadCardState();
}

class _LastReadCardState extends State<LastReadCard> {
  void _getLastRead() {
    final user = context.read<UserNotifier>().user!;
    context.read<LastReadBloc>().add(
          LastReadEvent.getLastReadEvent(userId: user.id),
        );
  }

  void _getToDetail(Bookmark lastReadBookmark) {
    if (lastReadBookmark.type == 'surah') {
      context.pushNamed(
        SurahDetailScreen.name,
        extra: {
          'title': lastReadBookmark.title,
          'bloc': context.read<BookmarkBloc>(),
        },
        pathParameters: {'number': '${lastReadBookmark.surahOrJuzId}'},
      );
    }

    if (lastReadBookmark.type == 'juz') {
      context.read<JuzBloc>().add(
            JuzEvent.getJuzEvent(
              juz: lastReadBookmark.surahOrJuzId,
            ),
          );
    }
  }

  @override
  void initState() {
    _getLastRead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BookmarkBloc, BookmarkState>(
          listener: (context, state) {
            state.whenOrNull(
              bookmarkCreated: _getLastRead,
              bookmarkDeleted: _getLastRead,
            );
          },
        ),
        BlocListener<JuzBloc, JuzState>(
          listener: (context, state) {
            state.whenOrNull(
              juzLoaded: (juz) {
                context.pushNamed(
                  JuzDetailScreen.name,
                  extra: {
                    'juz': juz,
                    'bloc': context.read<BookmarkBloc>(),
                  },
                  pathParameters: {'juz': '${juz.juz}'},
                );
              },
              getJuzFailed: (message) {
                CoreUtils.showSnackBar(
                  context: context,
                  message: message,
                  type: SnackBarType.error,
                );
              },
            );
          },
        ),
      ],
      child: BlocBuilder<LastReadBloc, LastReadState>(
        builder: (context, state) {
          return Stack(
            children: [
              InkWell(
                onTap: state.maybeWhen(
                  orElse: () => () {},
                  lastReadLoaded: (lastReadBookmark) =>
                      () => _getToDetail(lastReadBookmark),
                ),
                borderRadius: BorderRadius.circular(20),
                child: Ink(
                  height: 164,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: Colours.gradient,
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          Media.alquran,
                          fit: BoxFit.cover,
                          width: 0.5 * context.width,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      color: context.colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Terakhir Dibaca',
                      style: Typographies.regular13.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: state.maybeWhen(
                  gettingLastRead: _buildLoading,
                  getLastReadFailed: _buildError,
                  lastReadEmpty: _buildEmpty,
                  lastReadLoaded: _buildContent,
                  orElse: _buildEmpty,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Text(
      'Loading...',
      style: Typographies.regular16.copyWith(
        color: context.colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildError(String message) {
    return Text(
      message,
      style: Typographies.regular16.copyWith(
        color: context.colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildEmpty() {
    return Text(
      'Belum ada data',
      style: Typographies.regular16.copyWith(
        color: context.colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildContent(Bookmark lastReadBookmark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lastReadBookmark.title,
          style: Typographies.regular16.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Ayah ${lastReadBookmark.ayah}',
          style: Typographies.regular13.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
