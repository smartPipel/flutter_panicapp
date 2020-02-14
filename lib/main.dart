import 'package:panicapp/components/login_ui.dart';
import 'package:panicapp/home.dart';
import 'package:panicapp/profileEdit.dart';
import 'package:flutter/material.dart';
import 'package:panicapp/navigatorMenu/laporanActivity.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:panicapp/register.dart';

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
  @override
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      photoSize: 50,
      onClick: (){
        Navigator.pushNamedAndRemoveUntil(context, 'main', ModalRoute.withName("/"));
      },
      image: Image.asset(
        "assets/images/icons/icon.png",
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.white,
      loaderColor: Colors.orangeAccent,
      navigateAfterSeconds: MyApp(),
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
      body: Container(
        
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/1,
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
