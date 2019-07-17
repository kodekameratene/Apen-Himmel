import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../styles.dart';

class DayButton extends StatelessWidget {
  final String day;
  final String date;
  final bool active;

  const DayButton({
    Key key,
    this.day,
    this.date,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    return ListView(
//        children: <Widget> [
//          circularButton(context),
//          weekDay(),
//    ]);
    return circularButton();
  }

  Widget circularButton() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Container(
              padding: EdgeInsets.only(bottom: 2),
              color: active ? Colors.white : Colors.white70,
              height: 30.0,
              // height of the button
              width: 30.0,
              // width of the button
              child: Center(child: Text(date)),
            ),
          ),
          weekDay(),
        ],
      ),
    );
  }

  Widget weekDay() {
    return Text(
      day,
      style: Styles.textDayButtons,
    );
  }
}
