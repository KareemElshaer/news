import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  void ChangeTheme(String newTheme) {
    if (newTheme == "dark") {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  bool isdark() {
    return themeMode == ThemeMode.dark;
  }
}
