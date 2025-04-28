import 'package:flutter/material.dart';
import 'package:notes/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(bool isOn) async {
    _themeData = isOn ? darkMode : lightMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isOn);
  }

  // Funkcja ładująca zapisane ustawienie motywu
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark =
        prefs.getBool('isDarkMode') ??
        false; // Jeśli brak ustawienia, domyślnie Light
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }
}
