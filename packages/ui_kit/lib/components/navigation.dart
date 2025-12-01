import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/icons.dart';
import 'package:ui_kit/theme/text_styles.dart';

class AppNavigation extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onItemSelected;

  const AppNavigation({
    super.key,
    this.initialIndex = 0,
    required this.onItemSelected,
  });

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Map<String, dynamic>> _items = [
    {'label': 'Галерея', 'icon': AppIcons.gallery},
    {'label': 'Импорт', 'icon': AppIcons.import},
    {'label': 'Экспорт', 'icon': AppIcons.export},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.inputBackground,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1.2)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = index == _selectedIndex;

              return _buildItem(
                icon: item['icon'],
                label: item['label'],
                isSelected: isSelected,
                onTap: () {
                  setState(() => _selectedIndex = index);
                  widget.onItemSelected(index);
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? AppColors.accent : AppColors.inputIcon;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.textRegular(color: color, height: 1.33),
            ),
          ],
        ),
      ),
    );
  }
}
