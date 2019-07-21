import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styles.dart';

class KokaButton extends StatelessWidget {
/*
Button made by Koka
Can launch urls or your own provided onTap method.
 */
  const KokaButton({
    Key key,
    this.onTap,
    this.color,
    this.text,
    this.url,
  }) : super(key: key);
  final Function onTap;
  final Color color;
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Styles.colorShadowCardMain,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ]),
      padding: EdgeInsets.all(10),
      child: Material(
        color: color ?? Styles.colorPrimary,
        child: InkWell(
          splashColor: Styles.colorPrimary,
          onTap: onTap ?? url != null ? () => openURL(url) : () {},
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      text != null
                          ? text
                          : url != null
                              ? _makeTitleFromUrl(url)
                              : 'Please give me something to do...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Todo: Test mailto, call and regular links works on both iOS and Android
  openURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //todo: Format mailto, website, and calling urls.
  _makeTitleFromUrl(String url) {
    if (url.contains('mailto')) {
      return "Send epost";
    }
    if (url.contains('http')) {
      String formattedURL = url.split('/')[2];
      return 'Besøk nettside | $formattedURL';
    }
    if (url.contains('tel')) {
      String formattedURL = url.split(':')[1];
      return 'Ring $formattedURL';
    }
    return url;
  }
}
