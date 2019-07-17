import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fullScreenImage.dart';

// Img that when touched will open in full-screen
class KokaImg extends StatelessWidget {
  const KokaImg({
    Key key,
    @required this.document,
  }) : super(key: key);

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return FullScreenPage(img: document['img']);
          }));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Image.network(
            document['img'],
            fit: BoxFit.cover,
          ),
        ));
  }
}
