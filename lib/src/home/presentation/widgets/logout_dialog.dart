import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'Keluar?',
        style: Typographies.medium23,
      ),
      content: const Text('Apakah anda yakin ingin keluar?'),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () => context.pop(false),
          child: const Text('Batal'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            foregroundColor: context.colorScheme.error,
          ),
          onPressed: () => context.pop(true),
          child: const Text('Keluar'),
        ),
      ],
    );
  }
}
