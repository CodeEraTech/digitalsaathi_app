import 'package:digitalsaathi/utils/theme_preference.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  DarkThemeProvider(){
    fetchTheme();
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  fetchTheme() async {
    _darkTheme = await darkThemePreference.getTheme();
    notifyListeners();
  }

    ThemeData get currentTheme {
      if (_darkTheme) {
        return ThemeData.dark().copyWith(
          primaryColor: Colors.deepPurple,
          hintColor: Colors.teal,
          textTheme: TextTheme(
            bodyLarge: const TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.grey[300]),
          ),
        );
      } else {
        return ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          hintColor: Colors.orange,
          textTheme: TextTheme(
            bodyLarge: const TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.grey[800]),
          ),
        );
      }
    }
}

