import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/icons.dart';
import 'package:ui_kit/theme/text_styles.dart';

/// Компонент строки поиска.
///
/// Представляет собой стилизованное текстовое поле с иконкой поиска слева (prefix) ..
/// .. и кнопкой очистки справа (suffix), которая появляется только при фокусе.
class AppSearch extends StatefulWidget {
  /// Текст-подсказка, отображаемый, когда поле пустое.
  final String? hintText;

  /// Колбэк, вызываемый при каждом изменении текста в поле.
  final ValueChanged<String> onChanged;

  const AppSearch({this.hintText, required this.onChanged, super.key});

  @override
  State<StatefulWidget> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  /// Контроллер для управления текстом в поле ввода.
  late final TextEditingController _controller;

  /// Узел фокуса для отслеживания состояния (в фокусе или нет).
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Добавляем слушатель изменения фокуса.
    // Это необходимо для перерисовки виджета, чтобы показать/скрыть кнопку очистки.
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Очищает текстовое поле и вызывает [widget.onChanged] с пустой строкой.
  /// Используется при нажатии на кнопку "крестик".
  void _onClear() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      cursorColor: AppColors.accent,
      cursorWidth: 2,
      cursorHeight: 20,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.textRegular(color: AppColors.placeholder),
        filled: true,
        fillColor: AppColors.inputBackground,
        // Граница в обычном состоянии.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.inputStroke,
            width: 1.2,
          ),
        ),
        // Граница при фокусе.
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.inputStroke,
            width: 1.2,
          ),
        ),
        // Иконка поиска слева (всегда видна).
        prefixIcon: const Icon(AppIcons.search, color: AppColors.description),
        // Кнопка очистки справа (видна только когда поле в фокусе).
        suffixIcon: _focusNode.hasFocus
            ? IconButton(
                onPressed: _onClear,
                icon: const Icon(AppIcons.close, color: AppColors.description),
              )
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}
