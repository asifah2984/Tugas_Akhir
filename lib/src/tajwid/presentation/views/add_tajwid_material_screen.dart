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

class AddTajwidMaterialScreen extends StatefulWidget {
  const AddTajwidMaterialScreen({
    required this.tajwidId,
    super.key,
  });

  final String tajwidId;

  static const name = 'add';
  static const path = 'add';

  @override
  State<AddTajwidMaterialScreen> createState() =>
      _AddTajwidMaterialScreenState();
}

class _AddTajwidMaterialScreenState extends State<AddTajwidMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();

  void _addMaterial() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    context.read<TajwidBloc>().add(
          TajwidEvent.addTajwidMaterialEvent(
            tajwidId: widget.tajwidId,
            content: _contentController.text.trim(),
          ),
        );
  }

  void _getMaterials() {
    context.read<TajwidBloc>().add(
          TajwidEvent.getTajwidMaterialsEvent(tajwidId: widget.tajwidId),
        );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUAT MATERI'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextInputField(
              controller: _contentController,
              labelText: 'Materi',
              hintText: 'Isikan materi',
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                LengthLimitingTextInputFormatter(512),
              ],
              validator: Validators.required('Materi wajib diisi'),
              minLines: 4,
              maxLines: 10,
            ),
            const SizedBox(height: 24),
            BlocConsumer<TajwidBloc, TajwidState>(
              listener: (context, state) {
                state.whenOrNull(
                  tajwidMaterialAdded: () {
                    _getMaterials();
                    context.pop();
                  },
                  addTajwidMaterialFailed: (message) {
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
                  addingTajwidMaterial: () {
                    return const ActionButton(
                      isLoading: true,
                      onPressed: null,
                      child: Text('Buat Materi'),
                    );
                  },
                  orElse: () {
                    return ActionButton(
                      onPressed: _addMaterial,
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
