import 'package:apen_himmel/helpers/SharedPreferences.dart';
import 'package:apen_himmel/helpers/appInfo_helper.dart';
import 'package:apen_himmel/widgets/organisms/KokaCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles.dart';
import 'ContentViewerPage.dart';

class NewsPage extends StatelessWidget {
  Widget _buildListItem(
      BuildContext context, DocumentSnapshot document, myTracks) {
    bool shouldShowDocument = false;
    myTracks.forEach((track) {
      if (document['track'].toString().contains(track)) {
        shouldShowDocument = true;
        return;
      }
    });
    return shouldShowDocument
        ? KokaCard(
            document: document,
            short: true,
            onTapAction: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContentViewerPage(document))),
          )
        : SizedBox.shrink();
  }

  Widget build(context) {
    return Material(
      child: Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance
                .collection(AppInfo.dbCollectionContent)
                .where("page", arrayContains: 'news')
                .where("timestamp", isLessThanOrEqualTo: Timestamp.now())
                .orderBy("timestamp", descending: true)
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
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) => _buildListItem(
                                context,
                                snapshot.data.documents[index],
                                myTracks));
                        break;
                    }
                    return Text("Hei på deg! :)");
                  });
            }),
        backgroundColor: Styles.colorBackgroundColorMain,
      ),
    );
  }
}
