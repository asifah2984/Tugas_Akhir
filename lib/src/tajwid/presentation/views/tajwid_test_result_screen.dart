import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/tajwid_question_item.dart';
import 'package:alquran_app/src/tajwid/presentation/widgets/test_grade_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TajwidTestResultScreen extends StatefulWidget {
  const TajwidTestResultScreen({
    required this.tajwidId,
    this.userId,
    super.key,
  });

  final String tajwidId;
  final String? userId;

  static const name = 'result';
  static const path = 'result';

  @override
  State<TajwidTestResultScreen> createState() => _TajwidTestResultScreenState();
}

class _TajwidTestResultScreenState extends State<TajwidTestResultScreen> {
  void _getTestResult() {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTestResultEvent(
            tajwidId: widget.tajwidId,
            userId: widget.userId,
          ),
        );
  }

  void _backToHome() {
    context.goNamed(TajwidScreen.name);
  }

  @override
  void initState() {
    _getTestResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HASIL TEST'),
      ),
      body: BlocBuilder<TajwidBloc, TajwidState>(
        builder: (context, state) {
          return state.maybeWhen(
            gettingTestResult: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            testResultEmpty: () {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Anda belum mengerjakan test'),
                      const SizedBox(height: 12),
                      ReloadButton(
                        label: 'Kembali',
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                ),
              );
            },
            testResultLoaded: (testResult) {
              return Column(
                children: [
                  TestGradeCard(
                    grade: testResult.second.grade,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: testResult.first.length,
                      itemBuilder: (context, index) {
                        final question = testResult.first[index];
                        return TajwidQuestionItem.result(
                          index: index,
                          question: question,
                          isAdmin: false,
                          userResponse: testResult.second.answers[question.id],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                    ),
                  ),
                ],
              );
            },
            getTestResultFailed: (message) {
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
                      onPressed: _getTestResult,
                      label: 'Muat Ulang',
                    ),
                  ],
                ),
              );
            },
            orElse: Container.new,
          );
        },
      ),
      bottomNavigationBar: _buildNavigationBar(context),
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
              return ActionButton(
                onPressed: _backToHome,
                child: const Text('Kembali ke Tajwid'),
              );
            },
          ),
        );
      },
    );
  }
}
