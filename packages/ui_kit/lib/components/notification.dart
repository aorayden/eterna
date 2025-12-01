import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class AppNotification extends StatelessWidget {
  final String message;

  const AppNotification({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider, width: 1.2),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.smallBold(color: AppColors.black, height: 1.67),
        ),
      ),
    );
  }

  static void show(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppNotification(message: message),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
