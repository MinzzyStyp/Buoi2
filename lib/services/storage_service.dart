import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveTheme(bool isDark) async => _prefs.setBool('is_dark', isDark);
  static bool getTheme() => _prefs.getBool('is_dark') ?? true;

  static Future<void> saveHistory(List<String> history) async => _prefs.setStringList('calc_history', history);
  static List<String> getHistory() => _prefs.getStringList('calc_history') ?? [];
}