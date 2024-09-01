import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    required this.controller,
    this.textInputAction = TextInputAction.done,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    super.key,
  }) : isPassword = false;

  const TextInputField.password({
    required this.controller,
    this.textInputAction = TextInputAction.done,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    super.key,
  }) : isPassword = true;

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: Typographies.medium13,
          ),
        if (widget.labelText != null) const SizedBox(height: 4),
        TextFormField(
          obscureText: widget.isPassword && !_isVisible,
          controller: widget.controller,
          keyboardType: widget.isPassword
              ? TextInputType.visiblePassword
              : widget.keyboardType,
          readOnly: widget.readOnly,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.textInputAction,
          style: Typographies.medium13,
          onTap: widget.onTap,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          validator: widget.validator,
          decoration: InputDecoration(
            suffixIconConstraints: const BoxConstraints(maxHeight: 36),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                    icon: Icon(
                      _isVisible ? IconlyLight.show : IconlyLight.hide,
                    ),
                  )
                : widget.suffixIcon,
            isDense: true,
            filled: true,
            fillColor: Colours.grey100,
            hintText: widget.hintText,
            hintStyle: Typographies.regular13,
            enabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.error,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }
}
