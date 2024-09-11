import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:blog_ward/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static InputBorder _border([Color borderColor = AppPallete.accentColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      );
  static ThemeData darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      // labelStyle: const TextStyle(decoration: TextDecoration.lineThrough),
      floatingLabelStyle: const TextStyle(color: AppPallete.secondaryColor),
      prefixIconColor: AppPallete.accentColor,
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedErrorBorder: _border(Colors.redAccent),
      focusedBorder: _border(AppPallete.secondaryColor),
      errorBorder: _border(Colors.red),
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        // shape: MaterialStatePropertyAll(OutlineInputBorder(side: BorderSide())),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
              fontSize: AppSizes.buttonTextSize, fontWeight: FontWeight.w600),
        ),
        padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
        backgroundColor: MaterialStatePropertyAll(
          AppPallete.primaryColor,
        ),
        shadowColor: MaterialStatePropertyAll(
          AppPallete.primaryColor,
        ),
      ),
    ),
  );
}
