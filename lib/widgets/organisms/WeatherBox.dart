import 'package:apen_himmel/widgets/molecules/weatherWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styles.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        const url =
            'https://www.yr.no/nb/værvarsel/graf/1-2753969/Norge/Østfold/Fredrikstad/Kongstenhallen';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Styles.colorWeatherBgEnd,
              Styles.colorWeatherBgStart,
            ],
            begin: const FractionalOffset(2.8, 0),
            end: const FractionalOffset(0.2, 5),
            stops: [0.5, 1],
            tileMode: TileMode.clamp,
          ),
          boxShadow: [
            new BoxShadow(
              color: Styles.colorShadowCardMain,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        height: 81,
        child: WeatherWidget(
          temperature: "23",
          location: "Fredrikstad",
        ),
      ),
    );
  }
}
