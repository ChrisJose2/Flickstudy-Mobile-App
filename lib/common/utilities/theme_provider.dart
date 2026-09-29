import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color _primary = const Color(0xFFff6000);

  Color get primary => _primary;

  void updateColor(Color newColor) {
    _primary = newColor;
    notifyListeners();
  }
}
