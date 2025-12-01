import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/icons.dart';

//! TODO: исправить цвета и стили, задокументировать виджет.
class Navigation extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onItemSelected;

  const Navigation({
    super.key,
    this.initialIndex = 0,
    required this.onItemSelected,
  });

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        border: Border.all(color: const Color(0xFF202020).withAlpha(10)),
      ),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
