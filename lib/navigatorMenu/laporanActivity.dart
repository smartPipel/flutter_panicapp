import 'package:panicapp/auth/auth.dart';
import 'package:panicapp/components/menu.dart';
import 'package:flutter/material.dart';

class LaporanAct extends StatefulWidget {
  @override
  _LaporanActState createState() => _LaporanActState();
}

class _LaporanActState extends State<LaporanAct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Laporan",
          style: TextStyle(letterSpacing: 1),
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
                  child: Text(pilihan),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }

  pilihAksi(String pilih) {
    if (pilih == Constants.logout) {
      AuthServices().logout(context);
      
    }
  }
}

Widget buildLaporanListView(BuildContext context, String username,
    String alamat, String email, String fotoProfil, String jenisLaporan) {
  return Column(
    children: <Widget>[
      ListTile(
        title: Text(jenisLaporan),
      ),
      Row(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              fotoProfil,
              height: 50,
              width: 50,
            ),
          ),
          ListTile(
            title: Text(username),
            subtitle: Text(email),
          ),
          ListTile(
            subtitle: Text(alamat),
          )
        ],
      ),
    ],
  );
}
