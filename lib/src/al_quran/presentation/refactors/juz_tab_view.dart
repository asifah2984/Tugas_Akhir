import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/juz_bloc/juz_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/views/juz_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class JuzTabView extends StatefulWidget {
  const JuzTabView({super.key});

  @override
  State<JuzTabView> createState() => _JuzTabViewState();
}

class _JuzTabViewState extends State<JuzTabView>
    with AutomaticKeepAliveClientMixin {
  void _getJuzs() {
    context.read<JuzBloc>().add(
          const JuzEvent.getJuzsEvent(),
        );
  }

  void _getToDetail(Juz juz) {
    context.pushNamed(
      JuzDetailScreen.name,
      extra: {
        'juz': juz,
        'bloc': context.read<BookmarkBloc>(),
      },
      pathParameters: {'juz': '${juz.juz}'},
    );
  }

  @override
  void initState() {
    _getJuzs();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<JuzBloc, JuzState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: Container.new,
          gettingJuzs: _buildLoading,
          getJuzsFailed: _buildError,
          juzsLoaded: _buildContent,
          orElse: () {
            final juzs = context.read<JuzBloc>().juzs;
            return _buildContent(juzs ?? []);
          },
        );
      },
    );
  }

  Widget _buildContent(List<Juz> juzs) {
    return ListView.builder(
      itemCount: juzs.length,
      itemBuilder: (context, index) {
        final juz = juzs[index];
        return ListTile(
          onTap: () => _getToDetail(juz),
          leading: Text('${index + 1}'),
          title: Text(
            'Juz ${juz.juz}',
            style: Typographies.medium16.copyWith(
              color: context.colorScheme.secondary,
            ),
          ),
          subtitle: Text(
            'Mulai dari ${juz.juzStartInfo}\n'
            'Sampai ${juz.juzEndInfo}',
            style: Typographies.regular13.copyWith(
              color: Colours.greyText,
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
            onPressed: _getJuzs,
          ),
        ],
      ),
    );
  }
}
