import 'package:flutter/material.dart';

const textColor = Color(0xFFe1e4ee);
const backgroundColor = Color(0xFF1e1e1e);
const primaryColor = Color.fromARGB(255, 245, 245, 245);
const primaryFgColor = Color(0xFFe1e4ee);
const secondaryColor = Color(0xFF363636);
const secondaryFgColor = Color(0xFF242424);
const accentColor = Color(0xFF0130ad);
const accentFgColor = Color(0xFFe1e4ee);
  
const colorScheme = ColorScheme(
  brightness: Brightness.dark,
  background: backgroundColor,
  onBackground: textColor,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: Brightness.dark == Brightness.light ? Color(0xffB3261E) : Color(0xffF2B8B5),
  onError: Brightness.dark == Brightness.light ? Color(0xffFFFFFF) : Color(0xff601410),
);

class AppTheme {

  AppTheme._();

  static ThemeData darkMode = ThemeData(
    colorScheme: colorScheme,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    fontFamily: "ProductSans",
  );

  static InputDecorationTheme loginRegisterInputTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide(color: primaryColor), borderRadius: BorderRadius.all(Radius.circular(15)))
  );


}




