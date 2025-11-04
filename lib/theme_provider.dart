import 'package:flutter/material.dart';

enum ThemePreference { bianco, nero, system }

class ThemeProvider extends ChangeNotifier {
  ThemePreference _preference = ThemePreference.bianco;

  ThemePreference get preference => _preference;

  ThemeMode get themeMode {
    switch (_preference) {
      case ThemePreference.bianco:
        return ThemeMode.light;
      case ThemePreference.nero:
        return ThemeMode.dark;
      case ThemePreference.system:
        return ThemeMode.system;
    }
  }

  void setTheme(ThemePreference pref) {
    _preference = pref;
    notifyListeners();
  }

  bool get isBianco => _preference == ThemePreference.bianco;
}
