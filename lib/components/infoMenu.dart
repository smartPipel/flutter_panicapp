import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/alertLaporan.dart';


  Widget infoMenu(
    BuildContext context,
    String icon,
    String historiData,
    String caption,
    Color numberColor
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        // boxShadow: [
        //   new BoxShadow(
        //       color: Colors.black12, offset: new Offset(0, 3), blurRadius: 6)
        // ],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width /1.4,
      height: 100,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    historiData,
                    style: fontBold(50, numberColor),
                  ),
                  Text(caption, style: fontBold(18, DefaultColors.darken)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

