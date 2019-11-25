import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iot/detail.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.id, this.name, this.value});
  final db = Firestore.instance;
  final id;
  final name;
  final value;

  updateData(String name, bool value) async {
    db.collection('control').document(name).updateData({'value': value});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            leading: Switch(
              activeColor: Colors.blue,
              value: value,
              onChanged: (newValue) {
                updateData(id, newValue);
              },
            ),
            title: Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            // subtitle: Row(
            //   children: <Widget>[
            //     Switch(
            //       activeColor: Colors.blue,
            //       value: value,
            //       onChanged: (newValue) {
            //         updateData(id, newValue);
            //       },
            //     ),
            //   ],
            // ),
            trailing: new IconButton(
              icon: new Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 40.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detail()));
              },
            ),
          )),
    );
  }
}
