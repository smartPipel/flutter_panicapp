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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Donasi",
          style: TextStyle(color: Colors.white, letterSpacing: 1),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent[100],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz),
            padding: EdgeInsets.only(top: 5, right: 20),
            onSelected: pilihAksi,
            itemBuilder: (BuildContext context) {
              return Constants.pilihan.map((String pilihan) {
                return PopupMenuItem<String>(
                  value: pilihan,
                  child: Row(
                    children: <Widget>[
                      Text(pilihan),
                    ],
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }

  pilihAksi(String pilih) {
    if (pilih == Constants.logout) {
      AuthServices().logout(context);
    }
  }
}
