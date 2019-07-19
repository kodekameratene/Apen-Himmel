import 'package:apen_himmel/helpers/convertTimeStamp_helper.dart';
import 'package:apen_himmel/helpers/mapTrackToColor.dart';
import 'package:apen_himmel/widgets/atoms/ColorStrip.dart';
import 'package:apen_himmel/widgets/atoms/TimeWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../styles.dart';

class KokaCardEvent extends StatelessWidget {
  const KokaCardEvent({
    Key key,
    this.document,
    this.onTapAction,
    this.short = true,
  }) : super(key: key);

  final DocumentSnapshot document;
  final onTapAction;
  final bool short;

  @override
  Widget build(BuildContext context) {
    String hours;
    String minutes;
    if (_exists('startTime')) {
      var startTime = convertStamp(document['startTime']);
      var formatterHours = new DateFormat('HH');
      var formatterMinutes = new DateFormat('mm');
      hours = formatterHours.format(startTime).toString();
      minutes = formatterMinutes.format(startTime).toString();
    }
    final String title = _exists('title') ? document['title'] : '';
    final String subtitle = _exists('subtitle') ? document['subtitle'] : '';
    final Color colorStart = _exists('track')
        ? mapTrackToStartColor(document['track'][0].toString())
        : mapTrackToStartColor('default');
    final Color colorEnd = _exists('track')
        ? mapTrackToEndColor(document['track'][0].toString())
        : mapTrackToEndColor('default');
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ColorStrip(
            colorStart: colorStart,
            colorEnd: colorEnd,
            vertical: true,
          ),
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
//                color: Styles.kokaEventCardColorBackground,
                elevation: 0,
                margin: EdgeInsets.all(0),
                child: InkWell(
                    splashColor: Styles.colorPrimary,
                    child: Container(
                        height: short ? 60 : null,
                        margin: EdgeInsets.fromLTRB(18, 8, 20, 10),
                        child: Row(
                          children: <Widget>[
                            TimeWidget(
                              hours: hours,
                              minutes: minutes,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 18, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    buildTitle(title, short),
                                    buildSubtitle(subtitle, short),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    onTap: onTapAction),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitle(String title, bool short) {
    if (title == '') {
      return SizedBox.shrink();
    }
    if (short) {
      return Text(title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.textEventCardHeader);
    } else {
      return Text(title, softWrap: true, style: Styles.textEventCardHeader);
    }
  }

  Widget buildSubtitle(String subtitle, bool short) {
    if (subtitle == null ?? subtitle == '') {
      return SizedBox.shrink();
    }
    if (short) {
      return Text(formatText(subtitle),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
          style: Styles.textEventCardContent);
    } else {
      return Text(formatText(subtitle),
          softWrap: true, style: Styles.textEventCardContent);
    }
  }

  /// Checks if the document have a field
  /// that matches the provided string.
  /// Returns True if the string does exist,
  /// and False if not.
  _exists(String s) {
    return ((document[s] ?? '') != '');
  }

  String formatText(String content) {
    return content.replaceAll("\\n", "\n");
  }
}
