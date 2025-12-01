import 'package:flutter/material.dart';
import 'package:ui_kit/models/select_item.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

/// Компонент выпадающего списка (Select).
///
/// Реализован через [DropdownButtonFormField].
/// Визуально унифицирован с другими полями ввода (фон, границы, скругления).
class AppSelect extends StatelessWidget {
  /// Текст-подсказка, отображаемый, если значение еще не выбрано.
  final String? hintText;

  /// Список доступных для выбора элементов.
  /// Каждый элемент описывается моделью [SelectItem].
  final List<SelectItem> items;

  /// Значение, которое будет выбрано по умолчанию при инициализации.
  /// Должно совпадать с полем `value` одного из элементов списка [items].
  final String? initialValue;

  /// Колбэк, вызываемый при выборе нового значения из списка.
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
      // ValueKey используется для принудительного обновления виджета,
      // если initialValue изменится извне (например, при сбросе формы).
      key: ValueKey(initialValue),
      // isExpanded: true заставляет элемент списка занимать всю ширину
      // и корректно обрабатывает переполнение текста (ellipsis).
      isExpanded: true,
      hint: hintText != null
          ? Text(
              hintText!,
              style: AppTextStyles.textRegular(color: AppColors.placeholder),
            )
          : null,
      // Стилизация контейнера (InputDecoration) совпадает с классом Input.
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
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
      // Маппинг моделей SelectItem в виджеты меню.
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
