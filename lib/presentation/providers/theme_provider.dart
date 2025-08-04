import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_constants.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(AppConstants.themeStorageKey) ?? 0;
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.themeStorageKey, _themeMode.index);
    notifyListeners();
  }
}
