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
      backgroundColor: DefaultColors.light,
      body: SafeArea(
            child: UserDashboard(),
          ),
    );
  }
}
