import 'package:flutter/widgets.dart';

class ColorStrip extends StatelessWidget {
  const ColorStrip({
    Key key,
    this.colorStart,
    this.colorEnd,
    this.vertical = false,
    this.thickness = 4,
    this.length,
  }) : super(key: key);

  final Color colorStart;
  final Color colorEnd;
  final double thickness;
  final bool vertical;
  final double length;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Container(
        height: length != null ? length : 66,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              colorStart,
              colorEnd,
            ],
            begin: const FractionalOffset(1, 0),
            end: const FractionalOffset(0, 1),
          ),
        ),
        width: thickness,
      );
    }
    return Container(
      height: thickness,
      width: length != null ? length : null,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [
          colorStart,
          colorEnd,
        ]),
      ),
    );
  }
}
