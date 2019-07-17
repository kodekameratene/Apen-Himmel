import 'package:apen_himmel/helpers/convertTimeStamp_helper.dart';
import 'package:apen_himmel/helpers/date_helper.dart';
import 'package:apen_himmel/widgets/atoms/TimeWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../styles.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({
    Key key,
    this.document,
    this.onTapAction,
  }) : super(key: key);

  final DocumentSnapshot document;
  final onTapAction;

  @override
  Widget build(BuildContext context) {
    String startHours;
    String startMinutes;
    String startDayName;
    if (_exists('startTime')) {
      var startTime = convertStamp(document['startTime']);
      var formatterHours = new DateFormat('HH');
      var formatterMinutes = new DateFormat('mm');
      startHours = formatterHours.format(startTime).toString();
      startMinutes = formatterMinutes.format(startTime).toString();
      startDayName = getWeekdayDateMonth(document["startTime"]);
    }
    String endHours;
    String endMinutes;
    String endDayName;
    if (_exists('endTime')) {
      var endTime = convertStamp(document['endTime']);
      var formatterHours = new DateFormat('HH');
      var formatterMinutes = new DateFormat('mm');
      endHours = formatterHours.format(endTime).toString();
      endMinutes = formatterMinutes.format(endTime).toString();
      endDayName = getWeekdayDateMonth(document["endTime"]);
    }
    String location;
    if (_exists('location')) {
      location = document['location'];
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: new BoxDecoration(boxShadow: [
                new BoxShadow(
                  color: Styles.colorShadowCardMain,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ]),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                color: Styles.kokaEventCardColorBackground,
                elevation: 0,
                margin: EdgeInsets.all(0),
                child: Container(
                    margin: EdgeInsets.fromLTRB(18, 8, 20, 10),
                    child: buildTimeContent(
                        startHours,
                        startMinutes,
                        startDayName,
                        endHours,
                        endMinutes,
                        endDayName,
                        location)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeContent(
      String startHours,
      String startMinutes,
      String startDayName,
      String endHours,
      String endMinutes,
      String endDayName,
      String location) {
    if (endHours == null) {
      return TimeWidget(
        hours: startHours,
        minutes: startMinutes,
        text: '$startDayName',
      );
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: TimeWidget(
                      hours: startHours,
                      minutes: startMinutes,
                      text: '$startDayName',
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: TimeWidget(
                      hours: endHours,
                      minutes: endMinutes,
                      text: '$endDayName',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Checks if the document have a field
  /// that matches the provided string.
  /// Returns True if the string does exist,
  /// and False if not.
  _exists(String s) {
    return ((document[s] ?? '') != '');
  }
}
