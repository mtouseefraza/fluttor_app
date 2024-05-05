import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  // Using a singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  // Private generic method for retrieving data from shared preferences
  dynamic _getData(String key) {
    // Retrieve data from shared preferences
    var value = _prefs.get(key);

    // Easily log the data that we retrieve from shared preferences
    print('Retrieved $key: $value');

    // Return the data that we retrieve from shared preferences
    return value;
  }

  // Private method for saving data to shared preferences
  void _saveData(String key, dynamic value) {
    // Easily log the data that we save to shared preferences
    print('Saving $key: $value');
    // Save data to shared preferences
    if (value is String) {
      _prefs.setString(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    }
  }
}