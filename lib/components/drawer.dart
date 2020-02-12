import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
  return SafeArea(
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Alvin Ferdian"),
              accountEmail: Text("alvinakbar095@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                      'assets/images/image1.png'),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/image1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.priority_high),
              title: Text("Laporan"),
              onTap: () {
                Navigator.pushNamed(context, "/laporan");
              },
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text("Donasi"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Akun saya"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Info"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
