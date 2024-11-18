import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_to_do_app/shared/theme/colors.dart';

ThemeData defineTheme() {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: _defineColorScheme(),
    textTheme: GoogleFonts.lexendTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.brandBlue),
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ),
  );
}

ColorScheme _defineColorScheme() => const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.brandPink,
    onPrimary: AppColors.greyDark1,
    primaryContainer: AppColors.brandPink,
    onPrimaryContainer: AppColors.black,
    secondary: AppColors.brandBlue,
    onSecondary: AppColors.black,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.greyDark2,
    shadow: AppColors.greyLight2,
    inversePrimary: AppColors.brandDarkBlue);
