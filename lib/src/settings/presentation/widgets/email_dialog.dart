import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class EmailDialog extends StatefulWidget {
  const EmailDialog({super.key});

  @override
  State<EmailDialog> createState() => _EmailDialogState();
}

class _EmailDialogState extends State<EmailDialog> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'Masukkan Email Anda',
        style: Typographies.medium16,
      ),
      actions: [
        TextInputField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: 'Masukkan email anda',
          inputFormatters: [
            LengthLimitingTextInputFormatter(64),
          ],
        ),
        const SizedBox(height: 24),
        ActionButton(
          onPressed: _emailController.text.trim().isNotEmpty
              ? () => context.pop(_emailController.text.trim())
              : null,
          child: const Text('Ubah Password'),
        ),
      ],
    );
  }
}
