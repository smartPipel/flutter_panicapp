import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panicapp/auth/auth.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/cardReport.dart';
import 'package:panicapp/components/menu.dart';
import 'package:flutter/material.dart';

class LaporanAct extends StatefulWidget {
  @override
  _LaporanActState createState() => _LaporanActState();
}

class _LaporanActState extends State<LaporanAct> {
  final Firestore _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('laporan').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.deepPurple,
                  ),
                );
              }
              else if(snapshot.connectionState == ConnectionState.none){
                return Text("None");
              }else if(!snapshot.hasData){
                Center(child: Text("Tai"));
              }
              return ListView.builder(
                itemCount:  snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return reportCard(
                      context,
                      snapshot.data.documents[index]);
                },
              );
            },
          ),
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
