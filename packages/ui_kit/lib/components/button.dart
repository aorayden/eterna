import 'package:flutter/material.dart';
import 'package:ui_kit/models/button_enums.dart';
import 'package:ui_kit/theme/colors.dart';

//! TODO: исправить цвета и задокументировать виджет.
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
    final double height = _getHeight();
    final EdgeInsets padding = _getPadding();
    final double fontSize = _getFontSize();
    const double borderRadius = 10;

    final double? width = kind == AppButtonKind.large ? double.infinity : null;

    return SizedBox(
      width: width,
      height: height,
      child: _buildButtonVariant(
        borderRadius: borderRadius,
        padding: padding,
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildButtonVariant({
    required double borderRadius,
    required EdgeInsets padding,
    required double fontSize,
  }) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    final textStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );

    switch (variant) {
      case AppButtonVariant.filled:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: AppColors.accentInactive,
            disabledForegroundColor: AppColors.white,
            elevation: 0,
            shape: shape,
            padding: padding,
          ),
          child: Text(text, style: textStyle),
        );

      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.accent,
            side: const BorderSide(color: AppColors.accentInactive),
            disabledForegroundColor: Colors.grey,
            backgroundColor: Colors.transparent,
            shape: shape,
            padding: padding,
          ),
          child: Text(text, style: textStyle),
        );

      case AppButtonVariant.ghost:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.5),
            disabledForegroundColor: Colors.grey.withValues(alpha: 0.5),
            shape: shape,
            padding: padding,
          ),
          child: Text(text, style: textStyle),
        );
    }
  }

  double _getHeight() {
    switch (kind) {
      case AppButtonKind.large:
        return 56;
      case AppButtonKind.small:
        return 40;
      case AppButtonKind.chip:
        return 48;
    }
  }

  double _getFontSize() {
    switch (kind) {
      case AppButtonKind.large:
        return 17.0;
      case AppButtonKind.small:
        return 14.0;
      case AppButtonKind.chip:
        return 15.0;
    }
  }

  EdgeInsets _getPadding() {
    switch (kind) {
      case AppButtonKind.large:
        return const EdgeInsets.symmetric(horizontal: 24);
      case AppButtonKind.small:
        return const EdgeInsets.symmetric(horizontal: 16);
      case AppButtonKind.chip:
        return const EdgeInsets.symmetric(horizontal: 12);
    }
  }
}
