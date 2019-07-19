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
                  buildTrackBox(),
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

  Widget buildLocationBox() =>
      _exists('location') ? LocationBox(document: document) : SizedBox.shrink();

  Widget buildTimeBox() =>
      _exists('startTime') ? TimeBox(document: document) : SizedBox.shrink();

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

  /// Checks if the document have a field
  /// that matches the provided string.
  /// Returns True if the string does exist,
  /// and False if not.
  _exists(String s) {
    return ((document[s] ?? '') != '');
  }
}
