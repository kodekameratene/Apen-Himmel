import 'dart:ui';

import '../styles.dart';

/// Returns a color if the string have a predefined color.
/// Note that we return after the first match.
/// This is the strings we match on:
/// møte, seminar, samling, konsert, forestilling, mat
/// IF NO MATCH => Styles.colorPrimary
Color mapCategoryToStartColor(String category) {
  if (category.contains('møte')) {
    return Styles.colorAccentCategoryMeetingStart;
  }
  if (category.contains('seminar')) {
    return Styles.colorAccentCategorySeminarStart;
  }
  if (category.contains('samling')) {
    return Styles.colorAccentCategoryGatheringStart;
  }
  if (category.contains('konsert')) {
    return Styles.colorAccentCategoryConcertStart;
  }
  if (category.contains('forestilling')) {
    return Styles.colorAccentCategoryPerformanceStart;
  }
  if (category.contains('mat')) {
    return Styles.colorAccentCategoryFoodStart;
  }
  return Styles.colorPrimary;
}

/// Returns a color if the string have a predefined color.
/// Note that we return after the first match.
/// This is the strings we match on:
/// møte, seminar, samling, konsert, forestilling, mat
/// IF NO MATCH => Styles.colorPrimary
Color mapCategoryToEndColor(String category) {
  if (category.contains('møte')) {
    return Styles.colorAccentCategoryMeetingEnd;
  }
  if (category.contains('seminar')) {
    return Styles.colorAccentCategorySeminarEnd;
  }
  if (category.contains('samling')) {
    return Styles.colorAccentCategoryGatheringEnd;
  }
  if (category.contains('konsert')) {
    return Styles.colorAccentCategoryConcertEnd;
  }
  if (category.contains('forestilling')) {
    return Styles.colorAccentCategoryPerformanceEnd;
  }
  if (category.contains('mat')) {
    return Styles.colorAccentCategoryFoodEnd;
  }
  return Styles.colorSecondary;
}
