import 'package:apen_himmel/helpers/convertTimeStamp_helper.dart';
import 'package:apen_himmel/helpers/mapTrackToColor.dart';
import 'package:apen_himmel/widgets/atoms/ColorStrip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../styles.dart';

class KokaCard extends StatelessWidget {
  const KokaCard({
    Key key,
    this.document,
    this.padding = const EdgeInsets.all(10),
    this.onTapAction,
    this.short = false,
  }) : super(key: key);

  final DocumentSnapshot document;
  final EdgeInsets padding;
  final onTapAction;
  final bool short;

  @override
  Widget build(BuildContext context) {
    String hours;
    if (_exists('startTime')) {
      var startTime = convertStamp(document['startTime']);
      var formatterHours = new DateFormat('HH');
      hours = formatterHours.format(startTime).toString();
    }
    String timePosted;
    if (_exists('timestamp')) {
      var timestamp = convertStamp(document['timestamp']);
      var formatter = new DateFormat('HH:mm dd/MM/yyyy');
      timePosted = formatter.format(timestamp).toString();
    }
    final String title = document['title'] ?? '';
    final String subtitle = document['subtitle'] ?? '';
    final String content = document['content'] ?? '';
    final Color colorStart = _exists('track')
        ? mapTrackToStartColor(document['track'][0].toString())
        : mapTrackToStartColor('default');
    final Color colorEnd = _exists('track')
        ? mapTrackToEndColor(document['track'][0].toString())
        : mapTrackToEndColor('default');
    return Padding(
      padding: padding,
      child: Container(
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Styles.colorShadowCardMain,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ]),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTapAction,
            splashColor: colorStart,
            child: Column(
              children: <Widget>[
                ColorStrip(
                  colorStart: colorStart,
                  colorEnd: colorEnd,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              hours != null
                                  ? SizedBox.shrink()
                                  : _title(title, short),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: _content(content, subtitle, short),
                              ),
                              TimePostedField(timePosted: timePosted),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

class TimePostedField extends StatelessWidget {
  const TimePostedField({
    Key key,
    @required this.timePosted,
  }) : super(key: key);

  final String timePosted;

  @override
  Widget build(BuildContext context) {
    if (timePosted != null) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 8,
        ),
        child: Text(
          "Publisert $timePosted",
          style: Styles.textCardTimePosted,
        ),
      );
    }
    return SizedBox.shrink();
  }
}

Text _title(String title, bool short) {
  if (short) {
    return Text(title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Styles.kokaCardNewsTextHeader);
  }
  return Text(title, style: Styles.kokaCardNewsTextHeader);
}

Text _content(String content, String subtitle, bool short) {
  if (subtitle != '' && short) {
    return Text(formatText(subtitle),
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: Styles.kokaCardNewsTextContent);
  }
  if (short) {
    return Text(formatText(content),
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: Styles.kokaCardNewsTextContent);
  }
  return Text(formatText(content), style: Styles.kokaCardNewsTextContent);
}

String formatText(String content) {
  return content.replaceAll("\\n", "\n");
}
