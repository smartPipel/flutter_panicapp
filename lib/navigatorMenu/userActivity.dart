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
import 'package:slide_button/slide_button.dart';
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
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    alignment: AlignmentDirectional.topEnd,
                    margin: EdgeInsets.only(top: 40),
                    duration: Duration(milliseconds: 1000),
                    height: 50,
                    width: _width,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent[100],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.orangeAccent[100],
                            width: 100,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      EvaIcons.closeCircle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return RichAlertDialog(
                                              alertTitle: richTitle("Logout?"),
                                              backgroundOpacity: 0.3,
                                              alertSubtitle: richSubtitle(
                                                  "Apakah Anda Yakin?"),
                                              alertType: RichAlertType.WARNING,
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    AuthServices().logout(context);                                               
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: IconButton(
                                        icon: Icon(
                                          EvaIcons.edit2,
                                          color: Colors.orange,
                                        ),
                                        onPressed: null)),
                                Expanded(
                                    child: IconButton(
                                  icon: Icon(
                                    EvaIcons.pin,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    getUserLocation().then((location) {
                                      Toast.show(
                                        "${location.subLocality + ', ' + location.locality + ', ' + location.subAdminArea}",
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.greenAccent,
                                      );
                                    });
                                  },
                                ))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                            color: Colors.orangeAccent[100],
                          ),
                          child: IconButton(
                              icon: _width == 50
                                  ? Icon(
                                      EvaIcons.arrowIosForwardOutline,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      EvaIcons.arrowIosBackOutline,
                                      color: Colors.black,
                                    ),
                              onPressed: () {
                                if (_width == 50) {
                                  setState(() {
                                    _width = 200;
                                  });
                                } else if (_width == 200) {
                                  setState(() {
                                    _width = 50;
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                UserDashboard(),
              ],
            ),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    );
  }
}
