import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveString(String key, String value) async {
    final prefs = await _getPrefs();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await _getPrefs();
    return prefs.getString(key);
  }

  Future<void> saveStringList(String key, List<String> values) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(key, values);
  }

  Future<List<String>?> getStringList(String key) async {
    final prefs = await _getPrefs();
    return prefs.getStringList(key);
  }

}
