import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const name = 'forgot-password';
  static const path = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    context.read<AuthBloc>().add(
          AuthEvent.sendPasswordResetEmailEvent(
            email: _emailController.text.trim(),
          ),
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const Text(
                'Lupa Password?',
                style: Typographies.bold23,
              ),
              Text(
                'Isikan email anda',
                style: Typographies.regular16.copyWith(
                  color: Colours.grey700,
                ),
              ),
              const SizedBox(height: 24),
              TextInputField(
                controller: _emailController,
                hintText: 'example@gmail.com',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.compose([
                  Validators.required('Email tidak boleh kosong'),
                  Validators.email('Email tidak valid'),
                ]),
              ),
              const SizedBox(height: 24),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  state.whenOrNull(
                    passwordResetEmailSent: () {
                      CoreUtils.showSnackBar(
                        context: context,
                        message: 'Konfirmasi perbaruan password telah dikirim '
                            'ke ${_emailController.text.trim()}',
                        type: SnackBarType.success,
                      );
                    },
                    sendPasswordResetEmailFailed: (message) {
                      CoreUtils.showSnackBar(
                        context: context,
                        message: message,
                        type: SnackBarType.success,
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    sendingPasswordResetEmail: () => ActionButton(
                      isLoading: true,
                      onPressed: _resetPassword,
                      child: const Text('Perbarui Password'),
                    ),
                    orElse: () => ActionButton(
                      onPressed: _resetPassword,
                      child: const Text('Perbarui Password'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
