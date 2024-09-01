import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/settings/presentation/blocs/settings_bloc/settings_bloc.dart';
import 'package:alquran_app/src/settings/presentation/widgets/password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SettingEmailScreen extends StatefulWidget {
  const SettingEmailScreen({super.key});

  static const name = 'update-email';
  static const path = 'update-email';

  @override
  State<SettingEmailScreen> createState() => _SettingEmailScreenState();
}

class _SettingEmailScreenState extends State<SettingEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentEmailController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _confirmEmailController = TextEditingController();

  Future<void> _sendUpdateEmailVerification() async {
    final bloc = context.read<SettingsBloc>();
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final password = await showDialog<String>(
      context: context,
      builder: (context) {
        return const PasswordDialog();
      },
    );

    if (password == null) return;

    bloc.add(
      SendUpdateEmailVerificationEvent(
        currentEmail: _currentEmailController.text.trim(),
        newEmail: _newEmailController.text.trim(),
        password: password,
      ),
    );
  }

  @override
  void initState() {
    _currentEmailController.text = context.read<UserNotifier>().user!.email;
    super.initState();
  }

  @override
  void dispose() {
    _currentEmailController.dispose();
    _newEmailController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UBAH EMAIL'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextInputField(
              controller: _currentEmailController,
              labelText: 'Email Saat Ini',
              hintText: 'Isikan email anda saat ini',
              inputFormatters: [
                LengthLimitingTextInputFormatter(64),
              ],
              keyboardType: TextInputType.emailAddress,
              validator: Validators.compose([
                Validators.required('Email saat ini wajib diisi'),
                Validators.email('Email saat ini tidak valid'),
              ]),
            ),
            const SizedBox(height: 12),
            TextInputField(
              controller: _newEmailController,
              labelText: 'Email Baru',
              hintText: 'Isikan email baru anda',
              inputFormatters: [
                LengthLimitingTextInputFormatter(64),
              ],
              keyboardType: TextInputType.emailAddress,
              validator: Validators.compose([
                Validators.required('Email baru wajib diisi'),
                Validators.email('Email baru tidak valid'),
              ]),
            ),
            const SizedBox(height: 12),
            TextInputField(
              controller: _confirmEmailController,
              labelText: 'Konfirmasi Email',
              hintText: 'Konfirmasi email baru anda',
              inputFormatters: [
                LengthLimitingTextInputFormatter(64),
              ],
              keyboardType: TextInputType.emailAddress,
              validator: Validators.compose([
                Validators.required('Konfirmasi email wajib diisi'),
                Validators.email('Konfirmasi email tidak valid'),
                (value) => value != _newEmailController.text
                    ? 'Email tidak cocok'
                    : null,
              ]),
            ),
            const SizedBox(height: 24),
            BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                state.whenOrNull(
                  sendUpdateEmailVerificationFailed: (message) {
                    CoreUtils.showSnackBar(
                      context: context,
                      message: message,
                      type: SnackBarType.error,
                    );
                  },
                  updateEmailVerificationSent: () {
                    CoreUtils.showSnackBar(
                      context: context,
                      message: 'Verifikasi perbaruan email telah dikirim ke '
                          '${_newEmailController.text.trim()}, mohon periksa '
                          'email anda',
                      type: SnackBarType.success,
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  sendingUpdateEmailVerification: () => ActionButton(
                    isLoading: true,
                    onPressed: _sendUpdateEmailVerification,
                    child: const Text('UBAH EMAIL'),
                  ),
                  orElse: () => ActionButton(
                    onPressed: _sendUpdateEmailVerification,
                    child: const Text('UBAH EMAIL'),
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
