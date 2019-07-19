import 'package:flutter/material.dart';

abstract class Styles {
  // Colors
  static const colorPrimary = Color(0xff5CA4A9);
  static const colorSecondary = Color(0xff9BC1BC);
  static const colorAlert = Color(0xffED6A5A);
  static const colorWeatherBgStart = Color.fromRGBO(125, 209, 179, 1);
  static const colorWeatherBgEnd = Color.fromRGBO(76, 165, 133, 1);
  static const colorBackgroundColorMain = Color(0xffE6EBE0);
  static const colorWeatherTextColor = Colors.white;
  static const colorWeatherSunColor = Color.fromRGBO(255, 216, 0, 1);
  static var colorShadowCardMain = Color.fromRGBO(0, 0, 0, 0.06);

  ////////////////////////////////////////////////////////
  // AccentColors for our Categories
  ////////////////////////////////////////////////////////
  //  Mat
  static var colorAccentCategoryFoodStart = Color(0xff6DD3CE);
  static var colorAccentCategoryFoodEnd = Color(0xffC8E9A0);

  // Møte
  static var colorAccentCategoryMeetingStart = Color(0xffF7A278);
  static var colorAccentCategoryMeetingEnd = Color(0xffA13D63);

  // Seminar
  static var colorAccentCategorySeminarStart = Color(0xffA13D63);
  static var colorAccentCategorySeminarEnd = Color(0xff351E29);

  // Samling
  static var colorAccentCategoryGatheringStart = Color(0xffE5F4E3);
  static var colorAccentCategoryGatheringEnd = Color(0xff5DA9E9);

  // Konsert
  static var colorAccentCategoryConcertStart = Color(0xff5DA9E9);
  static var colorAccentCategoryConcertEnd = Color(0xff003F91);

  // Forestilling
  static var colorAccentCategoryPerformanceStart = Color(0xffFAF3DD);
  static var colorAccentCategoryPerformanceEnd = Color(0xff8FC0A9);

  ////////////////////////////////////////////////////////
  // AccentColors for our Tracks
  ////////////////////////////////////////////////////////
  //  Felles
  static var colorAccentTrackFellesStart = Color(0xff6DD3CE);
  static var colorAccentTrackFellesEnd = Color(0xffC8E9A0);

  // YouthCamp
  static var colorAccentTrackYouthCampStart = Color(0xffF7A278);
  static var colorAccentTrackYouthCampEnd = Color(0xffA13D63);

  // VoksenCamp
  static var colorAccentTrackVoksenCampStart = Color(0xffC8E9A0);
  static var colorAccentTrackVoksenCampEnd = Color(0xff6DD3CE);

  // KidsCamp
  static var colorAccentTrackKidsCampStart = Color(0xff5DA9E9);
  static var colorAccentTrackKidsCampEnd = Color(0xffE5F4E3);

  // TweensCamp
  static var colorAccentTrackTweensCampStart = Color(0xffA13D63);
  static var colorAccentTrackTweensCampEnd = Color(0xffE5F4E3);

  // Teltet
  static var colorAccentTrackTeltetStart = Color(0xffFAF3DD);
  static var colorAccentTrackTeltetEnd = Color(0xff8FC0A9);

  ////////////////////////////////////////////////////////

  // Images
  static const imgLogoMain = "lib/assets/sommerfestival.png";
  static const imgLogo = "lib/assets/logo.png";
  static const mainSponsor = "lib/assets/knif.png";

//  TextStyles
  static var textAppBar = TextStyle(fontSize: 30, fontWeight: FontWeight.w200);

  static var textHeader = TextStyle(fontSize: 30, fontWeight: FontWeight.w200);
  static var textContent = TextStyle(fontSize: 12, fontWeight: FontWeight.w200);

  static var textCardHeader =
      TextStyle(fontSize: 20, fontFamily: "Lato", fontWeight: FontWeight.bold);
  static var textCardContent = TextStyle(
      fontSize: 12, fontFamily: "Lao Sangam MN", fontWeight: FontWeight.normal);
  static var textCardTimePosted = TextStyle(
    fontSize: 12,
    fontFamily: "Lao Sangam MN",
    fontWeight: FontWeight.w100,
    color: Colors.black38,
  );

  static var weatherWidgetTextTemperature = TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w100,
      color: Styles.colorWeatherTextColor);

  static var weatherWidgetTextLocation =
      TextStyle(fontSize: 17, color: Styles.colorWeatherTextColor);

  static var kokaEventCardColorBackground = Color.fromRGBO(253, 253, 253, 1);
  static var textEventCardHeader =
      TextStyle(fontSize: 20, fontFamily: "Lato", fontWeight: FontWeight.bold);
  static var textEventCardLocation = TextStyle(
    fontSize: 20,
    fontFamily: "Lato",
    fontWeight: FontWeight.w100,
  );
  static var textEventCardContent = TextStyle(
      fontSize: 18, fontFamily: "Lao Sangam MN", fontWeight: FontWeight.normal);

  static var textEventCardTimeHours =
      TextStyle(fontFamily: "Didot", fontSize: 20, fontWeight: FontWeight.bold);
  static var textEventCardTimeMinutes = TextStyle(
      fontFamily: "Didot", fontSize: 18, fontWeight: FontWeight.normal);

  static var kokaCardNewsTextHeader =
      TextStyle(fontSize: 20, fontFamily: "Lato", fontWeight: FontWeight.bold);
  static var kokaCardNewsTextContent = TextStyle(
      fontSize: 18, fontFamily: "Lao Sangam MN", fontWeight: FontWeight.normal);

  static var kokaCardNewsTextTopRight =
      TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 12);

  static var textTimeBoxDay = TextStyle(
    fontSize: 12,
    fontFamily: "Lao Sangam MN",
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static var textDayButtons = TextStyle(
      fontFamily: "Didot",
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.white70);
}
