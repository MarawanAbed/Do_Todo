import 'package:flutter/material.dart';

class Themes {
  static ThemeData getTheme(BuildContext context) {
    return Theme.of(context);
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
    );
  }

  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor:Colors.white,
    );
  }
}