import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeNotifier() {
    _loadSystemTheme();
  }

  void _loadSystemTheme() {
    // Optionally set dark mode as default if system is in dark mode
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        brightness: Brightness.light,
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      );

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;
}