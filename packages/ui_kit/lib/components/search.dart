import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/icons.dart';
import 'package:ui_kit/theme/text_styles.dart';

class AppSearchBar extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String> onChanged;

  const AppSearchBar({this.hintText, required this.onChanged, super.key});

  @override
  State<StatefulWidget> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

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
        prefixIcon: const Icon(AppIcons.search, color: AppColors.description),
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
