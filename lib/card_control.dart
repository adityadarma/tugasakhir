import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardControl extends StatelessWidget {
  CardControl({@required this.id, this.name, this.value, this.arus});
  final db = Firestore.instance;
  final id;
  final name;
  final value;
  final arus;
  final formatter = new NumberFormat("#.###");

  updateData(String name, bool value) async {
    db.collection('control').document(name).updateData({'value': value});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 100.0,
        padding: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          trailing: Switch(
            activeColor: Colors.blue,
            value: value,
            onChanged: (newValue) {
              updateData(id, newValue);
            },
          ),
        )
      ),
    );
  }
}
