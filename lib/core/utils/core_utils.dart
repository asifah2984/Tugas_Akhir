import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:flutter/material.dart';

class CoreUtils<T> {
  const CoreUtils._();

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required SnackBarType type,
  }) {
    late Color backgroundColor;

    if (type == SnackBarType.warning) {
      backgroundColor = Colours.warning;
    } else if (type == SnackBarType.error) {
      backgroundColor = Colours.error;
    } else {
      backgroundColor = Colours.success;
    }

    context
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(12),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          dismissDirection: DismissDirection.horizontal,
          content: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: Typographies.regular11,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => context.clearSnackBars(),
                child: Icon(
                  Icons.close_rounded,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      );
  }

  static Future<T?> showConfirmationDialog<T>({
    required BuildContext context,
    Widget? content,
    List<Widget>? actions,
  }) async {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: content,
          contentTextStyle: Typographies.regular13.copyWith(
            color: context.colorScheme.onSurface,
          ),
          contentPadding: const EdgeInsets.all(24).copyWith(bottom: 12),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 24),
          actions: actions,
        );
      },
    );
  }
}
