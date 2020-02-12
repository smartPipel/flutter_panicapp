import 'package:panicapp/navigatorMenu/donasiActivity.dart';
import 'package:panicapp/navigatorMenu/laporanActivity.dart';
import 'package:panicapp/navigatorMenu/userActivity.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _layoutPage = [User(), LaporanAct(), Donasi()];

  PageController _pageController;

  @override
  void initState() {
    super.initState();
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
      body: _layoutPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavyBar( 
        showElevation: false, 
        animationDuration: Duration(milliseconds: 350),
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() {
         _onTapItem(index);
        }),
        backgroundColor: Colors.white,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(EvaIcons.homeOutline),
            title: Text("Home"),
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(EvaIcons.clipboardOutline),
            title: Text("Laporan"),
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(EvaIcons.giftOutline),
            title: Text("Donasi"),
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
