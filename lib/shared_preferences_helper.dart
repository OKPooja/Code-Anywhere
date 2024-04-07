
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._ctor();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._ctor();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setApiKey({required String apiKey}) {
    _prefs.setString("apiKey", apiKey);
  }

  static String getApiKey() {
    return _prefs.getString("apiKey") ?? "";
  }
  static void setIsLoggedIn({required bool status}) {
    _prefs.setBool('isLoggedIn', status);
  }
  static dynamic getIsLoggedIn() {
    return _prefs.getBool("isLoggedIn") ?? false;
  }
  static String getUserId() {
    return _prefs.getString("user_id") == null
        ? ''
        : _prefs.getString("user_id").toString();
  }
  static void setUserName({required String userName}) {
    _prefs.setString("userName", userName);
  }

  static String getUserName() {
    return _prefs.getString("userName") ?? "";
  }

}