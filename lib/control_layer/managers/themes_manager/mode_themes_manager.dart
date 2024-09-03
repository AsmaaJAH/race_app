import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_fonts.dart';

class ModeThemeManager {
  const ModeThemeManager._();

// colorsScheme:
  static final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: AppColors.white,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.white,
  );

// Themes:
  static final lightThemes = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: Brightness.light,
    fontFamily: AppFonts.fontFamily,
    primaryColor: AppColors.primary,
    dialogBackgroundColor: AppColors.offWhiteBackground,
    datePickerTheme: const DatePickerThemeData(
      //because of time limits of task
      backgroundColor: AppColors.secondary,
      dividerColor: AppColors.primary,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData()

  );

  static final darkThemes = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    fontFamily: AppFonts.fontFamily,
    primaryColor: AppColors.primary,
    dialogBackgroundColor: AppColors.offWhiteBackground,
    datePickerTheme: const DatePickerThemeData(
      //because of time limits of task
      backgroundColor: AppColors.secondary,
      dividerColor: AppColors.primary,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData()
  );
}
