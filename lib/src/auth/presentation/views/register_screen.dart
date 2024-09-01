import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/media.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/constants.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/auth/data/models/user_model.dart';
import 'package:alquran_app/src/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:alquran_app/src/auth/presentation/views/login_screen.dart';
import 'package:alquran_app/src/home/presentation/views/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const path = '/register';
  static const name = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _register(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
          AuthEvent.registerUserEvent(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  void _login(BuildContext context) {
    context.read<AuthBloc>().add(
          AuthEvent.loginUserEvent(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Lottie.asset(
                              Media.register,
                              height: context.height * 0.3,
                            ),
                          ),
                          const Text(
                            'Mulai, Yuk!',
                            style: Typographies.bold23,
                          ),
                          Text(
                            'Buat akun untuk memulai',
                            style: Typographies.regular16.copyWith(
                              color: Colours.grey700,
                            ),
                          ),
                          const SizedBox(height: 28),
                          TextInputField(
                            controller: _nameController,
                            labelText: 'Nama',
                            hintText: 'Your Name',
                            keyboardType: TextInputType.name,
                            validator: Validators.compose([
                              Validators.required('Nama wajib diisi'),
                            ]),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(64),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextInputField(
                            controller: _emailController,
                            labelText: 'Email',
                            hintText: 'example@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.compose([
                              Validators.required('Alamat email wajib diisi'),
                              Validators.email('Email tidak valid'),
                            ]),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(128),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextInputField.password(
                            controller: _passwordController,
                            hintText: '********',
                            labelText: 'Password',
                            validator: Validators.compose([
                              Validators.required(
                                'Password tidak boleh kosong',
                              ),
                              Validators.minLength(
                                8,
                                'Password wajib terdiri dari minimum 8 '
                                'karakter',
                              ),
                              Validators.patternRegExp(
                                  RegExp(kValidPasswordPattern),
                                  'Password harus memenuhi syarat berikut:\n'
                                  ' * minimum 1 huruf besar\n'
                                  ' * minimum 1 huruf kecil\n'
                                  ' * minimum 1 angka'),
                            ]),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(16),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextInputField.password(
                            controller: _confirmPasswordController,
                            hintText: '********',
                            labelText: 'Konfirmasi Password',
                            validator: (value) =>
                                value != _passwordController.text
                                    ? 'Password tidak cocok'
                                    : null,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(64),
                            ],
                          ),
                          const SizedBox(height: 24),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              state.whenOrNull(
                                userLoggedIn: (user) {
                                  context
                                      .read<UserNotifier>()
                                      .initUser(user as LocalUserModel);
                                  context.goNamed(HomeScreen.name);
                                },
                                userRegistered: () => _login(context),
                                userRegistrationFailed: (message) {
                                  CoreUtils.showSnackBar(
                                    context: context,
                                    message: message,
                                    type: SnackBarType.error,
                                  );
                                },
                                userLoginFailed: (message) {
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
                                loggingInUser: () => const ActionButton(
                                  onPressed: null,
                                  isLoading: true,
                                  child: Text('Register'),
                                ),
                                registeringUser: () => const ActionButton(
                                  onPressed: null,
                                  isLoading: true,
                                  child: Text('Register'),
                                ),
                                orElse: () => ActionButton(
                                  onPressed: () => _register(context),
                                  child: const Text('Register'),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Sudah punya akun? ',
                                  style: Typographies.regular13.copyWith(
                                    color: Colours.grey900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Masuk',
                                  style: Typographies.medium13.copyWith(
                                    color: context.colorScheme.secondary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => context
                                        .pushReplacementNamed(LogInScreen.name),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
