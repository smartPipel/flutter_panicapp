import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
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
  double _width = 50;
  bool _loading = true;
  bool orderByNameAsc = false;
  bool orderByNameDesc = false;
  bool orderByJenis = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                margin: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  alignment: AlignmentDirectional.topEnd,
                  margin: EdgeInsets.only(top: 40),
                  duration: Duration(milliseconds: 500),
                  height: 50,
                  width: _width,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent[100],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Row(
                    children: <Widget>[
                      //write code here
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.sortAlphaDownAlt,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              orderByNameDesc = true;
                              orderByNameAsc = false;
                              orderByJenis = false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.sortAlphaUpAlt,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              orderByNameDesc = false;
                              orderByNameAsc = true;
                              orderByJenis = false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.featured_play_list,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              orderByNameDesc = false;
                              orderByNameAsc = false;
                              orderByJenis = true;
                            });
                          },
                        ),
                      ),

                      //end
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
                                    Icons.sort,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    EvaIcons.arrowIosBackOutline,
                                    color: Colors.white,
                                  ),
                            onPressed: () {
                              if (_width == 50) {
                                setState(() {
                                  _width = 200;
                                  orderByNameDesc = false;
                                  orderByNameAsc = false;
                                  orderByJenis = false;
                                });
                              } else if (_width == 200) {
                                setState(() {
                                  _width = 50;
                                  orderByNameDesc = false;
                                  orderByNameAsc = false;
                                  orderByJenis = false;
                                });
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: 20, bottom: 20),
                padding: EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                      stream: orderByNameDesc == true
                          ? _firestore
                              .collection('laporan')
                              .orderBy("nama_pelapor", descending: true)
                              .snapshots()
                          : orderByNameAsc == true
                              ? _firestore
                                  .collection('laporan')
                                  .orderBy("nama_pelapor", descending: false)
                                  .snapshots()
                              : orderByJenis == true
                                  ? _firestore
                                      .collection('laporan')
                                      .orderBy("jenis_laporan",
                                          descending: true)
                                      .snapshots()
                                  : _firestore
                                      .collection('laporan')
                                      .orderBy("waktu", descending: true)
                                      .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.none) {
                          return LoadingFlare(context);
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return LoadingFlare(context);
                        } else if (!snapshot.hasData) {
                          Center(
                              child: Text(
                            "No Data Found",
                            style: fontBold(40, Colors.orangeAccent),
                          ));
                        }
                        return Container(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: reportCard(
                                    context, snapshot.data.documents[index]),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget LoadingFlare(BuildContext context) {
    return Center(
      heightFactor: 50,
      widthFactor: 50,
      child: FlareActor(
        "assets/anims/panic_loading_screen.flr",
        animation: "loading",
        shouldClip: true,
      ),
    );
  }
}
