import 'package:apen_himmel/helpers/appInfo_helper.dart';
import 'package:apen_himmel/widgets/molecules/KokaButton.dart';
import 'package:apen_himmel/widgets/molecules/PushSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool showSecrets = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Styles.colorBackgroundColorMain,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Text(
              "Instillinger",
              style: Styles.textAppBar,
            ),
            backgroundColor: Styles.colorPrimary,
          ),
        ),
        body: Container(
          color: Styles.kokaEventCardColorBackground,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  buildSwitchButtonSection(),
                  KokaButton(
                    text: 'Erklæring om personvern',
                    url: 'https://koka.no/apen-himmel/privacy-policy',
                  ),
                  KokaButton(
                    text: 'Lisens for kildekode',
                    url:
                        'https://github.com/kodekameratene/Apen-Himmel/blob/develop/LICENSE',
                  ),
                  VersionInfoLabel(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSwitchButtonSection() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onDoubleTap: () => setState(() {
            showSecrets ? showSecrets = false : showSecrets = true;
          }),
          child: Icon(
            Icons.notifications_active,
            color: Styles.colorSecondary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hva som vises i Appen",
            style: Styles.kokaCardNewsTextHeader,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Slå på det du vil holde deg oppdatert på.",
            style: Styles.kokaCardNewsTextContent,
          ),
        ),
        buildPushSwitch('VoksenCamp'),
        buildPushSwitch('YouthCamp'),
        buildPushSwitch('KidsCamp'),
        buildPushSwitch('Teltet'),
        showSecrets ? buildPushSwitch('Developer') : SizedBox.shrink(),
      ],
    );
  }

  Widget buildPushSwitch(text, {bool highlight = false}) {
    return Column(
      children: <Widget>[
        new PushSwitch(pushKey: text, highlight: highlight),
        Divider(),
      ],
    );
  }
}

class VersionInfoLabel extends StatelessWidget {
  const VersionInfoLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () async {
          const url = 'https://koka.no';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Text(
          '${AppInfo.appName} v${AppInfo.version}\n ${AppInfo.developers}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black38),
        ),
      ),
    );
  }
}
