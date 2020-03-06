import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget reportCard(BuildContext context, DocumentSnapshot ds) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    width: MediaQuery.of(context).size.width / 1.1,
    height: MediaQuery.of(context).size.height / 6,
    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 10,
          height: MediaQuery.of(context).size.height / 3.2,
          // child: Align(
          //     alignment: Alignment.center,
          //     child: Text(
          //       ds.data['jenis_laporan'],
          //       style: fontBold(20, DefaultColors.darken),
          //     )),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ds.data['jenis_laporan'] == "Kebakaran"
                ? DefaultColors.orange
                : ds.data['jenis_laporan'] == "Kriminalitas"
                    ? DefaultColors.blue
                    : DefaultColors.green,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10)),
          ),
        ),
        Row(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(right: 10, left: 20, top: 10),
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: ds.data['user_photo'] != "null"
                      ? NetworkImage(ds.data['user_photo'])
                      : AssetImage("assets/images/userPhoto.png"),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        ds.data['nama_pelapor'],
                        style: fontBold(18, DefaultColors.darken),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      timeago.format(ds.data['waktu'].toDate()).toString(),
                      style: fontSemi(10, Colors.pink),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 10, left: 0),
                    width: 180,
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                          
                            margin: EdgeInsets.only(right: 0),
                            width: 30,
                            
                            child: Icon(
                              LineAwesomeIcons.map_pin,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 150,
                            margin: EdgeInsets.only(top:10),
                            child: Text(
                              ds.data['lokasi'],
                              style: fontSemi(14, DefaultColors.darken),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
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
      ],
    ),
  );
}
