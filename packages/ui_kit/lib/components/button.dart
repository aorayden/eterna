import 'package:flutter/material.dart';
import 'package:ui_kit/models/button_enums.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonKind kind;
  final AppButtonVariant variant;
  final TextStyle? textStyle;

  const AppButton({
    required this.text,
    this.kind = AppButtonKind.large,
    this.variant = AppButtonVariant.filled,
    this.onPressed,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double height = _getHeight();
    final EdgeInsets padding = _getPadding();

    final double? width = kind == AppButtonKind.large ? double.infinity : null;

    final TextStyle baseTextStyle = _getBaseTextStyle();

    final effectiveTextStyle = baseTextStyle.merge(textStyle);

    return SizedBox(
      width: width,
      height: height,
      child: _buildButtonVariant(
        padding: padding,
        textStyle: effectiveTextStyle,
      ),
    );
  }

  Widget _buildButtonVariant({
    required EdgeInsets padding,
    required TextStyle textStyle,
  }) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );

    switch (variant) {
      case AppButtonVariant.filled:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.white,
            elevation: 0,
            shape: shape,
            padding: padding,
          ),
          child: Text(text, style: textStyle.copyWith(color: AppColors.white)),
        );

      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.accent,
            side: const BorderSide(color: AppColors.accent, width: 1),
            shape: shape,
            padding: padding,
            elevation: 0,
          ),
          child: Text(text, style: textStyle.copyWith(color: AppColors.accent)),
        );

      case AppButtonVariant.ghost:
        final Color textColor = kind == AppButtonKind.chip
            ? AppColors.inputLabel
            : AppColors.black.withValues(alpha: 0.20);

        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: AppColors.inputBackground,
            foregroundColor: textColor,
            shape: shape,
            padding: padding,
            elevation: 0,
          ),
          child: Text(text, style: textStyle.copyWith(color: textColor)),
        );
    }
  }

  double _getHeight() {
    switch (kind) {
      case AppButtonKind.large:
        return 56;
      case AppButtonKind.chip:
        return 48;
      case AppButtonKind.small:
        return 40;
    }
  }

  EdgeInsets _getPadding() {
    switch (kind) {
      case AppButtonKind.large:
        return const EdgeInsets.symmetric(horizontal: 24);
      case AppButtonKind.chip:
        return const EdgeInsets.symmetric(horizontal: 20);
      case AppButtonKind.small:
        return const EdgeInsets.symmetric(horizontal: 20);
    }
  }

  TextStyle _getBaseTextStyle() {
    switch (kind) {
      case AppButtonKind.large:
        return AppTextStyles.thirdTitleSemibold(height: 1.41);
      case AppButtonKind.chip:
        return AppTextStyles.textMedium(height: 1.33);
      case AppButtonKind.small:
        return AppTextStyles.captionSemibold(height: 1.43);
    }
  }
}
