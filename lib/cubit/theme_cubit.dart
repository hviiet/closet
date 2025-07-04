import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  static const String _themeKey = 'isDarkMode';

  ThemeCubit([bool? initialTheme]) : super(initialTheme ?? false) {
    if (initialTheme == null) {
      _loadTheme();
    }
  }

  /// Load theme state from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode =
          prefs.getBool(_themeKey) ?? false; // Default to light mode
      emit(isDarkMode);
    } catch (e) {
      // If there's an error loading preferences, default to light mode
      emit(false);
    }
  }

  /// Save theme state to SharedPreferences
  Future<void> _saveTheme(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDarkMode);
    } catch (e) {
      // Handle error silently - theme will still work for current session
      // Could add logging here if needed
    }
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final newTheme = !state;
    emit(newTheme);
    await _saveTheme(newTheme);
  }

  /// Set specific theme mode
  Future<void> setTheme(bool isDarkMode) async {
    emit(isDarkMode);
    await _saveTheme(isDarkMode);
  }

  /// Initialize theme from SharedPreferences (for app startup)
  static Future<bool> getInitialTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_themeKey) ?? false; // Default to light mode
    } catch (e) {
      return false; // Default to light mode if error
    }
  }

  // Getters for convenience
  bool get isDarkMode => state;
  bool get isLightMode => !state;
}
