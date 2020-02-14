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
        child: SingleChildScrollView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width / 1,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.grey,
                              offset: new Offset(0, 3),
                              blurRadius: 6)
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/images/bg_dashboard.png"),
                            fit: BoxFit.cover)),
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 0),
                      height: MediaQuery.of(context).size.height / 4,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 70,
                              height: 70,
                              margin: EdgeInsets.only(bottom: 20),
                              child: CircleAvatar(
                                backgroundImage: user?.photoUrl == null
                                    ? AssetImage("assets/images/user.png")
                                    : NetworkImage("${user?.photoUrl}"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 40),
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(right: 5),
                                          width: 30,
                                          height: 50,
                                          child: Image.asset(
                                              "assets/images/icons/user.png")),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          "${user?.displayName != null ? user?.displayName : 'Terjadi Kesalahan'}",
                                          style: fontBold(18, Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(right: 5),
                                          width: 30,
                                          height: 50,
                                          child: Image.asset(
                                              "assets/images/icons/email.png")),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          "${user?.email != null ? user?.email : 'Terjadi Kesalahan'}",
                                          style: fontSemi(18, Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(right: 5),
                                          width: 30,
                                          height: 50,
                                          child: Image.asset(
                                              "assets/images/icons/location.png")),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          "${userLocation}",
                                          style: fontSemi(16, Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                user?.phoneNumber != null
                                    ? Container(
                                      
                                        height: 30,
                                        child: Text(
                                          "${user?.phoneNumber})}",
                                          style: fontSemi(14, Colors.black),
                                        ),
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
                                                  16, Colors.black),
                                            );
                                          }else if (snapshot
                                                  .connectionState ==
                                              ConnectionState.none) {
                                            return new Text(
                                              "none",
                                              style: fontSemi(
                                                  16, Colors.black),
                                            );
                                          } else if (snapshot.hasData) {
                                            var userDocument =
                                                snapshot.data;
                                            return Container(
                                              padding: EdgeInsets.only(left: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                           right: 5),
                                                      width: 30,
                                                      height: 50,
                                                      child: Image.asset(
                                                          "assets/images/icons/telphone.png")),
                                                  Container(
                                                    width: 220,
                                                    height: 30,
                                                    child: Text(
                                                      userDocument[
                                                          "phone_number"],
                                                      style: fontSemi(
                                                          16, Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                    ),
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
