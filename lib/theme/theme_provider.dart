import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes/theme/theme.dart';

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

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('isDarkMode')) {
      final isDark = prefs.getBool('isDarkMode') ?? false;
      _themeData = isDark ? darkMode : lightMode;
    } else {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDark = brightness == Brightness.dark;
      _themeData = isDark ? darkMode : lightMode;
    }
    notifyListeners();
  }
}
