import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panicapp/auth/auth.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:toast/toast.dart';

import 'alertLaporan.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

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
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 6,
                    margin: EdgeInsets.only(top: 60, bottom: 30, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       new BoxShadow(
                        //           color: Colors.white,
                        //           offset: new Offset(0, -3),
                        //           blurRadius: 6)
                        //     ],
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   width: MediaQuery.of(context).size.width / 1.1,
                        //   height: MediaQuery.of(context).size.height / 6,
                        // ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 20, left: 20, bottom: 10),
                          height: 65,
                          width: 65,
                          child: CircleAvatar(
                            backgroundImage: user?.photoUrl == null
                                ? AssetImage("assets/images/image1.png")
                                : NetworkImage("${user?.photoUrl}"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${user?.displayName != null ? user?.displayName : 'Terjadi Kesalahan'}",
                                style: GoogleFonts.overpass(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                "${user?.email != null ? user?.email : 'Terjadi Kesalahan'}",
                                style: GoogleFonts.overpass(
                                    fontSize: 14, fontWeight: FontWeight.w500),
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
                                              style: fontSemi(14, Colors.black),
                                            );
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return new Text(
                                              "Loading...",
                                              style: fontSemi(14, Colors.black),
                                            );
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.none) {
                                            return new Text(
                                              "none",
                                              style: fontSemi(14, Colors.black),
                                            );
                                          } else if (snapshot.hasData) {
                                            var userDocument = snapshot.data;
                                            return Text(
                                              userDocument["phone_number"],
                                              style: fontSemi(14, Colors.black),
                                            );
                                          }
                                        } catch (e) {
                                          return Text("");
                                        }
                                      }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 300, top: 60),
                    child: FloatingActionButton(
                      mini: true,
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
