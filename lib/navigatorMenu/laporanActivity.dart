import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/cardReport.dart';
import 'package:panicapp/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:panicapp/model/getUserLocation.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:toast/toast.dart';

class LaporanAct extends StatefulWidget {
  @override
  _LaporanActState createState() => _LaporanActState();
}

class _LaporanActState extends State<LaporanAct> {
  final Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Laporan",
          style: TextStyle(letterSpacing: 1),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent[100],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz),
            padding: EdgeInsets.only(top: 5, right: 20),
            onSelected: pilihAksi,
            itemBuilder: (BuildContext context) {
              return Constants.pilihan.map((String pilihan) {
                return PopupMenuItem<String>(
                  value: pilihan,
                  child: Text(pilihan),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Stack(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('laporan').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.deepPurple,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text("None");
                  } else if (!snapshot.hasData) {
                    Center(child: Text("Tai"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return reportCard(
                          context, snapshot.data.documents[index]);
                    },
                  );
                },
              ),
              FabCircularMenu(
                  animationDuration: Duration(seconds: 1),
                  ringWidth: 100,
                  ringDiameter: 250,
                  fabColor: Colors.greenAccent,
                  fabOpenIcon: Icon(EvaIcons.arrowIosBack),
                  fabCloseIcon: Icon(EvaIcons.arrowIosForward),
                  child: Container(),
                  options: <Widget>[
                    IconButton(
                        iconSize: 40,
                        color: Colors.blue,
                        tooltip: "Lokasi",
                        icon: Icon(EvaIcons.pin),
                        onPressed: () {
                          getUserLocation().then((r){
                            Toast.show("${r.addressLine}", context, duration: Toast.LENGTH_LONG);
                          });
                        }),
                    IconButton(
                        iconSize: 40,
                        color: Colors.orangeAccent,
                        tooltip: "Edit Profile",
                        icon: Icon(EvaIcons.edit),
                        onPressed: () {}),
                    IconButton(
                        color: Colors.red,
                        iconSize: 40,
                        tooltip: "Logout",
                        icon: Icon(EvaIcons.closeCircle),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RichAlertDialog(
                                  alertTitle: richTitle("Logout?"),
                                  alertSubtitle:
                                      richSubtitle("Apakah Anda Yakin?"),
                                  alertType: RichAlertType.INFO,
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        AuthServices().logout(context);
                                        Navigator.pop(context);
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
                        })
                  ])
            ],
          ),
        ),
      ),
    );
  }

  pilihAksi(String pilih) {
    if (pilih == Constants.logout) {
      AuthServices().logout(context);
    }
  }
}
