import 'package:data_service/artwork_service.dart';
import 'package:data_service/models/artwork_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/components/button.dart';
import 'package:ui_kit/components/card.dart';
import 'package:ui_kit/components/search.dart';
import 'package:ui_kit/models/button_enums.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  final List<String> _categories = ['Все', 'Современные', 'Старинные'];

  int _parseYearToInt(String dateStr) {
    if (dateStr.isEmpty) return 0;
    try {
      if (dateStr.contains('.')) {
        final parts = dateStr.split('.');
        if (parts.isNotEmpty) return int.parse(parts.last);
      }
      return int.parse(dateStr);
    } catch (e) {
      return 0;
    }
  }

  String _extractYearString(String dateStr) {
    if (dateStr.isEmpty) return '';
    if (dateStr.contains('.')) {
      final parts = dateStr.split('.');
      if (parts.isNotEmpty) {
        return parts.last;
      }
    }
    return dateStr;
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 28.0;
    const double verticalGap = 12.0;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: AppSearchBar(
                hintText: 'Введите запрос',
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),

            const SizedBox(height: verticalGap),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Каталог произведений',
                  style: AppTextStyles.thirdTitleSemibold(
                    color: AppColors.textSecondary,
                    height: 1.41,
                  ),
                ),
              ),
            ),

            const SizedBox(height: verticalGap),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Row(
                spacing: 10,
                children: List.generate(_categories.length, (index) {
                  final bool isSelected = _selectedIndex == index;
                  return AppButton(
                    text: _categories[index],
                    kind: AppButtonKind.chip,
                    variant: isSelected
                        ? AppButtonVariant.filled
                        : AppButtonVariant.ghost,
                    onPressed: () => setState(() => _selectedIndex = index),
                  );
                }),
              ),
            ),

            const SizedBox(height: verticalGap),

            Expanded(
              child: ValueListenableBuilder<List<ArtworkModel>>(
                valueListenable: ArtworkService.instance.artworksNotifier,
                builder: (context, allArtworks, child) {
                  if (allArtworks.isEmpty) {
                    return Center(
                      child: Text(
                        'Галерея пуста!\nЗаполните её в окне Импорта',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineMedium(
                          color: AppColors.inputLabel.withValues(alpha: 0.6),
                          height: 1.5,
                        ),
                      ),
                    );
                  }

                  final filteredArtworks = allArtworks.where((artwork) {
                    if (_searchQuery.isNotEmpty) {
                      final titleLower = artwork.title.toLowerCase();
                      final queryLower = _searchQuery.toLowerCase();
                      if (!titleLower.contains(queryLower)) return false;
                    }
                    if (_selectedIndex == 0) return true;
                    final year = _parseYearToInt(artwork.yearStart);
                    if (_selectedIndex == 1) return year >= 1900;
                    if (_selectedIndex == 2) return year < 1900;
                    return true;
                  }).toList();

                  if (filteredArtworks.isEmpty) {
                    return Center(
                      child: Text(
                        'Ничего не найдено',
                        style: AppTextStyles.headlineMedium(
                          color: AppColors.inputLabel.withValues(alpha: 0.6),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.only(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: 0,
                      bottom: 20,
                    ),
                    itemCount: filteredArtworks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: verticalGap),
                    itemBuilder: (context, index) {
                      final item = filteredArtworks[index];

                      final startYear = _extractYearString(item.yearStart);
                      final endYear = _extractYearString(item.yearEnd);
                      final subtitle = '$startYear-$endYear гг.';

                      return AppCard(
                        title: item.title,
                        subtitle: subtitle,
                        imageUrl: item.imageUrl,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return ArtworkDetailsBottomSheet(artwork: item);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtworkDetailsBottomSheet extends StatelessWidget {
  final ArtworkModel artwork;

  const ArtworkDetailsBottomSheet({super.key, required this.artwork});

  String _extractYearString(String dateStr) {
    if (dateStr.isEmpty) return '';
    if (dateStr.contains('.')) {
      final parts = dateStr.split('.');
      if (parts.isNotEmpty) return parts.last;
    }
    return dateStr;
  }

  @override
  Widget build(BuildContext context) {
    final startYear = _extractYearString(artwork.yearStart);
    final endYear = _extractYearString(artwork.yearEnd);
    final dateString = '$startYear-$endYear гг.';

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            artwork.title,
            style: AppTextStyles.secondTitleSemibold(
              color: AppColors.black,
              height: 1.40,
              letterSpacing: 0.08,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 152,
              width: double.infinity,
              color: Colors.grey[300],
              child: Image.network(
                artwork.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.image_not_supported));
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Описание',
            style: AppTextStyles.headlineMedium(
              color: AppColors.textSecondary,
              height: 1.25,
              letterSpacing: -0.05,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            artwork.description.isNotEmpty
                ? artwork.description
                : 'Описание отсутствует',
            style: AppTextStyles.textRegular(
              color: AppColors.black,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'Дата: $dateString',
            style: AppTextStyles.headlineMedium(
              color: AppColors.textSecondary,
              height: 1.25,
              letterSpacing: -0.05,
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Закрыть',
            kind: AppButtonKind.large,
            variant: AppButtonVariant.filled,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
