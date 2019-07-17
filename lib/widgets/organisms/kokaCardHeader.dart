import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../styles.dart';

Widget kokaCardHeader(
    {String title = "hello",
      String content =
      'Lorum ipsum dolor sit amet complesir met inet und a let nous aprenter',
      onTapAction,
      String topRight = "21:30",
      Color accentColor = Styles.colorPrimary,
      String category,
      TextStyle categoryStyle,
    }) {
  return Container(
    key: Key(category),
    padding: EdgeInsets.all(10),
    decoration: new BoxDecoration(boxShadow: [
      new BoxShadow(
        color: Styles.colorShadowCardMain,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ]),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      color: Styles.kokaEventCardColorBackground,
      margin: EdgeInsets.all(0),
      child: InkWell(
          splashColor: Styles.colorPrimary,
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                width: 40,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    category,
                    style: categoryStyle,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 124,
                  child: VerticalDivider(
                    width: 1,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  )),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 128,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles
                                      .kokaCardNewsTextHeader),
                              Text(content,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                  style:
                                  Styles.kokaCardNewsTextContent),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          onTap: () => onTapAction()),
    ),
  );
}
