import 'package:apen_himmel/config/application.dart';
import 'package:apen_himmel/helpers/SharedPreferences.dart';
import 'package:apen_himmel/helpers/SharedPreferences.dart' as prefix0;
import 'package:apen_himmel/helpers/asset_helpers.dart';
import 'package:apen_himmel/pages/InfoPage.dart';
import 'package:apen_himmel/pages/NewsPage.dart';
import 'package:apen_himmel/pages/ProgramPage.dart';
import 'package:apen_himmel/widgets/molecules/PushSwitch.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  bool showWelcomeScreen = false;

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper.getShouldShowStartupScreen().then((v) {
      showWelcomeScreen = v;
    });
    if (showWelcomeScreen) {
      return buildWelcomeScreen();
    }
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: AssetHelpers.getAppBarImage(),
          centerTitle: true,
          backgroundColor: Styles.colorPrimary,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Application.router.navigateTo(context, '/settings',
                  transition: TransitionType.fadeIn);
            },
          ),
        ),
        bottomNavigationBar: menu(),
        backgroundColor: Styles.colorBackgroundColorMain,
        body: TabBarView(
          children: <Widget>[
            Container(child: NewsPage()),
            Container(child: ProgramPage()),
            Container(child: InfoPage()),
          ],
        ),
      ),
    ));
  }

  Widget menu() {
    return Container(
      color: Styles.colorPrimary,
      child: SafeArea(
        child: TabBar(
          indicatorColor: Styles.colorSecondary,
          tabs: [
            Tab(
              text: "Nyheter",
              icon: Icon(Icons.notifications_active),
            ),
            Tab(
              text: "Program",
              icon: Icon(Icons.calendar_today),
            ),
            Tab(
              text: "Info",
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }

  Material buildWelcomeScreen() {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: AssetHelpers.getAppBarImage(),
          centerTitle: true,
          backgroundColor: Styles.colorPrimary,
        ),
        backgroundColor: Styles.colorPrimary,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Divider(),
              Container(
                margin: EdgeInsets.all(10),
                color: Styles.colorBackgroundColorMain,
                child: Column(
                  children: <Widget>[
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
                    PushSwitch(pushKey: 'VoksenCamp'),
                    Divider(height: 0),
                    PushSwitch(pushKey: 'YouthCamp'),
                    Divider(height: 0),
                    PushSwitch(pushKey: 'KidsCamp'),
                    Divider(height: 0),
                    PushSwitch(pushKey: 'TweensCamp'),
                    Divider(height: 0),
                    PushSwitch(pushKey: 'TELTET'),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                              "NB. Du kan når som helst ombestemme deg ved en senere anledning."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    SharedPreferencesHelper.setShouldShowStartupScreen(false);
                    setState(() {
                      showWelcomeScreen = false;
                      SharedPreferencesHelper.getMyTracks();
                    });
                  },
                  splashColor: Styles.colorSecondary,
                  child: Container(
                    color: Colors.white10,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.navigate_next,
                            size: 50,
                            color: Colors.white,
                          ),
                          Text(
                            "Gå videre",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
