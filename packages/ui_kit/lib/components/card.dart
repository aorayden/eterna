import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 152,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.secondTitleExtraBold(
                      color: AppColors.white,
                      height: 1.40,
                      letterSpacing: 0.08,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    subtitle,
                    style: AppTextStyles.secondTitleExtraBold(
                      color: AppColors.white,
                      height: 1.40,
                      letterSpacing: 0.08,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
