import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_kit/theme/colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle firstTitle({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w600,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle secondTitleSemibold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w600,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle secondTitleExtraBold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w800,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle thirdTitleSemibold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w600,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 17,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle headlineMedium({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w500,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle textRegular({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w400,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle textMedium({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w500,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle captionRegular({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w400,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle captionSemibold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w600,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle smallBold({
    Color? color = AppColors.black,
    FontWeight? fontWeight = FontWeight.w700,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: 12,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
