import 'package:flutter/material.dart';
import 'package:ui_kit/components/button.dart';
import 'package:ui_kit/components/search.dart';
import 'package:ui_kit/models/button_enums.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSearch(onChanged: (value) {}),
            Text(
              'Каталог произведений',
              style: AppTextStyles.thirdTitleSemibold(
                color: AppColors.placeholder,
              ),
            ),
            AppButton(text: 'ВсеASDAS', kind: AppButtonKind.small),
          ],
        ),
      ),
    );
  }
}
