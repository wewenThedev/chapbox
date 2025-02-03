import 'package:flutter/material.dart';
import 'styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor, // Couleur principale
      primaryContainer: primaryColorDark,
      secondary: primaryColorLight, // Couleur secondaire (ancien accentColor)
      secondaryContainer: Color(0xFFFFD1BF),
      surface: Colors.white,//Color(0xFFFFFFFF)
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: appGrey,
      onError: Colors.white,//Color(0xFFFFFFFF),
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // Couleur de l'AppBar
  ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: appGrey),
      bodyLarge: TextStyle(color: appGrey),
      bodyMedium: TextStyle(color: appLightGrey),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.accent,
    ),
    
    /*elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.orange, // Couleur de fond du bouton
      onPrimary: Colors.white, // Couleur du texte et de l'icône
      textStyle: TextStyle(
        fontSize: 16, // Taille du texte
        fontWeight: FontWeight.bold, // Poids du texte
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding du bouton
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bordure arrondie
      ),
    ),
  ),*/
  );
}
