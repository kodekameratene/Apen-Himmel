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
    if (value) {
      addTrack(key);
      _fcm.subscribeToTopic(key);
    } else {
      removeTrack(key);
      _fcm.unsubscribeFromTopic(key);
    }
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

  static Future<dynamic> getMyTracks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('MyTracks');
    return result;
  }

  static addTrack(String track) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myTracks = await getMyTracks();
    if (myTracks != null) {
      myTracks.add(track);
    } else {
      myTracks = ['$track'];
    }
    print('Added $track \nMyTracks => $myTracks');
    prefs.setStringList('MyTracks', myTracks);
  }

  static removeTrack(String track) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myTracks = await getMyTracks();
    if (myTracks != null) {
      myTracks.remove(track);
    }
    print('removed $track \nMyTracks => $myTracks');
    prefs.setStringList('MyTracks', myTracks);
  }

  static shouldShowDocument(List tracks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var tracksToShow = prefs.getStringList('MyTracks');
    var shouldShow = false;
    tracks.toList().forEach((track) {
      if (tracksToShow.contains(track)) {
        shouldShow = true;
      }
      return shouldShow;
    });
    return shouldShow;
  }
}
