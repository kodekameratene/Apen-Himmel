import 'package:apen_himmel/helpers/SharedPreferences.dart';
import 'package:apen_himmel/helpers/appInfo_helper.dart';
import 'package:apen_himmel/helpers/asset_helpers.dart';
import 'package:apen_himmel/helpers/date_helper.dart';
import 'package:apen_himmel/widgets/organisms/DayButton.dart';
import 'package:apen_himmel/widgets/organisms/KokaCardEvent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
  double nextEventPosition;
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Styles.colorPrimary,
            title: AssetHelpers.getAppBarImage(),
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Flexible(
                    child: programList(),
                  ),
//              Container(
//                  color: Styles.colorPrimary,
//                  height: 82,
//                  child: dayButtonList()),
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

  Widget _buildProgramListItem(
      BuildContext context, DocumentSnapshot document, shouldShowNewDayLabel) {
    var shouldShowEvent =
        SharedPreferencesHelper.shouldShowDocument(document['track']);
    return FutureBuilder(
        future: shouldShowEvent,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return SizedBox.shrink();
              break;
            case ConnectionState.waiting:
              return SizedBox.shrink();
              break;
            case ConnectionState.active:
              return SizedBox.shrink();
              break;
            case ConnectionState.done:
              if (snapshot.data) {
                return KokaCardEvent(
                  document: document,
                  short: true,
                  onTapAction: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContentViewerPage(document)),
                  ),
                );
              }
              break;
          }
          return SizedBox.shrink();
        });
  }

  Widget programList() {
    nextEventPosition = -70;
    return (StreamBuilder(
        stream: Firestore.instance
            .collection(AppInfo.dbCollectionContent)
            .where("page", arrayContains: 'program')
            .orderBy("startTime")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Laster inn data...")));
          days = [];
          daySeparators = new List<String>();
          return ListView.builder(
              controller: _controller,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
//                bool shouldShowEvent =
//                    SharedPreferencesHelper.shouldShowDocument(
//                        snapshot.data.documents[index]['track']);
//                print("$index $shouldShowEvent");
                bool shouldShowNewDayLabel = index == 0 ? true : false;
                if (index > 0) {
                  int lastOne = index - 1;
                  if (getDayNumberFromTimestamp(
                          snapshot.data.documents[lastOne]["startTime"]) !=
                      getDayNumberFromTimestamp(
                          snapshot.data.documents[index]["startTime"])) {
                    shouldShowNewDayLabel = true;
                    nextEventPosition += 60;
                  }
                }
//                bool shouldShowEvent =true;
////                    SharedPreferencesHelper.shouldShowDocument(
////                        snapshot.data.documents[index]['track']);
//                if (shouldShowEvent) {
//                  nextEventPosition += 80;
//                }
                return Column(
                  children: <Widget>[
                    shouldShowNewDayLabel
                        ? DayLabel(
                            document: snapshot.data.documents[index],
                          )
                        : SizedBox.shrink(),
//                    shouldShowEvent
//                        ?
                    _buildProgramListItem(context,
                        snapshot.data.documents[index], shouldShowNewDayLabel)
//                        : SizedBox.shrink(),
                  ],
                );
              });
        }));
  }

  Widget _buildButtonListItem(BuildContext context, DocumentSnapshot document) {
    // watch_your_profanity
    String filter = getDayFromTimestamp(document["startTime"]);
    bool active = false;
    return GestureDetector(
      onTap: () {
        print("Filter on $filter");
        setState(() {
          active = true;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: DayButton(
            active: active,
            date: getDayNumberFromTimestamp(document['startTime']),
            day: getDayFromTimestamp(document["startTime"])),
      ),
    );
  }

  Widget dayButtonList() {
    return (StreamBuilder(
        stream: Firestore.instance
            .collection(AppInfo.dbCollectionContent)
            .where("page", arrayContains: 'program')
            .orderBy("startTime")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text("Laster inn data..."));
          days = [];
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                String dayNumberFromTimestamp = getDayNumberFromTimestamp(
                    snapshot.data.documents[index]["startTime"]);
                if (!days.contains(dayNumberFromTimestamp)) {
                  days.add(dayNumberFromTimestamp);
                  return _buildButtonListItem(
                      context, snapshot.data.documents[index]);
                }
                return SizedBox.shrink();
              });
        }));
  }

  void scrollToNextEvent() {
    // Scroll to first item in the future
    _controller.animateTo(getPositionOfActiveEvent(),
        duration: Duration(seconds: 2), curve: ElasticOutCurve());
  }

  double getPositionOfActiveEvent() {
    return activeEventPosition[0];
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
