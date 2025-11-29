import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_kit/theme/colors.dart';

/// Класс, содержащий стили текста, используемые в приложении.
///
/// Все стили основаны на шрифте Manrope.
/// Использование централизованных стилей обеспечивает единообразие типографики во всем приложении.
class AppTextStyles {
  const AppTextStyles._();

  /// Возвращает стиль для заголовков первого уровня.
  ///
  /// Стандартный размер шрифта: 24.
  /// Стандартная толщина: [FontWeight.w600] (SemiBold).
  ///
  /// [color] - цвет текста (по умолчанию [AppColors.black]).
  /// [fontWeight] - толщина шрифта (можно переопределить).
  static TextStyle firstTitle({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Возвращает стиль для заголовков второго уровня (полужирный).
  ///
  /// Стандартный размер шрифта: 20.
  /// Стандартная толщина: [FontWeight.w600] (SemiBold).
  ///
  /// [color] - цвет текста (по умолчанию [AppColors.black]).
  /// [fontWeight] - толщина шрифта.
  static TextStyle secondTitleSemibold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.manrope(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Возвращает стиль для заголовков второго уровня (экстра-жирный).
  ///
  /// Стандартный размер шрифта: 20.
  /// Стандартная толщина: [FontWeight.w800] (ExtraBold).
  /// Обычно используется для акцентных заголовков.
  ///
  /// [color] - цвет текста (по умолчанию [AppColors.black]).
  /// [fontWeight] - толщина шрифта.
  static TextStyle secondTitleExtraBold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.manrope(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Возвращает стиль для заголовков третьего уровня.
  ///
  /// Стандартный размер шрифта: 17.
  /// Стандартная толщина: [FontWeight.w600] (SemiBold).
  ///
  /// [color] - цвет текста (по умолчанию [AppColors.black]).
  /// [fontWeight] - толщина шрифта.
  static TextStyle thirdTitleSemibold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.manrope(
      fontSize: 17,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Возвращает стиль для средних заголовков или подзаголовков.
  ///
  /// Стандартный размер шрифта: 16.
  /// Стандартная толщина: [FontWeight.w500] (Medium).
  ///
  /// [color] - цвет текста (по умолчанию [AppColors.black]).
  /// [fontWeight] - толщина шрифта.
  static TextStyle headlineMedium({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Возвращает стиль для основного (обычного) текста.
  ///
  /// Стандартный размер шрифта: 15.
  /// Стандартная толщина: [FontWeight.w400] (Regular).
  /// Используется для тела статей, описаний и основного контента.
  ///
  /// [color] - цвет текста (по умолчанию [AppColors.black]).
  /// [fontWeight] - толщина шрифта.
  static TextStyle textRegular({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.manrope(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle captionRegular({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
