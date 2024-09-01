import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/surah_bloc/surah_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/views/surah_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SurahTabView extends StatefulWidget {
  const SurahTabView({super.key});

  @override
  State<SurahTabView> createState() => _SurahTabViewState();
}

class _SurahTabViewState extends State<SurahTabView>
    with AutomaticKeepAliveClientMixin {
  void _getSurahs() {
    context.read<SurahBloc>().add(const SurahEvent.getSurahsEvent());
  }

  void _getToDetail(Surah surah) {
    context.pushNamed(
      SurahDetailScreen.name,
      extra: {
        'title':
            // ignore: lines_longer_than_80_chars
            'SURAH ${(surah.name.transliteration.id ?? 'Surah ${surah.number}').toUpperCase()}',
        'bloc': context.read<BookmarkBloc>(),
      },
      pathParameters: {'number': '${surah.number}'},
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getSurahs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SurahBloc, SurahState>(
      builder: (context, state) {
        return state.maybeWhen(
          gettingSurahs: _buildLoading,
          getSurahsFailed: _buildError,
          surahsLoaded: _buildContent,
          orElse: () {
            final surahs = context.read<SurahBloc>().surahs;
            return _buildContent(surahs ?? []);
          },
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
            onPressed: _getSurahs,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Surah> surahs) {
    if (surahs.isEmpty) {
      return const Center(
        child: Text('Tidak ada surah'),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => _getSurahs(),
      child: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return ListTile(
            onTap: () => _getToDetail(surah),
            leading: Text('${surah.number}'),
            title: Text(
              surah.name.transliteration.id ?? '-',
              style: Typographies.regular16.copyWith(
                color: context.colorScheme.secondary,
              ),
            ),
            subtitle: Text(
              '${surah.numberOfVerses} Ayat | ${surah.revelation.id}',
              style: Typographies.regular13.copyWith(color: Colours.greyText),
            ),
            trailing: Text(
              surah.name.short,
              style: Typographies.regular13.copyWith(
                color: context.colorScheme.secondary,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          );
        },
      ),
    );
  }
}
