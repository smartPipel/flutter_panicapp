import 'package:flutter/material.dart';


class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

 alertDialogLaporan(BuildContext context, String kejadian, String images) {
   return AlertDialog(
    elevation: 10,
    content: Container(
      height: 250,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage(images),
            ),
          ),
          Container(
            child: Text(
              "Alvin Ferdian Akbar",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            margin: EdgeInsets.only(top: 30),
          ),
          Container(
            child: Text(
              "alvinakbar095@gmail.com",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            margin: EdgeInsets.only(top: 10),
          ),
        ],
      ),
    ),
    title: Align(
      alignment: Alignment.center,
      child: Text(kejadian),
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: ButtonTheme(
              minWidth: 110,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                color: Colors.green,
                child: Text("Laporkan"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ButtonTheme(
              minWidth: 110,
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.orangeAccent,
                child: Text("Batal"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    ],
  );
}

}
