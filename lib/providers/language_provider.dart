import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String appLanguage = "en";

  void ChangeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
