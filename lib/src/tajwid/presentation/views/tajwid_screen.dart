import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/views/add_tajwid_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/edit_tajwid_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_material_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/delete_tajwid_alert_dialog.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/tajwid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TajwidScreen extends StatefulWidget {
  const TajwidScreen({super.key});

  static const name = 'tajwid';
  static const path = 'tajwid';

  @override
  State<TajwidScreen> createState() => _TajwidScreenState();
}

class _TajwidScreenState extends State<TajwidScreen> {
  late final bool _isAdmin;
  String? _longPressedTajwid;

  void _getTajwids() {
    context.read<TajwidBloc>().add(const TajwidEvent.getTajwidsEvent());
  }

  void _addTajwid() {
    context.pushNamed(
      AddTajwidScreen.name,
      extra: context.read<TajwidBloc>(),
    );
  }

  void _onEditTajwid(Tajwid tajwid) {
    context.pushNamed(
      EditTajwidScreen.name,
      extra: {
        'tajwid': tajwid,
        'bloc': context.read<TajwidBloc>(),
      },
    );
  }

  Future<void> _onDeleteTajwid(Tajwid tajwid) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return DeleteTajwidAlertDialog(
          tajwid: tajwid,
          bloc: context.read<TajwidBloc>(),
        );
      },
    );
  }

  @override
  void initState() {
    _isAdmin = context.read<UserNotifier>().user?.isAdmin ?? false;
    _getTajwids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MATERI TAJWID'),
        actions: _isAdmin
            ? [
                IconButton(
                  onPressed: _addTajwid,
                  icon: const Icon(Icons.add),
                ),
              ]
            : null,
      ),
      body: BlocConsumer<TajwidBloc, TajwidState>(
        listener: (context, state) {
          state.whenOrNull(
            tajwidsLoaded: (tajwids) => _longPressedTajwid = null,
            tajwidEdited: () => _longPressedTajwid = null,
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            gettingTajwids: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            tajwidsLoaded: _buildContent,
            getTajwidsFailed: (message) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ReloadButton(
                      onPressed: _getTajwids,
                      label: 'Muat Ulang',
                    ),
                  ],
                ),
              );
            },
            orElse: () {
              final tajwids = context.read<TajwidBloc>().tajwids;

              if (tajwids == null) return Container();
              return _buildContent(tajwids);
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(List<Tajwid> tajwids) {
    if (tajwids.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: _isAdmin
              ? const Text(
                  'Belum ada tajwid. Klik tombol + untuk membuat tajwid',
                )
              : const Text('Belum ada tajwid'),
        ),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async => _getTajwids(),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
  
        itemCount: tajwids.length,
        itemBuilder: (context, index) {
          final tajwid = tajwids[index];
          return TajwidCard(
            isAdmin: _isAdmin,
            tajwid: tajwid,
            onPressed: () => context.pushNamed(
              TajwidMaterialScreen.name,
              pathParameters: {
                'tajwidId': tajwid.id,
              },
            ),
            editable: _longPressedTajwid == tajwid.id,
            onLongPressed: () {
              setState(() {
                if (_longPressedTajwid == tajwid.id) {
                  _longPressedTajwid = null;
                  return;
                }
                _longPressedTajwid = tajwid.id;
              });
            },
            onEdit: _isAdmin ? () => _onEditTajwid(tajwid) : null,
            onDelete: _isAdmin ? () => _onDeleteTajwid(tajwid) : null,
          );
        },
      ),
    );
  }
}
