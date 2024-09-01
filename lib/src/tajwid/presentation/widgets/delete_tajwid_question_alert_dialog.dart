import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteTajwidQuestionAlertDialog extends StatelessWidget {
  const DeleteTajwidQuestionAlertDialog({
    required this.id,
    required this.tajwidId,
    required this.bloc,
    super.key,
  });

  final String id;
  final String tajwidId;
  final TajwidBloc bloc;

  void _deleteTajwidQuestion(
    BuildContext context, {
    required String id,
  }) {
    context.read<TajwidBloc>().add(
          TajwidEvent.deleteTajwidQuestionEvent(id: id),
        );
  }

  void _getTajwidQuestions(
    BuildContext context, {
    required String tajwidId,
  }) {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTajwidQuestionsEvent(tajwidId: tajwidId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AlertDialog.adaptive(
        surfaceTintColor: Colors.transparent,
        title: const Text('Hapus Soal'),
        content: const Text('Apakah anda yakin ingin menghapus soal ini?'),
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
                tajwidQuestionDeleted: () {
                  _getTajwidQuestions(context, tajwidId: tajwidId);
                  context.pop();
                },
                deleteTajwidQuestionFailed: (message) {
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
                deletingTajwidQuestion: () {
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
                    onPressed: () => _deleteTajwidQuestion(context, id: id),
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
