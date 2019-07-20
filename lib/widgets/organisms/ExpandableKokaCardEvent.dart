import 'package:flutter/material.dart';
import 'package:apen_himmel/widgets/organisms/KokaCardEvent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpandableKokaCardEvent extends StatelessWidget {

const ExpandableKokaCardEvent({
  Key key,
  this.kokaCardEvent,
}) : super(key: key);

final KokaCardEvent kokaCardEvent;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: seminars.length,
        itemBuilder: (context, i) {
          return new ExpansionTile(
            title: new Text(seminars[i].title, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(seminars[i]),
              ),
            ],
          );
        },
      ),
    );
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