import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../styles.dart';

class LocationBox extends StatelessWidget {
  const LocationBox({
    Key key,
    @required this.document,
  }) : super(key: key);

  final DocumentSnapshot document;

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
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Styles.kokaEventCardColorBackground,
        height: 100,
        padding:
        const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.map,
                color: Styles.colorSecondary,
              ),
            ),
            Text(document['location']),
          ],
        ),
      ),
    );
  }
}
