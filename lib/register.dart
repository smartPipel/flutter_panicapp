import 'package:flutter/material.dart';
import 'package:panicapp/components/register_ui.dart';

import 'components/login_ui.dart';

class RegisterAkun extends StatefulWidget {
  @override
  _RegisterAkunState createState() => _RegisterAkunState();
}

class _RegisterAkunState extends State<RegisterAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: MediaQuery.of(context).size.height/1,
                child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: RegisterUser()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
