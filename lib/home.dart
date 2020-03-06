import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/model/getUserLocation.dart';
import 'package:panicapp/navigation/donasiActivity.dart';
import 'package:panicapp/navigation/laporanActivity.dart';
import 'package:panicapp/navigation/userActivity.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _layoutPage = [User(), LaporanAct(), Donasi()];
  FirebaseUser user;

  PageController _pageController;

  @override
  void initState() {
    super.initState();

    AuthServices().getUser().then((u) {
      setState(() {
        user = u;
      });
    });

    _pageController = PageController();
  }

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 160,
          padding: EdgeInsets.only(top: 35, left: 20),
          child: Row(
            children: <Widget>[
              Text(
                "Hai,\n${user?.displayName}",
                style: fontBold(16, DefaultColors.dark),
              ),
            ],
          ),
        ),
        titleSpacing: 20,
        backgroundColor: DefaultColors.light,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
                child: Icon(
                  EvaIcons.logOutOutline,
                  color: Colors.red,
                ),
                onTap: () =>
                    Toast.show("msg", context, duration: Toast.LENGTH_LONG)),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
                child: Icon(
                  EvaIcons.settings,
                  color: Colors.grey,
                ),
                onTap: () =>
                    Toast.show("msg", context, duration: Toast.LENGTH_LONG)),
          )
        ],
      ),
      backgroundColor: DefaultColors.light,
      body: _layoutPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavyBar(
        showElevation: false,
        animationDuration: Duration(milliseconds: 350),
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() {
          _onTapItem(index);
        }),
        backgroundColor: Colors.grey[300],
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(EvaIcons.homeOutline),
            title: Text("Home"),
            activeColor: DefaultColors.dark,
            inactiveColor: DefaultColors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(EvaIcons.clipboardOutline),
            title: Text("Laporan"),
            activeColor: DefaultColors.dark,
            inactiveColor: DefaultColors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(EvaIcons.giftOutline),
            title: Text("Donasi"),
            activeColor: DefaultColors.dark,
            inactiveColor: DefaultColors.blue,
          ),
        ],
      ),
    );
  }
}
