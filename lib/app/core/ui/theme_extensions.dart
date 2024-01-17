import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get myCustomPrimaryColor => const Color.fromARGB(255, 240, 241, 246);
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get elevateseButtonColor => const Color.fromARGB(255, 102, 120, 219);
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get titleStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: myCustomPrimaryColor,
      );
  TextStyle get buttonText => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
  ButtonStyle? get elevatedButtonThemeCustom => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        textStyle: MaterialStateProperty.all<TextStyle>(buttonText),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
