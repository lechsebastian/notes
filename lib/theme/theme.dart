import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    onPrimary: Colors.grey.shade900,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
  iconTheme: IconThemeData(color: Colors.grey.shade800),
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey.shade800,
    iconColor: Colors.grey.shade800,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    onPrimary: Colors.grey.shade100,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300,
  ),
  iconTheme: IconThemeData(color: Colors.grey.shade300),
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey.shade300,
    iconColor: Colors.grey.shade300,
  ),
);
