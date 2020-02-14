import 'package:flutter/material.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/components/alertLaporan.dart';

  Widget buildCardLaporanMenu(
    BuildContext context,
    String icon,
    String caption,
    String nama, String email, String photo,
    String uid,
    String location
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
              color: Colors.black12, offset: new Offset(0, 3), blurRadius: 6)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(top: 20),
      width: 120,
      height: 120,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    splashColor: Colors.transparent,
                    autofocus: false,
                    onPressed: () {
                      showDialog(
                          child: Alert().alertDialogLaporan(
                              context,
                              caption,
                              icon,
                              nama,
                              email,
                              photo,
                              uid,
                              location),
                          context: context);
                    },
                    iconSize: 80,
                    icon: Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset(icon),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    caption,
                    style: fontBold(18, Colors.orangeAccent),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

