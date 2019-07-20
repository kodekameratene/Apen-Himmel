import 'package:apen_himmel/helpers/SharedPreferences.dart';
import 'package:apen_himmel/helpers/appInfo_helper.dart';
import 'package:apen_himmel/helpers/date_helper.dart';
import 'package:apen_himmel/widgets/organisms/DayButton.dart';
import 'package:apen_himmel/widgets/organisms/KokaCardEvent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:apen_himmel/widgets/organisms/ExpandableKokaCardEvent2.dart';
import 'package:apen_himmel/helpers/existInDatabase_helper.dart';

import '../styles.dart';
import 'ContentViewerPage.dart';

class ProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  List<DayButton> list = new List<DayButton>();
  List<String> days = new List<String>();
  List<String> daySeparators = new List<String>();
  List<double> activeEventPosition = new List<double>();

  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  Widget build(context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Flexible(
                    child: programList(),
                  ),
                ],
              ),
//              Padding(
//                padding: const EdgeInsets.all(10),
//                child: Align(
//                    alignment: Alignment(1, 1),
//                    child: FloatingActionButton(
//                      child: Icon(Icons.call_missed),
//                      tooltip: "Gå til neste hendelse",
//                      backgroundColor: Styles.colorPrimary,
//                      onPressed: () {
//                        scrollToNextEvent();
//                      },
//                    )),
//              ),
            ],
          ),
        ),
        backgroundColor: Styles.colorBackgroundColorMain,
      ),
    );
  }


  Widget _buildProgramListItem(BuildContext context, DocumentSnapshot document,
      shouldShowNewDayLabel) {
    if (Exists(document, 'group')) {
      return (ExpandableKokaCardEvent(
          document: document,
          short: true,
          onTapAction: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContentViewerPage(document)),
              )));
    } else
      return KokaCardEvent(
        document: document,
        short: true,
        onTapAction: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContentViewerPage(document)),
            ),
      );
  }

  Widget programList() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(AppInfo.dbCollectionContent)
            .where("page", arrayContains: 'program')
            .orderBy("startTime")
            .snapshots(),
        builder: (context, documentSnapshot) {
          if (!documentSnapshot.hasData)
            return Center(
                child: Padding(
                    padding: EdgeInsets.all(10), child: Text("Ingen data...")));
          days = [];
          daySeparators = new List<String>();
          return FutureBuilder(
              future: SharedPreferencesHelper.getMyTracks(),
              builder: (BuildContext context, AsyncSnapshot trackSnapshot) {
                switch (trackSnapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Ingen forbindelse",
                              style: Styles.textEventCardHeader,
                            ),
                          ),
                          Text(
                            "Er du koblet på internett?",
                            style: Styles.textEventCardContent,
                          ),
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.waiting:
                    continue loading;
                  loading:
                  case ConnectionState.active:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Styles.colorPrimary),
                            ),
                          ),
                          Text(
                            "Oppdaterer data...",
                            style: Styles.textEventCardContent,
                          ),
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.done:
                    var myTracks = trackSnapshot.data;
                    return ListView.builder(
                        controller: _controller,
                        itemCount: documentSnapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          bool shouldShowNewDayLabel =
                          index == 0 ? true : false;
                          if (index > 0) {
                            int lastOne = index - 1;
                            if (getDayNumberFromTimestamp(documentSnapshot
                                .data.documents[lastOne]["startTime"]) !=
                                getDayNumberFromTimestamp(documentSnapshot
                                    .data.documents[index]["startTime"])) {
                              shouldShowNewDayLabel = true;
                            }
                          }
                          return Column(
                            children: <Widget>[
                              shouldShowNewDayLabel
                                  ? DayLabel(
                                document: documentSnapshot
                                    .data.documents[index],
                              )
                                  : SizedBox.shrink(),
                              _buildExpandableContent(seminars[0]),
                            ],
                          );
                        });
                    break;
                }
/*                return new ExpansionTile(
                  title: new Text(snapshot.data.documents[index]['title'], style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                  children: <Widget>[
                    new Column(
                      children: _buildExpandableContent(seminars[1]),
                    ),
                  ],
                );*/
                return SizedBox.shrink();
              });
        });
  }

  _buildExpandableContent(Vehicle seminar) {
    List<Widget> columnContent = [];

    for (String content in seminar.contents)
      columnContent.add(
        new ListTile(
            title: new Text(
              content, style: new TextStyle(fontSize: 18.0),)
        ),
      );

    return columnContent;
  }

  Widget _buildButtonListItem(BuildContext context, DocumentSnapshot document) {
    // watch_your_profanity
    String filter = getDayFromTimestamp(document["startTime"]);
    bool active = false;
    return GestureDetector(
        onTap: ()
    {
      print("Filter on $filter");
      setState(() {
        active = true;
      });
    });
  }
}

class DayLabel extends StatelessWidget {
  const DayLabel({Key key, this.document}) : super(key: key);
  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          getWeekdayDateMonth(document["startTime"]),
          style: Styles.textEventCardHeader,
        ),
      ),
    );
  }

}


class Vehicle {
  final String title;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);
}

List<Vehicle> seminars = [
  new Vehicle(
    'Seminarbolk 1',
    [],
    Icons.motorcycle,
  ),
  new Vehicle(
    'Seminarbolk 2',
    ['Seminar no. 3', 'Seminar no. 4', 'Seminar no. 6'],
    Icons.directions_car,
  ),
];