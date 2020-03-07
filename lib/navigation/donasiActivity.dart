import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/components/menu.dart';
import 'package:flutter/material.dart';

class Donasi extends StatefulWidget {
  @override
  _DonasiState createState() => _DonasiState();
}

class _DonasiState extends State<Donasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.light,
      body: SafeArea(child: Container(child: Center(
        child: Image.asset("assets/images/coming_soon.png"),
      ),)),
    );
  }

  pilihAksi(String pilih) {
    if (pilih == Constants.logout) {
      AuthServices().logout(context);
    }
  }
}
