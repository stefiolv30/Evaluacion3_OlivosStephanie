import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.pink[50],
    appBarTheme: const AppBarTheme(color: Colors.pinkAccent, elevation: 0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.pinkAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: const StadiumBorder(),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: Colors.pinkAccent),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
      ),
    ),
  );
}
