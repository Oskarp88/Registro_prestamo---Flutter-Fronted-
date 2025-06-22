import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prestapp/utils/constants/my_colors.dart';

class MyTextStyle {
  static TextStyle get headlineLarge => GoogleFonts.aDLaMDisplay(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get headlineMedium => GoogleFonts.aDLaMDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get headlineSmall => GoogleFonts.aDLaMDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get titleLarge => GoogleFonts.aDLaMDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get titleMedium => GoogleFonts.aDLaMDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get titleSmall => GoogleFonts.aDLaMDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get bodyLarge => GoogleFonts.aDLaMDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get bodyMedium => GoogleFonts.aDLaMDisplay(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get bodySmall => GoogleFonts.aDLaMDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColors.wesAsphalt0.withValues(alpha: 0.5),
      );

  static TextStyle get bodySmallFont08 => GoogleFonts.aDLaMDisplay(
        fontSize: 8,
        fontWeight: FontWeight.w500,
        color: MyColors.wesAsphalt0.withValues(alpha: 0.5),
      );

  static TextStyle get labelLarge => GoogleFonts.aDLaMDisplay(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get labelMedium => GoogleFonts.aDLaMDisplay(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: MyColors.wesAsphalt0.withValues(alpha: 0.5),
      );

  static TextStyle get labelSmall => GoogleFonts.aDLaMDisplay(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: MyColors.wesAsphalt0,
      );

  static TextStyle get labelSmallOpacity => GoogleFonts.aDLaMDisplay(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: MyColors.wesAsphalt0.withValues(alpha: 0.5),
      );
}
