import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/infoMenu.dart';
import 'package:panicapp/components/laporanMenu.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/model/getUserLocation.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userLocation;
  FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    initUser();
    getUserLocation().then((r) {
      setState(() {
        userLocation = r.addressLine;
      });
    });
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.orangeAccent[100],
        child: SingleChildScrollView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width / 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.orangeAccent[100],
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            colors: <Color>[
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.orangeAccent[100]
                            ],
                          ),
                          
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.height * 1.2,
                        margin: EdgeInsets.only(
                          top: 30,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 20),
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  width: 70,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      child: CircleAvatar(
                                        backgroundImage: user?.photoUrl == null
                                            ? AssetImage(
                                                "assets/images/user.png")
                                            : NetworkImage("${user?.photoUrl}"),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin: EdgeInsets.only(bottom: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: 30,
                                              height: 50,
                                              child: Image.asset(
                                                  "assets/images/icons/user.png")),
                                          Text(
                                            "${user?.displayName != null ? user?.displayName : 'Terjadi Kesalahan'}",
                                            style: GoogleFonts.overpass(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: 30,
                                              height: 50,
                                              child: Image.asset(
                                                  "assets/images/icons/email.png")),
                                          Text(
                                            "${user?.email != null ? user?.email : 'Terjadi Kesalahan'}",
                                            style: GoogleFonts.overpass(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: 30,
                                              height: 50,
                                              child: Image.asset(
                                                  "assets/images/icons/location.png")),
                                          Container(
                                            width: 180,
                                            child: Text(
                                              "${userLocation}",
                                              style: fontSemi(14, Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      user?.phoneNumber != null
                                          ? Text(
                                              "${user?.phoneNumber})}",
                                              style: fontSemi(14, Colors.black),
                                            )
                                          : StreamBuilder(
                                              stream: Firestore.instance
                                                  .collection('user_phone')
                                                  .document('${user?.uid}')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                try {
                                                  if (!snapshot.hasData) {
                                                    return new Text(
                                                      "...",
                                                      style: fontSemi(
                                                          14, Colors.black),
                                                    );
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return new Text(
                                                      "Loading...",
                                                      style: fontSemi(
                                                          14, Colors.black),
                                                    );
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.none) {
                                                    return new Text(
                                                      "none",
                                                      style: fontSemi(
                                                          14, Colors.black),
                                                    );
                                                  } else if (snapshot.hasData) {
                                                    var userDocument =
                                                        snapshot.data;
                                                    return Row(
                                                      children: <Widget>[
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            width: 30,
                                                            height: 50,
                                                            child: Image.asset(
                                                                "assets/images/icons/telphone.png")),
                                                        Text(
                                                          userDocument[
                                                              "phone_number"],
                                                          style: fontSemi(
                                                              14, Colors.black),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                } catch (e) {
                                                  return Text("");
                                                }
                                              },
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
                                            "${user?.uid}"),
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
                                            "${user?.uid}"),
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
                                            "${user?.uid}"),
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
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      StreamBuilder<QuerySnapshot>(
                                        stream: Firestore.instance
                                            .collection("laporan")
                                            .where('jenis_laporan',
                                                isEqualTo: "Kebakaran")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return Container(
                                            margin: EdgeInsets.all(20),
                                            child: infoMenu(
                                                context,
                                                "collections",
                                                "${snapshot.data.documents.length != null ? snapshot.data.documents.length : "0"}",
                                                "Kebakaran",
                                                Colors.orangeAccent),
                                          );
                                        },
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: Firestore.instance
                                            .collection("laporan")
                                            .where('jenis_laporan',
                                                isEqualTo: "Kecelakaan")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return Container(
                                            margin: EdgeInsets.all(20),
                                            child: infoMenu(
                                                context,
                                                "collections",
                                                "${snapshot.data.documents.length != null ? snapshot.data.documents.length : "0"}",
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
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return Container(
                                            margin: EdgeInsets.all(20),
                                            child: infoMenu(
                                                context,
                                                "collections",
                                                "${snapshot.data.documents.length != null ? snapshot.data.documents.length : "0"}",
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
                                                "${snapshot.data.documents.length != null ? snapshot.data.documents.length : "0"}",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
