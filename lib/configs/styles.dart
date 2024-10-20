import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFF4500);

const Color primaryColorLight = Color(0xFFFF7F50);

const Color primaryColorDark = Color(0xFFCC3700);

const Color secondaryColor = Color(0xFFFF7F50);

const Color backgroundColor = Color(0xFF2E2E2E);

const Color scaffoldBackgroundColor = Color.fromARGB(255, 255, 243, 243);

const Color appGrey = Color(0xFF4A4A4A);

const Color appDarkGrey = Color(0xFF2E2E2E);

const Color appLightGrey = Color(0xFF7D7D7D);

ButtonStyle defaultStyle(BuildContext ctx) {
  return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder?>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
      foregroundColor: WidgetStateProperty.all<Color?>(Colors.white),
      backgroundColor:
          WidgetStateProperty.all<Color?>(Theme.of(ctx).primaryColor));
}

ButtonStyle customStyle(BuildContext ctx) {
  return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder?>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
      foregroundColor:
          WidgetStateProperty.all<Color?>(Theme.of(ctx).primaryColor),
      backgroundColor: WidgetStateProperty.all<Color?>(appGrey));
}


ButtonStyle homePageBtStyle(BuildContext ctx) {
  return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder?>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Theme.of(ctx).primaryColor, width: 2))),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
          const EdgeInsets.symmetric(vertical: 25, horizontal: 20)),
      foregroundColor: WidgetStateProperty.all<Color?>(
          Theme.of(ctx).appBarTheme.foregroundColor),
      backgroundColor: WidgetStateProperty.all<Color?>(
          Theme.of(ctx).scaffoldBackgroundColor));
}

ButtonStyle productDialogBtStyle(Color backgroundColor) {
  return ButtonStyle(
      textStyle:
          WidgetStateProperty.all<TextStyle?>(const TextStyle(fontSize: 15)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder?>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
          const EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
      foregroundColor: WidgetStateProperty.all<Color?>(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color?>(backgroundColor));
}

