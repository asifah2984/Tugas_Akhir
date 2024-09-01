import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({super.key});

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'Masukkan Password Anda',
        style: Typographies.medium16,
      ),
      actions: [
        TextInputField.password(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          hintText: 'Masukkan password anda',
          inputFormatters: [
            LengthLimitingTextInputFormatter(64),
          ],
        ),
        const SizedBox(height: 24),
        ActionButton(
          onPressed: _passwordController.text.trim().isNotEmpty
              ? () => context.pop(_passwordController.text.trim())
              : null,
          child: const Text('Ubah Email'),
        ),
      ],
    );
  }
}
