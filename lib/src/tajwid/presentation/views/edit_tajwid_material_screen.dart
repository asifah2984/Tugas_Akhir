import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class EditTajwidMaterialScreen extends StatefulWidget {
  const EditTajwidMaterialScreen({
    required this.id,
    required this.tajwidId,
    required this.content,
    super.key,
  });

  final String id;
  final String tajwidId;
  final String content;

  static const name = 'edit';
  static const path = 'edit/:materialId';

  @override
  State<EditTajwidMaterialScreen> createState() =>
      _EditTajwidMaterialScreenState();
}

class _EditTajwidMaterialScreenState extends State<EditTajwidMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newContentController = TextEditingController();

  void _editMaterial() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    context.read<TajwidBloc>().add(
          TajwidEvent.editTajwidMaterialEvent(
            id: widget.id,
            newContent: _newContentController.text.trim(),
          ),
        );
  }

  void _getMaterials() {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTajwidMaterialsEvent(tajwidId: widget.tajwidId),
        );
  }

  @override
  void initState() {
    _newContentController.text = widget.content;
    super.initState();
  }

  @override
  void dispose() {
    _newContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT MATERI'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextInputField(
              controller: _newContentController,
              labelText: 'Materi',
              hintText: 'Isikan materi',
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                LengthLimitingTextInputFormatter(512),
              ],
              validator: Validators.compose([
                Validators.required('Materi wajib diisi'),
                (value) =>
                    value == widget.content ? 'Materi belum diedit' : null,
              ]),
              minLines: 4,
              maxLines: 10,
            ),
            const SizedBox(height: 24),
            BlocConsumer<TajwidBloc, TajwidState>(
              listener: (context, state) {
                state.whenOrNull(
                  tajwidMaterialEdited: () {
                    _getMaterials();
                    context.pop();
                  },
                  editTajwidMaterialFailed: (message) {
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
                  editingTajwidMaterial: () {
                    return const ActionButton(
                      isLoading: true,
                      onPressed: null,
                      child: Text('Buat Materi'),
                    );
                  },
                  orElse: () {
                    return ActionButton(
                      onPressed: _editMaterial,
                      child: const Text('Buat Materi'),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
