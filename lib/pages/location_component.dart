import 'package:flutter/material.dart';

import '../styles.dart';

class LocationSelectPage extends StatelessWidget {
  final List<Location> locations;

  const LocationSelectPage({Key key, this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text("Velg sted"), backgroundColor: Styles.colorPrimary),
            body: ListView(
                children: locations
                    .map((post) => ListTile(
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            top: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          title: Text(post.title),
                          subtitle: Text(post.startTime.toLocal().toString()),
                          trailing: Image.network(
                            post.img,
                            height: 100,
                            width: 100,
                          ),
                          onTap: () => AlertDialog(
                                backgroundColor: Styles.colorPrimary,
                                title: Text(post.title),
                                content: Text("Select location"),
                              ),
                        ))
                    .toList())));
  }
}

class Location {
  String get title => null;

  get startTime => null;

  String get img => null;
}
