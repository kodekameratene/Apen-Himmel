import 'package:apen_himmel/helpers/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../styles.dart';

class PushSwitch extends StatefulWidget {
  PushSwitch({Key key, this.pushKey, this.highlight = false}) : super(key: key);
  final String pushKey;
  final bool highlight;

  @override
  _PushSwitchState createState() => _PushSwitchState();
}

class _PushSwitchState extends State<PushSwitch> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SharedPreferencesHelper.getPushValue(widget.pushKey),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            //This should not happen, since this is a local connection... :P
            return Text("No connection.");
            break;
          case ConnectionState.waiting:
            //This _does_ happen while we are waiting on the data
            //Let us return our switches turned off
            return Container(
              color: widget.highlight ? Color.fromRGBO(0, 180, 255, 0.1) : null,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.pushKey),
                    Switch(
                      value: false,
                      onChanged: (bool value) {},
                      activeColor: Styles.colorSecondary,
                    ),
                  ],
                ),
              ),
            );
            break;
          case ConnectionState.active:
            //This one is unlikely, since we only need one object... Read the doc ;)
            return Text("Active");
            break;
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Container(
              color: widget.highlight ? Color.fromRGBO(0, 180, 255, 0.1) : null,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.pushKey),
                    Switch(
                      value: snapshot.data != null ? snapshot.data : false,
                      onChanged: (bool value) {
                        setState(() {
                          SharedPreferencesHelper.setPushValue(
                              widget.pushKey, value);
                        });
                      },
                      activeColor: Styles.colorSecondary,
                    ),
                  ],
                ),
              ),
            );
            break;
        }
        return Text("Ops! Hva skjedde nå? Vennligst send et skjermbilde av dette til utvikler");
      },
    );
  }
}
