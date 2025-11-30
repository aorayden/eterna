import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

/// Универсальный компонент поля ввода (Input).
///
/// Обертка над [TextFormField], управляемая через [FormField].
/// Компонент поддерживает:
/// - Верхний заголовок ([labelText]).
/// - Текст-подсказку ([hintText]).
/// - Валидацию и отображение состояния ошибки.
/// - Маскирование ввода (через [inputFormatter]).
class AppInput extends StatefulWidget {
  /// Заголовок, отображаемый над полем ввода.
  final String? labelText;

  /// Текст-подсказка (placeholder), отображаемый внутри поля, когда оно пустое.
  final String? hintText;

  /// Текст ошибки по умолчанию.
  /// Отображается, если поле пустое и не передан кастомный [validator].
  final String? errorText;

  /// Формат маски ввода.
  ///
  /// - Если значение 'date', логика маски может обрабатываться отдельно (в текущей реализации не задана).
  /// - Если передана строка маски, используется [MaskTextInputFormatter].
  /// - В текущей конфигурации символ '-' в строке маски обозначает цифру (0-9).
  /// - Значение по умолчанию: 'default' (без маски).
  final String inputFormatter;

  /// Функция валидации.
  /// Возвращает текст ошибки или `null`, если валидация прошла успешно.
  final String? Function(String?)? validator;

  /// Режим автоматической валидации (например, при взаимодействии с пользователем).
  final AutovalidateMode autovalidateMode;

  const AppInput({
    this.labelText,
    this.hintText,
    this.errorText,
    this.inputFormatter = 'default',
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  /// Форматтер для маскирования ввода (например, для телефонов или карт).
  MaskTextInputFormatter? _maskTextInputFormatter;

  /// Проверка, является ли режим ввода датой.
  bool get _isDateMode => widget.inputFormatter == 'date';

  @override
  void initState() {
    super.initState();

    // Инициализация маски, если это не режим даты и строка формата не пуста.
    // Используется ленивый тип автодополнения.
    // ВАЖНО: Символ '-' в паттерне маски заменяется на регулярное выражение цифр [0-9].
    if (!_isDateMode && widget.inputFormatter.isNotEmpty) {
      _maskTextInputFormatter = MaskTextInputFormatter(
        mask: widget.inputFormatter,
        filter: <String, RegExp>{'-': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );
    }
  }

  @override
  void dispose() {
    // Здесь можно освободить ресурсы, если потребуется в будущем.
    super.dispose();
  }

  /// Внутренний метод валидации.
  ///
  /// 1. Если передан внешний [widget.validator], используется он.
  /// 2. Если внешнего валидатора нет, проверяется пустота поля.
  ///    При пустом поле возвращается [widget.errorText].
  String? _validator(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }

    if (value == null || value.trim().isEmpty) return widget.errorText;

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Используем FormField для управления состоянием ошибки и интеграции с формой.
    return FormField<String>(
      autovalidateMode: widget.autovalidateMode,
      validator: _validator,
      builder: (FormFieldState<String> state) {
        final bool hasError = state.hasError;

        // Определение цветов в зависимости от состояния ошибки.
        final Color fillColor = hasError
            ? AppColors.error.withValues(alpha: 0.10)
            : AppColors.inputBackground;
        final Color borderColor = hasError
            ? AppColors.error
            : AppColors.inputStroke;
        final Color focusedColor = hasError
            ? AppColors.error
            : AppColors.accent;

        // Формирование списка форматтеров.
        final List<TextInputFormatter> inputFormatters = [
          if (_maskTextInputFormatter != null) _maskTextInputFormatter!,
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8, // Отступ между заголовком, полем и ошибкой.
          children: [
            // Заголовок поля.
            if (widget.labelText != null)
              Text(widget.labelText!, style: AppTextStyles.captionRegular()),

            // Само поле ввода.
            TextFormField(
              onChanged: (value) => state.didChange(value),
              inputFormatters: inputFormatters,
              cursorColor: AppColors.accent,
              cursorWidth: 2,
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.textRegular(
                  color: AppColors.placeholder,
                ),
                filled: true,
                fillColor: fillColor,
                // Граница в обычном состоянии.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 1.2),
                ),
                // Граница при фокусе.
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: focusedColor, width: 1.2),
                ),
                // Граница при ошибке.
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.2,
                  ),
                ),
                // Граница при ошибке и фокусе.
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.2,
                  ),
                ),
              ),
            ),

            // Текст ошибки под полем.
            if (hasError)
              Text(
                state.errorText ?? '',
                style: AppTextStyles.textRegular(color: AppColors.error),
              ),
          ],
        );
      },
    );
  }
}
