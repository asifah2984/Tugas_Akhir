import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/media.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/auth/data/models/user_model.dart';
import 'package:alquran_app/src/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:alquran_app/src/auth/presentation/views/forgot_password_screen.dart';
import 'package:alquran_app/src/auth/presentation/views/register_screen.dart';
import 'package:alquran_app/src/home/presentation/views/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const path = '/login';
  static const name = 'login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
          AuthEvent.loginUserEvent(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                            padding: const EdgeInsets.all(16),
                            child: Lottie.asset(Media.mosque),
                          ),
                          const Text(
                            'Selamat Datang!',
                            style: Typographies.bold23,
                          ),
                          Text(
                            'Masuk untuk melanjutkan',
                            style: Typographies.regular16.copyWith(
                              color: Colours.grey700,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextInputField(
                            controller: _emailController,
                            labelText: 'Email ',
                            hintText: 'example@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.required(
                              'Email tidak boleh kosong',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextInputField.password(
                            controller: _passwordController,
                            hintText: '********',
                            labelText: 'Password',
                            validator: Validators.required(
                              'Password tidak boleh kosong',
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => context
                                    .pushNamed(ForgotPasswordScreen.name),
                                child: Text(
                                  'Lupa Password',
                                  style: Typographies.medium11.copyWith(
                                    color: context.colorScheme.secondary,
                                  ),
                                ),
                              ),
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
                                  child: Text('Login'),
                                ),
                                orElse: () => ActionButton(
                                  onPressed: () => _login(context),
                                  child: const Text('Login'),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 23),
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Belum punya akun? ',
                                  style: Typographies.regular13.copyWith(
                                    color: Colours.grey900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Buat',
                                  style: Typographies.medium13.copyWith(
                                    color: context.colorScheme.secondary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => context.pushReplacementNamed(
                                              RegisterScreen.name,
                                            ),
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
