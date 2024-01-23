import 'package:flutter/material.dart';

class AppUiConfig {
  AppUiConfig._();
  static ThemeData get themeCustom => ThemeData(
        primaryColor: const Color.fromARGB(255, 111, 94, 203),
        primaryColorLight: const Color.fromARGB(255, 178, 182, 205),
        elevatedButtonTheme: buttonThemCustom(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 111, 94, 203),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

  static ElevatedButtonThemeData buttonThemCustom() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 95, 113, 214),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 241, 242, 240),
          ),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static IconThemeData iconThemeCustom() {
    return const IconThemeData(
      color: Color.fromARGB(255, 241, 242, 240),
    );
  }
}
