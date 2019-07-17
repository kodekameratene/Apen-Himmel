import 'package:flutter/widgets.dart';
import '../../styles.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key key,
    this.hours,
    this.minutes,
    this.text,
  }) : super(key: key);

  final String hours;
  final String minutes;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "$hours",
          style: Styles.textEventCardTimeHours,
        ),
        Text(
          "$minutes",
          style: Styles.textEventCardTimeMinutes,
        ),
        text != null
            ? Text("$text", style: Styles.textTimeBoxDay)
            : SizedBox.shrink(),
      ],
    );
  }
}
