import 'package:flutter/material.dart';
import 'styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor, // Couleur principale
      primaryContainer: primaryColorDark,
      secondary: primaryColorLight, // Couleur secondaire (ancien accentColor)
      secondaryContainer: Color(0xFFFFD1BF),
      background: backgroundColor,
      surface: Colors.white,//Color(0xFFFFFFFF)
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: appGrey,
      onBackground: Colors.white,
      onError: Colors.white,//Color(0xFFFFFFFF),
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: appGrey),
      bodyLarge: TextStyle(color: appGrey),
      bodyMedium: TextStyle(color: appLightGrey),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
