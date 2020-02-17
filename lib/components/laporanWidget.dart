import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/infoMenu.dart';
import 'package:panicapp/components/laporanMenu.dart';
import 'package:panicapp/model/getUserLocation.dart';

class LaporanWidget extends StatefulWidget {

  @override
  _LaporanWidgetState createState() => _LaporanWidgetState();
}

class _LaporanWidgetState extends State<LaporanWidget> {
  FirebaseUser user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userLocation;

  FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    _initUser();
    getUserLocation().then((r) {
      setState(() {
        userLocation = r.addressLine;
      });
    });
  }

  _initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height * 1.2,
            margin: EdgeInsets.only(
              top: 30,
            ),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Laporkan kejadian!",
                            style: fontBold(18, Colors.black),
                          ),
                          Icon(
                            EvaIcons.arrowIosForward,
                            size: 18,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView(
                        physics:
                            PageScrollPhysics(parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            child: buildCardLaporanMenu(
                                context,
                                "assets/images/menu/api.png",
                                "Kebakaran",
                                "${user?.displayName}",
                                "${user?.email}",
                                "${user?.photoUrl}",
                                "${user?.uid}",
                                "${userLocation}"),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: buildCardLaporanMenu(
                                context,
                                "assets/images/menu/borgol.png",
                                "Kriminalitas",
                                "${user?.displayName}",
                                "${user?.email}",
                                "${user?.photoUrl}",
                                "${user?.uid}",
                                "${userLocation}"),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: buildCardLaporanMenu(
                                context,
                                "assets/images/menu/p_tiga_k.png",
                                "Kecelakaan",
                                "${user?.displayName}",
                                "${user?.email}",
                                "${user?.photoUrl}",
                                "${user?.uid}",
                                "${userLocation}"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Histori laporan",
                            style: fontBold(18, Colors.black),
                          ),
                          Icon(
                            EvaIcons.arrowIosForward,
                            size: 18,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView(
                        physics:
                            PageScrollPhysics(parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("laporan")
                                .where('jenis_laporan', isEqualTo: "Kebakaran")
                                .where('uid', isEqualTo: user?.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                child: infoMenu(
                                    context,
                                    "collections",
                                    "${snapshot.data.documents.length != 0 ? snapshot.data.documents.length : "0"}",
                                    "Kebakaran",
                                    Colors.orangeAccent),
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("laporan")
                                .where('jenis_laporan', isEqualTo: "Kecelakaan")
                                .where('uid', isEqualTo: user?.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                child: infoMenu(
                                    context,
                                    "collections",
                                    "${snapshot.data.documents.length != 0 ? snapshot.data.documents.length : 0}",
                                    "Kecelakaan",
                                    Colors.greenAccent),
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("laporan")
                                .where('jenis_laporan',
                                    isEqualTo: "Kriminalitas")
                                .where('uid', isEqualTo: user?.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                child: infoMenu(
                                    context,
                                    "collections",
                                    "${snapshot.data.documents.length != 0 ? snapshot.data.documents.length : 0}",
                                    "Kriminalitas",
                                    Colors.blueAccent),
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("laporan")
                                .where('uid', isEqualTo: user?.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                child: infoMenu(
                                    context,
                                    "collections",
                                    "${snapshot.data.documents.length != 0 ? snapshot.data.documents.length : 0}",
                                    "Jumlah",
                                    Colors.black),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
