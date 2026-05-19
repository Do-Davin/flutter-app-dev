import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _keyTheme = 'theme_mode';
  static const _keyLanguage = 'language';

  static Future<void> setTheme(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTheme, mode);
  }

  static Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString(_keyTheme);

    if (theme == 'light' || theme == 'dark' || theme == 'system') {
      return theme!;
    }

    return 'system';
  }

  static Future<void> setLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, lang);
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString(_keyLanguage);

    if (language == 'en' || language == 'km') {
      return language!;
    }

    return 'en';
  }
}
