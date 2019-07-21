import 'package:apen_himmel/helpers/SharedPreferences.dart';
import 'package:apen_himmel/helpers/appInfo_helper.dart';
import 'package:apen_himmel/helpers/asset_helpers.dart';
import 'package:apen_himmel/widgets/molecules/KokaButton.dart';
import 'package:apen_himmel/widgets/molecules/KokaImg.dart';
import 'package:apen_himmel/widgets/molecules/LocationBox.dart';
import 'package:apen_himmel/widgets/molecules/TrackBox.dart';
import 'package:apen_himmel/widgets/organisms/KokaCard.dart';
import 'package:apen_himmel/widgets/organisms/KokaCardEvent.dart';
import 'package:apen_himmel/widgets/organisms/TimeBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class ContentViewerPage extends StatelessWidget {
  ContentViewerPage(this.document);

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.colorPrimary,
          title: AssetHelpers.getAppBarImage(),
          centerTitle: true,
        ),
        backgroundColor: Styles.colorBackgroundColorMain,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  buildKokaCardEvent(),
                  buildImg(context),
                  buildKokaCard(),
                  buildKokaButton(),
                  buildTimeBox(),
                  buildLocationBox(),
//                  buildTrackBox(),
                  showSeminarTitle(),
                  showSeminars(),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildTrackBox() {
    if (_exists('category') || _exists('track'))
      return TrackBox(document: document);
    return SizedBox.shrink();
  }

  Widget buildLocationBox() => _exists('location') && !_exists('startTime')
      ? LocationBox(document: document)
      : SizedBox.shrink();

  Widget buildTimeBox() =>
      _exists('endTime') ? TimeBox(document: document) : SizedBox.shrink();

  Widget buildKokaButton() =>
      _exists('url') ? KokaButton(url: document['url']) : SizedBox.shrink();

  Widget buildKokaCard() => _exists('content')
      ? KokaCard(
          document: document,
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ))
      : SizedBox.shrink();

  Widget buildKokaCardEvent() => _exists('startTime')
      ? KokaCardEvent(
          document: document,
          short: false,
        )
      : SizedBox.shrink();

  Widget buildImg(context) => _exists('img')
      ? KokaImg(document: document)
      : Container(
          height: 10,
        );

  Widget showSeminarTitle() {
    if (_exists('groupTitle')) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            document['groupTitle'],
            style: TextStyle(fontSize: 20.0),
          )
        ],
      );
    } else
      return SizedBox.shrink();
  }

  Widget showSeminars() {
    if (_exists('header')) {
      String group = document['group'][0].toString();
      print(group);
      return StreamBuilder(
          stream: Firestore.instance
              .collection(AppInfo.dbCollectionContent)
              .where("group", arrayContains: group)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text("Laster inn data..."));
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => _buildSeminarItem(
                              context,
                              snapshot.data.documents[index],
                              myTracks));
                      break;
                  }
                  return Text("Hello");
                });
          });
    }
    return SizedBox.shrink();
  }

  /// Checks if the document have a field
  /// that matches the provided string.
  /// Returns True if the string does exist,
  /// and False if not.
  _exists(String s) {
    return ((document[s] ?? '') != '');
  }

  Widget _buildSeminarItem(
      BuildContext context, DocumentSnapshot document, myTracks) {
    bool shouldShowDocument = false;
    myTracks.forEach((track) {
      bool isSub = !((document['header'] ?? '') != '');

      if (document['track'].toString().contains(track) && isSub) {
        shouldShowDocument = true;
        return;
      }
    });

    bool hasStartTime = ((document['startTime'] ?? '') != '');

    if (hasStartTime) {
      return shouldShowDocument
          ? KokaCardEvent(
              document: document,
              short: true,
              onTapAction: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContentViewerPage(document))))
          : SizedBox.shrink();
    } else
      return shouldShowDocument
          ? KokaCard(
              document: document,
              short: true,
              onTapAction: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContentViewerPage(document))))
          : SizedBox.shrink();
  }
}
