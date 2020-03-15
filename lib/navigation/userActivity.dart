import 'package:flutter/cupertino.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/dashboard.dart';
import 'package:flutter/material.dart';


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
