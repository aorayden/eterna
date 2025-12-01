import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class AppInput extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final String inputFormatter;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  const AppInput({
    this.labelText,
    this.hintText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.inputFormatter = '',
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    super.key,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  MaskTextInputFormatter? _maskTextInputFormatter;

  @override
  void initState() {
    super.initState();
    _initMask();
  }

  @override
  void didUpdateWidget(AppInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inputFormatter != widget.inputFormatter) {
      _initMask();
    }
  }

  void _initMask() {
    if (widget.inputFormatter.isNotEmpty &&
        widget.inputFormatter != 'default') {
      _maskTextInputFormatter = MaskTextInputFormatter(
        mask: widget.inputFormatter,
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );
    } else {
      _maskTextInputFormatter = null;
    }
  }

  String? _validator(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }
    if (widget.errorText != null && (value == null || value.trim().isEmpty)) {
      return widget.errorText;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      autovalidateMode: widget.autovalidateMode,
      validator: _validator,
      initialValue: widget.controller?.text,
      builder: (FormFieldState<String> state) {
        final bool hasError = state.hasError;

        final Color fillColor = hasError
            ? AppColors.error.withValues(alpha: 0.10)
            : AppColors.inputBackground;

        final Color borderColor = hasError
            ? AppColors.error
            : AppColors.inputStroke;

        final Color focusedColor = hasError
            ? AppColors.error
            : AppColors.accent;

        final List<TextInputFormatter> inputFormatters = [
          if (_maskTextInputFormatter != null) _maskTextInputFormatter!,
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            if (widget.labelText != null)
              Text(widget.labelText!, style: AppTextStyles.captionRegular()),

            TextFormField(
              controller: widget.controller,
              initialValue: widget.controller == null ? state.value : null,
              keyboardType: widget.keyboardType,

              onChanged: (value) {
                state.didChange(value);
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },

              inputFormatters: inputFormatters,
              cursorColor: AppColors.accent,
              cursorWidth: 2,
              cursorHeight: 20,

              style: AppTextStyles.textRegular(),

              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.textRegular(
                  color: AppColors.placeholder,
                ),
                filled: true,
                fillColor: fillColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),

                border: _buildBorder(borderColor),
                enabledBorder: _buildBorder(borderColor),
                focusedBorder: _buildBorder(focusedColor),
                errorBorder: _buildBorder(AppColors.error),
                focusedErrorBorder: _buildBorder(AppColors.error),
              ),
            ),

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

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
