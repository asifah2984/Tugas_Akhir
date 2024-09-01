import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteTajwidAlertDialog extends StatelessWidget {
  const DeleteTajwidAlertDialog({
    required this.tajwid,
    required this.bloc,
    super.key,
  });

  final Tajwid tajwid;
  final TajwidBloc bloc;

  void _deleteTajwid(
    BuildContext context, {
    required String id,
  }) {
    context.read<TajwidBloc>().add(
          TajwidEvent.deleteTajwidEvent(id: id),
        );
  }

  void _getTajwids(BuildContext context) {
    context.read<TajwidBloc>().add(const TajwidEvent.getTajwidsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AlertDialog.adaptive(
        surfaceTintColor: Colors.transparent,
        title: const Text('Hapus Materi'),
        content: const Text('Apakah anda yakin ingin menghapus tajwid ini?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: context.colorScheme.secondary,
            ),
            onPressed: () => context.pop(),
            child: const Text('Batal'),
          ),
          BlocConsumer<TajwidBloc, TajwidState>(
            listener: (context, state) {
              state.whenOrNull(
                tajwidDeleted: () {
                  _getTajwids(context);
                  context.pop();
                },
                deleteTajwidFailed: (message) {
                  context.pop();
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
                deletingTajwid: () {
                  return TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.error,
                    ),
                    onPressed: null,
                    child: const Text('Hapus'),
                  );
                },
                orElse: () {
                  return TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.error,
                    ),
                    onPressed: () => _deleteTajwid(context, id: tajwid.id),
                    child: const Text('Hapus'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
