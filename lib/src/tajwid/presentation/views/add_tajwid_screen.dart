import 'dart:io';

import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/thumbnail_bloc/thumbnail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class AddTajwidScreen extends StatefulWidget {
  const AddTajwidScreen({super.key});

  static const path = 'add';
  static const name = 'add-tajwid';

  @override
  State<AddTajwidScreen> createState() => _AddTajwidScreenState();
}

class _AddTajwidScreenState extends State<AddTajwidScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tajwidNameController = TextEditingController();
  final _tajwidDescriptionController = TextEditingController();
  final _imageNameController = TextEditingController();
  File? _imageFile;

  void _pickThumbnailImage() {
    context.read<ThumbnailBloc>().add(
          const ThumbnailEvent.pickThumbnailImageEvent(),
        );
  }

  void _addTajwid() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    context.read<TajwidBloc>().add(
          TajwidEvent.addTajwidEvent(
            tajwidName: _tajwidNameController.text.trim(),
            tajwidDescription: _tajwidDescriptionController.text.trim(),
            thumbnailImage: _imageFile!,
          ),
        );
  }

  String _getFileName(File file) {
    return file.path.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TAMBAH TAJWID'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextInputField(
              controller: _tajwidNameController,
              labelText: 'Nama Tajwid',
              hintText: 'Isikan nama tajwid',
              inputFormatters: [
                LengthLimitingTextInputFormatter(24),
              ],
              validator: Validators.required('Nama tajwid wajib diisi'),
            ),
            const SizedBox(height: 12),
            TextInputField(
              controller: _tajwidDescriptionController,
              labelText: 'Deskripsi  Tajwid',
              hintText: 'Isikan deskripsi tajwid',
              inputFormatters: [
                LengthLimitingTextInputFormatter(128),
              ],
              validator: Validators.required('Deskripsi tajwid wajib diisi'),
            ),
            const SizedBox(height: 12),
            BlocListener<ThumbnailBloc, ThumbnailState>(
              listener: (context, state) {
                state.whenOrNull(
                  thumbnailImagePicked: (imageFile) {
                    if (imageFile == null) return;

                    _imageFile = imageFile;
                    _imageNameController.text = _getFileName(_imageFile!);
                  },
                  pickThumbnailImageFailed: (message) {
                    CoreUtils.showSnackBar(
                      context: context,
                      message: message,
                      type: SnackBarType.error,
                    );
                  },
                );
              },
              child: TextInputField(
                controller: _imageNameController,
                labelText: 'Gambar Thumbnail',
                hintText: 'Pilih gambar thumbnail',
                validator: (value) {
                  if (value == null || value.isEmpty || _imageFile == null) {
                    return 'Gambar thumbnail wajib diisi';
                  }

                  return null;
                },
                readOnly: true,
                onTap: _pickThumbnailImage,
                suffixIcon: IconButton(
                  onPressed: _pickThumbnailImage,
                  icon: const Icon(Icons.image),
                ),
              ),
            ),
            const SizedBox(height: 24),
            BlocConsumer<TajwidBloc, TajwidState>(
              listener: (context, state) {
                state.whenOrNull(
                  tajwidAdded: () {
                    context
                        .read<TajwidBloc>()
                        .add(const TajwidEvent.getTajwidsEvent());

                    context.pop();
                  },
                  addTajwidFailed: (message) {
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
                  addingTajwid: () {
                    return const ActionButton(
                      isLoading: true,
                      onPressed: null,
                      child: Text('Tambah Tajwid'),
                    );
                  },
                  orElse: () {
                    return ActionButton(
                      onPressed: _addTajwid,
                      child: const Text('Tambah Tajwid'),
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
