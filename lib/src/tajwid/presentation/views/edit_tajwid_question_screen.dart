import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class EditTajwidQuestionScreen extends StatefulWidget {
  const EditTajwidQuestionScreen({
    required this.id,
    required this.tajwidId,
    required this.question,
    required this.choices,
    required this.answer,
    super.key,
  });

  final String id;
  final String tajwidId;
  final String question;
  final List<String> choices;
  final String answer;

  static const name = 'edit-question';
  static const path = 'edit/:questionId';

  @override
  State<EditTajwidQuestionScreen> createState() =>
      _EditTajwidQuestionScreenState();
}

class _EditTajwidQuestionScreenState extends State<EditTajwidQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _choiceControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  TextEditingController? _answerController;

  void _addQuestion(BuildContext context) {
    // check controllers form validation
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    // check if answer is selected
    if (_answerController == null) {
      CoreUtils.showSnackBar(
        context: context,
        message: 'Pilih jawaban benar di antara pilihan ganda.',
        type: SnackBarType.error,
      );
      return;
    }

    // check if any editing occurred
    if (widget.question == _questionController.text.trim() &&
        const IterableEquality<String>().equals(
          widget.choices,
          _choiceControllers
              .map((controller) => controller.text.trim())
              .toList(),
        ) &&
        widget.answer == _answerController!.text.trim()) {
      CoreUtils.showSnackBar(
        context: context,
        message: 'Tidak ada perubahan, edit soal dibatalkan',
        type: SnackBarType.warning,
      );
      return;
    }

    context.read<TajwidBloc>().add(
          TajwidEvent.editTajwidQuestionEvent(
            id: widget.id,
            newQuestion: _questionController.text.trim(),
            newChoices: _choiceControllers
                .map((controller) => controller.text.trim())
                .toList(),
            newAnswer: _answerController!.text.trim(),
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
  void initState() {
    _questionController.text = widget.question;
    for (var i = 0; i < _choiceControllers.length; i++) {
      _choiceControllers[i].text = widget.choices[i];

      if (_choiceControllers[i].text == widget.answer) {
        _answerController = _choiceControllers[i];
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _choiceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT SOAL'),
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
                tileColor: _answerController == _choiceControllers[choiceIndex]
                    ? Colours.success50
                    : null,
                leading: Radio<TextEditingController>(
                  value: _choiceControllers[choiceIndex],
                  groupValue: _answerController,
                  onChanged: (value) {
                    setState(() {
                      _answerController = value;
                    });
                  },
                ),
                title: TextFormField(
                  controller: _choiceControllers[choiceIndex],
                  style: Typographies.medium13,
                  validator: Validators.required(''),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: const InputDecoration(
                    hintText: 'Isikan pilihan',
                    hintStyle: Typographies.regular13,
                    contentPadding: EdgeInsets.all(4),
                    isDense: true,
                    enabledBorder: InputBorder.none,
                    errorStyle: TextStyle(height: 0.01),
                  ),
                ),
                trailing: _answerController == _choiceControllers[choiceIndex]
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
                  tajwidQuestionEdited: () {
                    context.pop();
                    _getTajwidQuestions();
                  },
                  editTajwidQuestionFailed: (message) {
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
                  editingTajwidQuestion: () => ActionButton(
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
