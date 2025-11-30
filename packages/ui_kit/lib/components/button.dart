import 'package:flutter/material.dart';
import 'package:ui_kit/models/button_enums.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonKind kind;
  final AppButtonVariant variant;

  const AppButton({
    required this.text,
    this.kind = AppButtonKind.large,
    this.variant = AppButtonVariant.filled,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
