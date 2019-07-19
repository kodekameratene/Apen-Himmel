import 'package:apen_himmel/helpers/SharedPreferences.dart';
import 'package:apen_himmel/helpers/appInfo_helper.dart';
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
            ],
          ),
        ),
        backgroundColor: Styles.colorBackgroundColorMain,
      ),
    );
  }

  Widget _buildProgramListItem(BuildContext context, DocumentSnapshot document,
      shouldShowNewDayLabel, myTracks) {
    bool shouldShowDocument = false;
    myTracks.forEach((track) {
      if (document['track'].toString().contains(track.toString())) {
        shouldShowDocument = true;
        return;
      }
    });
    return shouldShowDocument
        ? KokaCardEvent(
            document: document,
            short: true,
            onTapAction: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContentViewerPage(document)),
            ),
          )
        : SizedBox.shrink();
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
                              _buildProgramListItem(
                                  context,
                                  documentSnapshot.data.documents[index],
                                  shouldShowNewDayLabel,
                                  myTracks)
                            ],
                          );
                        });
                    break;
                }
                return Text("Hello");
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
