import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

class ThemeViewModel extends Notifier<Brightness> {
  static const _key = 'theme_mode';
  
  @override
  Brightness build() {
    // Initialize with Light mode and load preference asynchronously
    _loadTheme();
    return Brightness.light;
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_key) ?? false;
      state = isDark ? Brightness.dark : Brightness.light;
    } catch (e) {
      debugPrint('Error loading theme: $e');
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (state == Brightness.light) {
        state = Brightness.dark;
        await prefs.setBool(_key, true);
      } else {
        state = Brightness.light;
        await prefs.setBool(_key, false);
      }
    } catch (e) {
      debugPrint('Error toggling theme: $e');
    }
  }
}

final themeProvider = NotifierProvider<ThemeViewModel, Brightness>(() {
  return ThemeViewModel();
});

final appColorProvider = Provider<AppColors>((ref) {
  final brightness = ref.watch(themeProvider);
  return brightness == Brightness.dark ? DarkAppColors() : LightAppColors();
});
