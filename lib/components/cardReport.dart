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
      color: ds.data['jenis_laporan'] == "Kebakaran" ? Colors.orangeAccent[100] 
                  : ds.data['jenis_laporan'] == "Kriminalitas" ? Colors.blueAccent[100] : Colors.greenAccent[100],
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
                style: fontBold(20, Colors.white),
              )),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ds.data['jenis_laporan'] == "Kebakaran" ? Colors.orangeAccent 
                  : ds.data['jenis_laporan'] == "Kriminalitas" ? Colors.blueAccent : Colors.greenAccent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey, offset: new Offset(0, 1), blurRadius: 6)
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
                backgroundImage: ds.data['user_photo'] != "null" ? NetworkImage(ds.data['user_photo']) : AssetImage("assets/images/userPhoto.png"),
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
                        style: fontBold(18, Colors.white),
                        overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    width: 190,
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 30,
                            height: 50,
                            child: Image.asset(
                                "assets/images/icons/location.png")),
                        Container(
                          width: 150,
                          child: Text(
                            ds.data['lokasi'],
                            style: fontSemi(14, Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
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
          padding: EdgeInsets.only(right:20),
          alignment: Alignment.bottomRight,
          child: Text(timeago.format(ds.data['waktu'].toDate()).toString(), style: fontSemi(10, Colors.pink),),
        ),
      ],
    ),
  );

}
 


