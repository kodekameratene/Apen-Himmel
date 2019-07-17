import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Takes care of all stuff that needs to be stored in the app.
 */
class SharedPreferencesHelper {
  static Future<bool> getPushValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(key);
    return result;
  }

  static Future<bool> setPushValue(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseMessaging _fcm = FirebaseMessaging();
    value != null ? _fcm.subscribeToTopic(key) : _fcm.unsubscribeFromTopic(key);
    bool result;
    await prefs.setBool(key, value).then((action) {
      result = action;
    });
    return result;
  }

  static Future<bool> setMainTrack(String track) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseMessaging _fcm = FirebaseMessaging();
    track != null ?? _fcm.subscribeToTopic(track);
    bool result;
    await prefs.setString("mainTrack", track).then((value) {
      result = value;
    });
    return result;
  }

  static Future<String> getMainTrack() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString("mainTrack");
    return result;
  }

  static Future<bool> getShouldShowStartupScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool('firstStart');
    if (result != null) {
      return result;
    }
    return true;
  }

  static Future<bool> setShouldShowStartupScreen(bool shouldShow) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Future<bool> result = prefs.setBool('firstStart', shouldShow);
    return result;
  }
}
