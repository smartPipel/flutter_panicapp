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
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 40,),
          decoration: BoxDecoration(
            color: DefaultColors.darken,
            
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height ,
          
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
                          style: fontBold(18, Colors.white),
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
              
            ],
          ),
        ),
      ],
    );
  }
}
