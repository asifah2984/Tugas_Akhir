import 'package:flutter/material.dart';

class ReloadButton extends StatelessWidget {
  const ReloadButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
  }
}
