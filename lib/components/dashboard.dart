import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/model/getUserLocation.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:toast/toast.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  static FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userLocation;
  FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();
  double _width = 50;
  String username = "${user?.displayName}";
  String email = "${user?.email}";

  @override
  void initState() {
    super.initState();
    initUser();
    getUserLocation().then((loc){
      setState(() {
        userLocation = loc.addressLine;
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
                                                  AuthServices()
                                                      .logout(context);
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
                                  EvaIcons.refresh,
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
                                    setState(() {
                                      userLocation = "${location.addressLine}";
                                    });
                                  });
                                  setState(() {
                                    username = "${user?.displayName}";
                                    email = "${user?.email}";
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
              Container(
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
                                image: AssetImage(
                                    "assets/images/bg_dashboard.png"),
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
                                        ? AssetImage(
                                            "assets/images/userPhoto.png")
                                        : NetworkImage("${user?.photoUrl}"),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 40),
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              username,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              email,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: 30,
                                              height: 50,
                                              child: Image.asset(
                                                  "assets/images/icons/location.png")),
                                          Container(
                                            width: 200,
                                            child: Text(userLocation != null ? "${userLocation}" : "${userLocation}",
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
                                                    "",
                                                    style: fontSemi(
                                                        16, Colors.black),
                                                  );
                                                } else if (snapshot
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
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
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
                                                            style: fontSemi(16,
                                                                Colors.black),
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
            ],
          ),
        ),
      ),
    );
  }
}
