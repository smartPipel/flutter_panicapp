import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget reportCard(BuildContext context, DocumentSnapshot ds) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.1,
    height: MediaQuery.of(context).size.height / 3.2,
    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 16,
          child: Align(
              alignment: Alignment.center,
              child: Text(
                ds.data['jenis_laporan'],
                style: fontBold(20, Colors.black),
              )),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ds.data['jenis_laporan'] == "Kebakaran" ? Colors.orangeAccent 
                  : ds.data['jenis_laporan'] == "Kriminalitas" ? Colors.blueAccent : Colors.greenAccent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey, offset: new Offset(0, 3), blurRadius: 6)
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10, left: 20, top: 5),
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundImage: ds.data['user_photo'] != "null" ? NetworkImage(ds.data['user_photo']) : AssetImage("assets/images/user.png"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        ds.data['nama_pelapor'],
                        style: fontBold(18, Colors.black),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 30,
                            height: 50,
                            child: Image.asset(
                                "assets/images/icons/location.png")),
                        Text(
                          ds.data['lokasi'],
                          style: fontSemi(16, Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: Text(timeago.format(ds.data['waktu'].toDate()).toString()),
        ),
      ],
    ),
  );

}
  DateTime parseTime(dynamic date) {
    return Platform.isIOS ? (date as Timestamp).toDate() : (date as DateTime);
  }


