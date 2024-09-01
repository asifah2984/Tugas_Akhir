import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class AddTajwidQuestionScreen extends StatefulWidget {
  const AddTajwidQuestionScreen({
    required this.tajwidId,
    super.key,
  });

  final String tajwidId;

  static const name = 'add-question';
  static const path = 'add-question';

  @override
  State<AddTajwidQuestionScreen> createState() =>
      _AddTajwidQuestionScreenState();
}

class _AddTajwidQuestionScreenState extends State<AddTajwidQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _choicesController = List.generate(
    4,
    (index) => TextEditingController(),
  );
  TextEditingController? _selectedChoiceController;

  void _addQuestion(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    if (_selectedChoiceController == null) {
      CoreUtils.showSnackBar(
        context: context,
        message: 'Pilih jawaban benar di antara pilihan ganda.',
        type: SnackBarType.error,
      );
      return;
    }

    context.read<TajwidBloc>().add(
          TajwidEvent.addTajwidQuestionEvent(
            tajwidId: widget.tajwidId,
            question: _questionController.text.trim(),
            choices:
                _choicesController.map((choice) => choice.text.trim()).toList(),
            answer: _selectedChoiceController!.text.trim(),
          ),
        );
  }

  void _getTajwidQuestions() {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTajwidQuestionsEvent(
            tajwidId: widget.tajwidId,
          ),
        );
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _choicesController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUAT SOAL'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Soal',
              style: Typographies.medium16,
            ),
            const SizedBox(height: 8),
            TextInputField(
              controller: _questionController,
              hintText: 'Isikan soal',
              minLines: 4,
              maxLines: 4,
              inputFormatters: [
                LengthLimitingTextInputFormatter(512),
              ],
              validator: Validators.required('Soal wajib diisi'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pilihan Ganda',
              style: Typographies.medium16,
            ),
            const SizedBox(height: 8),
            ...List.generate(4, (choiceIndex) {
              return ListTile(
                horizontalTitleGap: 0,
                dense: true,
                contentPadding: EdgeInsets.zero,
                tileColor:
                    _selectedChoiceController == _choicesController[choiceIndex]
                        ? Colours.success50
                        : null,
                leading: Radio<TextEditingController>(
                  value: _choicesController[choiceIndex],
                  groupValue: _selectedChoiceController,
                  onChanged: (value) {
                    setState(() {
                      _selectedChoiceController = value;
                    });
                  },
                ),
                title: TextFormField(
                  controller: _choicesController[choiceIndex],
                  style: Typographies.medium13,
                  validator: Validators.required(''),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => context
                    ..nextFocus()
                    ..nextFocus(),
                  decoration: const InputDecoration(
                    hintText: 'Isikan pilihan',
                    hintStyle: Typographies.regular13,
                    contentPadding: EdgeInsets.all(4),
                    isDense: true,
                    enabledBorder: InputBorder.none,
                    errorStyle: TextStyle(height: 0.01),
                  ),
                ),
                trailing:
                    _selectedChoiceController == _choicesController[choiceIndex]
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colours.success500,
                          )
                        : null,
              );
            }),
            const SizedBox(height: 24),
            BlocConsumer<TajwidBloc, TajwidState>(
              listener: (context, state) {
                state.whenOrNull(
                  tajwidQuestionAdded: () {
                    _getTajwidQuestions();
                    context.pop();
                  },
                  addTajwidQuestionFailed: (message) {
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
                  addingTajwidQuestion: () => ActionButton(
                    isLoading: true,
                    onPressed: () => _addQuestion(context),
                    child: const Text('Buat Soal'),
                  ),
                  orElse: () => ActionButton(
                    onPressed: () => _addQuestion(context),
                    child: const Text('Buat Soal'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
