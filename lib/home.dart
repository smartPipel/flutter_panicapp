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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final _layoutPage = [User(), Donasi()];
  FirebaseUser user;
  TabController _controller;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            bottom: TabBar(
                indicatorWeight: 3,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 5.0,
                      color: DefaultColors.orange,
                      style: BorderStyle.solid,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 20.0)),
                controller: _controller,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "DASHBOARD",
                      style: fontSemi(14, DefaultColors.dark),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "DONASI",
                      style: fontSemi(14, DefaultColors.dark),
                    ),
                  ),
                ]),
            // flexibleSpace: Container(
            //   padding: EdgeInsets.only(bottom: 20, left: 20),
            //   child: Row(
            //     children: <Widget>[

            //     ],
            //   ),
            // ),
            titleSpacing: 20,
            backgroundColor: DefaultColors.light,
            elevation: 0,
            title: Text(
              "Hi, ${user?.displayName}",
              style: fontBold(18, DefaultColors.dark),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 20,
                ),
                child: InkWell(
                    child: Icon(
                      EvaIcons.logOutOutline,
                      color: Colors.red,
                    ),
                    onTap: () =>
                        showDialog(context: context, child: logOutAlert())),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20,
                ),
                child: InkWell(
                    highlightColor: Colors.white,
                    splashColor: Colors.white,
                    child: Icon(
                      EvaIcons.settings,
                      color: Colors.grey,
                    ),
                    onTap: () => Toast.show("Setting", context,
                        duration: Toast.LENGTH_LONG)),
              )
            ],
          ),
        ),
        backgroundColor: DefaultColors.light,
        body: TabBarView(
            controller: _controller, children: <Widget>[User(), Donasi()]));
  }

  Widget logOutAlert() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Align(
        alignment: Alignment.center,
        child: Text("Logout"),
      ),
      titleTextStyle: fontBold(18, DefaultColors.dark),
      actions: <Widget>[
        InkWell(
          highlightColor: Colors.white,
          splashColor: Colors.white,
          child: Container(
            child: Align(alignment: Alignment.center,child: Text("Ya", style: fontSemi(16, DefaultColors.light),)),
            width: 100,
            height: 40,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          onTap: () {
            AuthServices().logout(context);
            Navigator.pop(context);
          },
        ),
        InkWell(
          highlightColor: Colors.white,
           splashColor: Colors.white,
          child: Container(child: Align(alignment: Alignment.center,child: Text("Tidak", style: fontSemi(16, DefaultColors.light),)),
            width: 100,
            height: 40,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: DefaultColors.green,
              borderRadius: BorderRadius.circular(20)
            ),),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
