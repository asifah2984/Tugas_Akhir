import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/utils/constants.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/settings/presentation/blocs/settings_bloc/settings_bloc.dart';
import 'package:alquran_app/src/settings/presentation/widgets/email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SettingPasswordScreen extends StatefulWidget {
  const SettingPasswordScreen({super.key});

  static const name = 'update-password';
  static const path = 'update-password';

  @override
  State<SettingPasswordScreen> createState() => _SettingPasswordScreenState();
}

class _SettingPasswordScreenState extends State<SettingPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _sendUpdateEmailVerification() async {
    final bloc = context.read<SettingsBloc>();
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final email = await showDialog<String>(
      context: context,
      builder: (context) {
        return const EmailDialog();
      },
    );

    if (email == null) return;

    bloc.add(
      UpdatePasswordEvent(
        currentPassword: _currentPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
        email: email,
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UBAH PASSWORD'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextInputField.password(
              controller: _currentPasswordController,
              labelText: 'Password Saat Ini',
              hintText: 'Isikan password anda saat ini',
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
              keyboardType: TextInputType.visiblePassword,
              validator: Validators.compose([
                Validators.required('Password saat ini wajib diisi'),
              ]),
            ),
            const SizedBox(height: 12),
            TextInputField.password(
              controller: _newPasswordController,
              labelText: 'Password Baru',
              hintText: 'Isikan password baru anda',
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
              keyboardType: TextInputType.visiblePassword,
              validator: Validators.compose([
                Validators.required('Password baru wajib diisi'),
                Validators.minLength(
                  8,
                  'Password wajib terdiri dari minimum 8 karakter',
                ),
                Validators.patternRegExp(
                    RegExp(kValidPasswordPattern),
                    'Password harus memenuhi syarat berikut:\n'
                    ' * minimum 1 huruf besar\n'
                    ' * minimum 1 huruf kecil\n'
                    ' * minimum 1 angka'),
              ]),
            ),
            const SizedBox(height: 12),
            TextInputField.password(
              controller: _confirmPasswordController,
              labelText: 'Konfirmasi Password',
              hintText: 'Konfirmasi Password baru anda',
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
              keyboardType: TextInputType.visiblePassword,
              validator: Validators.compose([
                Validators.required('Konfirmasi password wajib diisi'),
                (value) => value != _newPasswordController.text
                    ? 'Password tidak cocok'
                    : null,
              ]),
            ),
            const SizedBox(height: 24),
            BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                state.whenOrNull(
                  updatePasswordFailed: (message) {
                    CoreUtils.showSnackBar(
                      context: context,
                      message: message,
                      type: SnackBarType.error,
                    );
                  },
                  passwordUpdated: () {
                    CoreUtils.showSnackBar(
                      context: context,
                      message: 'Password berhasil diperbarui',
                      type: SnackBarType.success,
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  updatingPassword: () => ActionButton(
                    isLoading: true,
                    onPressed: _sendUpdateEmailVerification,
                    child: const Text('UBAH PASSWORD'),
                  ),
                  orElse: () => ActionButton(
                    onPressed: _sendUpdateEmailVerification,
                    child: const Text('UBAH PASSWORD'),
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
