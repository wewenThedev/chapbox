import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'styles.dart';

class ChapboxTheme {
  //late BuildContext? context;
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor, // Couleur principale
      primaryContainer: primaryColorDark,
      secondary: primaryColorLight, // Couleur secondaire (ancien accentColor)
      secondaryContainer: Color(0xFFFFD1BF),
      surface: Colors.white, //Color(0xFFFFFFFF)
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: appGrey,
      onError: Colors.white, //Color(0xFFFFFFFF),
      //brightness: Brightness.dark,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black /*primaryColor*/,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: appLightGrey, //Colors.grey
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.openSans(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
        color: Color(0xFF333333),
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
        color: const Color.fromARGB(255, 77, 77, 77) /*Colors.black*/,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: appDarkGrey,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 11.0,
        fontWeight: FontWeight.w300,
        color: Colors.black, //appGrey,
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      buttonColor: primaryColor,
      disabledColor: Colors.white,
      /*hoverColor: primaryColorLight,
      focusColor: primaryColorDark,*/
    ),
    checkboxTheme: CheckboxThemeData(),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyle(
      color: primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    )))),
    iconButtonTheme: IconButtonThemeData(),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white70,
      shadowColor: onSecondaryContainerColor,
      elevation: 1.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      contentTextStyle: TextStyle(
        color: appGrey,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        //fixedSize: Size(media.width*0.75, media.height*0.06),

        elevation: 0.0,
        //fixedSize: Size(300, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        //side: ,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: TextStyle(
            color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        alignment: Alignment.center,
        backgroundColor: null,
        elevation: 0.0,
        //side: BorderSide(color: primaryColor, width: 2, style: BorderStyle.solid),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*
      ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(color: primaryColor)),
        elevation: WidgetStatePropertyAll(0.0),
        backgroundColor: WidgetStatePropertyAll(onSecondaryContainerColor),
        //foregroundColor: WidgetStatePropertyAll(Colors.white),
        //à vérifier
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0)),
        minimumSize: WidgetStatePropertyAll(MediaQuery.of(ChapboxTheme().context!).size * 0.4),
        maximumSize: WidgetStatePropertyAll(MediaQuery.of(ChapboxTheme().context!).size * 0.8),
        //shape: WidgetStatePropertyAll(Roun),*/
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: /*appLightGrey*/ appGrey),
      hintStyle: TextStyle(
          fontSize: 11, fontWeight: FontWeight.normal, color: appGrey),
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.grey.shade300,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            10), //BorderRadiusDirectional.circular(10.0),//BorderRadius.all(Radius.circular(10),
        borderSide: BorderSide(
            color: /*Color(0xffff0000)*/ primaryColorLight, width: 1.5),
      ),
      enabledBorder: /*UnderlineInputBorder()*/ OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            10), //BorderRadiusDirectional.circular(10.0),//BorderRadius.all(Radius.circular(10),
        borderSide: BorderSide(color: appLightGrey /*appDarkGrey*/),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            10), //BorderRadiusDirectional.circular(10.0),//BorderRadius.all(Radius.circular(10),
        //borderSide: BorderSide(color: primaryColorLight, width: 1.5),
      ),
      prefixIconColor: appGrey,
      suffixIconColor: appGrey,
    ),
    /*searchBarTheme: SearchBarThemeData(
      elevation: WidgetStatePropertyAll(1.5),
      hintStyle: WidgetStatePropertyAll(ChapboxTheme.lightTheme.textTheme.bodySmall),
      backgroundColor: WidgetStatePropertyAll(appLightGrey),
      padding:  WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0)),
    ),*/
  );

  //get context => null;
}
