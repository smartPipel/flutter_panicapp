import 'package:panicapp/auth/auth.dart';
import 'package:panicapp/components/dashboard.dart';
import 'package:panicapp/components/menu.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home", style: TextStyle(color: Colors.white,letterSpacing: 1),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent[100],
            // borderRadius: BorderRadius.only(
            //   bottomRight: Radius.circular(15),
            //   bottomLeft: Radius.circular(15),
            // ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(EvaIcons.moreHorizotnalOutline,color: Colors.white,),
            padding: EdgeInsets.only(top: 5, right: 20),
            onSelected: pilihAksi,
            itemBuilder: (BuildContext context) {
              return Constants.pilihan.map((String pilihan) {
                return PopupMenuItem<String>(
                  value: pilihan,
                  child: Text(pilihan),
                );
              }).toList();
            },
          )
        ],
      ),
      body: UserDashboard(),
    );
  }
  pilihAksi(String pilih) {
    if (pilih == Constants.logout) {
      AuthServices().logout(context);
      Toast.show("Berhasil", context, duration: Toast.LENGTH_LONG);
    }
  }
}
