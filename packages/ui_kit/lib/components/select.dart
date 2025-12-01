import 'package:flutter/material.dart';
import 'package:ui_kit/models/select_item.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/icons.dart';
import 'package:ui_kit/theme/text_styles.dart';

class AppSelect extends StatelessWidget {
  final String? hintText;
  final List<SelectItem> items;
  final String? initialValue;
  final ValueChanged<String?> onChanged;

  const AppSelect({
    this.hintText,
    required this.items,
    required this.onChanged,
    this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      key: ValueKey(initialValue),
      isExpanded: true,
      icon: const Icon(AppIcons.arrowDown),
      iconEnabledColor: AppColors.description,
      iconSize: 24,
      hint: hintText != null
          ? Text(
              hintText!,
              style: AppTextStyles.textRegular(color: AppColors.placeholder),
            )
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.inputStroke,
            width: 1.2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.inputStroke,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.inputStroke,
            width: 1.2,
          ),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item.value,
          child: Text(
            item.text,
            style: AppTextStyles.textRegular(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
