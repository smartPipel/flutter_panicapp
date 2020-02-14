import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/laporanWidget.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/components/dashboard.dart';
import 'package:panicapp/components/menu.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panicapp/model/getUserLocation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:toast/toast.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  double _width = 50;
  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
          panel: Center(
            child: LaporanWidget(),
          ),
          margin: EdgeInsets.only(left: 15, right: 15),
          backdropColor: Colors.orangeAccent[100],
          parallaxEnabled: true,
          parallaxOffset: -0.7,
          panelSnapping: true,
          renderPanelSheet: true,
          backdropOpacity: 0.6,
          backdropEnabled: true,
          collapsed: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.orangeAccent[100]),
            child: Center(
              child: Text(
                "Laporan",
                style: fontBold(20, Colors.black),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                
                UserDashboard(),
              ],
            ),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    );
  }
}
