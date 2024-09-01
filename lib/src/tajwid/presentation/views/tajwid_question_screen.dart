import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/views/add_tajwid_question_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/edit_tajwid_question_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_test_result_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_test_results_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/delete_tajwid_question_alert_dialog.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/tajwid_question_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TajwidQuestionScreen extends StatefulWidget {
  const TajwidQuestionScreen({
    required this.tajwidId,
    super.key,
  });

  final String tajwidId;

  static const name = 'questions';
  static const path = 'questions';

  @override
  State<TajwidQuestionScreen> createState() => _TajwidQuestionScreenState();
}

class _TajwidQuestionScreenState extends State<TajwidQuestionScreen> {
  late final bool _isAdmin;
  final _answeredQuestions = <String, String>{};

  void _getTajwidQuestions() {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTajwidQuestionsEvent(
            tajwidId: widget.tajwidId,
          ),
        );
  }

  void _addTajwidQuestion() {
    context.pushNamed(
      AddTajwidQuestionScreen.name,
      pathParameters: {'tajwidId': widget.tajwidId},
      extra: context.read<TajwidBloc>(),
    );
  }

  void _editTajwidQuestion(TajwidQuestion question) {
    context.pushNamed(
      EditTajwidQuestionScreen.name,
      pathParameters: {
        'tajwidId': widget.tajwidId,
        'questionId': question.id,
      },
      extra: {
        'bloc': context.read<TajwidBloc>(),
        'id': question.id,
        'question': question.question,
        'choices': question.choices,
        'answer': question.answer,
      },
    );
  }

  Future<void> _deleteTajwidQuestion(TajwidQuestion question) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return DeleteTajwidQuestionAlertDialog(
          id: question.id,
          tajwidId: widget.tajwidId,
          bloc: context.read<TajwidBloc>(),
        );
      },
    );
  }

  void _submitTest({
    required int answeredQuestionsLength,
    required int questionsLength,
  }) {
    if (answeredQuestionsLength < questionsLength) {
      CoreUtils.showSnackBar(
        context: context,
        message: 'Pastikan telah menjawab semua soal '
            'sebelum mengumpulkan tes ini.',
        type: SnackBarType.error,
      );
      return;
    }

    context.clearSnackBars();

    context.read<TajwidBloc>().add(
          TajwidEvent.submitTestEvent(
            tajwidId: widget.tajwidId,
            answers: _answeredQuestions,
          ),
        );
  }

  void _viewGrades() {
    context.pushNamed(
      TajwidTestResultsScreen.name,
      pathParameters: {
        'tajwidId': widget.tajwidId,
      },
    );
  }

  @override
  void initState() {
    _isAdmin = context.read<UserNotifier>().user?.isAdmin ?? false;
    _getTajwidQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TajwidBloc, TajwidState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SOAL MATERI'),
            actions: _isAdmin
                ? [
                    IconButton(
                      onPressed: _addTajwidQuestion,
                      icon: const Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: state.maybeWhen(
            gettingTajwidQuestions: () {
              final questions = context.read<TajwidBloc>().questions;
              if (questions == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              return _buildContent(questions);
            },
            tajwidQuestionsLoaded: _buildContent,
            getTajwidQuestionsFailed: (message) {
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
                      onPressed: _getTajwidQuestions,
                      label: 'Muat Ulang',
                    ),
                  ],
                ),
              );
            },
            orElse: () {
              final questions = context.read<TajwidBloc>().questions;
              if (questions == null) {
                return Container();
              }

              return _buildContent(questions);
            },
          ),
          bottomNavigationBar: _buildNavigationBar(context),
        );
      },
    );
  }

  Widget? _buildNavigationBar(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          width: context.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            boxShadow: const [
              BoxShadow(
                color: Colours.grey400,
                offset: Offset(0, -3),
                blurRadius: 5,
              ),
            ],
          ),
          child: Builder(
            builder: (context) {
              if (!_isAdmin) {
                return BlocConsumer<TajwidBloc, TajwidState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      testSubmitted: () {
                        context.pushNamed(
                          TajwidTestResultScreen.name,
                          pathParameters: {
                            'tajwidId': widget.tajwidId,
                          },
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      gettingTajwidQuestions: Container.new,
                      tajwidQuestionsLoaded: (questions) {
                        if (questions.isEmpty) return Container(height: 0);
                        return ActionButton(
                          onPressed: () {
                            final questionsLength =
                                context.read<TajwidBloc>().questions!.length;
                            _submitTest(
                              answeredQuestionsLength:
                                  _answeredQuestions.keys.length,
                              questionsLength: questionsLength,
                            );
                          },
                          child: const Text('Kumpulkan'),
                        );
                      },
                      submittingTest: () => const ActionButton(
                        isLoading: true,
                        onPressed: null,
                        child: Text('Kumpulkan'),
                      ),
                      orElse: () => const ActionButton(
                        onPressed: null,
                        child: Text('Kumpulkan'),
                      ),
                    );
                  },
                );
              }

              return ActionButton(
                onPressed: _viewGrades,
                child: const Text('Lihat Nilai'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildContent(List<TajwidQuestion> questions) {
    if (questions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Builder(
            builder: (context) {
              if (_isAdmin) {
                return const Text(
                  'Belum ada soal yang dibuat. '
                  "Buatlah soal dengan menekan tombol '+'",
                  textAlign: TextAlign.center,
                );
              }

              return const Text(
                'Belum ada soal yang tersedia',
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async => _getTajwidQuestions(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return TajwidQuestionItem(
            index: index,
            question: question,
            isAdmin: _isAdmin,
            onChangedCallback: !_isAdmin
                ? (value) {
                    if (value == null || value.isEmpty) return;

                    _answeredQuestions.addAll({
                      question.id: value,
                    });
                  }
                : null,
            onEdit: () => _editTajwidQuestion(question),
            onDelete: () => _deleteTajwidQuestion(question),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }
}
