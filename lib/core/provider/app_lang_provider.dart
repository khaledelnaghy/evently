import 'package:flutter/material.dart';

class AppLangProvider extends ChangeNotifier {
  String appLang = "en"; // default english

  void changeLang(String newLang) {
    if (appLang == newLang) {
      return;
    } else {
      appLang = newLang;
      notifyListeners(); // same as setState
    }
  }
}
