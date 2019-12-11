import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot/detail.dart';

class CardMonitor extends StatelessWidget {
  CardMonitor({this.id, this.name, this.arus});
  final db = Firestore.instance;
  final id;
  final name;
  final arus;
  final formatter = new NumberFormat("#.###");

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          title: Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(formatter.format(arus) + ' Ampere', style: TextStyle(fontSize: 18.0),),
            ],
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 40.0),
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(relayId : id,)));
            },
          ),
        )
      ),
    );
  }
}