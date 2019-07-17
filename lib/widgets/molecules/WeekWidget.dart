import 'package:apen_himmel/widgets/organisms/DayButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeekWidget extends StatelessWidget {
  final List<DayButton> buttonList;

  const WeekWidget({Key key, this.buttonList}) : super(key: key);

  Widget listViewBuilder() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: buttonList.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(child: DayButton(date: buttonList[index].date.toString(), day: buttonList[index].day.toString())),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: listViewBuilder()
    );
  }
}
