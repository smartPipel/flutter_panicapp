import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panicapp/auth/auth.dart';

import 'alertLaporan.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black12,
                            offset: new Offset(0, 3),
                            blurRadius: 6)
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 6,
                    margin: EdgeInsets.only(top: 60, bottom: 30, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(right: 30, left: 20, bottom: 10),
                          height: 65,
                          width: 65,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/image1.png"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "${user.displayName}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    height: 2),
                              ),
                              Text(
                                "${user.email}",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection("user_phone")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError)
                                    return Text("${snapshot.error}");
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Text("Loading...");
                                    default:
                                      return ListView(
                                        children: snapshot.data.documents
                                            .map((DocumentSnapshot document) {
                                          return Text("${document['phone_number']}");
                                        }).toList(),
                                      );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 320, top: 90),
                    child: FloatingActionButton(
                      backgroundColor: Colors.orangeAccent[400],
                      splashColor: Colors.orangeAccent[100],
                      tooltip: "Edit Profil",
                      onPressed: () {
                        Navigator.pushNamed(context, "/userRegister");
                      },
                      child: Icon(EvaIcons.edit2Outline),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCardLaporanMenu(
                    context, "assets/images/menu/api.png", "Kebakaran"),
                _buildCardLaporanMenu(
                    context, "assets/images/menu/borgol.png", "Kriminalitas"),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildCardLaporanMenu(
                      context, "assets/images/menu/p_tiga_k.png", "Kecelakaan"),
                  _buildCardLaporanMenu(
                      context, "assets/images/menu/p_tiga_k.png", "Kecelakaan"),
                ]),
          ],
        ),
      ),
    );
  }
}

Widget _buildCardLaporanMenu(
  BuildContext context,
  String icon,
  String caption,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        new BoxShadow(
            color: Colors.black12, offset: new Offset(0, 3), blurRadius: 6)
      ],
      borderRadius: BorderRadius.circular(15),
    ),
    margin: EdgeInsets.only(top: 20),
    width: 120,
    height: 120,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                  splashColor: Colors.transparent,
                  autofocus: false,
                  onPressed: () {
                    showDialog(
                        child:
                            Alert().alertDialogLaporan(context, caption, icon),
                        context: context);
                  },
                  iconSize: 80,
                  icon: Container(
                    child: Column(
                      children: <Widget>[
                        Image.asset(icon),
                      ],
                    ),
                  ),
                ),
                Text(
                  caption,
                  style: TextStyle(fontSize: 14, color: Colors.orangeAccent),
                )
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
