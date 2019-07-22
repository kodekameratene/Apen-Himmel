abstract class AppInfo {
  //Todo: Do it programmatically
  // Check out ==> https://pub.dev/packages/package_info
  static String appName = "Åpen Himmel";
  static String version = "2.2.1";
  static String developers = "kodekameratene";

  static String festivalId = "SxS6fKd88fpRhwrqWKXo";

  static String get dbCollectionContent => 'festival/$festivalId/content';

  static String get dbCollectionSponsor => 'festival/$festivalId/sponsors';
}
