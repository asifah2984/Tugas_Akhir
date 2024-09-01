import 'package:alquran_app/core/resources/colours.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.color,
    this.thickness,
    this.height,
    this.indent,
    this.endIndent,
  });

  final Color? color;
  final double? thickness;
  final double? height;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colours.grey100,
      thickness: thickness ?? 1,
      height: height ?? 0,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
