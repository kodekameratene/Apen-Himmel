import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore is returning a Timestamp object, which consists of seconds and
/// nanoseconds. Oddly, on iOS you can just use a .toDate() and it works.
/// But that breaks on Android as toDate() is not a method.
/// So you can do a platform check if you want,
/// but the universal solution is to use Firestore's Timestamp:
/// https://stackoverflow.com/a/55226665
DateTime convertStamp(Timestamp _stamp) {
  if (_stamp != null) {
    return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
  } else {
    return null;
  }
}
