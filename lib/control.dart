import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iot/card_control.dart';

class Control extends StatefulWidget {
  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('control').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      );
                default:
                  return new ListView(
                    children: snapshot.data.documents
                      .map((DocumentSnapshot document) {
                        return new CardControl(
                          id : document.documentID,
                          name : document['name'],
                          value : document['value'],
                          arus: document['arus'],
                        );
                    }).toList(),
                  );
              }
            },
          ),
      ),
    ); 
  }
}