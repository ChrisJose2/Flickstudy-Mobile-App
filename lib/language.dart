import 'package:flutter/material.dart';

class Language extends ChangeNotifier {
  Locale _currentLocale=const Locale('en');

  Locale get currentLocale => _currentLocale;

  void updateLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}
