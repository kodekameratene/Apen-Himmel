import 'dart:ui';

import '../styles.dart';

/// Returns a color if the string have a predefined color.
/// Note that we return after the first match.
/// This is the strings we match on:
/// møte, seminar, samling, konsert, forestilling, mat
/// IF NO MATCH => Styles.colorPrimary
Color mapTrackToStartColor(String track) {
  if (track.contains('YouthCamp')) {
    return Styles.colorAccentTrackYouthCampStart;
  }
  if (track.contains('VoksenCamp')) {
    return Styles.colorAccentTrackVoksenCampStart;
  }
  if (track.contains('KidsCamp')) {
    return Styles.colorAccentTrackKidsCampStart;
  }
  if (track.contains('TweensCamp')) {
    return Styles.colorAccentTrackTweensCampStart;
  }
  if (track.contains('MiniCamp')) {
    return Styles.colorAccentTrackMiniCampStart;
  }
  if (track.contains('TELTET')) {
    return Styles.colorAccentTrackTeltetStart;
  }
  if (track.contains('Felles')) {
    return Styles.colorAccentTrackFellesStart;
  }
  if (track.contains('Developer')) {
    return Styles.colorAccentTrackDeveloperStart;
  }
  return Styles.colorPrimary;
}

/// Returns a color if the string have a predefined color.
/// Note that we return after the first match.
/// This is the strings we match on:
/// møte, seminar, samling, konsert, forestilling, mat
/// IF NO MATCH => Styles.colorPrimary
Color mapTrackToEndColor(String track) {
  if (track.contains('YouthCamp')) {
    return Styles.colorAccentTrackYouthCampEnd;
  }
  if (track.contains('VoksenCamp')) {
    return Styles.colorAccentTrackVoksenCampEnd;
  }
  if (track.contains('KidsCamp')) {
    return Styles.colorAccentTrackKidsCampEnd;
  }
  if (track.contains('TweensCamp')) {
    return Styles.colorAccentTrackTweensCampEnd;
  }
  if (track.contains('MiniCamp')) {
    return Styles.colorAccentTrackMiniCampEnd;
  }
  if (track.contains('Teltet')) {
    return Styles.colorAccentTrackTeltetEnd;
  }
  if (track.contains('Felles')) {
    return Styles.colorAccentTrackFellesEnd;
  }
  if (track.contains('Developer')) {
    return Styles.colorAccentTrackDeveloperEnd;
  }
  return Styles.colorSecondary;
}
