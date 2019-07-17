import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../styles.dart';

class TrackBox extends StatelessWidget {
  const TrackBox({
    Key key,
    this.document,
  }) : super(key: key);

  _exists(String s) {
    return ((document[s] ?? '') != '');
  }

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    String category;
    if (_exists('category')) {
      category = document['category'].toString();
    }
    String track;
    if (_exists('track')) {
      track = document['track'].toString();
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Styles.colorShadowCardMain,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ]),
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.white,
          child: Wrap(
            children: <Widget>[
              category != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Kategori: $category",
                        style: Styles.textEventCardTimeMinutes,
                      ),
                    )
                  : SizedBox.shrink(),
              track != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Spor: $track",
                        style: Styles.textEventCardTimeMinutes,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
