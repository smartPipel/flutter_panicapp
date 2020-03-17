import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:toast/toast.dart';

class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  alertDialogLaporan(BuildContext context, String kejadian, String nama,
      String email, String photo, String uid, String lokasi) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      elevation: 10,
      content: Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 80,
              height: 80,
              child: CircleAvatar(
                backgroundImage: NetworkImage(photo),
              ),
            ),
            Container(
              child: Text(
                nama,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              margin: EdgeInsets.only(top: 30),
            ),
            Container(
              child: Text(
                email,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.grey),
              ),
              margin: EdgeInsets.only(top: 10),
            ),
          ],
        ),
      ),
      title: Align(
        alignment: Alignment.center,
        child: Text(kejadian),
      ),
      titleTextStyle: fontBold(18, DefaultColors.dark),
      contentTextStyle: fontSemi(18, DefaultColors.dark),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.all(12),
          child: InkWell(
            onTap: () async {
              Firestore.instance.collection("laporan").add({
                'jenis_laporan': kejadian,
                'lokasi': lokasi,
                'nama_pelapor': nama,
                'user_photo': photo,
                'waktu': new DateTime.now(),
                'uid': uid,
              }).whenComplete(() {
                Toast.show("Berhasil Upload", context,
                    duration: Toast.LENGTH_LONG);
              });
              Navigator.pop(context);
            },
           highlightColor: Colors.white,
          splashColor: Colors.white,
          child: Container(
            child: Align(alignment: Alignment.center,child: Text("Laporkan", style: fontSemi(16, DefaultColors.light),)),
            width: 100,
            height: 40,
            
            decoration: BoxDecoration(
              color: DefaultColors.orange,
              borderRadius: BorderRadius.circular(20)
            ),),
          ),
        ),
        Container(
          margin: EdgeInsets.all(12),
          child: InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.white,
            child: Container(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Batal",
                    style: fontSemi(16, DefaultColors.light),
                  )),
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
