import 'dart:io';

import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/tajwid_bloc/tajwid_bloc.dart';
import 'package:alquran_app/src/tajwid/presentation/blocs/thumbnail_bloc/thumbnail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class EditTajwidScreen extends StatefulWidget {
  const EditTajwidScreen({
    required this.currentTajwid,
    super.key,
  });

  final Tajwid currentTajwid;

  static const path = 'edit';
  static const name = 'edit-tajwid';

  @override
  State<EditTajwidScreen> createState() => _AddTajwidScreenState();
}

class _AddTajwidScreenState extends State<EditTajwidScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newTajwidNameController = TextEditingController();
  final _newTajwidDescriptionController = TextEditingController();
  final _newImageNameController = TextEditingController();
  // ignore: use_late_for_private_fields_and_variables
  File? _newImageFile;

  void _pickThumbnailImage() {
    context.read<ThumbnailBloc>().add(
          const ThumbnailEvent.pickThumbnailImageEvent(),
        );
  }

  void _editTajwid() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (_newTajwidNameController.text.trim() == widget.currentTajwid.name &&
        _newTajwidDescriptionController.text.trim() ==
            widget.currentTajwid.description &&
        _newImageNameController.text.trim() ==
            _getFileNameFromUrl(widget.currentTajwid.imageUrl)) {
      CoreUtils.showSnackBar(
        context: context,
        message: 'Tidak ada perubahan, edit tajwid dibatalkan',
        type: SnackBarType.error,
      );
      return;
    }

    context.read<TajwidBloc>().add(
          TajwidEvent.editTajwidEvent(
            id: widget.currentTajwid.id,
            newTajwidName: _newTajwidNameController.text.trim(),
            newTajwidDescription: _newTajwidDescriptionController.text.trim(),
            newThumbnailImage: _newImageFile,
          ),
        );
  }

  String _getFileName(File file) {
    return file.path.split('/').last;
  }

  String _getFileNameFromUrl(String url) {
    final regExp = RegExp(r'.+(\/|%2F)(.+)\?.+');
    final matches = regExp.allMatches(url);
    final match = matches.elementAt(0);
    return Uri.decodeFull(match.group(2)!);
  }

  @override
  void initState() {
    _newTajwidNameController.text = widget.currentTajwid.name;
    _newImageNameController.text =
        _getFileNameFromUrl(widget.currentTajwid.imageUrl);
    _newTajwidDescriptionController.text = widget.currentTajwid.description;
    super.initState();
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
              controller: _newTajwidNameController,
              labelText: 'Nama Tajwid',
              hintText: 'Isikan nama tajwid',
              inputFormatters: [
                LengthLimitingTextInputFormatter(24),
              ],
              validator: Validators.required('Nama tajwid wajib diisi'),
            ),
            const SizedBox(height: 12),
            TextInputField(
              controller: _newTajwidDescriptionController,
              labelText: 'Deskripsi Tajwid',
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

                    _newImageFile = imageFile;
                    _newImageNameController.text = _getFileName(_newImageFile!);
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
                controller: _newImageNameController,
                labelText: 'Gambar Thumbnail',
                hintText: 'Pilih gambar thumbnail',
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                  tajwidEdited: () {
                    context
                        .read<TajwidBloc>()
                        .add(const TajwidEvent.getTajwidsEvent());

                    context.pop();
                  },
                  editTajwidFailed: (message) {
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
                  editingTajwid: () {
                    return const ActionButton(
                      isLoading: true,
                      onPressed: null,
                      child: Text('Tambah Tajwid'),
                    );
                  },
                  orElse: () {
                    return ActionButton(
                      onPressed: _editTajwid,
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
