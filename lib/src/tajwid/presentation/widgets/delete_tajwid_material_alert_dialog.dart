import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteTajwidMaterialAlertDialog extends StatelessWidget {
  const DeleteTajwidMaterialAlertDialog({
    required this.id,
    required this.tajwidId,
    required this.bloc,
    super.key,
  });

  final String id;
  final String tajwidId;
  final TajwidBloc bloc;

  void _deleteTajwidMaterial(
    BuildContext context, {
    required String id,
  }) {
    context.read<TajwidBloc>().add(
          TajwidEvent.deleteTajwidMaterialEvent(id: id),
        );
  }

  void _getTajwidMaterials(
    BuildContext context, {
    required String tajwidId,
  }) {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTajwidMaterialsEvent(tajwidId: tajwidId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AlertDialog.adaptive(
        surfaceTintColor: Colors.transparent,
        title: const Text('Hapus Materi'),
        content: const Text('Apakah anda yakin ingin menghapus materi ini?'),
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
                tajwidMaterialDeleted: () {
                  _getTajwidMaterials(context, tajwidId: tajwidId);
                  context.pop();
                },
                deleteTajwidMaterialFailed: (message) {
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
                deletingMaterial: () {
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
                    onPressed: () => _deleteTajwidMaterial(context, id: id),
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
