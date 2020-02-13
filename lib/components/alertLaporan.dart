import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

 alertDialogLaporan(BuildContext context, String kejadian, String images, String nama, String email, String photo, String uid) {
   return AlertDialog(
    elevation: 10,
    content: Container(
      height: 250,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
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
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: ButtonTheme(
              minWidth: 110,
              child: FlatButton(
                onPressed: () async{
                  Firestore.instance.collection("laporan").add({
                    'jenis_laporan': kejadian,
                    'lokasi': "Jl. Gadang Gg 21c",
                    'nama_pelapor': nama,
                    'user_photo': photo,
                    'waktu': new DateTime.now(),
                    'uid': uid,
                  }).whenComplete((){
                    Toast.show("Berhasil Upload", context, duration: Toast.LENGTH_LONG);
                    Navigator.pop(context);
                  }); 
                },
                textColor: Colors.white,
                color: Colors.green,
                child: Text("Laporkan"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ButtonTheme(
              minWidth: 110,
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.orangeAccent,
                child: Text("Batal"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    ],
  );
}

}
