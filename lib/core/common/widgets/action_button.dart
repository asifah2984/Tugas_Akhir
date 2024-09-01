import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    super.key,
  }) : outlined = false;

  const ActionButton.outlined({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    super.key,
  }) : outlined = true;

  final VoidCallback? onPressed;
  final Widget child;
  final bool outlined;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: context.colorScheme.primary),
          disabledBackgroundColor: outlined
              ? context.colorScheme.surface
              : context.colorScheme.primary,
          disabledForegroundColor: outlined
              ? context.colorScheme.primary
              : context.colorScheme.onPrimary,
          backgroundColor: outlined
              ? context.colorScheme.surface
              : context.colorScheme.primary,
          foregroundColor: outlined
              ? context.colorScheme.primary
              : context.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator.adaptive(
                  strokeAlign: BorderSide.strokeAlignInside,
                  strokeCap: StrokeCap.round,
                  backgroundColor: outlined
                      ? context.colorScheme.primary
                      : context.colorScheme.onPrimary,
                ),
              )
            : child,
      ),
    );
  }
}
