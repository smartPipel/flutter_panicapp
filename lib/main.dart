import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/login_ui.dart';
import 'package:panicapp/home.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/profileEdit.dart';
import 'package:flutter/material.dart';
import 'package:panicapp/navigatorMenu/laporanActivity.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:panicapp/register.dart';
import 'package:toast/toast.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => Splash(),
          "/main": (context) => MyApp(),
          "/home": (context) => HomeScreen(),
          "/userRegister": (context) => RegisterAkun(),
          "/laporan": (context) => LaporanAct(),
          "/updateProfile": (context) => EditProfile()
        },
      ),
    );

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FlareControls _flareControls = FlareControls();
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    
    _flareControls.play("loading", mix: 0.5, mixSeconds: 1);
    loadData();
  }

  Future<Timer> loadData() async {
  return new Timer(Duration(seconds: 4), onDoneLoading);
  }

  onDoneLoading() async{
    AuthServices().getUser().then((user) {
      if(user != null){
        Navigator.pushNamedAndRemoveUntil(context, "/home", ModalRoute.withName("/"));
        Toast.show("Selamat Datang ${user.displayName}", context, duration: Toast.LENGTH_SHORT);
      }else if (user == null) {
        Navigator.pushNamedAndRemoveUntil(context, "/main", ModalRoute.withName("/"));
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: FlareActor("assets/anims/panic_loading_screen.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"loading", controller: _flareControls,),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.darken,
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: LoginUser()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
